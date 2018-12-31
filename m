Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466F6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227092133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeLaKYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:24:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:32717 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeLaKYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 05:24:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 02:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,422,1539673200"; 
   d="scan'208";a="263381068"
Received: from alwhite-mobl4.amr.corp.intel.com (HELO [10.255.228.59]) ([10.255.228.59])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2018 02:24:41 -0800
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s5hk1k48ayx.wl-tiwai@suse.de>
 <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de>
 <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
 <s5h1s5ykteg.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <acbc8f2d-c112-550d-1028-b4c234df4c1b@linux.intel.com>
Date:   Mon, 31 Dec 2018 04:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5h1s5ykteg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/31/18 2:11 AM, Takashi Iwai wrote:
> On Mon, 31 Dec 2018 00:17:58 +0100,
> Pierre-Louis Bossart wrote:
>>> BTW, one thing I'd really like to avoid is to rearrange the probe
>>> procedure of the legacy HDA driver (so that we can get codec_mask
>>> during pci probe() call).  The async probe is the result of the many
>>> struggles with the various and complex configurations.   Moving the
>>> codec probe to the beginning isn't trivial and quite risky to break
>>> something else.
>> Agree, mucking with the probe isn't something we should look into,
>> especially with this Skylake driver being eventually deprecated once
>> SOF is at feature parity. This set of autodetection patches for 4.21
>> was really targeting CFL/WHL+ devices, where the DSP usage is
>> mandatory when directly-attached digital microphones are used. For
>> Skylake and kabylake using the legacy by default is just fine.
> OK, then how about applying the PCI class check only for such ones
> like the patch below?  The macro isn't sexy and can be replaced with
> another way, but you have an idea.

The two patches which added the PCI class checks were supposed to be a 
simple bullet-proof way of detecting the DSP presence and solving a 
problem of coexistence between two drivers. At this point if we start 
adding quirks and still have unclear issues with HDMI support which 
isn't different for CFL+, it may be wiser to revert them to let the 4.21 
merge window progress? It's frustrating but I'd rather solve this 
problem the right way than with multiple iterations rushed because of 
the merge window timing.

>
>
> thanks,
>
> Takashi
>
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -380,6 +380,13 @@ enum {
>   #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
>   #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
>   
> +/* CFL and later models, preferring ASoC when DSP is available */
> +#define IS_CFL_PLUS(pci)	     \
> +	((pci)->vendor == 0x8086 &&  \
> +	 ((pci)->device == 0xa348 || \
> +	  (pci)->device == 0x9dc8 || \
> +	  (pci)->device == 0x34c8))
> +
>   static char *driver_short_names[] = {
>   	[AZX_DRIVER_ICH] = "HDA Intel",
>   	[AZX_DRIVER_PCH] = "HDA Intel PCH",
> @@ -2056,7 +2063,7 @@ static int azx_probe(struct pci_dev *pci,
>   	if (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) {
>   		switch (skl_pci_binding) {
>   		case SND_SKL_PCI_BIND_AUTO:
> -			if (pci->class != 0x040300) {
> +			if (pci->class != 0x040300 && IS_CFL_PLUS(pci)) {
>   				dev_info(&pci->dev, "The DSP is enabled on this platform, aborting probe\n");
>   				return -ENODEV;
>   			}
>
>
