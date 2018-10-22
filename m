Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D6C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFBA2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYqbEABq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFBA2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeJVSk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbeJVSk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:40:59 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A332089C;
        Mon, 22 Oct 2018 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203783;
        bh=4+QpwNejEyhKST9OuVCuWn5/RmoYMlqY86nZaE+2Q/I=;
        h=From:To:Cc:Subject:Date:From;
        b=OYqbEABqXL3pu8l3C4NcNP8y7KKU+tyfy2ue/h7/0blS0uj+NweZbTl6HjEuCJ/Fg
         qsqiyj6m+04joMzBm/ReK2L1L3bn80dPO4xHQb2GU51Ue/rxJ4nuVK15fQhq91BXy2
         DMG2RCI1tzMKx1ouFab2x8L+aGerCeIwuiTcf+RA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 1/4] Input: mousedev - add a schedule point in mousedev_write()
Date:   Mon, 22 Oct 2018 06:22:52 -0400
Message-Id: <20181022102255.41695-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
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
index b604564dec5c..036acf861496 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -701,6 +701,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
 		mousedev_generate_response(client, c);
 
 		spin_unlock_irq(&client->packet_lock);
+		cond_resched();
 	}
 
 	kill_fasync(&client->fasync, SIGIO, POLL_IN);
-- 
2.17.1

