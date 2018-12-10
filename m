Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525DDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B33C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F3RJywn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B33C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeLJLxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:53:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43538 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeLJLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:53:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so10142296wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjNL4yM0W8Erfy6DaB3BWV2eQAISU0s+SMFRfUHR+Qo=;
        b=F3RJywn/KIIIpXUSKDmTVuWAYAHFJvM/gBnPnf0FttlxzYKVbe9EovYGLDiyulgUGz
         yXajFrlRKuy/NTVAjwDLysgHEGB9498C5usxNM7GGF7myAIWLuBwIbpm+HH1DCOHBSDo
         rQnVjtUjTo09bCl59QBAxAbaPWr+NeursZkHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjNL4yM0W8Erfy6DaB3BWV2eQAISU0s+SMFRfUHR+Qo=;
        b=oQVEeuAgJi8c/XixrDocoFWGntM7YfIPRu3iW2hIk10+jUt7JwW80owC7sc8z4sZ0i
         d6hoxaWQ8KzJKeJdtxDq/hbsyYOISht6sBAUBEo7zE+Jjx1BKzhXJmWPyX3im3wm1O0/
         ZowQ5xpJ64QnsK+Tu4fmhXM/p1zacq+d3SXE6xVgOZkeMZJPnaqljviSQBmgI05N9uad
         8fSboi1SWV3LzPyq2lTa/NW29x4aRl8EU9oRl24dHpx+cLs+hZoMCySbOP1zAGSUtS3E
         NNQ5U/LD5cjqnNFWX+odfsWbAy5yQZLxw6mQJUNa+DvqfATE7SebdMwu6FF69ZWKlTNJ
         zRHQ==
X-Gm-Message-State: AA+aEWad2ndB03DVlySx1GFJiJKSypo6EhKkCeFjx2bc6xg/xEvrUBlX
        TeSWqx6K7u8zG8DXYh2ELWZrOQ==
X-Google-Smtp-Source: AFSGD/UJfZHrJOS/Z96UvGeOwSEYmZLWTyIAlxZ/2QRMWB46KP/XmSNqIKJ83mVTVPBqhDUHuz3vvQ==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr9008517wrw.316.1544442810069;
        Mon, 10 Dec 2018 03:53:30 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:53:29 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/6] dt-bindings: media: sun6i: Add A64 CSI compatible
Date:   Mon, 10 Dec 2018 17:22:41 +0530
Message-Id: <20181210115246.8188-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3 but work by lowering clock than
default mod clock.

Add a compatible string for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..376aade669a1 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -7,6 +7,7 @@ Required properties:
   - compatible: value must be one of:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
+    * "allwinner,sun50i-a64-csi"
     * "allwinner,sun8i-v3s-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
-- 
2.18.0.321.gffc6fa0e3

