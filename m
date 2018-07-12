Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF37C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC812147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjT9Urs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC812147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbeGLQyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbeGLQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:54:14 -0400
Received: from localhost (unknown [106.51.18.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EC520BF2;
        Thu, 12 Jul 2018 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531413834;
        bh=B0h2Six/lErtu1MhSLyQJTEnn9/rnqMO+bpoY13JzCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjT9Urs/7nNhPMlB7AW0I9Vf7tgTnPiwrJBu2Oa+s4A5If2eLn2h/fM81ndEizobX
         45XwvN/zcGVm5VZc7LrBtRowe362R1pA8EWeShFIHeDDxUTHEyApPvrZ+OCTpTkrKJ
         EdFdjCLAC0dsLqYnqSn3u4u391ucNk8qu4hLweCA=
Date:   Thu, 12 Jul 2018 22:13:50 +0530
From:   Vinod <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH] ASoC: core: add support to card
 re-bind/unbind using component framework
Message-ID: <20180712164350.GW3219@vkoul-mobl>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-18, 10:26, Pierre-Louis Bossart wrote:
> On 7/11/18 3:43 AM, Srinivas Kandagatla wrote:
> > This patch aims at add achieving dynamic behaviour of audio card when
> > the dependent components disappear and reappear.
> > 
> > With this patch the card is removed if any of the dependent component
> > is removed and card is added back if the dependent component comes back.
> > All this is done using component framework and matching based on
> > component name.
> 
> Humm, no real comment on this patch proper but rather on how userspace would
> deal with this dynamic behavior?

As Takashi pointed out card disappearing and appearing should not be an
issue. On this machine, I typically run a BT headset which disappears
and keep appearing, haven't seen issue :)

> We had similar opens when we worked on the BYT/CHT HDMI stuff and ended-up
> with quite a few issues in userspace (PulseAudio mainly) related to dynamic
> behavior at the kernel level as a result of plug/unplug.

IIRC those had something to do with gfx callback, register, interrupt
racing on BYT HDMI. Ramesh/Jerome might have more details if they
remember now :)

> Also not sure how
> an Android HAL would deal with a card disappearing temporarily if DSP
> resources become unavailable or unresponsive. Any thoughts or guidance you
> might think of?

I have not see userspace HAL code but my guess is that it deals with
card not being there.

Btw this was handled/buried in the driver atm and asking realized that
this is better suited in core, so Srini pushed it up. Current QC stack
expects DSP to go off and card disappear as a result. Once DSP is back
it would appear again (DSP is handled thru remoteproc, I think you
should have a look at it and see if it would suit your DSP needs too)

-- 
~Vinod
