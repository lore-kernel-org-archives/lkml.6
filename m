Return-Path: <kernel-hardening-return-12787-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+27MKm5NTjqOPcWaSuPYZBDAf63WsM3vGSqWlpdhHpcyptaiRyU2NPd7MYjG/gArptTrKi
ARC-Seal: i=1; a=rsa-sha256; t=1522209314; cv=none;
        d=google.com; s=arc-20160816;
        b=EPZPPsCYfi2bA4HGy/lBOqeOgH7xr0v09WAg74Iu2HpHADn1JP/I0zLyGiWrZqTuZL
         69D5/oHimOjvoC/n8Ms+fvSfgIqqRebExK031SLXIh706uS4fOKI+ccaUuDIAEXS4sqe
         MKh6eHEGpn5wEkz1jnUj6K3gT147ML8wdZYwSthIxCysqTgsG8XTOCsCP++lCpw0m84m
         +vTOnWD9yQx9p7DKp5+h6AsRKdvXAru3zS0biAylOH6QgThtGgk2BjpuF5uaAP3fCVGa
         lR/ruEBJJWKk5vEepy89KPz/GEPedGXDuZKKvRrIuF+pDUBkmxBCwmfiZEC9twiZ3pZb
         iMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=P+YRrXWK2NEUA5teq4JXvI/Bw2UKYbokWKnBOVYQ/gg=;
        b=rvg7lbbHGEp0YW5oser3x9nRXmPtfyMstD6totzVhwBJcrcL9os+acKjraMPf2Kncg
         S9GthE3/6gv0uifsgHrLpt4NL09UHT0bvFSp7UHXInikCLyIcKElYUUTWske3m5knOFn
         NJA6/O4LjjqWK6M2dnPjWyKrlKtbxTqLCzLIcErbsEn7KxzBCEOKLHmHWb4CXxsF6avl
         23kKiH4PjB9c+1qoIWKb2fb1A9P8wjrGEqXb0g/jxqztCQ1BXcF4fL2/qvEe1IjRa6zh
         2B5hTnSqNCyqwuO1tJU/VRioeT9c0XQUDrh2ozYZcvSAkt+oFDfBPnbGjfDHEbCvbKpj
         7Zbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12787-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12787-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12787-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12787-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 28 Mar 2018 05:54:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Laura Abbott <labbott@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Nandor Han <nandor.han@ge.com>, Semi Malinen <semi.malinen@ge.com>,
	Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
Message-ID: <20180328035455.GA18149@wunner.de>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
 <20180317082509.GA2579@wunner.de>
 <20180318142327.GA23761@wunner.de>
 <b162140d-5c71-196b-8f1f-555fd07810df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b162140d-5c71-196b-8f1f-555fd07810df@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1596152153998019818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 05:37:18PM -0700, Laura Abbott wrote:
> On 03/18/2018 07:23 AM, Lukas Wunner wrote:
> > Actually, scratch that.  If ngpio is usually smallish, we can just
> > allocate reasonably sized space for mask and bits on the stack,
> > and fall back to the kcalloc slowpath only if chip->ngpio exceeds
> > that limit.  Basically the below (likewise compile-tested only),
> > this is on top of Laura's patch, could be squashed together.
> > Let me know what you think, thanks.
> >
> 
> It seems like there's general consensus this is okay so I'm going
> to fold it into the next version. If not, we can discuss again.

Yes, feel free to squash into your original patch with my S-o-b,
keep your authorship.

You may want to raise FASTPATH_NGPIO to something like 384, 448 or 512
to accommodate for the Intel chips Andy mentioned.  It's kind of a
"640k should be enough for everyone" thing but I'd expect the performance
impact of the extra bytes on the stack / memsetting them to zero
to be absolutely negligible.

Thanks!

Lukas
