Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeFENmo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:42:44 -0400
Received: from gloria.sntech.de ([95.129.55.99]:38542 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeFENmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:42:38 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        kishon@ti.com, dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, daniel.vetter@intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/5] drm/rockchip: add transfer function for cdn-dp
Date: Tue, 05 Jun 2018 15:42:11 +0200
Message-ID: <2246202.0LhvmkcTbg@diego>
In-Reply-To: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
References: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 23. Mai 2018, 09:42:29 CEST schrieb Lin Huang:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> We may support training outside firmware, so we need support
> dpcd read/write to get the message or do some setting with
> display.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Reviewed-by: Enric Balletbo <enric.balletbo@collabora.com>

> @@ -1030,6 +1064,13 @@ static int cdn_dp_bind(struct device *dev, struct
> device *master, void *data) dp->active = false;
>  	dp->active_port = -1;
>  	dp->fw_loaded = false;
> +	dp->aux.name = "DP-AUX";
> +	dp->aux.transfer = cdn_dp_aux_transfer;
> +	dp->aux.dev = dev;
> +
> +	ret = drm_dp_aux_register(&dp->aux);
> +	if (ret)
> +		return ret;

this is missing matching drm_dp_aux_unregister calls both in the error path as 
well as in the unbind callback.

With the code as is, the kernel gives warnings about it trying to initialize 
an already initialized object ... in cases like probe-deferrals.


Heiko
