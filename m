Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E40CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B28E21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="JE+zqLgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeLRRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:47:16 -0500
Received: from mail.horus.com ([78.46.148.228]:41543 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeLRRrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:47:16 -0500
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2018 12:47:14 EST
Received: from [192.168.1.20] (62-47-205-9.adsl.highway.telekom.at [62.47.205.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 705B7641D9;
        Tue, 18 Dec 2018 18:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1545154841;
        bh=NMzcuZQjcluVah8TenQKral9o/O1+dIJaTL7AwYbMpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JE+zqLgiemWwkHaB3yGSuCEshBTtevwRa6ktWnjfDGLED7RH1B3F3XGZGUQ845fvF
         YNMEmvcFRDGxI/BlC6hUwB0csJAQBlIXwyNzxJ9zglTiE2QmSsGqsdjiGlqFyUr6YU
         FbGhiDW5GFd6kWrzr4tlqnmrtaw3UGuJsAj9HUdw=
Received: by camel2.lan (Postfix, from userid 1000)
        id C67941C72A2; Tue, 18 Dec 2018 18:40:40 +0100 (CET)
Date:   Tue, 18 Dec 2018 18:40:40 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name
 vs. of_node assignement
Message-ID: <20181218174040.k7u26vnnoplllnwb@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org
References: <20181018111829.27056-1-marcel@ziswiler.com>
 <20181018111829.27056-4-marcel@ziswiler.com>
 <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
 <20181021112301.GC8554@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021112301.GC8554@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Sun, Oct 21, 2018 at 12:23:01PM +0100, Mark Brown wrote:
> On Fri, Oct 19, 2018 at 11:22:46AM +0100, Jon Hunter wrote:
> 
> > Looking at snd_soc_init_platform(), it seems that the platform pointer
> > can be allocated by the machine driver and so if it is not allocated by
> > the core, then I don't think we should clear it here. Seems we need a
> > way to determine if this was allocated by the core.
> 
> Indeed, this is a bit of a mess.  We probably shouldn't be modifying the
> data that the drivers passed in, otherwise we get into trouble like
> this.   That suggests that we should copy the data, probably all of it.
> I will try to have a proper look at this next week.

did you find the time to look into this?

The downstream Raspberry Pi kernel contains a bunch of machine drivers
that are implemented in a similar way as the tegra_sgtl5000 driver
(static card and dai link structs, dai_link->platform_of_node filled
in from device tree) which are breaking in 4.20 on deferred probing.

Switching these drivers to dynamically allocated dai link structs,
like 76836fd35492 "ASoC: omap-abe-twl6040: Fix missing audio card
caused by deferred probing" would be a possibility, but if there's
some solution on the horizon that doesn't require changes to the
driver code it'd be easier to wait for that.

so long,

Hias

> > Furthermore, it seems that it is possible that there is more than one
> > link that might be to be cleared.
> 
> Yes, that's an issue as well.



> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

