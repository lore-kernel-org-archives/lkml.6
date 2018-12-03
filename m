Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A96C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FED214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PrRwAGZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FED214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLCKIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:08:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40594 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeLCKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:08:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so11445926wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQOdFC9CjkWwFX8rp28xoDvtflvd5veREOu6vb3xEl4=;
        b=PrRwAGZpg1WSrlH+nDKOti9QiT/ISdGKiiT4vfkKVsyTZVwnWnbKZPr7Obm0IpQlCa
         XabiZsDcWjoAP54MnwGasjqYwpsrdMVThmbNZ97Rz+2QOjIvgzfl8XrfbrchG6syivEf
         EPRkfutL2oPKkSfwvSzTDm2cbN7sz82/gGum8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQOdFC9CjkWwFX8rp28xoDvtflvd5veREOu6vb3xEl4=;
        b=CThMoDebvrJ9W5gqJlvS6UV6lc8jWP4aGTCospx7fD3eDzJaIg+6fkA/ZKG/Lvu7zp
         GuVD2Mhpqg9VuUeaKTUSKeR/P3lfAgOsHLuO9Wh1rqMLTC0C/ETD9dn9DxtebfXT9InU
         j1zVIiGJuokGz/jztApxfQEKtHpePR/p/GzCgydnrf2ywtRBeSxmvhhXsRT0sEoEnLPk
         QO8uGqhn+NS3yyF9xoPvJTDD5n28oG3JTaHhtTpMYfdFtXvWVHZJXUgRU0FL64XH/DmB
         yhRery7x7hhQ89cjwBHal2FwprJEm12+Pod6dXh0w6HQXiXkgZ5Oa3R90RPxcYurY3WJ
         HVIA==
X-Gm-Message-State: AA+aEWYI/gQsJocqwlUO0/gbbzQTXM87s+G8IiUCsvholH7yICTsEU7z
        dG6Hnl57UpJ8lT4tjnr4ieIi/A==
X-Google-Smtp-Source: AFSGD/VPp+6EJ1yRntChb1CpYmwMyPbxm1MNxORzNUzpMr2buG2vPfa1uRSYwFnePbVCUHlq6tSumg==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr12686122wrs.86.1543831676559;
        Mon, 03 Dec 2018 02:07:56 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:07:55 -0800 (PST)
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
Subject: [PATCH 1/5] dt-bindings: media: sun6i: Add A64 CSI compatible (w/ H3 fallback)
Date:   Mon,  3 Dec 2018 15:37:43 +0530
Message-Id: <20181203100747.16442-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3.

Add a compatible string for it with H3 fallback compatible string,
in this case the H3 driver can be used.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..e78cf4f9bc8c 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -7,6 +7,7 @@ Required properties:
   - compatible: value must be one of:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
+    * "allwinner,sun50i-a64-csi", "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
-- 
2.18.0.321.gffc6fa0e3

