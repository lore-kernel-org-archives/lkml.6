Return-Path: <kernel-hardening-return-12684-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuJrDdxKA8dUnWsgJTgMzMi05FVQE5aWFCNZRbuN3PECTdrmwUr26U4Jrprhja8tSli4bX6
ARC-Seal: i=1; a=rsa-sha256; t=1521281502; cv=none;
        d=google.com; s=arc-20160816;
        b=CXxNBkQlhzDkuJ6aPRL60X6ehLNMu/Y+mIkIyUAzw/0dO7AFKzivM7ziyFCOZZhXdL
         bDfNoxPCM7wRIWquq8zebkDdoS+86g7GIgOBupSUCjfQ4BMUcdFM5Jotbl6OvloFXc2/
         0LgZzDXoNnT+9GgmgdgwIvkjbrJOhbdei/XqtKdB1/7JJXf+f5VLKVLbayXxL5CIqz2H
         X2ypTicCLZkwzwCjCDa45n6hlwAbDnRpf866OSBXBwyvVwbg3AUxe25m2D2sS3bkiU+t
         0HXD9EgbqvyzQWUFqxgTfY6RW3UgTgKBrPeqQUqhyT4FhB16IK7f1lbZEw7oDSaBGdMW
         eJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=u/t1007053CtIr+65fAz04cZpBUzZqA1FjjsftOPY18=;
        b=ctzcY3GrFC+sIf8ca2VrKAXsUjMS2PjPYjYzbV4SjLphWfOwaX19UbG1/LSwQ7ip03
         VVUz2Hr2rb61z1CW62CQo70RMgU6c4MxUSgEI+YfUcKjrNvTLE3uQEUdS66q1o8C3gGR
         NgfID7VxZ/xuZJdLTXkePz4Q6I7CkFBC2KxP4TD/A+YT+pdpWkzUpc3m9Q8+PDabl0SK
         GERoSqZ8w0ou5zu1A/Srw7ufvL/DZj7W0UQj6mYlSNATkMBfbL6ZzW7Lr6tpzuXmpox5
         +RX+LOBBR7ifjbynltLvTDnKXRvWwZnMLzVxCLbpiwcuDfMdU1htsBNu5h+jxGrb3zUp
         TmYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12684-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12684-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12684-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12684-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 17 Mar 2018 09:25:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Laura Abbott <labbott@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Nandor Han <nandor.han@ge.com>, Semi Malinen <semi.malinen@ge.com>,
	Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
Message-ID: <20180317082509.GA2579@wunner.de>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1595179272878875488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 04:00:36PM +0100, Rasmus Villemoes wrote:
> On 2018-03-10 01:10, Laura Abbott wrote:
> > @@ -2887,14 +2909,30 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
> >  
> >  	while (i < array_size) {
> >  		struct gpio_chip *chip = desc_array[i]->gdev->chip;
> > -		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
> > -		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
> > +		unsigned long *mask;
> > +		unsigned long *bits;
> >  		int count = 0;
> >  
> > +		mask = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
> > +				sizeof(*mask),
> > +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> > +
> > +		if (!mask)
> > +			return;
> > +
> > +		bits = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
> > +				sizeof(*bits),
> > +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> > +
> > +		if (!bits) {
> > +			kfree(mask);
> > +			return;
> > +		}
> > +
> >  		if (!can_sleep)
> >  			WARN_ON(chip->can_sleep);
> >  
> > -		memset(mask, 0, sizeof(mask));
> > +		memset(mask, 0, sizeof(*mask));
> 
> Other random thoughts: maybe two allocations for each loop iteration is
> a bit much. Maybe do a first pass over the array and collect the maximal
> chip->ngpio, do the memory allocation and freeing outside the loop (then
> you'd of course need to preserve the memset() with appropriate length
> computed). And maybe even just do one allocation, making bits point at
> the second half.

I think those are great ideas because the function is kind of a hotpath
and usage of VLAs was motivated by the desire to make it fast.

I'd go one step further and store the maximum ngpio of all registered
chips in a global variable (and update it in gpiochip_add_data_with_key()),
then allocate 2 * max_ngpio once before entering the loop (as you've
suggested).  That would avoid the first pass to determine the maximum
chip->ngpio.  In most systems max_ngpio will be < 64, so one or two
unsigned longs depending on the arch's bitness.

FWIW, to achieve a stack overflow the platform or a driver need to specify
a huge number of GPIOs for a chip.  So the exploitability is limited,
but of course it's still better to get rid of the VLAs.

Running v2 of this patch through checkpatch --strict results in a few
"Alignment should match open parenthesis" and one "Please don't use
multiple blank lines" complaint, granted those are nits but it may
be worth fixing them up front lest the usual suspects come along and
submit bikeshedding patches.

Thanks,

Lukas
