Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3285AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED64120835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bPKNq08X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bPKNq08X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfALACM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:02:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfALACM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:02:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EAFFB6079B; Sat, 12 Jan 2019 00:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547251330;
        bh=0rAQdi6qUXszAXrj1HB7ReG5Lx5xRSULNYXKlW/oM8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPKNq08XNiOO+mx6kd/GxbuJpI5uNI9piJayRI5d9RfyztZv8PTR/hlj7XS43QvSR
         XDala6QXrWxXH70hwf0byJbucekxfPfVrZfG+S9ODcQTHZF639CUsZQn2A+Vc+j0Qm
         PkwuJPb2t9fZl7Djs2A5+y93Hx0a3IpGuHvqYZGU=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A51960300;
        Sat, 12 Jan 2019 00:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547251330;
        bh=0rAQdi6qUXszAXrj1HB7ReG5Lx5xRSULNYXKlW/oM8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPKNq08XNiOO+mx6kd/GxbuJpI5uNI9piJayRI5d9RfyztZv8PTR/hlj7XS43QvSR
         XDala6QXrWxXH70hwf0byJbucekxfPfVrZfG+S9ODcQTHZF639CUsZQn2A+Vc+j0Qm
         PkwuJPb2t9fZl7Djs2A5+y93Hx0a3IpGuHvqYZGU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A51960300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 11 Jan 2019 17:02:06 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/msm: Fix A6XX support for opp-level
Message-ID: <20190112000206.GB14059@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        David Airlie <airlied@linux.ie>, freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20190111222721.246972-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111222721.246972-1-dianders@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 02:27:21PM -0800, Douglas Anderson wrote:
> The bindings for Qualcomm opp levels changed after being Acked but
> before landing.  Thus the code in the GPU that was relying on the old
> bindings is now broken.
> 
> While we could just change the string 'qcom,level' to the string
> 'opp-level', it actually seems better to use the newly-introduced
> dev_pm_opp_get_level().
> 
> This patch thus has a hard dependency on the outstanding patch ("OPP:
> Add support for parsing the 'opp-level' property") and will need to
> land in a tree that contains that patch.
> 
> This patch needs to land before the patch ("arm64: dts: sdm845: Add
> gpu and gmu device nodes") since if a tree contains the device tree
> patch but not this one you'll get a crash at bootup.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> ---
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 5beb83d1cf87..900f18dc1577 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -928,25 +928,20 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
>  }
>  
>  /* Return the 'arc-level' for the given frequency */
> -static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
> +static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
> +					   unsigned long freq)
>  {
>  	struct dev_pm_opp *opp;
> -	struct device_node *np;
> -	u32 val = 0;
> +	unsigned int val;
>  
>  	if (!freq)
>  		return 0;
>  
> -	opp  = dev_pm_opp_find_freq_exact(dev, freq, true);
> +	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
>  	if (IS_ERR(opp))
>  		return 0;
>  
> -	np = dev_pm_opp_get_of_node(opp);
> -
> -	if (np) {
> -		of_property_read_u32(np, "qcom,level", &val);
> -		of_node_put(np);
> -	}
> +	val = dev_pm_opp_get_level(opp);
>  
>  	dev_pm_opp_put(opp);
>  
> @@ -982,7 +977,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
>  	/* Construct a vote for each frequency */
>  	for (i = 0; i < freqs_count; i++) {
>  		u8 pindex = 0, sindex = 0;
> -		u32 level = a6xx_gmu_get_arc_level(dev, freqs[i]);
> +		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);
>  
>  		/* Get the primary index that matches the arc level */
>  		for (j = 0; j < pri_count; j++) {
> -- 
> 2.20.1.97.g81188d93c3-goog
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
