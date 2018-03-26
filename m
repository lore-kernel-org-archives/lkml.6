Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522093824; cv=none;
        d=google.com; s=arc-20160816;
        b=ia2WfFCN9RZfl4t52xnMO/PLTkuGtdTMe/Y510+2qTM59cncdjHk0HvII+Nq09hAuN
         E3c46rIRQ+S7onORvYgsr71oUrYiC4TQt/Rf5VMIn45Sj0FUw6uHgB5bge2FjifRtmed
         X93Xcf25R+SmRsC/tCR6CMt/V5iWycamRNplfCJZPH+Eq0ABJnWwLfQV77vsz82ZeVIJ
         LxhkyODycqodbdP8iAYHe1q2Ag/M7vv4KqHWkF3kypY4DaXNo0Vm4AWVErlyn0K85uB/
         uuQH50P0hwbJdhJEFwfoA7lc/1UQsOsu78XSs5KakIaSZ5B5iKN0pQW4vq5vhGLi6SHs
         2sZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=XsSLFwJG1fVG+jba5n3iz3v3KXe5QpW8Wg3QAhdaZx4=;
        b=pDPQ6raYmBxR8mydFXVbQ0XqADQa8A0Fo5+qi2hr4YzJDj2ijXN9pM5GIeBiSkNNwg
         PNr5E3ua4O7rqaOFDXTgdgmtngtt957dLb1/N0+RKEM20G4+8Too5NVzi002kePamUw4
         KdgoL+D+vUuzSdeNw6hN6HjEJK0SnBB7d8P210Fzq8ECp+jch+rwpGLrwpf22ps9nSgQ
         jQy0gt/mIylis5LBtB+Fbtfvaal5CE3FGycPQkJCmDg2WKAjHWH03FGTJ++XwKBenn3i
         7GkNA4kbrQChDQ0Kg7Gin01BkD2Jgxm+sys4nwkLfp19fTz2IQqjYBCyKWKf3miEN6DY
         /1wg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pTr1KuMm;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pTr1KuMm;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx48wVEx+84kr9sABO7RgFy5Tie2+KahJlX4bYd/DgdA8+QeqOFNUsiDOBxBQwmul8a2AEWgiGR7v87CgHFXSLQg=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <726eb143-2cca-b221-b569-e193a962e357@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com> <20180321163745.12286-2-logang@deltatee.com>
 <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com> <726eb143-2cca-b221-b569-e193a962e357@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 21:50:23 +0200
X-Google-Sender-Auth: KZFn-GKMyHRRa3lrYATZvaf0S98
Message-ID: <CAK8P3a2HGW=PWBtFL_96rztqa7KUAhuYBHTL3cGKY2VE=Ag1rA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596031054045754524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 6:21 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 26/03/18 04:53 AM, Arnd Bergmann wrote:
>> On most architectures, this is not important:
>> - For x86, the stores are aways atomic and no additional barriers
>>   are needed, so the two are the same
>> - For ARM (both 32 and 64-bit), powerpc and many others, we don't
>>   use the generic iowrite() and just fall back to writel() or
>>   writel(swab32()).
>>
>> However, shouldn't we just use the writel(swab32()) logic here as well
>> for the common case rather than risking missing barriers?
>
> Hmm, I don't know... it's complicated?
>
> Doing a bit of digging shows that the existing code was written during a
> time when writel() did not include extra barriers over __raw_writel() in
> any of the common arches.
>
> The commit logs don't seem to provide any guidance as to why this it was
> done this way, but I'd assume it was done to avoid a double swab() call
> on BE arches. Seeing writel() is typically implemented as:
>
> __raw_writel(__cpu_to_le32(value), addr);
>
> Then on BE arches, writel(swab32()) would become:
>
> __raw_writel(swab32(swab32(value)), addr)
>
> Which seems undesirable.

I wouldn't expect it to matter: the byte swap is almost always much
cheaper compared to the actual bus access for the MMIO, and I
would also guess that modern compilers can eliminate the double
byte swap on architectures where writel() is an inline function. Most of
the important architectures use ARCH_USE_BUILTIN_BSWAP, which
guarantees that.

       Arnd
