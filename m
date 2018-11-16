Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9786DC04EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644562082A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644562082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbeKPKhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:37:40 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:54000 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388965AbeKPKhk (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 05:37:40 -0500
Received: from linux-r8p5.psav.com (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 15 Nov 2018 17:27:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org
Subject: [PATCH 1/6] locking/mutex: Remove caller signal_pending branch predictions
Date:   Thu, 15 Nov 2018 16:27:08 -0800
Message-Id: <20181116002713.8474-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181116002713.8474-1-dave@stgolabs.net>
References: <20181116002713.8474-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already done for us internally by the signal machinery.

Cc: peterz@infradead.org
Cc: mingo@kernel.org
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/locking/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3f8a35104285..db578783dd36 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -987,7 +987,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 * wait_lock. This ensures the lock cancellation is ordered
 		 * against mutex_unlock() and wake-ups do not go missing.
 		 */
-		if (unlikely(signal_pending_state(state, current))) {
+		if (signal_pending_state(state, current)) {
 			ret = -EINTR;
 			goto err;
 		}
-- 
2.16.4

