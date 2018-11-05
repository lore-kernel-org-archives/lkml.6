Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0ABC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF4820866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T8eSztBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF4820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeKFFB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:01:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33403 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeKFFB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:01:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id w22-v6so1622116plk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXYamjpF54xPI4xprjmDSNKifg3b2CSoDvPVO1+NKHw=;
        b=T8eSztBh3tK92GEomtjwPwnFqQIo8ELCfddp4DE7oOc8pqedXR61DAlPlHPBDtEeoq
         PsRBbgLBs7J8bL9q0N/qoYseN4XGSPUvHloxF7vZvGavxGszbFokcRZGy8/5BZ/Qd59z
         vTzTb6Sn/Q8vKWxtMVh0fFGhwsQmT9WqzaR8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXYamjpF54xPI4xprjmDSNKifg3b2CSoDvPVO1+NKHw=;
        b=WnidvZc5/o7ne9sKjcbSRXdOoD5tHD26iRTlY57h+UbZWi7Zqi6WxBrM80iTnELsla
         7aKUbnBFTiYrWgT7wKtCKYa18ZbUsjaeloHh2fHMZi4a4EMmig0gD/gAWl8TJxthNXgL
         JWfXjjDhfO8Nf35FwpQvnk5/3ZJfStLUiRG4mnFeDBai20Y+1w5xMTVR3pfRvy9QODwf
         PpA1+5nODF5T9d6xNxWiyQ6l+DpldinIQOVYsiyKxyOC9EsLh4v2puxB5NRGsp5WmHYW
         6TD1/bvRXvh/UNuSVrz1yeblW99iKoGLXem+xG5SUbkpxsI4e6xHKR4GzTsPixYCwhAB
         P/Bw==
X-Gm-Message-State: AGRZ1gKQlV9xsGn1QSH4nq/BvuAB5ILO5Yr9WpuPA1JY6S8CT1lHFNZG
        TKPG5RoancHuM4NumRiuGlJEqA==
X-Google-Smtp-Source: AJdET5cj0j7v5OtsgSRptBWwCiht9C8Arc1XOuMdP3efF4vqzYCkYl8YpJN7P1QU4wqYF82gcjZaAg==
X-Received: by 2002:a17:902:4083:: with SMTP id c3-v6mr23548669pld.181.1541446815360;
        Mon, 05 Nov 2018 11:40:15 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id q25sm700728pgb.2.2018.11.05.11.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:40:14 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: clk: Introduce 'protected-clocks' property
Date:   Mon,  5 Nov 2018 11:40:10 -0800
Message-Id: <20181105194011.43770-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181105194011.43770-1-swboyd@chromium.org>
References: <20181105194011.43770-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic clk property for clks which are not intended to be used by
the OS due to security restrictions put in place by firmware. For
example, on some Qualcomm firmwares reading or writing certain clk
registers causes the entire system to reboot, but on other firmwares
reading and writing those same registers is required to make devices
like QSPI work. Rather than adding one-off properties each time a new
set of clks appears to be protected, let's add a generic clk property to
describe any set of clks that shouldn't be touched by the OS. This way
we never need to register the clks or use them in certain firmware
configurations.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../devicetree/bindings/clock/clock-bindings.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index 2ec489eebe72..b646bbcf7f92 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -168,3 +168,19 @@ a shared clock is forbidden.
 
 Configuration of common clocks, which affect multiple consumer devices can
 be similarly specified in the clock provider node.
+
+==Protected clocks==
+
+Some platforms or firmwares may not fully expose all the clocks to the OS, such
+as in situations where those clks are used by drivers running in ARM secure
+execution levels. Such a configuration can be specified in device tree with the
+protected-clocks property in the form of a clock specifier list. This property should
+only be specified in the node that is providing the clocks being protected:
+
+   clock-controller@a000f000 {
+        compatible = "vendor,clk95;
+        reg = <0xa000f000 0x1000>
+        #clocks-cells = <1>;
+        ...
+        protected-clocks = <UART3_CLK>, <SPI5_CLK>;
+   };
-- 
Sent by a computer through tubes

