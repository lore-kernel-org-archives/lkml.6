Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEDDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F411F208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE42TFpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F411F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeKTC6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbeKTC6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584B12086A;
        Mon, 19 Nov 2018 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645283;
        bh=/c1Hk+oWdNJuifLRlgWmy6XC9pnW7Xe9Y2gQWYtwXSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BE42TFpLs5QxCyetC4jQI7CKKpeQbizLL3fN9O8p85A7x/eB5+r5c6xezLjEFFuXj
         sFdZVFBebnlCzMeGbW6PAA8KNB+BBR2bW489svr6uVd/UqhTH37bu54N/DF3zH1pbv
         vYALM7Ke0siPjinM/dedz+kc38v7WF4s1GD2PQZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 4.19 068/205] drm/msm: fix OF child-node lookup
Date:   Mon, 19 Nov 2018 17:26:15 +0100
Message-Id: <20181119162629.210195640@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit f9a7082327e26f54067a49cac2316d31e0cc8ba7 upstream.

Use the new of_get_compatible_child() helper to lookup the legacy
pwrlevels child node instead of using of_find_compatible_node(), which
searches the entire tree from a given start node and thus can return an
unrelated (i.e.  non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the probed device's node).

While at it, also fix the related child-node reference leak.

Fixes: e2af8b6b0ca1 ("drm/msm: gpu: Use OPP tables if we can")
Cc: stable <stable@vger.kernel.org>     # 4.12
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index da1363a0c54d..93d70f4a2154 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -633,8 +633,7 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
 	struct device_node *child, *node;
 	int ret;
 
-	node = of_find_compatible_node(dev->of_node, NULL,
-		"qcom,gpu-pwrlevels");
+	node = of_get_compatible_child(dev->of_node, "qcom,gpu-pwrlevels");
 	if (!node) {
 		dev_err(dev, "Could not find the GPU powerlevels\n");
 		return -ENXIO;
@@ -655,6 +654,8 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
 			dev_pm_opp_add(dev, val, 0);
 	}
 
+	of_node_put(node);
+
 	return 0;
 }
 


