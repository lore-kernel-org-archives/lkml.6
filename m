Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4009650-1520451629-2-9733740939316990751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451628; b=vmpV/sBMm+IE/XwzMjTnFQ5dMn5aYbkRKbvhg/EZn+As82g
    JJJu/TVTyt392s8BRQpN2JV9HM3bWmfaskiB2xTJcyfMiX/pahsZbiWYK4YuWq4b
    GRq2BLF27H3dJgpCrRBqVe4ZGng71uilQGt/xyM3M8O9fLYw0sbPfzZEGWBgIaaT
    mnIUYwmPcs7dA/nfUxkChV1AHEw86OaZfFWtwqwx0jDaTcPxfaT6Cywmf4qsbTZD
    vgb+HYvnmsqnJaaxz8THhFhQRug/m/fTSV0JkK3LIYcCNOQuzjluOsAKN8Tmxxdu
    MSo+uwIvWSQ/D/E2nNDdycoXHNUJZth2JVURKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451628; bh=K2cYsOQBGwBW1tZ0NB5qgKqex4
    zUqkyeh0yaEykKmm4=; b=BIci/gyoMPirpzu8Lp27D1Ez+9OkCJ5B4SR+D+MwAG
    gBbl9DKBTRzIzC+0Q9692QlopKGpNOHuNPZfnCcswPPtSvLTbIbD1l6EeoGaKSR1
    FCcqCLielUFeB5Nhm6SdrnaLYdvYokwqWD9ve78etrvxQNB6Rr+PtMeRbywkinJh
    PgLC9i1BwtbI7cyDuEI6oKiCXz+5r00rh6lIjgSdlOJkmW3E7D9IEOgzJNxevZno
    +g48HMbLk8PfdkcyzKxPZrR1ziJ4+7EuHe6aIi9QfyxsH4/lx0whoYXogZkn6FYt
    ZD1X60zWBKmEKbqPxBYYOeac1ScW5UXfIgJjn5bouZkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbeCGTkZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:40:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754778AbeCGTkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:40:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.15 025/122] parisc: Reduce irq overhead when run in qemu
Date: Wed,  7 Mar 2018 11:37:17 -0800
Message-Id: <20180307191732.908858756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 636a415bcc7f4fd020ece8fd5fc648c4cef19c34 upstream.

When run under QEMU, calling mfctl(16) creates some overhead because the
qemu timer has to be scaled and moved into the register. This patch
reduces the number of calls to mfctl(16) by moving the calls out of the
loops.

Additionally, increase the minimal time interval to 8000 cycles instead
of 500 to compensate possible QEMU delays when delivering interrupts.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/time.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -76,10 +76,10 @@ irqreturn_t __irq_entry timer_interrupt(
 	next_tick = cpuinfo->it_value;
 
 	/* Calculate how many ticks have elapsed. */
+	now = mfctl(16);
 	do {
 		++ticks_elapsed;
 		next_tick += cpt;
-		now = mfctl(16);
 	} while (next_tick - now > cpt);
 
 	/* Store (in CR16 cycles) up to when we are accounting right now. */
@@ -103,16 +103,17 @@ irqreturn_t __irq_entry timer_interrupt(
 	 * if one or the other wrapped. If "now" is "bigger" we'll end up
 	 * with a very large unsigned number.
 	 */
-	while (next_tick - mfctl(16) > cpt)
+	now = mfctl(16);
+	while (next_tick - now > cpt)
 		next_tick += cpt;
 
 	/* Program the IT when to deliver the next interrupt.
 	 * Only bottom 32-bits of next_tick are writable in CR16!
 	 * Timer interrupt will be delivered at least a few hundred cycles
-	 * after the IT fires, so if we are too close (<= 500 cycles) to the
+	 * after the IT fires, so if we are too close (<= 8000 cycles) to the
 	 * next cycle, simply skip it.
 	 */
-	if (next_tick - mfctl(16) <= 500)
+	if (next_tick - now <= 8000)
 		next_tick += cpt;
 	mtctl(next_tick, 16);
 
