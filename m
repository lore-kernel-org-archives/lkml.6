Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A961C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB56214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB56214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeKUGg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:36:27 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:47400 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeKUGg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:36:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id B91FA35A8;
        Tue, 20 Nov 2018 21:05:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UGCeDk08eBse; Tue, 20 Nov 2018 21:05:31 +0100 (CET)
Received: from function (unknown [212.51.165.254])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 4FDD235B2;
        Tue, 20 Nov 2018 21:05:31 +0100 (CET)
Received: from samy by function with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gPCH4-0005XY-Ul; Tue, 20 Nov 2018 21:05:30 +0100
Date:   Tue, 20 Nov 2018 21:05:30 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     akpm@linux-foundation.org, speakup@braille.uwo.ca,
        linux-kernel@vger.kernel.org
Subject: staging/speakup_soft: Fix alternate speech with other synths
Message-ID: <20181120200530.xlntzbyfrq3xjz6n@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        akpm@linux-foundation.org, speakup@braille.uwo.ca,
        linux-kernel@vger.kernel.org
References: <20181023193624.6oftkzsziwz5jm7o@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023193624.6oftkzsziwz5jm7o@function>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching from speakup_soft to another synth, speakup_soft would
keep calling synth_buffer_getc() from softsynthx_read.

Let's thus make synth.c export the knowledge of the current synth, so
that speakup_soft can determine whether it should be running.

speakup_soft also needs to set itself alive, otherwise the switch would
let it remain silent.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/staging/speakup/speakup_soft.c |   16 +++++++++++-----
 drivers/staging/speakup/spk_priv.h     |    1 +
 drivers/staging/speakup/synth.c        |    6 ++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -208,12 +208,15 @@ static ssize_t softsynthx_read(struct fi
 		return -EINVAL;
 
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	synth_soft.alive = 1;
 	while (1) {
 		prepare_to_wait(&speakup_event, &wait, TASK_INTERRUPTIBLE);
-		if (!unicode)
-			synth_buffer_skip_nonlatin1();
-		if (!synth_buffer_empty() || speakup_info.flushing)
-			break;
+		if (synth_current() == &synth_soft) {
+			if (!unicode)
+				synth_buffer_skip_nonlatin1();
+			if (!synth_buffer_empty() || speakup_info.flushing)
+				break;
+		}
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 		if (fp->f_flags & O_NONBLOCK) {
 			finish_wait(&speakup_event, &wait);
@@ -233,6 +236,8 @@ static ssize_t softsynthx_read(struct fi
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
 	while (chars_sent <= count - bytes_per_ch) {
+		if (synth_current() != &synth_soft)
+			break;
 		if (speakup_info.flushing) {
 			speakup_info.flushing = 0;
 			ch = '\x18';
@@ -329,7 +334,8 @@ static __poll_t softsynth_poll(struct fi
 	poll_wait(fp, &speakup_event, wait);
 
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
-	if (!synth_buffer_empty() || speakup_info.flushing)
+	if (synth_current() == &synth_soft &&
+	    (!synth_buffer_empty() || speakup_info.flushing))
 		ret = EPOLLIN | EPOLLRDNORM;
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 	return ret;
--- a/drivers/staging/speakup/spk_priv.h
+++ b/drivers/staging/speakup/spk_priv.h
@@ -72,6 +72,7 @@ int synth_request_region(unsigned long s
 int synth_release_region(unsigned long start, unsigned long n);
 int synth_add(struct spk_synth *in_synth);
 void synth_remove(struct spk_synth *in_synth);
+struct spk_synth *synth_current(void);
 
 extern struct speakup_info_t speakup_info;
 
--- a/drivers/staging/speakup/synth.c
+++ b/drivers/staging/speakup/synth.c
@@ -495,4 +495,10 @@ void synth_remove(struct spk_synth *in_s
 }
 EXPORT_SYMBOL_GPL(synth_remove);
 
+struct spk_synth *synth_current(void)
+{
+	return synth;
+}
+EXPORT_SYMBOL_GPL(synth_current);
+
 short spk_punc_masks[] = { 0, SOME, MOST, PUNC, PUNC | B_SYM };

