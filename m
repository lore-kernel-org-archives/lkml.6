Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1AAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC0220643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197038;
	bh=UczYKW/erkCre+95T7mwnlspOqbwiNWsAh9lBazHQ3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQDXZugRQE+nxunZT7ngfDzgTQ5L0YIOEf6H7RYqfmnGnA0pC6AXCCT4/ouPWFHPs
	 K7qUgxBAmZEa9yxc+Ie0ov9w5B9AcoJGnzoL/Ah2+T/wWqkxn5fhw6g3SzwCAhRhzt
	 qQR5LRrp2piJrfotNvoUk0lmWc4QwMCQZts3mn/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391123AbfBOCQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:16:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406063AbfBOCQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:16:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7632F21934;
        Fri, 15 Feb 2019 02:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196959;
        bh=UczYKW/erkCre+95T7mwnlspOqbwiNWsAh9lBazHQ3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1uoo3T0NJ5u7JJ10xlhAaK7HMuKsaoD01jTKNAy/wI2ihL/L7bbS8S+keyQO2ciym
         gxJCTQigvzXtPagL1W9bxlijvLHqTDBa1E8u9XG5EHBIUDj0bGIqE/Hz0l6kQOkAln
         eZvsizopAH61vqoJfMnvJ7mXpo0lZGio4Uy3mf8s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 08/16] libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()
Date:   Thu, 14 Feb 2019 21:15:38 -0500
Message-Id: <20190215021546.179605-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021546.179605-1-sashal@kernel.org>
References: <20190215021546.179605-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 4aac9228d16458cedcfd90c7fb37211cf3653ac3 ]

con_fault() can transition the connection into STANDBY right after
ceph_con_keepalive() clears STANDBY in clear_standby():

    libceph user thread               ceph-msgr worker

ceph_con_keepalive()
  mutex_lock(&con->mutex)
  clear_standby(con)
  mutex_unlock(&con->mutex)
                                mutex_lock(&con->mutex)
                                con_fault()
                                  ...
                                  if KEEPALIVE_PENDING isn't set
                                    set state to STANDBY
                                  ...
                                mutex_unlock(&con->mutex)
  set KEEPALIVE_PENDING
  set WRITE_PENDING

This triggers warnings in clear_standby() when either ceph_con_send()
or ceph_con_keepalive() get to clearing STANDBY next time.

I don't see a reason to condition queue_con() call on the previous
value of KEEPALIVE_PENDING, so move the setting of KEEPALIVE_PENDING
into the critical section -- unlike WRITE_PENDING, KEEPALIVE_PENDING
could have been a non-atomic flag.

Reported-by: syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Myungho Jung <mhjungk@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/messenger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2dc4e064bea3..45bd78f3e28f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3068,9 +3068,10 @@ void ceph_con_keepalive(struct ceph_connection *con)
 	dout("con_keepalive %p\n", con);
 	mutex_lock(&con->mutex);
 	clear_standby(con);
+	con_flag_set(con, CON_FLAG_KEEPALIVE_PENDING);
 	mutex_unlock(&con->mutex);
-	if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
-	    con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
+
+	if (con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
 		queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_keepalive);
-- 
2.19.1

