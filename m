Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6049E20C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6049E20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeGQJjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:39:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40485 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeGQJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:39:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ffLxj-0001lX-7c; Tue, 17 Jul 2018 09:08:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] userfaultfd: remove redundant pointer uwq
Date:   Tue, 17 Jul 2018 10:08:02 +0100
Message-Id: <20180717090802.18357-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer uwq is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'uwq' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/userfaultfd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 594d192b2331..0bc422ae8a46 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1847,17 +1847,14 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct userfaultfd_ctx *ctx = f->private_data;
 	wait_queue_entry_t *wq;
-	struct userfaultfd_wait_queue *uwq;
 	unsigned long pending = 0, total = 0;
 
 	spin_lock(&ctx->fault_pending_wqh.lock);
 	list_for_each_entry(wq, &ctx->fault_pending_wqh.head, entry) {
-		uwq = container_of(wq, struct userfaultfd_wait_queue, wq);
 		pending++;
 		total++;
 	}
 	list_for_each_entry(wq, &ctx->fault_wqh.head, entry) {
-		uwq = container_of(wq, struct userfaultfd_wait_queue, wq);
 		total++;
 	}
 	spin_unlock(&ctx->fault_pending_wqh.lock);
-- 
2.17.1

