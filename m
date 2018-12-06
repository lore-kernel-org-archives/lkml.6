Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FC120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108253;
	bh=35BBglVNfpXJdHeX8B6vaid10ISk9wpWbUyouqoSJiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oIcn1VnSOi5nTktIXbJqTdhU1g+sLXPjKT44sAAfkcgghoTgtwPfc9PaE3yuApe8K
	 APFwSUdSV1h5UECQJi09q39QyR0xGlwzvn2CSbvHwMGDv0dGuPs09guSqyGOPYILOY
	 sbKodWK611oZJ8u3miEaxhezrI8vcXzjWTGVfUe8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FC120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeLFOmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730512AbeLFOmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F019F20661;
        Thu,  6 Dec 2018 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107358;
        bh=35BBglVNfpXJdHeX8B6vaid10ISk9wpWbUyouqoSJiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfhWyev2MaSO0Q3y2LspkGrB/IarQs7oQhquYBUTUqqnSxIf4yp1QNOYgJE0eLVo4
         dc9s9ZXONCp0Guqa6aVYW+tjO3c6ugf5WlcoKoTbXVrHlTBsbSodd0BY1uiMFiNICu
         TVRNRBlfWlGMFAW2TtPg3uKQJGypbsifSFijFqqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 4.14 32/55] drm/msm: fix OF child-node lookup
Date:   Thu,  6 Dec 2018 15:39:06 +0100
Message-Id: <20181206143003.451824388@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
[ johan: backport to 4.14 ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/adreno/adreno_device.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -223,8 +223,7 @@ static int adreno_get_legacy_pwrlevels(s
 	struct device_node *child, *node;
 	int ret;
 
-	node = of_find_compatible_node(dev->of_node, NULL,
-		"qcom,gpu-pwrlevels");
+	node = of_get_compatible_child(dev->of_node, "qcom,gpu-pwrlevels");
 	if (!node) {
 		dev_err(dev, "Could not find the GPU powerlevels\n");
 		return -ENXIO;
@@ -245,6 +244,8 @@ static int adreno_get_legacy_pwrlevels(s
 			dev_pm_opp_add(dev, val, 0);
 	}
 
+	of_node_put(node);
+
 	return 0;
 }
 


