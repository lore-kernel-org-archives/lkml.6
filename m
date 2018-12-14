Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A2C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0613214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789433;
	bh=H5Wxyz92SFTDvvKbKcK3/atOP/sXOPfLcws+6nQqJ3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aCDB46JDmGKGMMv7T6wJBmIFcIlAhxeqpac2gsQMZIqBbYJswJgP8+b4oxzDoMyVI
	 +tjdiBHmHwT0rVEcGYRiKlgA8bKE4bQTIbxfabN+7iBD9rv+iTuegLFGpTMBB6KUWC
	 x91x9K7rB9lcUox0jChipp9JtrVSBkLke/prvLuo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0613214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbeLNMKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbeLNMK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 994502133F;
        Fri, 14 Dec 2018 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789429;
        bh=H5Wxyz92SFTDvvKbKcK3/atOP/sXOPfLcws+6nQqJ3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdN2J8Wvockt4Rk0NTYUAOXOa1cMcWOJ6rU5PrqWjKQHNEnfaQ8tTwtUXblBR6A2D
         BXfLjt/VSurqD/uetKNII+5i90HBYDgrQmU/x/GT2lKptO0NbzCjUk4QDMFZjNRrlL
         3vgIaCm0RthoHFhpz+fXEmxiDlwey5msEaE9RblY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.14 79/89] Revert "printk: Never set console_may_schedule in console_trylock()"
Date:   Fri, 14 Dec 2018 13:00:32 +0100
Message-Id: <20181214115733.594242985@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit c9b8d580b3fb0ab65d37c372aef19a318fda3199.

This is just a technical revert to make the printk fix apply cleanly,
this patch will be re-picked in about 3 commits.
---
 kernel/printk/printk.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a9cf2e15f6a3..7161312593dd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1762,12 +1762,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched) {
-		/*
-		 * Disable preemption to avoid being preempted while holding
-		 * console_sem which would prevent anyone from printing to
-		 * console
-		 */
-		preempt_disable();
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore.  The release will print out buffers and wake up
@@ -1775,7 +1769,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		if (console_trylock())
 			console_unlock();
-		preempt_enable();
 	}
 
 	return printed_len;
@@ -2090,7 +2083,20 @@ int console_trylock(void)
 		return 0;
 	}
 	console_locked = 1;
-	console_may_schedule = 0;
+	/*
+	 * When PREEMPT_COUNT disabled we can't reliably detect if it's
+	 * safe to schedule (e.g. calling printk while holding a spin_lock),
+	 * because preempt_disable()/preempt_enable() are just barriers there
+	 * and preempt_count() is always 0.
+	 *
+	 * RCU read sections have a separate preemption counter when
+	 * PREEMPT_RCU enabled thus we must take extra care and check
+	 * rcu_preempt_depth(), otherwise RCU read sections modify
+	 * preempt_count().
+	 */
+	console_may_schedule = !oops_in_progress &&
+			preemptible() &&
+			!rcu_preempt_depth();
 	return 1;
 }
 EXPORT_SYMBOL(console_trylock);
-- 
2.19.1



