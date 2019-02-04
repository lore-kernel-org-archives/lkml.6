Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C990C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E531D2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHOfiVML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfBDOA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:00:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44463 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfBDOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:00:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so14440753wrt.11;
        Mon, 04 Feb 2019 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t2ThYZw12DdCfl3exIo5bV0QEutxsm9Hf0K2r5TPG7I=;
        b=kHOfiVMLm13XvBHQ7rpSVRkihNlQrTJq1OLBbQ5727BCp3xX1R4QLe8vUnFeRWPdxf
         Ayi2knw2aNlaVTXJlF6ZIYLGexOTL79wHpZwQQvVplOVV6SWllpXIBiFaLyC+ox2RTpz
         BKF7v+/Gp7M6fWqajsKXbDb0XQtV9nJs8HZ0tAgRVARzIGZCJnLzn2Q2sub2cGuTds8d
         uBjcUNj/jLoYh9cuOLQGWmB4WwmxMDp6f3edhxhmCl9awFg5J8/yOeksw9Ut/BcHMyr3
         cCiDaM4yWLt7MX0AijbenaKc9/BHcElhP/JrR9PZLdnX6J6sP5sF3a04WfWfAEElZEdv
         p89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t2ThYZw12DdCfl3exIo5bV0QEutxsm9Hf0K2r5TPG7I=;
        b=e8TOWGFwLiWgWbdf/ce4cgkXMbVsKDup7LSKUPC6LII1YrUpooccCkaIXvcYvafiDw
         1G+clrWJvHBtBXUjhB754eypqGE3P8XMe66VtAetwWxa8oRjqcwcJHZDdD2xdbI61IHa
         EwH8xCn9w5uh8Yq41+7MhgGRfbcuBfq0dSlQF6/VucsxKYumk8mQs4UPYOWDqFudvjZL
         wxzc04GqeSKDKg3dI70vQs+kuZVWmA3YIfyfcShVEC9NkkT4lOmGkEi+/1RE820uwKPE
         /jOJ9rLDPb/BvZeWsvKqTXtcP6fhbZ1TgE01/S5rhndSFsOP5Ben+wKghXjInaLPHiXY
         z5iA==
X-Gm-Message-State: AJcUuketA9oZwaaXxgNUBvfH7XvjVAJHljJQEByWjPQJY+12Uwn4j0v3
        TtyQloOSIgD3D9Hpewc8Bls=
X-Google-Smtp-Source: ALg8bN4giSTg95X2uDs9UU5zYfbLBRxl3LGwm2rjY9YTSDkqhYk5aof9qGDh4KQnwnpOJW3Lbe9GYQ==
X-Received: by 2002:a5d:42ce:: with SMTP id t14mr49857820wrr.51.1549288826144;
        Mon, 04 Feb 2019 06:00:26 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b13sm4433455wmj.42.2019.02.04.06.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 06:00:24 -0800 (PST)
Date:   Mon, 4 Feb 2019 15:00:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Message-ID: <20190204140024.GJ10412@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo>
 <2034694.JE9CgBysmF@aspire.rjw.lan>
 <20190204084555.GF19087@ulmo>
 <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
 <20190204110510.GA10412@ulmo>
 <f0bdcc21-efca-4d04-c7ec-953ec3d87031@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
Content-Disposition: inline
In-Reply-To: <f0bdcc21-efca-4d04-c7ec-953ec3d87031@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 03:03:49PM +0300, Dmitry Osipenko wrote:
> 04.02.2019 14:05, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, Feb 04, 2019 at 09:53:32AM +0000, Jon Hunter wrote:
> >>
> >>
> >> On 04/02/2019 08:45, Thierry Reding wrote:
> >>
> >> ...
> >>
> >>> The idea was, as I was saying below, to reuse dev_pm_ops even if
> >>> !CONFIG_PM. So pm_runtime_enable() could be something like this:
> >>>
> >>> 	pm_runtime_enable(dev)
> >>> 	{
> >>> 		if (!CONFIG_PM)
> >>> 			if (dev->pm_ops->resume)
> >>> 				dev->pm_ops->resume(dev);
> >>>
> >>> 		...
> >>> 	}
> >>>
> >>> But that's admittedly somewhat of a stretch. This could of course be
> >>> made somewhat nicer by adding an explicit variant, say:
> >>>
> >>> 	pm_runtime_enable_foo(dev)
> >>> 	{
> >>> 		if (!CONFIG_PM && dev->pm_ops->resume)
> >>> 			return dev->pm_ops->resume(dev);
> >>>
> >>> 		return 0;
> >>> 	}
> >>>
> >>> Maybe the fact that I couldn't come up with a good name is a good
> >>> indication that this is a bad idea...
> >>
> >> How about some new APIs called ...
> >>
> >> pm_runtime_enable_get()
> >> pm_runtime_enable_get_sync()
> >> pm_runtime_put_disable() (implies a put_sync)
> >>
> >> ... and in these APIs we add ...
> >>
> >> pm_runtime_enable_get(dev)
> >> {
> >> 	if (!CONFIG_PM && dev->pm_ops->resume)
> >> 		return dev->pm_ops->resume(dev);
> >>
> >> 	pm_runtime_enable(dev);
> >> 	return pm_runtime_get(dev);
> >> }
> >=20
> > Yeah, those sound sensible. I'm still a bit torn between this and just
> > enforcing PM. At least on the display side I think we already require PM
> > and with all the power domain work that you did we'd be much better off
> > if we could just get rid of the !PM workarounds.
> >=20
> >>>>> This would be somewhat tricky because drivers
> >>>>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
> >>>>> that would result in an empty structure if !CONFIG_PM, but we could
> >>>>> probably work around that by adding a __SET_RUNTIME_PM_OPS that wou=
ld
> >>>>> never be compiled out for this kind of case. Or such drivers could =
even
> >>>>> manually set .runtime_suspend and .runtime_resume to make sure they=
're
> >>>>> always populated.
> >>>>>
> >>>>> Another way out of this would be to make sure we never run into the=
 case
