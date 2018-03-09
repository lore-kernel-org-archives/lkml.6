Return-Path: <kernel-hardening-return-12329-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELscmEopVBATx2ER5uTHsa2zEN1Ggwf8RxCjZAx5YbKuLsfLsZ/i4T0vm7FkBZVYfNWvGBrd
ARC-Seal: i=1; a=rsa-sha256; t=1520610591; cv=none;
        d=google.com; s=arc-20160816;
        b=DJDd/T9lNkG0sUU7U+g1+edhJe//GtfWewTpvZ1dmmb36EI2KrzcHoBnqik3kKsDOR
         TXdsDq5/PSJ1arpLbBx9IiWAhOHK3BDB11K+orlrxs7rOBDFubaKbPDFUU3xxnYfJGDc
         CzpUKhlK87OuykFR0tFkc5Jfh84NcwVSfUYLoneHYqARBkB5E0Yp2ue0k5HrC38Tdgbk
         Kr1HKRRfaht9cima87mr9RfnJUwO2YNWipIMLPXMRCKxIapRy5Ui1JYgiQ4mlxHNFOM7
         EfHvJDararyqDS3esN7efGXTjZNiDLRkxIXISRP++YlJvNKiuImreh/FjA/bD0aIR791
         zNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Wd9z+yhuLY4pR/H1sjTtRhp8NCdZaF1EgaZBi+DxM3E=;
        b=lLZ9nSqiPG7xAfakRob+aKccEqErF5U5KtcS6RQeoy5+0DSIU8tU6E02Pmudt1xnI1
         A0YLsH/3yi+k6VvtA6FuUQegRq48EJOfQiBSNNm3GBgqj0alxf35DexGNVb998/+ffWx
         PFaWxwX4x3UJs0T4lUGdqzOcTk/eb76+rHn0D65TIqOtVTonuBwTjGVf9qXgpDoGI5fd
         ztA5mwvVoARu7/rLs56ii9xqlDvNlBZtDeUKBd2ZnPaneA2Uo0pJCHKQFVEtnrMF/Lit
         h7rTDeQkoN4QqswNQPRY2ZIlLEumogSWUjwd7EcCY80Cgfymx5z7glhb6Jd8IWPIw2IE
         Z49w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12329-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12329-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12329-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12329-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 16:49:28 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: linux-kernel@vger.kernel.org,
    Segher Boessenkool <segher@kernel.crashing.org>,
    kernel-hardening@lists.openwall.com
Subject: Re: [PATCH][RFC] rslib: Remove VLAs by setting upper bound on
 nroots
In-Reply-To: <20180309144613.GA48965@beast>
Message-ID: <alpine.DEB.2.21.1803091610120.1364@nanos.tec.linutronix.de>
References: <20180309144613.GA48965@beast>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594471791016821837?=
X-GMAIL-MSGID: =?utf-8?q?1594475771478174937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018, Kees Cook wrote:

> Avoid VLAs[1] by always allocating the upper bound of stack space
> needed. The existing users of rslib appear to max out at 32 roots,
> so use that as the upper bound.

I think 32 is plenty. Do we have actually a user with 32?

> Alternative: make init_rs() a true caller-instance and pre-allocate
> the workspaces. Will this need locking or are the callers already
> single-threaded in their use of librs?

init_rs() is an init function which needs to be invoked _before_ the
decoder/encoder can be used.

The way it works today that it can share the rs_control between users to
avoid duplicating the polynom arrays and the setup of them.

So we might change how rs_control works and allocate rs_control for each
invocation of init_rs(). That means we need two data structures:

Rename rs_control to rs_poly and just use that internaly for sharing the
polynom arrays.

rs_control then becomes:

struct rs_control {
	struct rs_poly	*poly;
	uint16_t	lamda[MAX_ROOTS + 1];
	....
	uint16_t	loc[MAX_ROOTS];
};

But as you said that requires serialization or separation at the usage
sites.

drivers/mtd/nand/* would either need a mutex or allocate one rs_control per
instance. Simple enough to do.

drivers/md/dm-verity-fec.c looks like it's allocating a dm control struct
for each worker thread, so that should just require allocating one
rs_control per worker then.

pstore only has an issue in case of OOPS. A simple solution would be to
allocate two rs_control structs, one for regular usage and one for the OOPS
case. Not sure if that covers all possible problems, so that needs more
thoughts.

Thanks,

	tglx
