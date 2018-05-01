Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525171053; cv=none;
        d=google.com; s=arc-20160816;
        b=StvKGa4KcxB3VwV7NS1iwCCFJ6dXZDHTeNRwQnmuQWNNgl7T/FxsWTu6PIWJ2KA6aB
         qDjhMT7fMtKKZ/W7qYjxyekFv64Mbk29/ul+11sMM1UYh8Ix9A0qdeOQxVF1g0xgrcLp
         C9mXcPISdV8pDXNEAfVHNcPpSYh4CS0LHDR5aCPICv4sn7hbfdhdC8ZqyQJmnCeiHw/+
         jCiykEjs6Q3yGUSdndizlVN2yKaKWHFUinCqQATnA7f3lmFV5psMMHd8yogtgoJdSLmr
         LerPf9z0HVy4x5rdsb4yVl5jRxj5yedrN6sPD4X6KWBdy1iwpT6rWsG16QVT+NMwmnFK
         VZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=qqM9Ix5uTMTIrOp+o+dk0Yu4umfgT+/g2cubkx4MCKU=;
        b=vj4Vo7RTrTP9awELt++7Z7N2ckqdu6Zi7eXoeIGEyH5uLhlsSaLsVvn2jndkZylQjV
         lRAIJwubtyQpLkAs54znwJ7D//Kidmk4hjAT0uJ24KXPoOxWEqoECcGM8EgmfL1GMYSk
         TxBkvrpoYgLcQmIM7M9NU9CUZijq+mgQvZ+2bToeXshJP1ZhEAP4thq9j+D/tVsJ3Ks2
         Nqzcgh/o2sMYA6ABwbC97Soe/YFqZZPqmBABW6VDnnENjZHLFCgiruIxCn0sgeKQ/8Jc
         Fxvi3sNmisAZRG80ImSnGMt1V4h7a1wielFVXjzyR2nBl70qItbJPMi/MyYgzFsLh8uN
         8mbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gCsacTxT;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gCsacTxT;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp9/s26sxkJbCRMVPmAv7ibUCnpXbKXZXInTrVQbjMep9hLUQtEF5MKgMVEZLXLcF0WwfJuDQ==
Date: Tue, 1 May 2018 20:37:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby  <jslaby@suse.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] powerpc/powernv: implement opal_put_chars_atomic
Message-ID: <20180501203721.7b60fcd8@roar.ozlabs.ibm.com>
In-Reply-To: <1525168138.2325.100.camel@kernel.crashing.org>
References: <20180430145558.4308-1-npiggin@gmail.com>
	<20180430145558.4308-9-npiggin@gmail.com>
	<1525168138.2325.100.camel@kernel.crashing.org>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183467019394764?=
X-GMAIL-MSGID: =?utf-8?q?1599257762676898498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 01 May 2018 19:48:58 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2018-05-01 at 00:55 +1000, Nicholas Piggin wrote:
> > The RAW console does not need writes to be atomic, so relax
> > opal_put_chars to be able to do partial writes, and implement an
> > _atomic variant which does not take a spinlock. This API is used
> > in xmon, so the less locking that is used, the better chance there
> > is that a crash can be debugged.  
> 
> Same comment I already had :-) "atomic" in Linux tends to mean
> something else (ie, atomic context), so I'd rather have something
> like opal_put_chars_sync() or such...

Oh yeah, I didn't ignore you, just... I thought atomic was okay.
atomic *also* tends to mean happens atomically. I think the in
atomic context meaning actually tends to be inatomic.

Sync I actually thought could be more easily confused with
synchronous vs asynchronous here.

