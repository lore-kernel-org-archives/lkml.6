Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A5BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF37420645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WYp4dBnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF37420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLCKIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:08:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52153 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeLCKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:08:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so5105945wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZwHMdseiN89HEVSRgqoNt8QGqFQI8aSS6wIp4a9e3c=;
        b=WYp4dBnqnA6t8f4+3/r7Q81AkOf/D53JEKyfYAKWJED6IieqTZDwsiyXXmPKJHl1xZ
         /RjT7/ug/RPxhzKJPKHYNYqijoS9xqNrGjrvmsOWZH9G4OWsogzCYTTqJlJaQJNndrHy
         X2iaiTd7eBx3Cf+srP9C9KRZChXve5BWfRZUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZwHMdseiN89HEVSRgqoNt8QGqFQI8aSS6wIp4a9e3c=;
        b=dSR5WjTbQgUKKCzfhH3uFCt5aCBwxo8FDcWBDLi2TEX1EEIR+XbRPjSGOvYeByQWvF
         ElEhj8zpEl6KRbbhJtjGHMJKNthb257f7zge/FVc2NdKUhaP2Ul2AIrUV9X49+JjDBas
         Nsa8xw7iBUQg5+tjuBGXu4JU5SFpWysw5wwfHCJnP092KqKfi1DN1cloHNm2koN/grxH
         GDl6dHOQbG8lAQu2txFTvL13/YmoWQICPx9usblP7E803qs3WPM8s1lJzlkNHvrsOQ3D
         6GmDDjt/9PAhq0R5I13zdAQQrzF39wFqW7TFrD2Gwih7F7Z0+IxR6z+rxtEHFLUriG05
         gK8Q==
X-Gm-Message-State: AA+aEWZ9SOcxblQtFLaUI44ory0D+pYl+uGxMDwS+u2/pcDNEEEuGgtP
        Iq/jSKBr0y8Vfge8Ix9rzuas9w==
X-Google-Smtp-Source: AFSGD/XnbFNuiD20WI4SVXVx7wsH0dmxqBf/ID0DyAkKyFtb/MOGzGfmOYAWr2InYDDaGLbjQuGBFw==
X-Received: by 2002:a1c:307:: with SMTP id 7-v6mr7540895wmd.146.1543831677859;
        Mon, 03 Dec 2018 02:07:57 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:07:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/5] dt-bindings: media: sun6i: Add vcc-csi supply property
Date:   Mon,  3 Dec 2018 15:37:44 +0530
Message-Id: <20181203100747.16442-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner A64 CSI controllers are supply with
VCC-PE pin. which need to supply for some of the boards to
trigger the power.

So, document the supply property as vcc-csi so-that the required
board can eable it via device tree.

Used vcc-csi instead of vcc-pe to have better naming convention
wrt other controller pin supplies.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index e78cf4f9bc8c..5fb6fd4e2c7d 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -18,6 +18,9 @@ Required properties:
   - clock-names: the clock names mentioned above
   - resets: phandles to the reset line driving the CSI
 
+Optional properties:
+  - vcc-csi-supply: the VCC-CSI power supply of the CSI PE group
+
 The CSI node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in
 Documentation/devicetree/bindings/media/video-interfaces.txt.
-- 
2.18.0.321.gffc6fa0e3

