Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x227EQJKdi9B2topT0/YTY08QCTadXaNUrzeEa3klLyDfkOBFBzTG9SYPNkQmaN3mq2bVpepR
ARC-Seal: i=1; a=rsa-sha256; t=1519780813; cv=none;
        d=google.com; s=arc-20160816;
        b=U5TdyZ09SMER0WWvziv2FJVzJLE6ycnsbUPIym4JY5wUFSOcZK8Pa940jkfSYmBuQQ
         E3wI2Bf6J+nT8RavsAUcXx1rB3Zhg/qAgPQWtdKI027SvUy5IplTBr+dNskzTn3SVCGx
         kNDAIKWifXL5q3ZodqLKcpxcIdytvLSY6h9/P2FVUn5rouCOWEj+F5R+da69RSI4yrA5
         aNnDngTaTLT+2xIfBhAkFMHSbe4zEVM8MqJQefzF/x//ydQ91T65bu855A1xxkdF19gP
         vy1/BoExe1EbMxf54O91BdJyUnnrr4CpgCQnIcYGWCWqs8LARfl/P99/n62HmmThpGMH
         tn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=D+WIQIiZ1t2MoCN/rhk7YQ3Sk4hNrdybf37rYAI1ick=;
        b=OYlsO9ucGIPenr1CVipnQU+5EyHLXIxDhgqokw+XGT+9mAmDIWaD54Vyt9+kZUQpO6
         g/zJdZZFOdhmAqZ8CWpeP/xLPChZVPqMSE0VrDjavhGdDZ1Jz/3K/8LX5D6Yob6wXEoK
         QGcnNWA7GvMTy1TYy42uBmdYs6w/eqMHxFFYdyYXuO5CxdFcVHtiJzcL5xN6M6YgjE1f
         UKk8DqEcUlHcyzwRMHA8u8gIQhnxqELmyeDkCA3EX4rip32kpUD8022novDP1KZKWzfb
         RRPUiSlRq9SrKkKqloUn8q8jtdItOAwML1XgBXzsGr/sDueoWpNU0yZI1l9V5eBkhTHK
         E4sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 28 Feb 2018 01:20:12 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, cantabile.desu@gmail.com,
	Jakub Kicinski <kubakici@wp.pl>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, oneukum@suse.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFT 3/7] firmware: make fw_add_devm_name() return 0 if cache
 present
Message-ID: <20180228012012.GE14069@wotan.suse.de>
References: <20180227232101.20786-1-mcgrof@kernel.org>
 <20180227232101.20786-4-mcgrof@kernel.org>
 <CAGXu5jL1mrZ6LqV0WKBY=w_kZzzcSrUD6Z5YqToSS2qmNaS4Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL1mrZ6LqV0WKBY=w_kZzzcSrUD6Z5YqToSS2qmNaS4Fw@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598196329346880?=
X-GMAIL-MSGID: =?utf-8?q?1593605686772358649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:31:11PM -0800, Kees Cook wrote:
> On Tue, Feb 27, 2018 at 3:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > Currently fw_add_devm_name() returns 1 if the firmware cache
> > was already set. This makes it complicated for us to check for
> > correctness. It is actually non-fatal if the firmware cache
> > is already setup, so just return 0, and simplify the checkers.
> >
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> That'll teach me to read all the patches first. ;)
> 
> Honestly, I'd just fold this into the prior patch: there's only one
> caller and it's exactly about checking the return value.

Sounds good.

  Luis
