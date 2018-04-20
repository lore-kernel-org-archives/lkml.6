Return-Path: <kernel-hardening-return-13068-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+o8YDD7vCz3w+TbBa1BKZ8ZHhU23RCxiTF77tOveb9RUQzNIpPecQKFiMrhpQcyGgq2oZ8
ARC-Seal: i=1; a=rsa-sha256; t=1524214204; cv=none;
        d=google.com; s=arc-20160816;
        b=j63CoDZ5D2VKHI8uT9TtA/ljXNpv1ziLSfyhX8A1ZOKFcy1zsTLRM/RGmcUB6SUtnN
         lrzfFjbE9gXGO+1o5FnxK+fud7kKm3Wgv3RL8617jgexK5CpFhjJTZNYSGKIt/QLwFS2
         Fb2mtMrgddrmQpJbQYCB9YEZCv07wi9tZbEP7NwnyM5e0aLOH41yMcNT23ScGR45Nq2R
         6Szt2f5w0KjyeOfzN1Mcl50tgc4NeMB8r9wqfCW99kHpgVh/KSbeQ9yoDNDKueZfj9Jm
         P4KFhLHfGkzduxxdpb+1dGmGdG8drrUkJ6talSUMXnPiAD5E5h53EGyJ3rxyOHXIQcjM
         Y9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=OKrD6wc5JxlZdqda6X59wyVoJE+kKITY7/n2AVZqRNM=;
        b=eaN2CI4sfeJ9wZj+QqaoH0raE/v9oKO9IVrDBno7xouNOLKXXLMbJgDsE4i30GkK0u
         V3ObIyoWhJWf6FavHrd/tbt0yyjsebPut/4uKyYocILeLQw2kR78Kikn/uoC24rfZZp6
         WZjvmpB3Dv4KbIecA5ywe3Gnyn55u11jc0ri5x+/H06OZtwVU4UwMi2RnFgi6XkW59pT
         soz3jx+dI5lrGINDyb88Lk6bmKUX0vMFW08Yd8fEvEOd3J+/QI9T7aDShRGo4ufEXLlH
         8TZlQgOWSnCKJsR/PBXyWTzf/juAKQAQWo9E9/iaVvM9SzdCS3hubLtn+WQFidhUcxUU
         6IWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13068-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13068-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13068-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13068-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 20 Apr 2018 10:49:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: NeilBrown <neilb@suse.com>
cc: Mike Snitzer <snitzer@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
    Kees Cook <keescook@chromium.org>,
    Segher Boessenkool <segher@kernel.crashing.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    Andrew Morton <akpm@linuxfoundation.org>,
    Boris Brezillon <boris.brezillon@free-electrons.com>,
    Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
    Alasdair Kergon <agk@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
    Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [patch V2 7/8] dm verity fec: Check result of init_rs()
In-Reply-To: <87o9ieq1ud.fsf@notabene.neil.brown.name>
Message-ID: <alpine.DEB.2.21.1804201040420.1683@nanos.tec.linutronix.de>
References: <20180419100441.548834519@linutronix.de> <20180419100935.340306831@linutronix.de> <20180419134647.GA9817@redhat.com> <alpine.DEB.2.21.1804191551520.19539@nanos.tec.linutronix.de> <87o9ieq1ud.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168985985100525?=
X-GMAIL-MSGID: =?utf-8?q?1598254434022414646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018, NeilBrown wrote:
> On Thu, Apr 19 2018, Thomas Gleixner wrote:
> > The analysis above forgot to look at the mempool->alloc() callback. So yes,
> > while the NOIO is good at the mempool level, but init_rs() uses GPF_KERNEL
> > so there might be a different can of wurms lurking.
> 
> The ->alloc call back is not relevant to the question of when
> mempool_alloc() can return NULL.
> If the ->alloc() callback returns a non-NULL value, it will be returned
> by mempool_alloc().
> If it returns NULL, that will not be returned.

Yes, as I said before, I missed the NOIO flag.

> 
> mempool_alloc() *only* returns NULL in one place:
> 
> 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
> 		spin_unlock_irqrestore(&pool->lock, flags);
> 		return NULL;
> 	}
> 
> so a NULL return is purely dependent on the GFP flags passed.
> GFP_NOIO contains __GFP_DIRECT_RECLAIM, so NULL cannot be returned.
> 
> It seems quite broken that init_rs() uses GFP_KERNEL. It should take a
> gfp_t arg for the allocation.

Well, init_rs() was that way before somebody used it in a mempool_alloc()
callback. And all other users are fine with GFP_KERNEL AFAICT.

> If the mempool_alloc() above really needs GFP_NOIO, then it could
> theoretically deadlock as it performs a GFP_KERNEL allocation inside
> rs_init().  So in that sense, the code is not correct as-is.
> It could possibly be fixed by calling memalloc_noio_save() /
> memalloc_noio_restore() around the call to init_rs() in fec_rs_alloc().

No, we surely can add a gfp aware version of init_rs(). It's trivial enough
to do.

Thanks,

	tglx
