Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1010C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A4121A0E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A4121A0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeGGI3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:29:31 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:56220 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeGGI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:29:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 03287CDE;
        Sat,  7 Jul 2018 10:29:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id swi8oudA1U7S; Sat,  7 Jul 2018 10:29:27 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (dhcp-64-205.ens-lyon.fr [140.77.64.205])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 3BB5473E;
        Sat,  7 Jul 2018 10:29:27 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fbias-0001bB-Ox; Sat, 07 Jul 2018 10:29:26 +0200
Date:   Sat, 7 Jul 2018 10:29:26 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jann Horn <jannh@google.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
Message-ID: <20180707082926.66zbedgq5zqjfbjx@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jann Horn <jannh@google.com>, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org
References: <20180707015344.146672-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707015344.146672-1-jannh@google.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re,

Could you review, test, and resubmit the patch below instead?

Samuel


If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
the loop to copy as much data as available to the provided buffer. If
softsynthx_read() is invoked through sys_splice(), this causes an
unbounded kernel write; but even when userspace just reads from it
normally, a small size could cause userspace crashes.

Fixes: 425e586cf95b ("speakup: add unicode variant of /dev/softsynth")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -198,11 +198,15 @@ static ssize_t softsynthx_read(struct fi
 	int chars_sent = 0;
 	char __user *cp;
 	char *init;
+	size_t bytes_per_ch = unicode ? 3 : 1;
 	u16 ch;
 	int empty;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
 
+	if (count < bytes_per_ch)
+		return -EINVAL;
+
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	while (1) {
 		prepare_to_wait(&speakup_event, &wait, TASK_INTERRUPTIBLE);
@@ -228,7 +232,7 @@ static ssize_t softsynthx_read(struct fi
 	init = get_initstring();
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
-	while (chars_sent <= count - 3) {
+	while (chars_sent <= count - bytes_per_ch) {
 		if (speakup_info.flushing) {
 			speakup_info.flushing = 0;
 			ch = '\x18';
