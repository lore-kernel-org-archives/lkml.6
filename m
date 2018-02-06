Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbeBFVYk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:24:40 -0500
Received: from mout.web.de ([212.227.15.3]:45475 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754053AbeBFVYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:24:38 -0500
Subject: [PATCH 2/2] drm/tilcdc: panel: Use common error handling code in
 of_get_panel_info()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <a7c7cebb-f4c9-04b7-5507-e41f8ebfb5f9@users.sourceforge.net>
Message-ID: <23b2cf6c-7b69-9ade-d97a-18af0c6eb73f@users.sourceforge.net>
Date: Tue, 6 Feb 2018 22:24:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a7c7cebb-f4c9-04b7-5507-e41f8ebfb5f9@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hROBHCJc7ytEzg20lpTU/QHETK/yEQxUE+C2pPVE7V94bGzOQsb
 GMo/7+ZvCypiZQ16AWaASCx+G9dYsEIOELy+s5trSupgeawrIKgLoIWUmD61qv0DEjnnBwa
 k7szwZOXdxkpv9ao7zG22RZVXOBIlTw3X08SeO4V3XG3m4HY1NSM16Xo1KHtdmLX6ECB2Qc
 hsVtCm8Wr7NFtaj+e2tjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bd8Oita7dVU=:XIfx3qUcOIjwtTPRs6E9rG
 zWBvRCPS68JNsxZdIG5J60FhaJaXtFPF4gZj1GeoPykFWnrxdbXVlw2yP7EAZd20l/RLBgtp3
 7nvIMaX+/XcYFqrsSYcGtTjR20SoterhcJe0NLMorqTVDhO3mJl+xCbubULgiySnnlsaSgEPR
 VBnYkO6d/I8lDhlTcJ8S6WRopL2XZ18gdm/nnIypozZgHzvWbunl3y1MfvXr64Tb444LRoxEG
 5IyEIBPqzNpdhdM8MzKeMB9M2xIDmikgpOrkNKHgtkrTMvSzLb4k0+PfL7/i2pC3rvoGorbFz
 7Unsf71lD934v4Onlgtttjy929Z2Aw0itlojy2LiPNOkbkvBJEeIavRjcMrN3FvBBBOHZfXis
 5tuPc4s8kfU/ka8NIdUXxfKxTKHrIYyqjCLHIyfdosRgnjazW+VXsV5+B/3aaLj8mCGWShSs7
 KlMm2UiHzSGueG4LnVyaUPx/O1bsENUUk7YIQm/4NKMmX1TzEOrYpFiIc2zh/7dKwGJVRHqS4
 8GkpGeWmVwtSChVITKrHCOOCgwgnhkSK9lD7RGwQvonj5Z+k189aKbt8LODkDT8CUY9+HKx46
 Z/zlTw9E7MaIBrCH90PvJTNcnFNnO8/ExbXz32I3UbHs9fNCrVfK+CB31QTzMUu3/AWb3qyPG
 08jnNMhoY6jKBberVJbO9kwA/giEjGSfR9Rs77gJMFkxNNval+AhLhzovOOyiYUxoBeMhYpil
 lG2i2D36n3WULio4EnbhsCw0HynZ3VXGwm2HzSAMA+XLyWZAKPZoH6fmX9OsiOo6hGnWX7t61
 dBXRTpiBOy/yP4KB+Y9NndJML7yyiqgKNhFi3ppLrEjqPPZzqs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 22:10:11 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 0b6aa95aec89..cf9ca16fee81 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -289,10 +289,8 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
 	}
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		of_node_put(info_np);
-		return NULL;
-	}
+	if (!info)
+		goto put_node;
 
 	ret |= of_property_read_u32(info_np, "ac-bias", &info->ac_bias);
 	ret |= of_property_read_u32(info_np, "ac-bias-intrpt", &info->ac_bias_intrpt);
@@ -311,11 +309,11 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
 	if (ret) {
 		pr_err("%s: error reading panel-info properties\n", __func__);
 		kfree(info);
-		of_node_put(info_np);
-		return NULL;
+		info = NULL;
 	}
-	of_node_put(info_np);
 
+put_node:
+	of_node_put(info_np);
 	return info;
 }
 
-- 
2.16.1
