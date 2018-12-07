Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A627A20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="PxUbF+M0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A627A20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLGBbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:31:03 -0500
Received: from onstation.org ([52.200.56.107]:55350 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGBbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:31:03 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6304E17F;
        Fri,  7 Dec 2018 01:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1544146262;
        bh=vcdrdX1szvmHjnsXgWmO1nkIo4SQ2uuX0m1iqzJuqy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxUbF+M0qSArWSRnmJKfPJqblnfWUO2TklHfZmV262Gzvuy2L0GUSJ+3IAdQaAxu/
         YVrdGUyCXIXNrpqhLtITX26m1we81wfJGjbSOjHqtsfxBLwGii9Tm8P6A4sCb2Me0+
         9L5XbXt6oc+VFBBD01eJbmls5cszQ7HAmCW5aDIM=
Date:   Thu, 6 Dec 2018 20:31:01 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, evgreen@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
Message-ID: <20181207013101.GA27539@basecamp>
References: <20181206222318.240401-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206222318.240401-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:23:18PM -0800, Douglas Anderson wrote:
> At the end of regulator_resolve_supply() we have historically turned
> on our supply in some cases.  This could be for one of two reasons:
> 
> 1. If resolving supplies was happening before the call to
>    set_machine_constraints() we needed to predict if
>    set_machine_constraints() was going to turn the regulator on and we
>    needed to preemptively turn the supply on.
> 2. Maybe set_machine_constraints() happened before we could resolve
>    supplies (because we failed the first time to resolve) and thus we
>    might need to propagate an enable that already happened up to our
>    supply.
> 
> Historically regulator_resolve_supply() used _regulator_is_enabled()
> to decide whether to turn on the supply.
> 
> Let's change things a little bit.  Specifically:
> 
> 1. Let's try to enable the supply and the regulator in the same place,
>    both in set_machine_constraints().  This means that we have exactly
>    the same logic for enabling the supply and the regulator.
> 2. Let's properly set use_count when we enable always-on or boot-on
>    regulators even for those that don't have supplies.  The previous
>    commit 1fc12b05895e ("regulator: core: Avoid propagating to
>    supplies when possible") only did this right for regulators with
>    supplies.
> 3. Let's make it clear that the only time we need to enable the supply
>    in regulator_resolve_supply() is if the main regulator is currently
>    in use.  By using use_count (like the rest of the code) to decide
>    if we're going to enable our supply we keep everything consistent.
> 
> Overall the new scheme should be cleaner and easier to reason about.
> In addition to fixing regulator_summary to be more correct (because of
> the more correct use_count), this change also has the effect of no
> longer using _regulator_is_enabled() in this code path.
> _regulator_is_enabled() could return an error code for some regulators
> at bootup (like RPMh) that can't read their initial state.  While one
> can argue that the design of those regulators is sub-optimal, the new
> logic sidesteps this brokenness.  This fix in particular fixes
> observed problems on Qualcomm sdm845 boards which use the
> above-mentioned RPMh regulator.  Those problems were made worse by
> commit 1fc12b05895e ("regulator: core: Avoid propagating to supplies
> when possible") because now we'd think at bootup that the SD
> regulators were already enabled and we'd never try them again.
> 
> Fixes: 1fc12b05895e ("regulator: core: Avoid propagating to supplies when possible")
> Reported-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Looks good on the Nexus 5 (qcom msm8974).

Tested-by: Brian Masney <masneyb@onstation.org>
