Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427320AbeCBMJK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:09:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45990 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423004AbeCBMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:09:07 -0500
Subject: Re: [PATCH v8 4/8] drm/rockchip: dw-mipi-dsi: Fix error handling path
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
References: <20180110162348.22765-1-thierry.escande@collabora.com>
 <20180110162348.22765-5-thierry.escande@collabora.com>
 <13219770.NOTAg9tncx@diego>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <68537204-0c41-5210-935a-0a7743ea847c@collabora.com>
Date: Fri, 2 Mar 2018 13:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <13219770.NOTAg9tncx@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 01/03/18 16:50, Heiko Stübner wrote:
> Hi Jeffy, Thierry, Enric,
> 
> Am Mittwoch, 10. Januar 2018, 17:23:44 CET schrieb Thierry Escande:
>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> Add missing pm_runtime_disable() in bind()'s error handling path.
>>
>> Also cleanup encoder & connector in unbind().
> 
> Can you please split all these surprise "Also" sections into separate
> patches?
> 

I'll take a look.

> It looks like this is true for all following patch to some degree and
> the inno-hdmi patch even has a unbind reordering-change without
> mentioning it in the commit message.
> 

Actually, I think this patch is not correct against current mainline, see below.

> 
> Thanks
> Heiko
> 
>> Fixes: 80a9a059d4e4 ("drm/rockchip/dsi: add dw-mipi power domain support")
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>> ---
>>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>> b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c index b1fe0639227e..78e6b7919bf7
>> 100644
>> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>> @@ -1282,7 +1282,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct
>> device *master, ret = dw_mipi_dsi_register(drm, dsi);
>>  	if (ret) {
>>  		DRM_DEV_ERROR(dev, "Failed to register mipi_dsi: %d\n", ret);
>> -		goto err_pllref;
>> +		goto err_disable_pllref;
>>  	}
>>
>>  	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
>> @@ -1290,24 +1290,25 @@ static int dw_mipi_dsi_bind(struct device *dev,
>> struct device *master, ret = mipi_dsi_host_register(&dsi->dsi_host);
>>  	if (ret) {
>>  		DRM_DEV_ERROR(dev, "Failed to register MIPI host: %d\n", ret);
>> -		goto err_cleanup;
>> +		goto err_disable_pm_runtime;
>>  	}
>>
>>  	if (!dsi->panel) {
>>  		ret = -EPROBE_DEFER;
>> -		goto err_mipi_dsi_host;
>> +		goto err_unreg_mipi_dsi_host;
>>  	}
>>
>>  	dev_set_drvdata(dev, dsi);
>>  	pm_runtime_enable(dev);
>>  	return 0;
>>
>> -err_mipi_dsi_host:
>> +err_unreg_mipi_dsi_host:
>>  	mipi_dsi_host_unregister(&dsi->dsi_host);
>> -err_cleanup:
>> -	drm_encoder_cleanup(&dsi->encoder);
>> -	drm_connector_cleanup(&dsi->connector);
>> -err_pllref:
>> +err_disable_pm_runtime:
>> +	pm_runtime_disable(dev);

I think that this is not required, 'pm_runtime_enable' is called just before the
'return 0' (see above). Commit 517f56839f58 'drm/rockchip: dw-mipi-dsi: fix
possible un-balanced runtime PM enable' moved the call to that place. So, now
the call to pm_runtime_disable is not needed.

>> +	dsi->connector.funcs->destroy(&dsi->connector);
>> +	dsi->encoder.funcs->destroy(&dsi->encoder);

Here, there is a reordering and also a function replacement. The reorder makes
sense to me, first cleanup the connector and then the encoder, but I'm not sure
about the function change and if is needed, anyway, in the case is needed,
shouldn't be

+	drm_connector_cleanup(&dsi->connector);
+	drm_encoder_cleanup(&dsi->encoder);

instead?

>> +err_disable_pllref:
>>  	clk_disable_unprepare(dsi->pllref_clk);
>>  	return ret;
>>  }
>> @@ -1319,6 +1320,10 @@ static void dw_mipi_dsi_unbind(struct device *dev,
>> struct device *master,
>>
>>  	mipi_dsi_host_unregister(&dsi->dsi_host);
>>  	pm_runtime_disable(dev);
>> +
>> +	dsi->connector.funcs->destroy(&dsi->connector);
>> +	dsi->encoder.funcs->destroy(&dsi->encoder);
>> +

Same here.

>>  	clk_disable_unprepare(dsi->pllref_clk);
>>  }
> 
> 

Best regards,
  Enric
