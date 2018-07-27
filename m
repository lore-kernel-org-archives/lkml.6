Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE95C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D6020894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D6020894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbeG0LYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:24:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbeG0LYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:24:11 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 304FDBB6;
        Fri, 27 Jul 2018 10:03:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 4.14 33/48] staging: speakup: fix wraparound in uaccess length check
Date:   Fri, 27 Jul 2018 12:00:18 +0200
Message-Id: <20180727095921.983735959@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

commit b96fba8d5855c3617adbfb43ca4723a808cac954 upstream.

If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
the loop to copy as much data as available to the provided buffer. If
softsynthx_read() is invoked through sys_splice(), this causes an
unbounded kernel write; but even when userspace just reads from it
normally, a small size could cause userspace crashes.

Fixes: 425e586cf95b ("speakup: add unicode variant of /dev/softsynth")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/speakup/speakup_soft.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -207,11 +207,15 @@ static ssize_t softsynthx_read(struct fi
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
@@ -237,7 +241,7 @@ static ssize_t softsynthx_read(struct fi
 	init = get_initstring();
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
-	while (chars_sent <= count - 3) {
+	while (chars_sent <= count - bytes_per_ch) {
 		if (speakup_info.flushing) {
 			speakup_info.flushing = 0;
 			ch = '\x18';


