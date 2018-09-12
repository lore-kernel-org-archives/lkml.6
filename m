Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A98C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064472133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064472133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIMDJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:09:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:29651 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeIMDJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:09:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 15:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,366,1531810800"; 
   d="scan'208";a="91202185"
Received: from przanoni-mobl.jf.intel.com ([10.24.10.174])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2018 15:02:31 -0700
Message-ID: <1536789750.2958.17.camel@intel.com>
Subject: Re: [PATCH] drm/i915/dp: fix shifting by a negative number of bits
From:   Paulo Zanoni <paulo.r.zanoni@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Date:   Wed, 12 Sep 2018 15:02:30 -0700
In-Reply-To: <20180912143153.GA27564@embeddedor.com>
References: <20180912143153.GA27564@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2018-09-12 às 09:31 -0500, Gustavo A. R. Silva escreveu:
> Function intel_port_to_tc() returns PORT_TC_NONE on error, which is
> a negative value -1. In case PORT_TC_NONE is returned, there is an
> undefined behavior when shifting by a negative number of bits in
> both DP_PHY_MODE_STATUS_NOT_SAFE and P_PHY_MODE_STATUS_COMPLETED
> macros.
> 
> Fix this by adding sanity checks on intel_port_to_tc return value,
> before
> using macros DP_PHY_MODE_STATUS_NOT_SAFE and
> P_PHY_MODE_STATUS_COMPLETED.

This was just discussed yesterday in a patch by Rodrigo:

https://patchwork.freedesktop.org/patch/246903/

I would personally prefer his version because it avoids passing -1 to
register macros that Coverity doesn't seem to care about, it's a single
check and it prints WARN() instead of DRM_DEBUG_KMS().

Although I do prefer your commit message explanation :).

Perhaps I should reconsider my vote to not merge it. Or we could
actually go and test what happens when intel_port_to_tc() is broken,
fixing all the issues instead of just the ones reported by Coverity.

Anyway, Rodrigo's patch with an improved commit message could receive
my R-B tag now.

> 
> Addresses-Coverity-ID: 1473324 ("Bad bit shift operation")
> Addresses-Coverity-ID: 1473325 ("Bad bit shift operation")
> Fixes: 39d1e234e1e1 ("drm/i915/icl: implement the tc/legacy HPD
> {dis,}connect flows")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/i915/intel_dp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp.c
> b/drivers/gpu/drm/i915/intel_dp.c
> index 436c22d..e34b7b1 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -4811,6 +4811,11 @@ static bool icl_tc_phy_connect(struct
> drm_i915_private *dev_priv,
>  	    dig_port->tc_type != TC_PORT_TYPEC)
>  		return true;
>  
> +	if (tc_port < 0) {
> +		DRM_DEBUG_KMS("Bad TC port %d\n", tc_port);
> +		return false;
> +	}
> +
>  	val = I915_READ(PORT_TX_DFLEXDPPMS);
>  	if (!(val & DP_PHY_MODE_STATUS_COMPLETED(tc_port))) {
>  		DRM_DEBUG_KMS("DP PHY for TC port %d not ready\n",
> tc_port);
> @@ -4857,6 +4862,10 @@ static void icl_tc_phy_disconnect(struct
> drm_i915_private *dev_priv,
>  	    dig_port->tc_type != TC_PORT_TYPEC)
>  		return;
>  
> +	if (tc_port < 0) {
> +		DRM_DEBUG_KMS("Bad TC port %d\n", tc_port);
> +		return;
> +	}
>  	/*
>  	 * This function may be called many times in a row without
> an HPD event
>  	 * in between, so try to avoid the write when we can.
