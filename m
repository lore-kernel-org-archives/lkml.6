Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeBFJG6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:06:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7053 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751835AbeBFJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:06:51 -0500
From: Yannick FERTRE <yannick.fertre@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 2/2] drm/panel: otm8009a: Add support for the optional
 power-supply
Thread-Topic: [PATCH v1 2/2] drm/panel: otm8009a: Add support for the optional
 power-supply
Thread-Index: AQHTnmYbIcGzjj9HPkKl4ycIlyfp16OXBgIA
Date: Tue, 6 Feb 2018 09:06:35 +0000
Message-ID: <77c5fd49-6a72-d720-f754-63c975447400@st.com>
References: <20180205094532.23547-1-philippe.cornu@st.com>
 <20180205094532.23547-3-philippe.cornu@st.com>
In-Reply-To: <20180205094532.23547-3-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F6463EDF592E24FBBC111F9B4B7A0F3@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w16974WL017117

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>


On 02/05/2018 10:45 AM, Philippe Cornu wrote:
> Add support for the optional power-supply.
>
> Note: A "dummy regulator" is returned by devm_regulator_get()
> if the optional regulator is not present in the device tree,
> simplifying the source code when enabling/disabling the regulator.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> index 72530983d55d..90f1ae4af93c 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> @@ -11,6 +11,7 @@
>   #include <drm/drm_panel.h>
>   #include <linux/backlight.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
>   #include <video/mipi_display.h>
>   
>   #define DRV_NAME "orisetech_otm8009a"
> @@ -62,6 +63,7 @@ struct otm8009a {
>   	struct drm_panel panel;
>   	struct backlight_device *bl_dev;
>   	struct gpio_desc *reset_gpio;
> +	struct regulator *supply;
>   	bool prepared;
>   	bool enabled;
>   };
> @@ -279,6 +281,8 @@ static int otm8009a_unprepare(struct drm_panel *panel)
>   		msleep(20);
>   	}
>   
> +	regulator_disable(ctx->supply);
> +
>   	ctx->prepared = false;
>   
>   	return 0;
> @@ -292,6 +296,12 @@ static int otm8009a_prepare(struct drm_panel *panel)
>   	if (ctx->prepared)
>   		return 0;
>   
> +	ret = regulator_enable(ctx->supply);
> +	if (ret < 0) {
> +		DRM_ERROR("failed to enable supply: %d\n", ret);
> +		return ret;
> +	}
> +
>   	if (ctx->reset_gpio) {
>   		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>   		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> @@ -414,6 +424,13 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
>   		return PTR_ERR(ctx->reset_gpio);
>   	}
>   
> +	ctx->supply = devm_regulator_get(dev, "power");
> +	if (IS_ERR(ctx->supply)) {
> +		ret = PTR_ERR(ctx->supply);
> +		dev_err(dev, "failed to request regulator: %d\n", ret);
> +		return ret;
> +	}
> +
>   	mipi_dsi_set_drvdata(dsi, ctx);
>   
>   	ctx->dev = dev;
