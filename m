Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeBWIat (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:30:49 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51934 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750910AbeBWIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:30:46 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 2/2] drm/panel: otm8009a: Add support for the optional
 power-supply
Thread-Topic: [PATCH v1 2/2] drm/panel: otm8009a: Add support for the optional
 power-supply
Thread-Index: AQHTnmYbQDiKk4+bDEy6RqkOjdNb+aOxs4iA
Date: Fri, 23 Feb 2018 08:30:24 +0000
Message-ID: <438395fc-f0f4-0536-155f-f2f3e60e912c@st.com>
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
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <85EB1CD0E4FD334BB4A3E2482E3FDE3A@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1N8UtxP010744

Hi Thierry & David,

May I ask you please your feedback on this small patch?
Many thanks,

Philippe :-)

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
> 
