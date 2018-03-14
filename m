Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELtOnPYjBW6S6HtmczMrNRebC6Qzxd9nzY9gEp2Fe3EARQIvk/Wi3ygTn6g5cgkDimgQPxGs
ARC-Seal: i=1; a=rsa-sha256; t=1521049446; cv=none;
        d=google.com; s=arc-20160816;
        b=bvc5uG1To1KInEQzvQ5qhIHGzCBy10G+Z/a136nGPKIB6ANMXZoj3bmgnng3uYKkaA
         E8Fr4tWEbGdHSlskrFBDGN0iFwxf+xsO955wvLYMg3T5j5X01yel+xJk1A9QiWYn5nZm
         Szl+C5zx0+lzGWWZbZ45oe/+b1AyEneQwv21pOYu7R+YOJZ72XhEHqZNlkZim/RNGavN
         c/XTHbj36OiiYv5KtuBIlGMWELvoMkXkCUXLCcAfl+DGpplaslT2Pc3PfFL+Q+sWq2jK
         5V5FcyDewk0Df0Mj/SoNya/OKeUrSEHMIcZT794yvScYqHydGbnwzXpXfNTUfQ8D9OT9
         loxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=7HRxrek337rzihAr1zDlenpisNZw5DJ5S2Cb8Dtx+hU=;
        b=rQ/7gxW4uH/i5s6lExumN+nwW1A4cKA+yR03l/nPl7N/DaPgopj9cAX1pBlcowo26j
         lHPt0Ipk9mbAjnXG+BA1k5HNAnYBAQLDnMRtmJgJiexNGMMs643LyK64K7+VRCsI4w0Y
         eNKg4J3i3roVK0QOMHxT6/eOPBWJxD10yeKJ6dvQbCa4IPIMaN99XChouu9IFOXiVGZw
         cNGMprglMYiOA1VkEYKt9PEwmvlln7JuUe5YmVpo7FsH3SoyHKLSFs71kCGnhfOA0sC8
         ZVMGKsrLyIxurvkPUI28IZUtV/Smgr0rqqZPPFL7jLMLpN1G1Vvj08C41zzc73YY5Mql
         Vtbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 14 Mar 2018 17:44:03 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Bitterblue of Monsea <cantabile.desu@gmail.com>,
	Jakub Kicinski <kubakici@wp.pl>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Nicolas Broeking <nbroeking@me.com>,
	Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, oneukum@suse.com, ast@fb.com,
	andresx7@gmail.com, LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/20] firmware: development for v4.17
Message-ID: <20180314174403.GJ4449@wotan.suse.de>
References: <20180310141501.2214-1-mcgrof@kernel.org>
 <CAGXu5jJqzahD=iwv8_ipvebi8kQ=UVPiMrHOtQL5iLyviFm6jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJqzahD=iwv8_ipvebi8kQ=UVPiMrHOtQL5iLyviFm6jQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560413093563327?=
X-GMAIL-MSGID: =?utf-8?q?1594935944839401944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 09:16:36AM -0800, Kees Cook wrote:
> On Sat, Mar 10, 2018 at 6:14 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > Greg,
> >
> > Here's a respin of what I have queued up for v4.17 for the firmware API. It
> > combines the cleanup I've been working on and the addition of the new API call
> > request_firmware_cache() for fixing a corner case suspend issue on some type of
> > cards with an optimization in place where the firmware is *not* needed on
> > reboot.
> >
> > The cleanup work allows us to test the firmware API with one kernel
> > configuration. I've addressed Kees' feedback on this respin and
> > combined the code into drivers/base/firmware_class/.
> >
> > I've made one new test_firmware change in consideration for one firmware
> > change, the patch "firmware: ensure the firmware cache is not used on
> > incompatible calls" requires us to modify our tests scripts to use
> > the APIs sanely as well.
> >
> > I've put up these changes on my git tree, refer to the branch
> > "20180307-firmware-dev-for-v4.17" based on linux-next [0] and
> > the same name based on Linus' tree [1].
> >
> > Questions, feedback, and specially rants are always welcomed.
> 
> This all looks good to me! Thanks for respinning. :)

Greg,

I'd like to get these baked a bit through linux-next. Let me know if its
easier for you if I go through Andrew for the firmware API changes.

  Luis
