Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbeCMDsG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 23:48:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:33905 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbeCMDsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 23:48:05 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: hl@rock-chips.com
X-FST-TO: nickey.yang@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: hl@rock-chips.com
X-UNIQUE-TAG: <47f77ddf6281f79e2cc62cbf4fe79770>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [RESEND PATCH v3 1/3] drm/panel: refactor INNOLUX P079ZCA panel
 driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: emil.l.velikov@gmail.com, briannorris@chromium.org, robh+dt@kernel.org,
        zyw@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nickey.yang@rock-chips.com
References: <1512371870-15350-1-git-send-email-hl@rock-chips.com>
 <20180312092110.GC15972@ulmo>
From: hl <hl@rock-chips.com>
Message-ID: <81b850e7-aa0c-16c1-5225-b01e2b546417@rock-chips.com>
Date: Tue, 13 Mar 2018 11:41:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312092110.GC15972@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry Reding,


On Monday, March 12, 2018 05:21 PM, Thierry Reding wrote:
> On Mon, Dec 04, 2017 at 03:17:48PM +0800, Lin Huang wrote:
>> Refactor Innolux P079ZCA panel driver, let it support
>> multi panel.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> ---
>> Changes in v2:
>> - Change regulator property name to meet the panel datasheet
>> Changes in v3:
>> - this patch only refactor P079ZCA panel to support multi panel, support P097PFG panel in another patch
>>
>>   drivers/gpu/drm/panel/panel-innolux-p079zca.c | 147 ++++++++++++++++++--------
>>   1 file changed, 105 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
>> index 6ba9344..1597744 100644
>> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
>> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
>> @@ -20,12 +20,32 @@
>>   
>>   #include <video/mipi_display.h>
>>   
>> +struct panel_desc {
>> +	const struct drm_display_mode *modes;
>> +	unsigned int bpc;
>> +	struct {
>> +		unsigned int width;
>> +		unsigned int height;
>> +	} size;
>> +};
>> +
>> +struct panel_desc_dsi {
>> +	struct panel_desc desc;
>> +
>> +	unsigned long flags;
>> +	enum mipi_dsi_pixel_format format;
>> +	unsigned int lanes;
>> +};
> There's no need for the two layers here. Just move everything from
> struct panel_desc_dsi into struct panel_desc.
Okay, will fix it.
>
>> +
>>   struct innolux_panel {
>>   	struct drm_panel base;
>>   	struct mipi_dsi_device *link;
>> +	const struct panel_desc_dsi *dsi_desc;
> And then this can just become:
>
> 	const struct panel_desc *desc;
>
> The _dsi suffix is redundant because this driver is exclusively for DSI
> devices.
>
Got it.
>> -static int innolux_panel_add(struct innolux_panel *innolux)
>> +static int innolux_panel_add(struct mipi_dsi_device *dsi,
>> +			     const struct panel_desc_dsi *desc)
>>   {
>> -	struct device *dev = &innolux->link->dev;
>> +	struct innolux_panel *innolux;
>> +	struct device *dev = &dsi->dev;
>>   	struct device_node *np;
>>   	int err;
>>   
>> -	innolux->supply = devm_regulator_get(dev, "power");
>> -	if (IS_ERR(innolux->supply))
>> -		return PTR_ERR(innolux->supply);
>> +	innolux = devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
>> +	if (!innolux)
>> +		return -ENOMEM;
>> +
>> +	innolux->dsi_desc = desc;
>> +	innolux->vddi = devm_regulator_get(dev, "power");
>> +	if (IS_ERR(innolux->vddi))
>> +		return PTR_ERR(innolux->vddi);
>> +
>> +	innolux->avdd = devm_regulator_get(dev, "avdd");
>> +	if (IS_ERR(innolux->avdd))
>> +		return PTR_ERR(innolux->avdd);
>> +
>> +	innolux->avee = devm_regulator_get(dev, "avee");
>> +	if (IS_ERR(innolux->avee))
>> +		return PTR_ERR(innolux->avee);
> According to the device tree bindings these regulators are all optional.
> Now devm_regulator_get() will return a dummy regulator if one has not
> been specified in DT, so this seems like it should work fine, even for
> existing DTBs that don't have the avdd and avee regulators. However, the
> DT bindings seem to be wrong, because these are in fact required
> regulators.
Actually, the vddi is request, and avdd and avee is optional, i will 
only check
vddi error later.
>>   
>>   	innolux->enable_gpio = devm_gpiod_get_optional(dev, "enable",
>>   						       GPIOD_OUT_HIGH);
>> @@ -243,14 +306,16 @@ static int innolux_panel_add(struct innolux_panel *innolux)
>>   
>>   	drm_panel_init(&innolux->base);
>>   	innolux->base.funcs = &innolux_panel_funcs;
>> -	innolux->base.dev = &innolux->link->dev;
>> +	innolux->base.dev = dev;
>>   
>>   	err = drm_panel_add(&innolux->base);
>>   	if (err < 0)
>>   		goto put_backlight;
>>   
>> -	return 0;
>> +	dev_set_drvdata(dev, innolux);
>> +	innolux->link = dsi;
>>   
>> +	return 0;
>>   put_backlight:
>>   	put_device(&innolux->backlight->dev);
>>   
>> @@ -267,28 +332,25 @@ static void innolux_panel_del(struct innolux_panel *innolux)
>>   
>>   static int innolux_panel_probe(struct mipi_dsi_device *dsi)
>>   {
>> -	struct innolux_panel *innolux;
>> -	int err;
>>   
>> -	dsi->lanes = 4;
>> -	dsi->format = MIPI_DSI_FMT_RGB888;
>> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>> -			  MIPI_DSI_MODE_LPM;
>> -
>> -	innolux = devm_kzalloc(&dsi->dev, sizeof(*innolux), GFP_KERNEL);
>> -	if (!innolux)
>> -		return -ENOMEM;
>> +	const struct panel_desc_dsi *dsi_desc;
>> +	const struct of_device_id *id;
>> +	int err;
>>   
>> -	mipi_dsi_set_drvdata(dsi, innolux);
>> +	id = of_match_node(innolux_of_match, dsi->dev.of_node);
>> +	if (!id)
>> +		return -ENODEV;
>>   
>> -	innolux->link = dsi;
>> +	dsi_desc = id->data;
>> +	dsi->mode_flags = dsi_desc->flags;
>> +	dsi->format = dsi_desc->format;
>> +	dsi->lanes = dsi_desc->lanes;
>>   
>> -	err = innolux_panel_add(innolux);
>> +	err = innolux_panel_add(dsi, dsi_desc);
>>   	if (err < 0)
>>   		return err;
>>   
>> -	err = mipi_dsi_attach(dsi);
>> -	return err;
>> +	return mipi_dsi_attach(dsi);
>>   }
>>   
>>   static int innolux_panel_remove(struct mipi_dsi_device *dsi)
>> @@ -326,7 +388,7 @@ static void innolux_panel_shutdown(struct mipi_dsi_device *dsi)
>>   
>>   static struct mipi_dsi_driver innolux_panel_driver = {
>>   	.driver = {
>> -		.name = "panel-innolux-p079zca",
>> +		.name = "panel-innolux-dsi",
> No need to change that. Also, probably a bad idea to change it because
> there are (or will be) likely other DSI panels from Innolux that are not
> compatible with this driver.
Okay, will fix it.
>
> Thierry
