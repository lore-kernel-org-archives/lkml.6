Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130DDC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E66720644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ds+Hs+p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E66720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJVOCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:02:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43898 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJVOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:02:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id d8-v6so7268634pgv.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 22:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QVmYwbsNG5bCOYhvkC1BJKsz0sRqPZ2yAfHeiZiCAWA=;
        b=Ds+Hs+p+tgFYM8FYjT83+zRuGzhte9kn4uUjRlmoezqhxD7ubqbu1VnAPg1F9fuak0
         iiO11HUQ41Vc1hGDuUL2YekD/mtCOkyI6JVukCqTWD0eiuvYzSu5V7u897xDYWOqnYF0
         72Orb0vy2KydoTnNtRDssFba2np6bzbzm4IYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QVmYwbsNG5bCOYhvkC1BJKsz0sRqPZ2yAfHeiZiCAWA=;
        b=WHnXEk1ZgfGn/lyMEYsz3dde1ujc0ILPktfSzj6cBupbmIVQgEMlMmB/dRQUIOjqKs
         deOAFsthWFW4mfGFpW4Giy0s9MuaIYjj89F2chTwCiZTY+MVaHQUKHqoG37mKcBexGP5
         RozfndS5joEswxa351EX43rcyQFszh6YX7RsxdIC0UKPSrQ+ZKMubBRMPcf0qCGgg//C
         agQqIW4yr6CCEy1XPyDF3t4Kbj34l/pG60i1FVNxjpnyi+EYEtpAsdRAO+wvsrDj+BTi
         sgc0DxpOt+2MxEOqhW6I44Fi64PyVTQSEF5TtuY5zgWdW4m7nquF2WBh7+7+8ZuM+HfZ
         NHNA==
X-Gm-Message-State: AGRZ1gK54os7Bi3Zm/EHD6yVdMR8hCd36yee7Yb5AWv0uPS1jb5hrcVO
        2AvKCqOEy25LmtB+iLCSHprpEw==
X-Google-Smtp-Source: AJdET5eT7ESMRJfOgN3cjvq5vTV+n2kGntuN0jPHfgryltHI6AKWAZ/7rbhQXoB7IjUgZSsOPgQ/sg==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr2985993pgb.242.1540187153819;
        Sun, 21 Oct 2018 22:45:53 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id 5-v6sm40325358pgt.83.2018.10.21.22.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 22:45:52 -0700 (PDT)
Date:   Mon, 22 Oct 2018 11:15:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: opp: Extend qcom-opp bindings with
 properties needed for CPR
Message-ID: <20181022054550.zlreptvlqn4z2jtq@vireshk-i7>
References: <20180627045234.27403-3-rnayak@codeaurora.org>
 <20181015124749.27276-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015124749.27276-1-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-18, 14:47, Niklas Cassel wrote:
> Extend qcom-opp bindings with properties needed for Core Power Reduction
> (CPR).
> 
> CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and
> msm8996, and was first introduced in msm8974.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
> Hello Rob, Rajendra,
> 
> Sorry for not replying sooner.
> Since Rob wanted the binding to be complete before merging,
> this is my proposal to extend the OPP binding with properties
> needed to support CPR (both for msm8916 and msm8996).
> I've discussed the proposal with Viresh, and this proposal
> seems better than what I previously suggested here:
> https://lore.kernel.org/lkml/20181005204424.GA29500@centauri.lan/
> 
>  .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> index db4d970c7ec7..3ab5dd84de86 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> @@ -23,3 +23,22 @@ Required properties:
>  representing a corner/level that's communicated with a remote microprocessor
>  (usually called the RPM) which then translates it into a certain voltage on
>  a voltage rail.
> +
> +Optional properties:
> +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. Even
> +  though a power domain doesn't need a opp-hz, there can be devices in the
> +  power domain that need to know the highest supported frequency for each
> +  corner/level (e.g. CPR), in order to properly initialize the hardware.
> +
> +- qcom,fuse-level: A positive value representing the fuse corner/level
> +  associated with this OPP node. Sometimes several corners/levels shares
> +  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
> +  min uV, and max uV.
> +
> +- qcom,fuse-level-<name>: Named qcom,fuse-level property. This is exactly
> +  similar to the above qcom,fuse-level property, but allows multiple
> +  fuse corners/levels to be provided for the same OPP. At runtime, the
> +  platform can pick a <name> and matching qcom,fuse-level-<name> property
> +  will be enabled for all OPPs. If the platform doesn't pick a specific
> +  <name> or the <name> doesn't match with any qcom,fuse-level-<name>
> +  properties, then qcom,fuse-level property shall be used, if present.

LGTM.

-- 
viresh
