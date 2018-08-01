Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7626DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204DC20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204DC20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbeHAUQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:16:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404232AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13B531127;
        Wed,  1 Aug 2018 17:07:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 262/336] drm/rockchip: analogix_dp: Do not call Analogix code before bind
Date:   Wed,  1 Aug 2018 18:49:57 +0200
Message-Id: <20180801165039.074313762@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Figa <tfiga@chromium.org>

[ Upstream commit a4169609def769c66f88140678970b2be6f64ac7 ]

Driver callbacks, such as system suspend or resume can be called any
time, specifically they can be called before the component bind
callback. Let's use dp->adp pointer as a safeguard and skip calling
Analogix entry points if it is an ERR_PTR().

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180423105003.9004-24-enric.balletbo@collabora.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -358,6 +358,8 @@ static void rockchip_dp_unbind(struct de
 	analogix_dp_unbind(dp->adp);
 	rockchip_drm_psr_unregister(&dp->encoder);
 	dp->encoder.funcs->destroy(&dp->encoder);
+
+	dp->adp = ERR_PTR(-ENODEV);
 }
 
 static const struct component_ops rockchip_dp_component_ops = {
@@ -381,6 +383,7 @@ static int rockchip_dp_probe(struct plat
 		return -ENOMEM;
 
 	dp->dev = dev;
+	dp->adp = ERR_PTR(-ENODEV);
 	dp->plat_data.panel = panel;
 
 	ret = rockchip_dp_of_probe(dp);
@@ -404,6 +407,9 @@ static int rockchip_dp_suspend(struct de
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
+	if (IS_ERR(dp->adp))
+		return 0;
+
 	return analogix_dp_suspend(dp->adp);
 }
 
@@ -411,6 +417,9 @@ static int rockchip_dp_resume(struct dev
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
+	if (IS_ERR(dp->adp))
+		return 0;
+
 	return analogix_dp_resume(dp->adp);
 }
 #endif


