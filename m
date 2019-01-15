Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D755C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0D420645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="uL/yHC/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbfAOVsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:48:11 -0500
Received: from mail.horus.com ([78.46.148.228]:43011 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbfAOVsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:48:10 -0500
Received: from lenny.lan (62-47-205-132.adsl.highway.telekom.at [62.47.205.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl Lenny", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 974A664138;
        Tue, 15 Jan 2019 22:48:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1547588888;
        bh=OxksLVlLTnfRNtyihoUBx070FU8FZN8M+aNl8mptglU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uL/yHC/L3wKgOnDXnAxwlBJvOYoz+dc7e6jEimVh+MWUyXFYan7VkpPQ3BtnHRhwV
         YDRDXJn79a15alXGf9RzkizPjsf0Hoc60LVd4u6HtVaas6m+NZJ+KGoVeAXs2gHR1i
         tDG/Pbe4KeZRGxJFzWr5/EA3klBxhOIVLu3SVgc0=
Received: by lenny.lan (Postfix, from userid 1000)
        id EED2A100063; Tue, 15 Jan 2019 22:48:07 +0100 (CET)
Date:   Tue, 15 Jan 2019 22:48:07 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190115214807.vhzxuuf33b4nnkoo@lenny.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com,
        plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <20190115214138.GL5522@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115214138.GL5522@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:41:38PM +0000, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 03:16:57PM -0600, Pierre-Louis Bossart wrote:
> 
> > > Maybe the defer card probe logic needs to be extended to also check if
> > > dai_link_name had already been registered (either cpu or cpu_dai_name
> > > needs to be set), not 100% sure which problem the defer card probe patch
> > > was trying to solve.
> 
> We were getting cards probing without the platforms being registered
> (which in turn meant we were just skipping their init) and had patches
> proposed to implement the deferral in the cards.  The deferral stuff is
> supposed to making sure that everything is registered when we
> instantiate.

Ah, that makes sense. Thanks a lot for the info!

so long,

Hias

> 
> > same here, I don't get why the deferred probe stuff only deals with one of
> > the two options.
> 
> I think it's just an oversight - I think the change you were proposing
> to check the cpu_dai_name is a good idea anyway as it makes things more
> consistent and work more obviously by intention.  And more generally if
> we can simplify the code by removing legacy options that'd be good but
> that's a bigger bit of work...


