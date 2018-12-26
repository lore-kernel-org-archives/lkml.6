Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C62C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837C5217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cby0UWXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeLZHx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:53:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35444 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLZHx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:53:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so7581932pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65wyOZIPtU/IC4Syfk+lbRQmeNVJWPwsPd+fkuL1h20=;
        b=cby0UWXrUTigFeVvS5JRp2oa2mLSVZiEwwKv/AjLG2Lc7DNtL89FIqqvi5W1x3Kjr4
         exsN7EoGkDRljZV6kcGiSQn1JSX7clFKu2h5BlufKlz1NIm0/vIUc966lWk7Z9sHaVs4
         yLavbyg2rij2FZHQ6AIE6i43kpVa2yJZQUXYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65wyOZIPtU/IC4Syfk+lbRQmeNVJWPwsPd+fkuL1h20=;
        b=YAaN48tl85tvGm5ojp3Cwn2F/Ik5k4Rkuf60CJ4B6Aa0c9/GQZE88vz7ErFWkGLFis
         tFwOcPvoNjCTD3lvTn8v3Y4ZbUGHW0aWwCPWGAo++wzg7qzLjqoJg63ysCeA7KJqM3AZ
         MdIHTSHoihDGoZxOul/7poduxJoRIKN+mb9+m4Cu1kxLorwnBxZV3buw+FJX1by8sdBt
         NZB9WOsW8mLW0TynRdz0MVCffXSI3VH5pIQIKlEE78VZfY3GNmb7/Pm9w/74emI9GSgf
         kF0ytrp2y5v4wWQuL86+jMDeK5TzvefHRvH74tZ8AuGd9OmSdxBGI6A6zGhS/Ar0kBS0
         DuHA==
X-Gm-Message-State: AJcUukeAZ+xMsZTgCrYqI9Uiy78srivFweqNuJFeR/CfAAe5lMBYMe8t
        T6QcXMcHBH9EMj3aQZ6f9z4kXg==
X-Google-Smtp-Source: AFSGD/W8/ChF1oBPzNTLHIeaxxijBRcOH1+A7FnrYyaVwd+yBju+8AFmEtSD4GyYz1qrAnmcm06B2A==
X-Received: by 2002:a62:868b:: with SMTP id x133mr20195061pfd.252.1545810835005;
        Tue, 25 Dec 2018 23:53:55 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 84sm107392395pfa.115.2018.12.25.23.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 23:53:54 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [RFC,1/5] dt-bindings: Add a binding for Mediatek SCP
Date:   Wed, 26 Dec 2018 15:53:09 +0800
Message-Id: <20181226075330.82462-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181226075330.82462-1-pihsun@chromium.org>
References: <20181226075330.82462-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erin Lo <erin.lo@mediatek.com>

Add a DT binding documentation of SCP for the
MT8183 SoC from Mediatek.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 0000000000000..b07e5c4ca9af1
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,9 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
-- 
2.20.1.415.g653613c723-goog

