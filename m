Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB120659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBB120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeH1Qso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:48:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:63944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1Qso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:48:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 05:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="68717077"
Received: from thaataja-mobl.ger.corp.intel.com (HELO [10.252.52.91]) ([10.252.52.91])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2018 05:54:04 -0700
Subject: Re: [PATCH] drm: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Gustavo Padovan <gustavo@padovan.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-19-robh@kernel.org>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <597b1b06-e1fb-dcf1-67f4-d6685fd38cad@linux.intel.com>
Date:   Tue, 28 Aug 2018 14:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-19-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 28-08-18 om 03:52 schreef Rob Herring:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/drm_modes.c     | 4 ++--
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 02db9ac82d7a..24a750436559 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -716,8 +716,8 @@ int of_get_drm_display_mode(struct device_node *np,
>  	if (bus_flags)
>  		drm_bus_flags_from_videomode(&vm, bus_flags);
>  
> -	pr_debug("%pOF: got %dx%d display mode from %s\n",
> -		np, vm.hactive, vm.vactive, np->name);
> +	pr_debug("%pOF: got %dx%d display mode\n",
> +		np, vm.hactive, vm.vactive);
Aren't you removing it here instead of converting?

~Maarten
>  	drm_mode_debug_printmodeline(dmode);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index c79659ca5706..23670907a29d 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -579,7 +579,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
>  	hdmi_cfg = (struct hdmi_platform_config *)
>  			of_device_get_match_data(dev);
>  	if (!hdmi_cfg) {
> -		dev_err(dev, "unknown hdmi_cfg: %s\n", of_node->name);
> +		dev_err(dev, "unknown hdmi_cfg: %pOFn\n", of_node);
>  		return -ENXIO;
>  	}
>  


