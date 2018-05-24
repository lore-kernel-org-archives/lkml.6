Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965126AbeEXH7Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:59:16 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:9531 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935508AbeEXH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:59:13 -0400
Subject: Re: omapdrm regression in v4.17-rc series
To: Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
CC: <ivo.g.dimitrov.75@gmail.com>, <abcloriens@gmail.com>,
        <sre@kernel.org>, <martijn@brixit.nl>, <filip.matijevic.pz@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>, <clayton@craftyguy.net>,
        <patrikbachan@gmail.com>, <serge@hallyn.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20180523220320.GX98604@atomide.com>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <2f803bfc-3ffe-332a-7b9a-d59a39db4630@ti.com>
Date: Thu, 24 May 2018 10:58:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523220320.GX98604@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/18 01:03, Tony Lindgren wrote:
> Hi all,
> 
> I bisected the n900 LCD issue to commit 24aac6011f70 ("drm: omapdrm:
> sdi: Allocate the sdi private data structure dynamically"). Reverting
> this patch makes LCD work for me again on n900.
> 
> Any ideas?

This should help to get the SDI enabled.

 Tomi

>From 4e96e6c2dedf366e081331c3825ff6fa8aabd85c Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 May 2018 10:53:24 +0300
Subject: [PATCH] drm/omap: fix NULL deref crash with SDI displays

Fix a NULL deref bug introduced in commit 24aac6011f70 ("drm: omapdrm:
sdi: Allocate the sdi private data structure dynamically").

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/dss/sdi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/sdi.c b/drivers/gpu/drm/omapdrm/dss/sdi.c
index 68a40ae26f5b..1e2c931f6acf 100644
--- a/drivers/gpu/drm/omapdrm/dss/sdi.c
+++ b/drivers/gpu/drm/omapdrm/dss/sdi.c
@@ -82,7 +82,7 @@ static int sdi_calc_clock_div(struct sdi_device *sdi, unsigned long pclk,
 			      struct dispc_clock_info *dispc_cinfo)
 {
 	int i;
-	struct sdi_clk_calc_ctx ctx = { .sdi = sdi };
+	struct sdi_clk_calc_ctx ctx;
 
 	/*
 	 * DSS fclk gives us very few possibilities, so finding a good pixel
@@ -95,6 +95,9 @@ static int sdi_calc_clock_div(struct sdi_device *sdi, unsigned long pclk,
 		bool ok;
 
 		memset(&ctx, 0, sizeof(ctx));
+
+		ctx.sdi = sdi;
+
 		if (pclk > 1000 * i * i * i)
 			ctx.pck_min = max(pclk - 1000 * i * i * i, 0lu);
 		else

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
