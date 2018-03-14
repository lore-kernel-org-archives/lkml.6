Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeCNGJr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:09:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNGJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:09:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEE0A60B67
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 11/36] drm/bridge: analogix_dp: Wait for HPD signal
 before configuring link
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com,
        seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org,
        heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com,
        wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com,
        sw0312.kim@samsung.com, dianders@chromium.org,
        kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-12-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <636d85d6-64bb-5387-912d-1ec09e47f0ef@codeaurora.org>
Date: Wed, 14 Mar 2018 11:39:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-12-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> According to DP spec v1.3 chap 3.5.1.2 Link Training, Link Policy Maker
> must first detect that the HPD signal is asserted high by the Downstream
> Device before establishing a link with it.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> 
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index c81733b8185e..92fb9a072cb6 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1169,6 +1169,17 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>   	if (ret)
>   		goto out_dp_init;
>   
> +	/*
> +	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
> +	 * We should first make sure the HPD signal is asserted high by device
> +	 * when we want to establish a link with it.
> +	 */
> +	ret = analogix_dp_detect_hpd(dp);
> +	if (ret) {
> +		DRM_ERROR("failed to get hpd single ret = %d\n", ret);
> +		goto out_dp_init;
> +	}
> +
>   	ret = analogix_dp_commit(dp);
>   	if (ret)
>   		goto out_dp_init;
> 
