Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F84AC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461652087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2sTK3llQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461652087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeJVSjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbeJVSjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:39:36 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1021A20898;
        Mon, 22 Oct 2018 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203701;
        bh=3FHGt6W2v/tllxLFwIZ/CkwwOULmCIGoTU+gKDzkDj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2sTK3llQGLbrIDbydaSIzi1SssyGyCHRIaE7tVVmEWspKda69/2cJlqzCiT4zMkB6
         eUU8HMc3is/kdUj3mKwOHX2Am6Yhk8wTbXGVZHxfPmWtDbQSMwo5qlZVxTdQVwLjJd
         IALx/nLTY7eNvi/yV580gSPp6v4FlkgRntNa7bdY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 2/9] Input: mousedev - add a schedule point in mousedev_write()
Date:   Mon, 22 Oct 2018 06:21:26 -0400
Message-Id: <20181022102133.41222-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102133.41222-1-sashal@kernel.org>
References: <20181022102133.41222-1-sashal@kernel.org>
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
index 30328e57fdda..b63eec7972e6 100644
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

