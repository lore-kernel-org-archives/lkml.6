Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451906-2-6964636180029402835
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
    t=1520451905; b=PQ8AOivNXMPrh25xZa0ojkCYeGxVDanMOqMR9zhBv+DMHAC
    QPA3rgbhAqmwFgY07qVYsibV4cBe5yK22AZYsyIZ9liiMgljSl1VErQDjpDXRmML
    b7sNp61DzRs+iIGL38RNyK5Y/zpDGzud92WDJ/pxg0fKd6RHDjh8XSoofnOF/Wr0
    irmdKwjyhFqZKb0PdinEDmugAioOJTdhCgBpE1i0GXeC2nJE4nE6hG6CLcnPj0ns
    0+RqlHZMrlAPdb4bVPuq8rN5AxSSy1Wd7YCP2ym4ENiesiQZWRGOvmgS5oGdzc91
    Rwve6p6HU0bLB6MjkaaN/h39OUIaaG/DTGWxEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451905; bh=7z1PgoAAvCHq5g1O4S2UE8ayOv
    6pR8Zow9YXihbXb8w=; b=k+lehidL9FhLv7xFJ4vW1gX+KvltWZkICAaAaUKZwM
    Ykwo20jeFOOpMhWoELBCdFu9I0j7sXZG9ZdV/DuNcQd7j9mCuxg2lRKL6mdBdgfi
    kQpetJMFyoUyZf2/z3SFrbtZ3akTBKOihi/xHQuG3mgvIZ2E3HVzj6COhDcX7gqi
    NaFqSs+L4ZB4lcKlKKm/n68MqXtEDhQoI1tKtVRbJL66Q4CLe9aUQiLWKyQuqNtw
    FCpmLE/8rU1mHk7ArO5ioyjHNKQqv3P8PcLZ5NCy9FAognuskyH1GpdQxNcYpNbv
    wJuJsN5UJVaKjNYoyhn1e4/pjQn0YoOD7n2EWwP0Y+pg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S965204AbeCGTpB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:45:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965182AbeCGTo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:44:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.14 022/110] parisc: Reduce irq overhead when run in qemu
Date: Wed,  7 Mar 2018 11:38:05 -0800
Message-Id: <20180307191042.523045231@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
