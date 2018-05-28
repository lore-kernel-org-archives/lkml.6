Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeE1GD6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbeE1GD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:03:57 -0400
Date: Mon, 28 May 2018 11:33:47 +0530
From: Vinod <vkoul@kernel.org>
To: Shreyas NC <shreyas.nc@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Message-ID: <20180528060347.GA5666@vkoul-mobl>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180525133323.GI3116@snc-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525133323.GI3116@snc-desk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 19:03, Shreyas NC wrote:
> Adding Vinod to help review as well..

Thanks Shreyas,

> > Commit dc31e741db49 ("ASoC: topology: ABI - Add the types for BE
> > DAI") introduced sound topology files version 5. Initially, this
> > change made the topology code incompatible with v4 topology files.
> > Backwards compatibility with v4 configuration files was
> > subsequently added with commit 288b8da7e992 ("ASoC: topology:
> > Support topology file of ABI v4").
> > 
> > Unfortunately, backwards compatibility was never fully implemented.

To give the history, we implement the binary method for data. The structures
given here were indeed ABI but we didn't move them to uapi/ as it was still in
development and with help from Takashi we finally zoomed on Tuple method for
describing the data and hence that was implemented and updated and alsa-lib
files also updated.

I am not sure we were able to ship any alsa release with this method due to
complexity of running intel tool to generate binary data and patch the topology
files.

> > First, the manifest size in (Skylake) v4 configuration files is set
> > to 0, which causes manifest_new_ver() to bail out with error messages
> > similar to the following.

So is this issue with Chrome kernel or upstream? We did ask Chrome to
cherry-pick patches for tuple support for SKL but I guess it was late for
release cycle for them and for SKL I dont think Chrome people took it. Yeah
perils of upstream and production racing...

> > 
> > snd_soc_skl 0000:00:1f.3: ASoC: invalid manifest size
> > snd_soc_skl 0000:00:1f.3: tplg component load failed-22
> > snd_soc_skl 0000:00:1f.3: Failed to init topology!
> > snd_soc_skl 0000:00:1f.3: ASoC: failed to probe component -22
> > skl_n88l25_m98357a skl_n88l25_m98357a: ASoC: failed to instantiate card -22
> > skl_n88l25_m98357a: probe of skl_n88l25_m98357a failed with error -22
> > 
> > After this problem is fixed, the following error message is seen instead.
> > 
> > snd_soc_skl 0000:00:1f.3: ASoC: old version of manifest
> > snd_soc_skl 0000:00:1f.3: Invalid descriptor token 1093938482
> > snd_soc_skl 0000:00:1f.3: ASoC: failed to load widget media0_in cpr 0
> > snd_soc_skl 0000:00:1f.3: tPlg component load failed-22
> > 
> > This message is seen because backwards compatibility for loading widgets
> > was never implemented.
> > 
> > The lack of audio support when running the upstream kernel on recent
> > Chromebooks has been reported in various forums, and can be traced back
> > to this problem. Attempts to fix the problem, usually by providing v5
> > configuration files, were only partially successful.
> > 
> > Let's implement backward compatibility properly to solve the problem
> > for good.

Thanks for doing this, great work indeed.

> > diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
> > index f8d1749a2e0c..b0e3d376594c 100644
> > --- a/sound/soc/intel/skylake/skl-tplg-interface.h
> > +++ b/sound/soc/intel/skylake/skl-tplg-interface.h

Don't we want to move these to upai/ as that is right place and use that in
alsa-lib.


-- 
~Vinod
