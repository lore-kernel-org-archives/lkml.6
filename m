Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933334AbeBMCr1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 21:47:27 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:52400 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932890AbeBMCrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 21:47:25 -0500
Subject: Re: [PATCH v7 5/9] dmtimer: Add timer ops to the platform data
 structure
To: "J, KEERTHY" <j-keerthy@ti.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kristo, Tero" <t-kristo@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sebastian.reichel@collabora.co.uk"
        <sebastian.reichel@collabora.co.uk>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-6-git-send-email-j-keerthy@ti.com>
From: Suman Anna <s-anna@ti.com>
Message-ID: <c7edf8b6-6b27-692a-813f-13c86f988831@ti.com>
Date: Mon, 12 Feb 2018 20:46:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515478987-5786-6-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.247.58.153]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2018 12:23 AM, J, KEERTHY wrote:
> Add timer ops to the platform data structure
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Tested-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>   include/linux/platform_data/dmtimer-omap.h | 38 ++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/platform_data/dmtimer-omap.h 
> b/include/linux/platform_data/dmtimer-omap.h
> index a19b78d..a3e1794 100644
> --- a/include/linux/platform_data/dmtimer-omap.h
> +++ b/include/linux/platform_data/dmtimer-omap.h
> @@ -20,12 +20,50 @@
>   #ifndef __PLATFORM_DATA_DMTIMER_OMAP_H__
>   #define __PLATFORM_DATA_DMTIMER_OMAP_H__
> 
> +struct omap_dm_timer_ops {
> +       struct omap_dm_timer *(*request_by_node)(struct device_node *np);
> +       struct omap_dm_timer *(*request_specific)(int timer_id);
> +       struct omap_dm_timer *(*request)(void);
> +
> +       int     (*free)(struct omap_dm_timer *timer);
> +
> +       void    (*enable)(struct omap_dm_timer *timer);
> +       void    (*disable)(struct omap_dm_timer *timer);
> +
> +       int     (*get_irq)(struct omap_dm_timer *timer);
> +       int     (*set_int_enable)(struct omap_dm_timer *timer,
> +                                 unsigned int value);
> +       int     (*set_int_disable)(struct omap_dm_timer *timer, u32 mask);
> +
> +       struct clk *(*get_fclk)(struct omap_dm_timer *timer);
> +
> +       int     (*start)(struct omap_dm_timer *timer);
> +       int     (*stop)(struct omap_dm_timer *timer);
> +       int     (*set_source)(struct omap_dm_timer *timer, int source);
> +
> +       int     (*set_load)(struct omap_dm_timer *timer, int autoreload,
> +                           unsigned int value);
> +       int     (*set_match)(struct omap_dm_timer *timer, int enable,
> +                            unsigned int match);
> +       int     (*set_pwm)(struct omap_dm_timer *timer, int def_on,
> +                          int toggle, int trigger);
> +       int     (*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
> +
> +       unsigned int (*read_counter)(struct omap_dm_timer *timer);
> +       int     (*write_counter)(struct omap_dm_timer *timer,
> +                                unsigned int value);
> +       unsigned int (*read_status)(struct omap_dm_timer *timer);
> +       int     (*write_status)(struct omap_dm_timer *timer,
> +                               unsigned int value);
> +};
> +
>   struct dmtimer_platform_data {
>           /* set_timer_src - Only used for OMAP1 devices */
>           int (*set_timer_src)(struct platform_device *pdev, int source);
Have you looked into collapsing this into the set_source() option above
for OMAP1? Looks like the only reason the pdev is needed is for
retrieving the pdev id, which is also stored in the omap_dm_timer structure?

>           u32 timer_capability;
>           u32 timer_errata;
>           int (*get_context_loss_count)(struct device *);
> +       struct omap_dm_timer_ops *timer_ops;

Any reason why this is not a const? We don't expect this to change right.

regards
Suman

>   };
> 
>   #endif /* __PLATFORM_DATA_DMTIMER_OMAP_H__ */
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
