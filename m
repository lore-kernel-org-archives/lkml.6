Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F24C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E988220850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039636;
	bh=j6nZF7n14aO5wiWp/oIpHGLhH+Uf00EdS1GaCHkeSao=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u5S2rOi+5qe+fJafMkLxk8vcxMko3c+dFiOCq2W/rEV7fMygUwESUIyecdoxRuI19
	 jvFcPdZGARD8Wloq+CtrXycYk4l9wYPK4tcLxFV7ARLHxzMloSPbmfu16Z3vF8+qYd
	 R4o19EX8hop38ol5XxHGfEr5nxBeqeExTU7jcaq4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E988220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeLETxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:53:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42032 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbeLETu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so18622887oiw.9;
        Wed, 05 Dec 2018 11:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wG9qhB3dKY9ge4bEEexb0MA1jfbsoKKi49Qcs8wQXFc=;
        b=Mi7L8eYSyANNW7luTIrLelv02nLyDrDNQ1rYYU4xWWtztW7V3R0zlD5DqW7HB6b9j9
         E1+mCtjXzOLxksK40fEgOIf52OAKuyk4/U/ch6S8Jlo9RlbDGO92E7/hPCwjOgq3RRox
         WWs4vCLGO0UuBocD8a5kTVWDg8vVARmLcSP1Q0XVQ7s4wHeEblN69Y2wUnI3xZ5Jg+VB
         M5Mpwlq994mi+RGtGh/iENQ4MJpR3qiEBIXcXcwUOhYcc3+PHEV+tyQYTjLPo7KmMRl0
         X2YiaJYLO7FCUqVl6H5v2BrmJrBTPfFPdnSXEubBqJWCHHyc8G7hYHreUIzEWZzgYU4+
         j9Uw==
X-Gm-Message-State: AA+aEWYBGWitD/mtJHCG/QegLaTrg1nx7E94AT6I1MlZFrWfYWnQUZUi
        qv3rbUY5r1KFUPxqxGzJpEosDrI=
X-Google-Smtp-Source: AFSGD/W8hg/Zs71toStVhWNB/EEOfXSP2N1MO4wk6f2hy+Zf2xQN4ZLTx7JTFLtMJ2jI0HRZ60TGYA==
X-Received: by 2002:aca:db85:: with SMTP id s127mr15028991oig.165.1544039458748;
        Wed, 05 Dec 2018 11:50:58 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:50:58 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: imx: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:23 -0600
Message-Id: <20181205195050.4759-7-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which this is.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 0e6942f21a4e..99ec6e5f89dc 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -198,7 +198,7 @@ static int compare_of(struct device *dev, void *data)
 	}
 
 	/* Special case for LDB, one device for two channels */
-	if (of_node_cmp(np->name, "lvds-channel") == 0) {
+	if (of_node_name_eq(np, "lvds-channel")) {
 		np = of_get_parent(np);
 		of_node_put(np);
 	}
-- 
2.19.1

