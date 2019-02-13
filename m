Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB35C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3FA20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083836;
	bh=DLsb54sMgEvNuIeSA/Z8cY29pG2C5XL1du65fR9bltk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=unrxzaFB1doyXJk8AU7dPMTbS5bnJQ0xYnIx5gPrE9vHpGLvA2Is6Vk47FNewLSA6
	 s9AAuEtex7NPOAtBEPNJ2QSS5qicz09ILZYAc2HImTO0x8lhcdJuA1EAVieibS9qao
	 TJlDaFlHendS0db84GCXtBP6EFsrDTaBj8HX1T7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406069AbfBMSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406053AbfBMSoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B36F820811;
        Wed, 13 Feb 2019 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083448;
        bh=DLsb54sMgEvNuIeSA/Z8cY29pG2C5XL1du65fR9bltk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZP5CO6X8ocm3lTOPL4HqQYoZ7MOBAo12A6CgFKmyxPRxO/3ybmUqA/a/sSmEI9LY
         IwWb70UvGwrGRCqxWUyE71P/ayOpKbbMavklZiEhS+r2iP1LnVpAN+9qpExB5jUij9
         HPxnHntW5ikUgzmrH0FLpQp9Wn4cNbAKCmdE8ADA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Myungho Jung <mhjungk@gmail.com>
Subject: [PATCH 4.19 39/44] libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()
Date:   Wed, 13 Feb 2019 19:38:40 +0100
Message-Id: <20190213183655.079123870@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 4aac9228d16458cedcfd90c7fb37211cf3653ac3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/messenger.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3240,9 +3240,10 @@ void ceph_con_keepalive(struct ceph_conn
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


