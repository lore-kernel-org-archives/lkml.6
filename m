Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C6C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885122085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikeSzi5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885122085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbeKFA2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:28:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41892 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbeKFA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:28:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so15167931qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DGmP/b5AgRKjZwNNB4ptvN/30E8ClAvHRtBMdegDU1o=;
        b=ikeSzi5rMRPpigv0KKG7WoGyR4xygsr+u4tPxbfztzWcLJF/anJwRzCW4R02cxkaVe
         qlxVF9KmpUaPTH3AOpyi/OZ+UJqwnDS3r3nHO/cAJto1JWlIAwX5t9uEtMjXycC/nhAC
         CP8F1JSzJVPfR5v5dT8E9Ffv4sBTdc05hORW6ALlzOSdSsk3cOI8KtBn0E2Xq2V7ajPB
         VE49BDbuj4KQLRXYCRxP9HTTZkrsZr9Q2ZAQziP1AVw9vxw1jl/bzQ99r/dFPzr4FGQj
         nBAFj/Syff7529cpgbTEx899QTJOqfAMxoyRRFY7zR5L6xDrprmYzry808F7PVqA9zNx
         VBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DGmP/b5AgRKjZwNNB4ptvN/30E8ClAvHRtBMdegDU1o=;
        b=G3Bawm3Gm/fulHeN0gMMS4lFO5FY17rOgiD+76bLf0BC0/NvVuWvwn3WJWswX1Gk1v
         msrkGnypRH4iQKXCuK47C8uBM7cwk7zQwtbcbttOkmKPmEZ87idzy9xiMclK5zNuHKPS
         6m8iSgiMZtE4hTA/X5LSWgrK+ESoMwZe4KFKEwSkY9KdiLKqPNzotLsKeyZC4mCBoKCB
         Smg3MkLK4dP+vWWWX1eM9Ih5ZqhWbKMR4eISL4EqYROTE3WI+tDj5hKhCruoLe5sJgXD
         Xj3cXOGgRppQF9LHCrfhYot3g34ss8SwS66cclPXJeETDgflkXfZppdKxnSoG9klIau/
         AZcQ==
X-Gm-Message-State: AGRZ1gLFWX9kYIQCgSwKWes/GYMG3n6sEpEZ6h8W+BzhcWgT8PA3Nn7y
        J3mxkYRMwGuUvgEFKV/yMToOxHwDoia3R9w7Od4mWg==
X-Google-Smtp-Source: AJdET5efc+JIajQGpA0dpglzGhnzrbydIGPisDvsuIeg0O+XiaKqeOELNb+C6zRRZom0PNY+JkZNDAimUD/nApRTu1M=
X-Received: by 2002:aed:2ba7:: with SMTP id e36mr18968483qtd.319.1541430471335;
 Mon, 05 Nov 2018 07:07:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 07:07:50 -0800 (PST)
In-Reply-To: <20181105133545.GF10650@smile.fi.intel.com>
References: <20181102112456.780127-1-arnd@arndb.de> <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com> <20181105133545.GF10650@smile.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 16:07:50 +0100
X-Google-Sender-Auth: OR0KJIkYv2wczeZkTQ7VPwdaA9U
Message-ID: <CAK8P3a0kdUtK_UuSJEPiWPxhdDULmW6RYEzu-Ug7f8VBoeWVog@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Sun, Nov 04, 2018 at 10:45:17AM -0600, Pierre-Louis Bossart wrote:
>
>> So yes indeed we have to add a select HDAC_HDA statement under the
>> SKYLAKE
>> config - i just don't know of any other means to say "don't build
>> HDAC_HDA
>> as a module when SKYLAKE is buit-in"
>
> We have this ("strange") lines over the drivers:
>
> config BAR
> depends on FOO || FOO=n
>
> which guarantees that FOO will be not module when BAR is built-in.

That's what I normally use, but I could not figure this one out.
One problem is that SND_SOC_ALL_CODECS selects
SND_SOC_HDAC_HDA, and SND_SOC_ALL_CODECS itself
may be =m, causing the failure for
SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y.

It might work with a separate dummy symbol:

config SND_SOC_HDAC_HDA_FORCE
         tristate
         depends on SND_SOC_ALL_CODECS != n
         default SND_SOC_INTEL_SKYLAKE
         select SND_SOC_HDAC_HDA

This would make SND_SOC_HDAC_HDA built-in even
with SND_SOC_ALL_CODECS=m and
SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=n

It seems a bit ugly, and would need some testing.

       Arnd