> 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/opal.h       |  1 +
> >  arch/powerpc/platforms/powernv/opal.c | 37 +++++++++++++++++++--------
> >  drivers/tty/hvc/hvc_opal.c            | 18 +++++++++----
> >  3 files changed, 41 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> > index bbff49fab0e5..5d7072411561 100644
> > --- a/arch/powerpc/include/asm/opal.h
> > +++ b/arch/powerpc/include/asm/opal.h
> > @@ -303,6 +303,7 @@ extern void opal_configure_cores(void);
> >  
> >  extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
> >  extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
> > +extern int opal_put_chars_atomic(uint32_t vtermno, const char *buf, int total_len);
> >  extern int opal_flush_console(uint32_t vtermno);
> >  
> >  extern void hvc_opal_init_early(void);
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> > index 55d4b1983110..bcdb90ada938 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -344,9 +344,9 @@ int opal_get_chars(uint32_t vtermno, char *buf, int count)
> >  	return 0;
> >  }
> >  
> > -int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
> > +static int __opal_put_chars(uint32_t vtermno, const char *data, int total_len, bool atomic)
> >  {
> > -	unsigned long flags;
> > +	unsigned long flags = 0 /* shut up gcc */;
> >  	int written;
> >  	__be64 olen;
> >  	s64 rc;
> > @@ -354,11 +354,8 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
> >  	if (!opal.entry)
> >  		return -ENODEV;
> >  
> > -	/* We want put_chars to be atomic to avoid mangling of hvsi
> > -	 * packets. To do that, we first test for room and return
> > -	 * -EAGAIN if there isn't enough.
> > -	 */
> > -	spin_lock_irqsave(&opal_write_lock, flags);
> > +	if (atomic)
> > +		spin_lock_irqsave(&opal_write_lock, flags);
> >  	rc = opal_console_write_buffer_space(vtermno, &olen);
> >  	if (rc || be64_to_cpu(olen) < total_len) {
> >  		/* Closed -> drop characters */
> > @@ -391,14 +388,18 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
> >  
> >  	written = be64_to_cpu(olen);
> >  	if (written < total_len) {
> > -		/* Should not happen */
> > -		pr_warn("atomic console write returned partial len=%d written=%d\n", total_len, written);
> > +		if (atomic) {
> > +			/* Should not happen */
> > +			pr_warn("atomic console write returned partial "
> > +				"len=%d written=%d\n", total_len, written);
> > +		}
> >  		if (!written)
> >  			written = -EAGAIN;
> >  	}
> >  
> >  out:
> > -	spin_unlock_irqrestore(&opal_write_lock, flags);
> > +	if (atomic)
> > +		spin_unlock_irqrestore(&opal_write_lock, flags);
> >  
> >  	/* In the -EAGAIN case, callers loop, so we have to flush the console
> >  	 * here in case they have interrupts off (and we don't want to wait
> > @@ -412,6 +413,22 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
> >  	return written;
> >  }
> >  
> > +int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
> > +{
> > +	return __opal_put_chars(vtermno, data, total_len, false);
> > +}
> > +
> > +/*
> > + * opal_put_chars_atomic will not perform partial-writes. Data will be
> > + * atomically written to the terminal or not at all. This is not strictly
> > + * true at the moment because console space can race with OPAL's console
> > + * writes.
> > + */
> > +int opal_put_chars_atomic(uint32_t vtermno, const char *data, int total_len)
> > +{
> > +	return __opal_put_chars(vtermno, data, total_len, true);
> > +}
> > +
> >  int opal_flush_console(uint32_t vtermno)
> >  {
> >  	s64 rc;
> > diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> > index af122ad7f06d..0a72f98ee082 100644
> > --- a/drivers/tty/hvc/hvc_opal.c
> > +++ b/drivers/tty/hvc/hvc_opal.c
> > @@ -183,9 +183,15 @@ static int hvc_opal_probe(struct platform_device *dev)
> >  			return -ENOMEM;
> >  		pv->proto = proto;
> >  		hvc_opal_privs[termno] = pv;
> > -		if (proto == HV_PROTOCOL_HVSI)
> > -			hvsilib_init(&pv->hvsi, opal_get_chars, opal_put_chars,
> > +		if (proto == HV_PROTOCOL_HVSI) {
> > +			/*
> > +			 * We want put_chars to be atomic to avoid mangling of
> > +			 * hvsi packets.
> > +			 */
> > +			hvsilib_init(&pv->hvsi,
> > +				     opal_get_chars, opal_put_chars_atomic,
> >  				     termno, 0);
> > +		}
> >  
> >  		/* Instanciate now to establish a mapping index==vtermno */
> >  		hvc_instantiate(termno, termno, ops);
> > @@ -376,8 +382,9 @@ void __init hvc_opal_init_early(void)
> >  	else if (of_device_is_compatible(stdout_node,"ibm,opal-console-hvsi")) {
> >  		hvc_opal_boot_priv.proto = HV_PROTOCOL_HVSI;
> >  		ops = &hvc_opal_hvsi_ops;
> > -		hvsilib_init(&hvc_opal_boot_priv.hvsi, opal_get_chars,
> > -			     opal_put_chars, index, 1);
> > +		hvsilib_init(&hvc_opal_boot_priv.hvsi,
> > +			     opal_get_chars, opal_put_chars_atomic,
> > +			     index, 1);
> >  		/* HVSI, perform the handshake now */
> >  		hvsilib_establish(&hvc_opal_boot_priv.hvsi);
> >  		pr_devel("hvc_opal: Found HVSI console\n");
> > @@ -409,7 +416,8 @@ void __init udbg_init_debug_opal_hvsi(void)
> >  	hvc_opal_privs[index] = &hvc_opal_boot_priv;
> >  	hvc_opal_boot_termno = index;
> >  	udbg_init_opal_common();
> > -	hvsilib_init(&hvc_opal_boot_priv.hvsi, opal_get_chars, opal_put_chars,
> > +	hvsilib_init(&hvc_opal_boot_priv.hvsi,
> > +		     opal_get_chars, opal_put_chars_atomic,
> >  		     index, 1);
> >  	hvsilib_establish(&hvc_opal_boot_priv.hvsi);
> >  }  
