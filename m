Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELtbZLeJkFNVTRRG/F0nXuVJkoMe98/22AVrSCgUneAGqMiyMXFBwe1G68W456ODgm5FZE7m
ARC-Seal: i=1; a=rsa-sha256; t=1519836594; cv=none;
        d=google.com; s=arc-20160816;
        b=g9c/pZXsZkoTNQhNkZx1Yxu4+YsxaMiMUmMj7NFlFIzxphiisQTBa/jIkyRDE/1+Y/
         YkN8lq9EPR6BSLs/dr4PxRxFWVGKF4mVfvvXf/cyDCTbE5YlDq6LB06f4ObCkJXAPjZS
         2vNtZhEEHR8jLHYiTg2rBsxx6ls/s0PywxnMpzmPtQPshwEs8nzreOqwzuzpxSamDkGP
         sCNQryHGMHGr+g7fdwhZgb8TROfMstPLlKU6tploH22xAXO7zGrepk5cpnTxmTj4uDSX
         iXWYHYXnPc8KHHv0o1Y2VOpkfUe0dBxdm71wZePJrW/EoGEQK/Q1/vaNk0ray08YFtMq
         tvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=HMRvxqpyciqVIGkxCdscmP6b0P742Bk4rxfeXhZwaeQ=;
        b=ODeae/3wi//x1M6Ri1f1kcVH9mUNsuEUkJCAKdCvvqsjLtzEOpN7LPvR6xtrqtYsm5
         5o6mK1UD+t2SIJLnDe7Eb3BH8WBp57Lv4jxspjo9wv5BHNCtaCH95t5boinjuKwCee1a
         txx/Xs32fYWEid9+jJQ6dXfr4geS0+y/o15PZnr013LGMlne1V5j5F+iAZhCAiKkK4gi
         yqghzJ737D/luRZX7WE96UA+ICQ+15KToa7f4bZAKmpMrvuY5Al7qLi6bpK7bgNXIOZ2
         QOpAf195ynyZctu0SVp1JVtvLh+1YZGMw9prJFThQ4CdSjHSEi6FZlsk0B45PbW1zJ8w
         MtCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Wed, 28 Feb 2018 17:49:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org,
    Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 4.4 33/53] x86/apic/vector: Fix off by one in error
 path
In-Reply-To: <alpine.DEB.2.21.1802171433390.2087@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1802281730310.1392@nanos.tec.linutronix.de>
References: <20180122083910.299610926@linuxfoundation.org>  <20180122083911.776154720@linuxfoundation.org> <1518814661.3422.42.camel@codethink.co.uk> <alpine.DEB.2.21.1802171433390.2087@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1929272789-1519836591=:1392"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590281458787974242?=
X-GMAIL-MSGID: =?utf-8?q?1593664176588114559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1929272789-1519836591=:1392
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 17 Feb 2018, Thomas Gleixner wrote:
> On Fri, 16 Feb 2018, Ben Hutchings wrote:
> > On Mon, 2018-01-22 at 09:40 +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > commit 45d55e7bac4028af93f5fa324e69958a0b868e96 upstream.
> > > 
> > > Keith reported the following warning:
> > > 
> > > WARNING: CPU: 28 PID: 1420 at kernel/irq/matrix.c:222 irq_matrix_remove_managed+0x10f/0x120
> > >   x86_vector_free_irqs+0xa1/0x180
> > >   x86_vector_alloc_irqs+0x1e4/0x3a0
> > >   msi_domain_alloc+0x62/0x130
> > > 
> > > The reason for this is that if the vector allocation fails the error
> > > handling code tries to free the failed vector as well, which causes the
> > > above imbalance warning to trigger.
> > > 
> > > Adjust the error path to handle this correctly.
> > > 
> > > Fixes: b5dc8e6c21e7 ("x86/irq: Use hierarchical irqdomain to manage CPU interrupt vectors")
> > > Reported-by: Keith Busch <keith.busch@intel.com>
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Tested-by: Keith Busch <keith.busch@intel.com>
> > > Cc: stable@vger.kernel.org
> > > Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801161217300.1823@nanos
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > ---
> > >  arch/x86/kernel/apic/vector.c |    7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > --- a/arch/x86/kernel/apic/vector.c
> > > +++ b/arch/x86/kernel/apic/vector.c
> > > @@ -359,14 +359,17 @@ static int x86_vector_alloc_irqs(struct
> > >  		irq_data->chip_data = data;
> > >  		irq_data->hwirq = virq + i;
> > >  		err = assign_irq_vector_policy(virq + i, node, data, info);
> > > -		if (err)
> > > +		if (err) {
> > > +			irq_data->chip_data = NULL;
> > > +			free_apic_chip_data(data);
> > >  			goto error;
> > 
> > This doesn't look quite right for 4.4.y (or any stable branch before
> > 4.15.y).  When virq is a legacy IRQ this function doesn't allocate
> > "data" and shouldn't free it.
> 
> Bah. I'm a moron. Lemme look at that.

Delta patch which fixes this below.

Thanks,

	tglx

8<----------------------------------
Subject: x86/apic/vector: Handle legacy irq data correctly
From: Thomas Gleixner <tglx@linutronix.de>

The backport of upstream commit 45d55e7bac40 ("x86/apic/vector: Fix off by
one in error path") missed to fixup the legacy interrupt data which is not
longer available upstream.

Handle legacy irq data correctly by clearing the legacy storage to prevent
use after free.

Fixes: 7fd133539289 ("x86/apic/vector: Fix off by one in error path") - 4.4.y
Fixes: c557481a9491 ("x86/apic/vector: Fix off by one in error path") - 4.9.y
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -91,8 +91,12 @@ static struct apic_chip_data *alloc_apic
 	return NULL;
 }
 
-static void free_apic_chip_data(struct apic_chip_data *data)
+static void free_apic_chip_data(unsigned int virq, struct apic_chip_data *data)
 {
+#ifdef	CONFIG_X86_IO_APIC
+	if (virq  < nr_legacy_irqs())
+		legacy_irq_data[virq] = NULL;
+#endif
 	if (data) {
 		free_cpumask_var(data->domain);
 		free_cpumask_var(data->old_domain);
@@ -316,11 +320,7 @@ static void x86_vector_free_irqs(struct
 			apic_data = irq_data->chip_data;
 			irq_domain_reset_irq_data(irq_data);
 			raw_spin_unlock_irqrestore(&vector_lock, flags);
-			free_apic_chip_data(apic_data);
-#ifdef	CONFIG_X86_IO_APIC
-			if (virq + i < nr_legacy_irqs())
-				legacy_irq_data[virq + i] = NULL;
-#endif
+			free_apic_chip_data(virq + i, apic_data);
 		}
 	}
 }
@@ -361,7 +361,7 @@ static int x86_vector_alloc_irqs(struct
 		err = assign_irq_vector_policy(virq + i, node, data, info);
 		if (err) {
 			irq_data->chip_data = NULL;
-			free_apic_chip_data(data);
+			free_apic_chip_data(virq + i, data);
 			goto error;
 		}
 	}

--8323329-1929272789-1519836591=:1392--
