Return-Path: <kernel-hardening-return-13132-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZraP45C01y6HIE2de58G3FjTPm7GK3BtnesxelyNSyf11teJtIjMMq2GHNCdJ++q/xRHjMg
ARC-Seal: i=1; a=rsa-sha256; t=1524646819; cv=none;
        d=google.com; s=arc-20160816;
        b=onnC8YXYmGq8fl24SEXH860Wzfs08JuSBfD21delkkMakAQ5SeoCL8z37QNWbYW8Ir
         rVg9kimR/66W86awWPUJ1DeV0BUnmUct2y+SnFXBIH5DCVohsbd6no6wqNfnwOXM8GOe
         cDhrkvzGLgqz5drveyw56N5+yIzQAFLVp8n9bl5qjVOWdlbPGwLwk9fRYD5QyTwMu+T/
         GhTEtXTslh2SINOMOiViSylfL0eTO7NUKGb0m3uJ/J2x4LvrJ4l1msmpKpcSCoDs+CK+
         OBIWbkgUKFlNHljUrkg3tZ4/7V4C0U8S0KaFgPI2+62V7DKCEF2htDG4SXLgOjcQWwzH
         DQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=STqOVT3v23VV5NcEnYRI/NEMdyv1otkGba11TIVVtKI=;
        b=FpJRRjM5JiF0FPp+azkC/e1r/qekwel9W1d5cMeBnJhf2q3BEA9rpcxXX9X0mN8F3i
         o4fsn8LUJpl6AQkTfFcuFvoDiQcJM3y0rbht8m3CnSzCvaUnQdrKr/A22jXbSx0VnXt/
         I8dVMOSdzuNI3teyf+IEs/fdoa2LGifEPmq4zPenUSOHMMshYIZ2HJnb6pom02JFjZrp
         R4XmrPXVmSeUng3msbU+I/rRTZ9CM69396hz/7hQWXzbw3Ss4NFlQG6vOd/tZskM9SG2
         fLMCdVIrWJiwgiRlefNU0aN2aTI4CJiDGp1tX4WGVeGIudWiTHlRU7+q1Y5Tf+AKKAV2
         ZwUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13132-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13132-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13132-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13132-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 25 Apr 2018 10:59:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
    LKML <linux-kernel@vger.kernel.org>,
    Segher Boessenkool <segher@kernel.crashing.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    Andrew Morton <akpm@linuxfoundation.org>,
    Boris Brezillon <boris.brezillon@free-electrons.com>,
    Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
    Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
    Tony Luck <tony.luck@intel.com>, Neil Brown <neilb@suse.com>
Subject: Re: [patch V3 01/10] rslib: Add GFP aware init function
In-Reply-To: <CAGXu5jLUgNGW-SXY3L2fJrBV3PpmAH9uXFV87xmPe14BrYnWMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804251059100.2082@nanos.tec.linutronix.de>
References: <20180422162345.004292133@linutronix.de> <20180422162512.363154748@linutronix.de> <20180425111617.2f4dc127@canb.auug.org.au> <CAGXu5jLUgNGW-SXY3L2fJrBV3PpmAH9uXFV87xmPe14BrYnWMw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464733406749436?=
X-GMAIL-MSGID: =?utf-8?q?1598708063651400916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 24 Apr 2018, Kees Cook wrote:
> On Tue, Apr 24, 2018 at 6:16 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Sun, 22 Apr 2018 18:23:46 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:
> >> +static inline struct rs_control *init_rs(int symsize, int gfpoly, int fcr,
> >> +                                      int prim, int nroots)
> >> +{
> >> +     return init_rs_gfp(symsize, gfpoly, fcr, prim, nroots, GFP_KERNEL);
> >> +}
> >> +
> >
> > The version of this patch that Kees has committed to his kspp tree in linux-next has
> >
> > #include <linux/slab.h>
> >
> > why not just
> >
> > #include <linux/types.h>        /* for gpf_t */
> > #include <linux/gpf.h>          /* for GFP_KERNEL */
> >
> > ?

Sure

> We could certainly switch to that. (Why doesn't gfp.h include types.h?)

Excellent question.

Thanks,

	tglx
