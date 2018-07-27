Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3188520671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3188520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbeG0K0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:26:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51225 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbeG0K0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:26:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <sebastian.siewior@linutronix.de>)
        id 1fiygl-0003Bu-Ss; Fri, 27 Jul 2018 11:05:31 +0200
Date:   Fri, 27 Jul 2018 11:05:31 +0200
From:   Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
To:     Pintu Kumar <pintu.ping@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PREEMPT_RT]: Using printk-rt-aware.patch in non-rt kernel
Message-ID: <20180727090531.k3skngkw6qhr7utt@linutronix.de>
References: <CAOuPNLiK9tdHF6k+mNSqEQG92hA9oo4C+obhiwpjVOi_zaBZXw@mail.gmail.com>
 <CAOuPNLhTBdzj8B_u9f7FLXHwaA5KYVwPoy87LaZNhzLxbuifaQ@mail.gmail.com>
 <20180726153857.abxfebvxjcp4jqgx@linutronix.de>
 <CAOuPNLgXNMm20nuPPDtUoy3qTF9MLDTRNmsOsocYYLrXtS0rBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOuPNLgXNMm20nuPPDtUoy3qTF9MLDTRNmsOsocYYLrXtS0rBg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 23:38:05 [+0530], Pintu Kumar wrote:
> > > Is there a way we can fix this issue on non-rt kernel?
> > I would guess that a wakeup to klogd would fix it.
> >
> Sorry, can you elaborate more about "wakeup to klogd".
> I wanted to try it and check.

Something like this should do the work.

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 179ad787a08c..411f9ed5f051 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1927,6 +1927,8 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 	return log_store(facility, level, lflags, 0, dict, dictlen, text, text_len);
 }
 
+static void printk_flush_pending_output(void);
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const char *dict, size_t dictlen,
 			    const char *fmt, va_list args)
@@ -2026,6 +2028,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		if (may_trylock && console_trylock_spinning())
 			console_unlock();
+		else if (!may_trylock)
+			printk_flush_pending_output();
+
 		migrate_enable();
 	}
 
@@ -2987,6 +2992,13 @@ static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
 	.flags = IRQ_WORK_LAZY,
 };
 
+static void printk_flush_pending_output(void)
+{
+	/* preemption or interrupts need to be disabled */
+	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
+}
+
 void wake_up_klogd(void)
 {
 	preempt_disable();

Sebastian
