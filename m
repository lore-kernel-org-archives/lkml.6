Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE6EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D666B206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZFISkBu+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kgF0KTGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfAPTpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:45:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36354 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbfAPTpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:45:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A0196024C; Wed, 16 Jan 2019 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547667945;
        bh=ddWK41vxBC664zh8VbVZtm20yC+tz5cxJXvovfJlykg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFISkBu+ZpWbTWRovYhPOafBzlZTJ+6f89yZy2aZ5mjPN2vM1WjnrCF/ASzRD+l17
         gL9A1jpd1U6w0N4wcl+uW385lo6QtVlz0r+Rhd9BoZ5hyAARahdtL+SFkF0iJGraGL
         9LRTVz0fgB5dIyI5BJTe4MUJS4W5oDopDxH/gKX0=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1D9C6024C;
        Wed, 16 Jan 2019 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547667944;
        bh=ddWK41vxBC664zh8VbVZtm20yC+tz5cxJXvovfJlykg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgF0KTGq5lJGEXbzM5/MtlNAGKqCXPgYh5f0xSxsrq16jqYmKThpVzdNBuVZ1LcwU
         z7mN4mSf952xNSN4a4zkoOE2YlA/CzHPUg3skvYSnf3ip/Bdgm/7NigZPuyPfE8wVE
         kOAmqtWiTkVUMNeoakE3s0mYngSm0yBKsvxEryg8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1D9C6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 16 Jan 2019 12:45:41 -0700
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
Subject: Re: [PATCH v2 1/2] drm/msm: Fix A6XX support for opp-level
Message-ID: <20190116194540.GC4140@jcrouse1-lnx.qualcomm.com>
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
References: <20190116184623.77136-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116184623.77136-1-dianders@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:46:21AM -0800, Douglas Anderson wrote:
> The bindings for Qualcomm opp levels changed after being Acked but
> before landing.  Thus the code in the GPU driver that was relying on
> the old bindings is now broken.
> 
> Let's change the code to match the new bindings by adjusting the old
> string 'qcom,level' to the new string 'opp-level'.  See the patch
> ("dt-bindings: opp: Introduce opp-level bindings").
> 
> NOTE: we will do additional cleanup to totally remove the string from
> the code and use the new dev_pm_opp_get_level() but we'll do it in a
> future patch.  This will facilitate getting the important code fix in
> sooner without having to deal with cross-maintainer dependencies.
> 
> This patch needs to land before the patch ("arm64: dts: sdm845: Add
> gpu and gmu device nodes") since if a tree contains the device tree
> patch but not this one you'll get a crash at bootup.
> 
> Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I agree that splitting these out make sense for the workflow.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
> Changes in v2:
> - Split into two patches to facilitate landing.
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 5beb83d1cf87..ce1b3cc4bf6d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -944,7 +944,7 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
>  	np = dev_pm_opp_get_of_node(opp);
>  
>  	if (np) {
> -		of_property_read_u32(np, "qcom,level", &val);
> +		of_property_read_u32(np, "opp-level", &val);
>  		of_node_put(np);
>  	}
>  
> -- 
> 2.20.1.97.g81188d93c3-goog
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