> >>>>> where runtime PM is disabled. If we always "select PM" on Tegra, th=
en PM
> >>>>> should always be available. But is it guaranteed that runtime PM fo=
r the
> >>>>> devices is functional in that case? From a cursory look at the code=
 it
> >>>>> would seem that way.
> >>>>
> >>>> If you select PM, then all of the requisite code should be there.
> >>>
> >>> We do this on 64-bit ARM, but there had been some pushback when we had
> >>> proposed to do the same thing on 32-bit ARM. I think there were two
> >>> concerns:
> >>>
> >>> 	1) select PM would force the setting for all platforms on multi-
> >>> 	   platforms builds
> >>>
> >>> 	2) prevents anyone from disabling PM for debugging purposes
> >>>
> >>> 1) no longer seems to be valid because Rockchip already selects PM
> >>> unconditionally. I'm not sure if 2) is valid anymore either. I haven't
> >>> run a build with !PM in a very long time and I wouldn't be surprised =
if
> >>> that was completely broken.
> >>>
> >>> Maybe we need to try this again since a couple of years have elapsed =
and
> >>> runtime PM support on Tegra is much more mature at this point.
> >>>
> >>>> Alternatively, you can make the driver depend on PM.
> >>>
> >>> That's probably the easiest way out, but to be honest I think I'd pre=
fer
> >>> to just enforce PM and keep things simple.
> >>>
> >>> Jon, any objections?
> >>
> >> None, but seems overkill just for this case.
> >=20
> > But that's precisely the point. It's not just about this case. We've
> > already got some drivers where we do a similar dance just to be able to
> > support the, let's admit it, exotic case where somebody turns off PM. I
> > think supporting !PM might have made sense at a point where we had no
> > support for power management at all. But I think we've come a long way
> > since then, and while we may still have some ways to go in some areas,
> > we do fairly decent runtime PM most of the time, to the point where I no
> > longer see any benefits in !PM.
>=20
> I'm requesting PM_DEBUG_ALWAYS_ON option then! Disabling PM is a
> useful debug feature, it can't just go away.=20

What is it about disabling PM that you consider useful? I can understand
why you'd want that option if power management is broken, but as far as
I can tell, power management on Tegra is in pretty good state, and it's
more likely that !PM would actually be broken (though I haven't built a
configuration like that in a couple of years, so I'm speculating). We
already can't disable PM on 64-bit ARM, so I don't understand why 32-bit
ARM should be treated any differently.

Thierry

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYRXcACgkQ3SOs138+
s6FlpQ//UOawJntTH01fvpWxtT+xE2r9X/bkdovL967txQYT2KESKadF0D//T9UZ
x4IPwVpk+xEl844VSUP7TjV0HgDQb4j+sqP8i3Ak3vGNxlwqNLD+HrK/QO9ttcPi
RZbs3J3bskasuVXkqLh6IY+bqzIFrs+az1LSvEY5yfUlYm9LDKjP2gWPHK9tx6yy
ZqWc3lhzKEJvkjdBl71aOqLw5LWdpa0RFCnrsdXIGC75YafuRH1VhXoW8utgGsEZ
jB8OOhPG7cQjRFooNllMQd1foYUSChdLtI8DNHXRX0BQAh3fSnZaHdQRy0parRf8
BHpV2fMC/BnWdsCzZDLfQ0BQnDR/X7+dnv1ZoTe6BGPXliu7NQYazq57uB0z9wYH
+DbD4VfTpm1zvsKf+1LQHJ1ege91QbhP8UZe9HFrsK0AC+VS5SylFtXM3hnBD9+j
71AeTsYXev3/yYEPNzQFd6uxthgBcDBVIIprpVMBXBmshG1dWRhSVT+QA1c0TjwP
MbwAOYO2/fXr+eRtcwkJafB9qHj3tHP9aFP3K3r8rm78Y83F39GxZTgL9nAfRsp1
bVAONCzJ7AH6YuqoxaiBVnDiPdF4/WULmVWnpIujV4xHxJRuNZWai0o+6xdMSrxb
AHsjHqn8/SnKdcdJsSShlDRxawwKJMqEVoWe/42/eVEcwDNCqzk=
=3kWN
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--
