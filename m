Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1C1206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="oHKwvqod";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R++EWDrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1C1206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbeKPI1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:27:51 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41287 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbeKPI1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:27:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1ABE5229F1;
        Thu, 15 Nov 2018 17:18:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=mQiY+XZCz9
        Ns7nNOXsOiTUkbneyFRMkgnJhmjJbz3HA=; b=oHKwvqod/YeJhDJv8ekzZwXIlI
        C3ABQeZI3G950c3B/7VyVjFZ/1Em78nfcBoYqfMeSArW6gqAz8TwQGOxtX2haPsZ
        n/ChKM3SjWuTqumHqwbpPF7dmxsFihuWMCQBzH5yGiLX/Mf4A1/HFq7AOl/baNoE
        E2LknX+COrlRmhl8g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mQiY+XZCz9Ns7nNOXsOiTUkbneyFRMkgnJhmjJbz3HA=; b=R++EWDrq
        kaqrf3GFzCdcJvwrrTX05xLlbc9msmBe9BBUP6O6sPYMIzG6WVH4B+fhtdXW9GrJ
        laMu23EOG1SH95GH4LMaH5iJbUgrN45vQeM/ItgwbFV7cKvLNYiacM+Oj+BIc7oX
        eH/efbqz6I3fM1Ir0c4CnluDuJm8iatXhGwWVcw/aUeMtbdDr3aoG6BE3ofkVfjQ
        hV3DmEe/OiWjQdpbB/hkTcanFkpRw1+MPfl0h7bVfgC3NrXZ9r2EJ4uvsrtk09nm
        TIjUMH8yyeNa/rQlzAOFmE6Y+xfUXu6wIW113JxVPgdtdLwQ124DVeraTik+Q7US
        LQdl6kxhWcOktw==
X-ME-Sender: <xms:n_DtW-z4VTDHGrx8pL8LXK9w6L1kWEpT3KkL7TZSdx89Jj4EaokqKQ>
X-ME-Proxy: <xmx:n_DtWyzid4ikdFl8oo_Sg4QZCMcg_vOXjl8rC0MqgLqEYrtwmcpt0g>
    <xmx:n_DtW8MdqaCZem-3OrBJfD_fhUMamQgZBZP8iDGhfpwKMFUizmzthg>
    <xmx:n_DtW75bScxiH0ZtlhgJbrRLcdjoB6RJFiM5iBOd2XSD6EZn6j2OQQ>
    <xmx:n_DtW1OvaNg2Scqm0fO8qlBioXnkgQu-4C7tjfg71gTy-9I_ZqcM7A>
    <xmx:n_DtWxnrL6gmMAb5NMC8OOxxehDVB9lNis8nXKtancp7HXoZfYZsFQ>
    <xmx:oPDtWwjOYA57H7qu1bXHfgDAYcyyrX0PKTBeUUnfXhL6sEmo8FDtCw>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 874DFE46B7;
        Thu, 15 Nov 2018 17:18:03 -0500 (EST)
From:   Fernando Ramos <greenfoo@gluegarage.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH 8/9] drm: remove no longer needed drm-get-put coccinelle script
Date:   Thu, 15 Nov 2018 23:16:28 +0100
Message-Id: <20181115221634.22715-9-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coccinelle script was used to rename some (deprecated) functions
which no longer exist now.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 scripts/coccinelle/api/drm-get-put.cocci | 78 ------------------------
 1 file changed, 78 deletions(-)
 delete mode 100644 scripts/coccinelle/api/drm-get-put.cocci

diff --git a/scripts/coccinelle/api/drm-get-put.cocci b/scripts/coccinelle/api/drm-get-put.cocci
deleted file mode 100644
index 3a09c97ad87d..000000000000
--- a/scripts/coccinelle/api/drm-get-put.cocci
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-///
-/// Use drm_*_get() and drm_*_put() helpers instead of drm_*_reference() and
-/// drm_*_unreference() helpers.
-///
-// Confidence: High
-// Copyright: (C) 2017 NVIDIA Corporation
-// Options: --no-includes --include-headers
-//
-
-virtual patch
-virtual report
-
-@depends on patch@
-expression object;
-@@
-
-(
-- drm_connector_reference(object)
-+ drm_connector_get(object)
-|
-- drm_connector_unreference(object)
-+ drm_connector_put(object)
-|
-- drm_framebuffer_reference(object)
-+ drm_framebuffer_get(object)
-|
-- drm_framebuffer_unreference(object)
-+ drm_framebuffer_put(object)
-|
-- drm_gem_object_reference(object)
-+ drm_gem_object_get(object)
-|
-- drm_gem_object_unreference(object)
-+ drm_gem_object_put(object)
-|
-- __drm_gem_object_unreference(object)
-+ __drm_gem_object_put(object)
-|
-- drm_gem_object_unreference_unlocked(object)
-+ drm_gem_object_put_unlocked(object)
-|
-- drm_dev_unref(object)
-+ drm_dev_put(object)
-)
-
-@r depends on report@
-expression object;
-position p;
-@@
-
-(
-drm_connector_unreference@p(object)
-|
-drm_connector_reference@p(object)
-|
-drm_framebuffer_unreference@p(object)
-|
-drm_framebuffer_reference@p(object)
-|
-drm_gem_object_unreference@p(object)
-|
-drm_gem_object_reference@p(object)
-|
-__drm_gem_object_unreference(object)
-|
-drm_gem_object_unreference_unlocked(object)
-|
-drm_dev_unref@p(object)
-)
-
-@script:python depends on report@
-object << r.object;
-p << r.p;
-@@
-
-msg="WARNING: use get/put helpers to reference and dereference %s" % (object)
-coccilib.report.print_report(p[0], msg)
-- 
2.19.1

