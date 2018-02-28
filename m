Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x226oenZR5mpQLPmo0aL8dtnYxcBGCWqWgvLhxk7wlRUQgP0ysskKMRXo1fKQKseW/nG4IM0n
ARC-Seal: i=1; a=rsa-sha256; t=1519780745; cv=none;
        d=google.com; s=arc-20160816;
        b=m6esFdjx9PUGan+R7dZr41jH0tctavGvvGjKWgmLHGIrz0AwdiHVv9Ddme16+B29Sb
         ttY8+SrRyqVUfAo2HPTcJXOAKpf0AT7MhRv0/8ngBYU2V0N6R867V3kjlfwPeWCUdJ9/
         iOiKxIb5/W/BSByj4zSA44HpSOc9JdVtp+vXl2w7M+sc8ByH36rRM9QgU3h2Rtc1iD3B
         v3lyf224Yqzto000g2/vCrjmi64wESnRIrHZWFMm2t9uyPjYXRO9eAFVoAm5WL2y3Zfo
         ci3r3GeMXSjtCtRJ7FKeoUlBwKpwkKkE2s9BxxcuAFDVg8+Tmz2FA+PrAV5V1X/sxlNf
         SROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vg+QQzo38GDriNcrYciaNGTXAtW1pJZ0rb0Z2TM3CuQ=;
        b=Aac2vUZy8+tpBPYG7ETz86LLkXCup43TDL4g089U4pGjsMn8cg5UDFh6ViFRnSmLUO
         gTgJOLPbKKDN10UqwWW87O6hAoFa9JCJouKqsnpG67lpZNup/+S6I9XBIa8KIxEP57QO
         F+bd2mOQochrjAY7ihhnZaSTFO4CGy0Qu19ESioB5E42spNuLIqym1eoMfa+ZuLByiMn
         V+37O2GGJV/gAZ5EFUqpVrGKgOGkWNBMuRpc3iSKAsvCAHLa/D9vNqub9/xYu0XU/Xn5
         5ONC3442Ou3jbRy1IuZicd0XiHhPAwynhmiwWREcxug4c4TPFvQP8Pzh2CJ+7A2V6naW
         6X0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 28 Feb 2018 01:19:01 +0000
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
	stephen.boyd@linaro.org, Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, oneukum@suse.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFT 2/7] firmware: fix checking for return values for
 fw_add_devm_name()
Message-ID: <20180228011900.GD14069@wotan.suse.de>
References: <20180227232101.20786-1-mcgrof@kernel.org>
 <20180227232101.20786-3-mcgrof@kernel.org>
 <CAGXu5jLxAPyBfzvM3izKYYjVz6P=7LQRkxNxUz1Cxwky1gPoUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLxAPyBfzvM3izKYYjVz6P=7LQRkxNxUz1Cxwky1gPoUA@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598195211276133?=
X-GMAIL-MSGID: =?utf-8?q?1593605615315364458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:29:53PM -0800, Kees Cook wrote:
> On Tue, Feb 27, 2018 at 3:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > fw_add_devm_name() adds device's name onto the devres for the
> > device so that prior to suspend we cache the firmware onto memory,
> > so that on resume the firmware is reliably available. We never
> > were checking for success for this call though, meaning in some
> > really rare cases we my have never setup the firmware cache for
> > a device, which could in turn make resume fail.
> >
> > This is all theoretical, no known issues have been reported.
> > This small issue has been present way since the addition of the
> > devres firmware cache names on v3.7.
> >
> > Fixes: f531f05ae9437 ("firmware loader: store firmware name into devres list")
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  drivers/base/firmware_loader.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
> > index 21dd31ef08ae..48932581c70c 100644
> > --- a/drivers/base/firmware_loader.c
> > +++ b/drivers/base/firmware_loader.c
> > @@ -431,6 +431,7 @@ int assign_fw(struct firmware *fw, struct device *device,
> >               unsigned int opt_flags)
> >  {
> >         struct fw_priv *fw_priv = fw->priv;
> > +       int ret;
> >
> >         mutex_lock(&fw_lock);
> >         if (!fw_priv->size || fw_state_is_aborted(fw_priv)) {
> > @@ -447,8 +448,13 @@ int assign_fw(struct firmware *fw, struct device *device,
> >          */
> >         /* don't cache firmware handled without uevent */
> >         if (device && (opt_flags & FW_OPT_UEVENT) &&
> > -           !(opt_flags & FW_OPT_NOCACHE))
> > -               fw_add_devm_name(device, fw_priv->fw_name);
> > +           !(opt_flags & FW_OPT_NOCACHE)) {
> > +               ret = fw_add_devm_name(device, fw_priv->fw_name);
> > +               if (ret && ret != 1) {
> 
> Why not if (ret < 0) ?

Could be, either way I remove this later for just (ret) after I adjust
fw_add_devm_name() to not return 1 anymore.

So its just a temporal check, I added this patch first so that this can
be merged into kernels who want the fix.

  Luis

> 
> -Kees
> 
> > +                       mutex_unlock(&fw_lock);
> > +                       return ret;
> > +               }
> > +       }
> >
> >         /*
> >          * After caching firmware image is started, let it piggyback
> > --
> > 2.16.2
> >
> 
> 
> 
> -- 
> Kees Cook
> Pixel Security
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
