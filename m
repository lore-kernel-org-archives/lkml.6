Return-Path: <kernel-hardening-return-13050-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/JLL/wAGTWJsdQvQW8WR1Ko84MULIzksmmzpP9Hnz+aaYdXeII9KOqH9O889nRK5Su8VkX
ARC-Seal: i=1; a=rsa-sha256; t=1524125846; cv=none;
        d=google.com; s=arc-20160816;
        b=M5go/BaD/aNO5OvJ6f67/83fwkEBgBbPKpTjHcsybF7KcTKPYv4kitlFzzmiJA2Y2t
         aCKrwQXyfqWTqz+43TMrCRskOdcPtluktoObJ6ctl9MaJOPTBvpg/4Ik6p5PXS3+tnxh
         j0JwrdwXaDHXVCvSpSu4wHCFEFjYcI+GyUEamtIDMoPlZbo/ezK4BtmkZPjb4KP7sGBx
         YKrWhHQKf1w4qNI31CZlUR4knEN/w38EC1jOmB/bfSbVdS21w8ZuscVeW7CBCcZGcjm1
         oPvowUIOccPZExOiDLxcCaZwPfzBlgRVuxj/cuSA/ytHtykZOwcj/PPxPRXtyQ1BW/kQ
         0AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=GObqzVgOtL29/IdomQ3swlimzDO1aRHCfQFtgvz+BlI=;
        b=lK9yd6u70c3ZWaOe+uIlX+NxeyAGT2tLtqMEdNLGfrAWYp5nujckei/qHpqZN0ePiX
         wjZ6HHZT79vVbxpdrOrJ2su7h+5OM8c3ZSnP/v43CS8lwDJlm5oPnmFBDCYXutnGR0yo
         3WPPm6/2LLN1mHuURJ86EtuhlVtLNS66U7SFz03pJJNDic2knXIcWw30vaeUF7suSDuY
         rJM+0KHp0Y+6DfdwOxTsNAc7hhrxr68lsNBSBV3fWcdUMBuGQrWBcKoL9jCOqwld057h
         mhMHGBd+liMGml3pnXeKEPyqh+iqRXFZKv9HZ5B4ciDoFyuZLkTZXlt4FrFDaGMHL+FJ
         nWhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13050-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13050-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13050-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13050-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 19 Apr 2018 10:16:51 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: Boris Brezillon <boris.brezillon@bootlin.com>,
    LKML <linux-kernel@vger.kernel.org>,
    Segher Boessenkool <segher@kernel.crashing.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    Andrew Morton <akpm@linuxfoundation.org>,
    Boris Brezillon <boris.brezillon@free-electrons.com>,
    Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
    Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
    Tony Luck <tony.luck@intel.com>
Subject: Re: [patch 5/8] rslib: Split rs control struct
In-Reply-To: <CAGXu5j+rckvb94YhdqUhRhuG=RtjN+S9QArAhwVWPj8mbPom+w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804191014510.1788@nanos.tec.linutronix.de>
References: <20180328205138.301218351@linutronix.de> <20180328205554.666762229@linutronix.de> <20180404214007.31a5fbc6@bbrezillon> <CAGXu5j+rckvb94YhdqUhRhuG=RtjN+S9QArAhwVWPj8mbPom+w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216529331204918?=
X-GMAIL-MSGID: =?utf-8?q?1598161784151033523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 18 Apr 2018, Kees Cook wrote:
> On Wed, Apr 4, 2018 at 12:40 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Don't know how you want to get these patches merged, but the NAND
> > related changes will conflict with my nand/for-4.17 changes (NAND
> > code base has been moved to drivers/mtd/nand/raw).
> >
> > The rest looks good,
> >
> > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Hi, just checking in on this series. Thomas, what's your plan for
> merging this? I don't see it in -next yet.

Got distracted. Need to address the review comments and repost.

Thanks,

	tglx
