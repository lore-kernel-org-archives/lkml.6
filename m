Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02446C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB3120893
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 19:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB3120893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeHZXD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 19:03:28 -0400
Received: from gateway30.websitewelcome.com ([192.185.152.11]:47927 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbeHZXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 19:03:28 -0400
X-Greylist: delayed 1973 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Aug 2018 19:03:28 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id BFB7234E4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 13:47:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id u049fLXV9BcCXu049fqQgy; Sun, 26 Aug 2018 13:47:13 -0500
X-Authority-Reason: nr=8
Received: from [189.250.132.202] (port=46808 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fu048-003zfG-Vs; Sun, 26 Aug 2018 13:47:13 -0500
Date:   Sun, 26 Aug 2018 13:47:12 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/rockchip: Use struct_size() in devm_kzalloc()
Message-ID: <20180826184712.GA9330@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.132.202
X-Source-L: No
X-Exim-ID: 1fu048-003zfG-Vs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.132.202]:46808
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
	int stuff;
        void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

or, like in this particular case:

size = sizeof(struct foo) + sizeof(void *) * count;
instance = devm_kzalloc(dev, size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count),
GFP_KERNEL);

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1359e5c..cf64e4d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -32,6 +32,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
+#include <linux/overflow.h>
 
 #include <linux/reset.h>
 #include <linux/delay.h>
@@ -1561,7 +1562,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm_dev = data;
 	struct vop *vop;
 	struct resource *res;
-	size_t alloc_size;
 	int ret, irq;
 
 	vop_data = of_device_get_match_data(dev);
@@ -1569,8 +1569,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		return -ENODEV;
 
 	/* Allocate vop struct and its vop_win array */
-	alloc_size = sizeof(*vop) + sizeof(*vop->win) * vop_data->win_size;
-	vop = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
+	vop = devm_kzalloc(dev, struct_size(vop, win, vop_data->win_size),
+			   GFP_KERNEL);
 	if (!vop)
 		return -ENOMEM;
 
-- 
2.7.4

