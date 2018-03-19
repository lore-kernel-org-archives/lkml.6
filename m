Return-Path: <kernel-hardening-return-12699-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtT2REH71IXU6OOYmjgOZJGGV569/4TPza/AnNLtlpfyZy+ynEXHhh4+j2RcrByO9pi3HJc
ARC-Seal: i=1; a=rsa-sha256; t=1521442864; cv=none;
        d=google.com; s=arc-20160816;
        b=Ii8tVKBmXiEzDnsCSZNwpZdKmtFyO7N/w75Xp3jEfJ2g9iIIs1/kJt4wTpE5BbLUi0
         o7h4DEKVLDgc2laHBqzChT56i4jPc9GZz6a/gyuUGd3xbBozHTVoBoB15NrNS1CQMZov
         UWavqVgWhqR7hby/yHqwWcBbv9SNyqN54BtGWSJ2sKZcctxRpJ1zKtP7cqL4RuSPfNan
         yqD89iIFkVG4gfjWRm2R7p0i9nRfbuv6jMRv0tm4i6dhF0rXYy2OkKl0CGW50lLIhj0r
         TcKAD0lMU2Cqo/0Z1zMw2p7RFmiNXVK8XRUwCZl7Y+S2fkNggVfOaxicepVMS/DbIDdn
         dVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=FOrMNQs3zFkTFUiolgeNT5U+ikK/8zW123QNGVjbuRY=;
        b=nJILh7tWd0iyQmoCDFC9DNfaCTbVF//jOqzBuL/sJiUJI20KOw8Mg2c11ujcBqZD2t
         Mt36Q8lEZiuEccbwIM+15fqdtbUhEa4rvgeoF3G1yFgpldiE/9uFStEGYaFYeWvWrzT3
         Foa9hjL3VW032DpEsf0+fIhI7WWAuguMtT+KNgsWDeH/TEW+z2u46E+2GvYGedooY6/s
         QsFpIFfNn647/hiXqx/gHOPcxokPqmv9JHTjHBFoYBSEae7ZYMOsXo4soR8agYlB6NJC
         9flI8NwjPUbUxhqn8DgUQsaoS4noAjHlvqGrjd7FxXCRx9PkzOFnc59MDU+8WLvEItoN
         EQJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12699-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12699-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12699-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12699-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 19 Mar 2018 08:00:43 +0100
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
Message-ID: <20180319070043.GA25474@wunner.de>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
 <20180317082509.GA2579@wunner.de>
 <20180318142327.GA23761@wunner.de>
 <0f17eb05-c183-bec9-0076-5ddd00d70f15@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f17eb05-c183-bec9-0076-5ddd00d70f15@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1595348473585185929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 09:34:12PM +0100, Rasmus Villemoes wrote:
> On 2018-03-18 15:23, Lukas Wunner wrote:
> >>> Other random thoughts: maybe two allocations for each loop iteration is
> >>> a bit much. Maybe do a first pass over the array and collect the maximal
> >>> chip->ngpio, do the memory allocation and freeing outside the loop (then
> >>> you'd of course need to preserve the memset() with appropriate length
> >>> computed). And maybe even just do one allocation, making bits point at
> >>> the second half.
> >>
> >> I think those are great ideas because the function is kind of a hotpath
> >> and usage of VLAs was motivated by the desire to make it fast.
> >>
> >> I'd go one step further and store the maximum ngpio of all registered
> >> chips in a global variable (and update it in gpiochip_add_data_with_key()),
> >> then allocate 2 * max_ngpio once before entering the loop (as you've
> >> suggested).  That would avoid the first pass to determine the maximum
> >> chip->ngpio.  In most systems max_ngpio will be < 64, so one or two
> >> unsigned longs depending on the arch's bitness.
> > 
> > Actually, scratch that.  If ngpio is usually smallish, we can just
> > allocate reasonably sized space for mask and bits on the stack,
> 
> Yes.
> 
> > and fall back to the kcalloc slowpath only if chip->ngpio exceeds
> > that limit.
> 
> Well, I'd suggest not adding that fallback code now, but simply add a
> check in gpiochip_add_data_with_key to ensure ngpio is sane (and refuse
> to register the chip otherwise), at least if we know that every
> currently supported/known chip is covered by the 256 (?).

The number 256 was arbitrarily chosen.  I really wouldn't be surprised
if gpiochips with more pins exist, but they're probably rare, so using
the slowpath seems fine, but dropping support for them completely would
be a regression.

E.g. many serially attached chips such as MAX3191X are daisy-chainable
and the driver deliberately doesn't impose an upper limit on the number
of chips because the spec doesn't contain one either.  To the OS a
daisy-chain of such chips appears as a single gpiochip with many pins.

Thanks,

Lukas
