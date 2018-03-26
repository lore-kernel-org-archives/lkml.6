Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522061585; cv=none;
        d=google.com; s=arc-20160816;
        b=KULYQoFO+wAzct7+L4pG3zkJTRoiE6ScZ6nXWyXQANIEWNYQKbfDO/HgtDrKqTHdAD
         GkI5M1gxhZAXqOO7I0SBgCSoOJfbms45lj5FTCIuSFnEwMcjZEIXJx2snUHhdvYflIli
         eNay8zkuzVD+IPb/ycKsrX5dv61i3dCfcAbY3xqulhj1YYrrGHeFkLc8y4SaVRjmR9wU
         mZ6HbY18Vg+UiXSZuIzXyF9LmiFZktWQ7AWsSEgXiNnLiDZnr3VItOMDLRj2wMThFE8V
         HmTMPRtUF7ub0SoB9gYfF2R/zEctarEcCh+zIh8tDqJyww2W9HaLVhG6ZPZCaeFHgVVy
         lIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Krtu540OU7Ij4sHyVli8AsM1nVWz0Y+HmLGNew6d6m0=;
        b=j2j5+q7ohppDEKrnvYbcfhiVUuRBOt7r8wApKLUfGSLqGylQrlQT6ZXaz7yDPyQORL
         Z+Ng/co4WRZuKGqDVmF8wwM4YR0+ApPdOjXrCWxkCCaz54prEnrjuQVpy9OiEMOtKXPY
         XigMcuDrNksHNUPfI1sh+d/VaooQZWGjN2llsPmhOm5WnA0y3a3SmYGr2O9w5W8bPhjV
         7h37UgYEJTkzrVrn0xeN3ckcoLZkWQNitkkR+OQcaQcAHQ7mHSWfkxnvwMSixxcmq4V1
         AwT5NpgtvuAx8z1Z04cFDqYLK0MRXwJmU8KHebIaYbOSZlmF8S6y9iJ+hNRw3MPT3A40
         JRcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=inq9Vxb0;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=inq9Vxb0;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELsQl7GiEnPhO/GSLbJS4vFOsVhevikjEX79JAXQrcVA/Ik1JA1CmKfM3l/FmfAFZrcs8Gz4HbJjGOXlt4N4gLU=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180321163745.12286-2-logang@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com> <20180321163745.12286-2-logang@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 12:53:04 +0200
X-Google-Sender-Auth: 1lf-MGwxnQGSplaGg0ZEPPguZPc
Message-ID: <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com>
Subject: Re: [PATCH v13 01/10] iomap: Use correct endian conversion function
 in mmio_writeXXbe
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	linux-ntb@googlegroups.com,
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
	Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565968042571455?=
X-GMAIL-MSGID: =?utf-8?q?1595997249440375979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 5:37 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> The semantics of the iowriteXXbe() functions are to write a
> value in CPU endianess to an IO register that is known by the
> caller to be in Big Endian. The mmio_writeXXbe() macro, which
> is called by iowriteXXbe(), should therefore use cpu_to_beXX()
> instead of beXX_to_cpu().
>
> Seeing both beXX_to_cpu() and cpu_to_beXX() are both functionally
> implemented as either null operations or swabXX operations there
> was no noticable bug here. But it is confusing for both developers
> and code analysis tools alike.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Your patch is a clear improvement of what we had before, but I notice
that we have a weird asymmetry between big-endian and little-endian
accessors before and after this patch:

void iowrite32(u32 val, void __iomem *addr)
{
        IO_COND(addr, outl(val,port), writel(val, addr));
}
void iowrite32be(u32 val, void __iomem *addr)
{
        IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
}

The little-endian iowrite32() when applied to mmio registers uses
a 32-bit wide atomic store to a little-endian register with barriers to
order against both spinlocks and DMA.

The big-endian iowrite32be() on the same pointer uses a nonatomic
store with no barriers whatsoever and the opposite endianess.

On most architectures, this is not important:
- For x86, the stores are aways atomic and no additional barriers
  are needed, so the two are the same
- For ARM (both 32 and 64-bit), powerpc and many others, we don't
  use the generic iowrite() and just fall back to writel() or
  writel(swab32()).

However, shouldn't we just use the writel(swab32()) logic here as well
for the common case rather than risking missing barriers?

       Arnd
