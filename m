Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB75820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHZ46NJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB75820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeJVSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbeJVShd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:33 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2718320853;
        Mon, 22 Oct 2018 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203578;
        bh=/DXtb/RTV+iLWHLPbTpJeEokBDE9v/IjgGKa2HPrVXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHZ46NJb0n2aEr4VJUewCyN7AaGqAPR47MK2IzDh7+MfU4Y4WiHAqK95A39aPruk8
         ll/UI70TQHXh/3YtW/vCT8YJTvbxCAn7Iver5+Xswp4HBXfijgP3azaJpKtQlSlF4D
         l2dbV77CMi1I6rmfMugyjxD97/y89yiZf+6cGfcI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 05/27] Input: mousedev - add a schedule point in mousedev_write()
Date:   Mon, 22 Oct 2018 06:19:02 -0400
Message-Id: <20181022101924.40531-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f74c371fe72a4f820d287db8067683fb533e4ede ]

syzbot was able to trigger rcu stalls by calling write()
with large number of bytes.

Add a cond_resched() in the loop to avoid this.

Link: https://lkml.org/lkml/2018/8/23/1106
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mousedev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index e08228061bcd..412fa71245af 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
 		mousedev_generate_response(client, c);
 
 		spin_unlock_irq(&client->packet_lock);
+		cond_resched();
 	}
 
 	kill_fasync(&client->fasync, SIGIO, POLL_IN);
-- 
2.17.1

