Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6132081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPOC7YVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6132081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKCHMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:12:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36132 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeKCHMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:12:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id o125so5486362qkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vXB03hD5J08BtKN+cL0rsQz91HxiY81ScInc8l4xgQo=;
        b=LPOC7YVZ8AzLSVPPFR2RXCbX8RuWq/ozEhxcmdnUBKsU2XiFyxD9muUDu4b3pg6wts
         9MA4j2LXv5BaPNv0QFEhEcNtbIPsyhFuszovFji4CBVy2045CrlhYb1ec6mYiSCJtYXW
         zCJN0iporDt9WDsCAU5ztNkfT2Y6ZtQ4CBvTDwhNJgeeLyKrk/oYNgV3g9P4lYV9eX8W
         ATpxaa8e3Z9H2qwphUVKQrBDcBZSQKhJ2z5YFnrkOp8LPBQV9CZcIBDoLxyqA2fX2kmm
         vEQvlhy/WbNDqiKNriWO4cDFV9GpFZu1qV0DgimYmcje+Lc+POaXQGJhms/dGcJXegMG
         ZfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vXB03hD5J08BtKN+cL0rsQz91HxiY81ScInc8l4xgQo=;
        b=pOxlE6HSpWpnxrKD9oou+ouyY7qkxhJHT7pIxB600t9DS3obfTUzkgQtalE5JKUZKU
         Pj1616gxAJDfSuoRLJ2qpe3EvXE4CWWrbnx0CG0h3uu7E2FJFFx+IJt10rqb2pCVqqNe
         KArvIkxl0gjSEU0euBHIzCXli3J+9Ku44N1BLjgFrMy/d1LNZrpiWw7niF36LaAZu9WV
         kj0ZMhHFzzcXjBY/F09gds9sQ1xPuHOftf9ZpL+QbwfedsmoW1ZoPZvjkw55dt1gn6FV
         xTWw8LHHEjLT9ln9epRDXbsxMtk17kUHXs8aREEgkMUaqFHDgjQvuK+lGK88njD3pOjh
         zY9w==
X-Gm-Message-State: AGRZ1gL7yY77CTnnOH5kAlBS5W4Yo6de7dqbmvczcrP695MTetOE20qU
        Fu94bUC7PtXZQxM2XCzOjz1xRdI90Xx8YnrX+5k=
X-Google-Smtp-Source: AJdET5fPUC/4ZJhJV335pQ89Rovsp53tc1t+F+WNp+IYxDxKDOd8yaMzP9pykALJoK+cddKEDekpI/ekAFz+VWmi6wc=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr12274766qke.173.1541196204120;
 Fri, 02 Nov 2018 15:03:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 15:03:23 -0700 (PDT)
In-Reply-To: <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
References: <20181102112456.780127-1-arnd@arndb.de> <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 23:03:23 +0100
X-Google-Sender-Auth: 7XrRkyNV9-4L0c5ydjmkvNUOgaQ
Message-ID: <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>
> On 11/2/18 6:24 AM, Arnd Bergmann wrote:
>> The skylake sound support is written to work both with or without
>> CONFIG_SND_SOC_HDAC_HDA, and uses an #ifdef to decide whether it should
>> link against that. However, this fails with SND_SOC_ALL_CODECS=m or
>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m when the Skylake support itself
>> is built-in, with this link error:
>>
>> sound/soc/intel/skylake/skl.o: In function `skl_probe':
>> skl.c:(.text+0x56c): undefined reference to `snd_soc_hdac_hda_get_ops'
>>
>> Using an explicit 'select' here simplifies the logic and prevents
>> it from happening, at the cost of always including the compile
>> time dependency.
>
> Thanks Arnd for the report. I don't quite agree with the proposal, this
> should be similar to HDAC_HDMI which is not selected by default, and
> there's no reason to force the support for HDAudio when the vast
> majority of Skylake+ devices which enable this driver don't have any
> HDaudio codec.

Sure, feel free to treat this patch as a bug report and come up with
a better fix.

> Also the code is skl.c is already conditional, so this function should
> not be required.
>
> Do you have a config that fails, I'd like to look at this further.

https://pastebin.com/4iYPGxkU is what first triggered this.

      Arnd
