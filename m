Return-Path: <James.Bottomley@hansenpartnership.com>
X-Google-Smtp-Source: AIpwx4/MgA9xfBdL74JD1WMYV5/741Uw+RO+n/oe8JJdAQf+ob14JPiafFgIO80KifkmHtiQOOdY
ARC-Seal: i=1; a=rsa-sha256; t=1523980515; cv=none;
        d=google.com; s=arc-20160816;
        b=JP6twBjDfNvtUtIEtM5mqI0ZDJYUC0atQPd5bIvUQebAcDLf2fvn5QpTc/Ig2lCX8Z
         +jS80DZM9sVeEksIpNxM0pUHxbYKzZAUTNaCGA12G0J+RDbxvk2BkDcAXZf24fOVA7el
         zg1MfOqzSfFUx7eekUexMfGTbea80z0jlNMJ/PqfqZlapp5XoVMORzB1lDnAT2f6x9sU
         ZVQe6e9ea0tSk1k32JW8G6EiPtoBKzAtBImO2UOH05Tj+iTx8V/JbcTLhCyTTSFGAJGl
         rssWcnj+Re7h6M39+ZDm0LLtV5Bfl5VA09wk9T8MIu+pHo9UTgLk8YYP7sLoqyOj97ZB
         3Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=LMTzPy6jABguNYoMCZlOZ86me0wrd2UcWgB4weit2S0=;
        b=Okab7cJcPp97hz/JM+pkzb0T4lBfYTEav2TbotTr8jLeWTpJcwMEJauC3qWnc+0bAL
         CBYFYzZCeLuEJuxoal915WQ4FLDPiMad+BmK+iGL2t+zYSu7D0OOkK6i39Wj6PkoCKm7
         n4KhANkyAyIYA+Fv3Yga0NF0zJwR1bCeHWHxMyFhNijHQQ74qFhO/lyw4SvwDOTaV0xA
         kFYYu+2MFmRbm5uScuLrcnr542tmIVe5Rr8x93a8ECs3TsJpqD/a3bMuF68bJh5AZSoL
         yK5S5tcOdA1DL8X19l/KDIusUgLrIk3L0/DFC2MUYSWM0q0rOq0FmIti7tY1MIRnqtNi
         xXKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=t9JGPo+Z;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=t9JGPo+Z;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Message-ID: <1523980508.3310.9.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-parisc@vger.kernel.org,
	arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Helge Deller
	 <deller@gmx.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart
	 <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2018 16:55:08 +0100
In-Reply-To: <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
	 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
	 <1523957852.3250.9.camel@HansenPartnership.com>
	 <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964966697704374?=
X-GMAIL-MSGID: =?utf-8?q?1598009393043249543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-17 at 10:13 -0400, Sinan Kaya wrote:
> Hi James,
> 
> > 
> > Perhaps if you gave an example of the actual problem you're trying
> > to fix we could assess if it affects parisc.
> 
> Let me clarify myself here. Maybe, there is a better solution.
> 
> 		/* assign ownership */
> 		desc->status = DEVICE_OWN;
> 
> 		/* notify device of new descriptors */
> 		writel(DESC_NOTIFY, doorbell);
> 
> The difference between writel() and writel_relax() is writel()
> guarantees memory transactions to be flushed to the device before the
> register write.

Um, no it doesn't, at least not in PCI.  It guarantees the write will
be issued by the memory system, but it may still be cached (called
posting) in the PCI bridge.  So it doesn't guarantee the write reaches
the device by the time it returns.

>  writel_relaxed() does not provide any guarantees about the memory
> and IO operations.
> 
> Similarly, readl() provides following code to observe the DMA result
> while readl_relaxed() does not provide this guarantee.

Right, the relaxed operator provides no guarantee of ordering between
the memory and IO domains.  However, it's only really a problem on
multiple memory controller systems (i.e. NUMA).  Parisc (except
superdome, which we don't support) doesn't have this problem.  We also
turn of CPU stream reordering, so compile order is retire order on our
CPUs (which makes life a lot simpler).

> Ideally, you want to embed rmb() and wmb() into the writel() and
> readl() to provide this guarantee.
>  
> PA-RISC doesn't seem to support neither one of the barrier types. If
> you are familiar with the architecture, maybe you could guide us
> here.
> 
> Is __raw_writeX() enough to provide this guarantee for this
> architecture?

Well, with the volatile address it is.

The current implementations provide the expected semantics: namely the
position in the instruction stream is compile (retire) ordered and
issued from memory once retired.  We still do have the write posting
problem, but you'll find additional reads in the drivers to flush the
posted writes, so I don't actually believe we need anything changing.

James
