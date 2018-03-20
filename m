Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeCTCHJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:07:09 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35234 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750731AbeCTCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:07:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.02912532|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.BN7lK90_1521511614;
Date: Tue, 20 Mar 2018 10:06:54 +0800
From: Guo Ren <ren_guo@c-sky.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Subject: Re: [PATCH 06/19] csky: IRQ handling
Message-ID: <20180320020651.GA14709@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <28baa2d92e5c3145afdff68ca784075afbb64d88.1521399976.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1803191413300.2010@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803191413300.2010@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Mar 19, 2018 at 02:16:37PM +0100, Thomas Gleixner wrote:
> > +static inline unsigned long arch_local_irq_save(void)
> > +{
> > +	unsigned long flags;
> 
> Newline between declaration and code please.
OK

> > +void csky_do_IRQ(int irq, struct pt_regs *regs)
> 
> static? If not, then it needs a declaration in a header somewhere.
Yes, need static.

> > +asmlinkage void csky_do_auto_IRQ(struct pt_regs *regs)
> > +{
> > +	unsigned long irq, psr;
> > +
> > +	asm volatile("mfcr %0, psr":"=r"(psr));
> > +
> > +	irq = (psr >> 16) & 0xff;
> > +
> > +	if (irq == 10)
> > +		irq = csky_get_auto_irqno();
> > +	else
> > +		irq -= 32;
> 
> Please add a comment explaining this magic here. Magic numbers w/o
> explanation are bad.
Yes, you are right. I will fixup them next.

PSR is our Processor Status Register and it store the vector number.

'10' is our auto-interrupt exception entry and we need get the irqno
from the interrupt-controller.

The "vector num > 32" is our vector interrupt exception entries, so we
can calculate the irq-num by vector-num and no need to access the
interrupt-controller's io regs.

Best Regards
  Guo Ren
