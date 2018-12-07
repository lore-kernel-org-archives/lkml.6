Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B40C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D391208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544185995;
	bh=rprg9VF6caVbpA9wA+loz0y98Nx80aJHJOXrLXyjSgo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GpNp0CrETzyrX/LQmSCco7FktRtn5+LCwqUyG6AzagQMbNMXOCb/UMZoNCQ/Y07OB
	 HuniVVcDQ2R6tjGhL8nppN5qTnbKwTFNWM2DX9uBdTq/c1apC/4kKQcHDhoLu3wzps
	 eMvR+yu+WzBlfz9WCUwuAlKji/jzb3QBNGjbZek8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D391208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeLGMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:33:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeLGMdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:33:09 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0114020989;
        Fri,  7 Dec 2018 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544185988;
        bh=rprg9VF6caVbpA9wA+loz0y98Nx80aJHJOXrLXyjSgo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zCfTfPhfXUAVHI9amQUQABb4GQQF+Gxw7tlrdUbhn7UsM93P+isYncqbsTwJSucU5
         fCOvINRn8yuj25Cp23aF3hguSMfMFWq1b7t7EW9Rbts5Pho1O9ws/SMllvEoPTn7RP
         yVJaFb8azEhGT9pZfT3xsSMqiiFtpEOq66AXfH74=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: leds: Add pattern initialization from Device Tree
Date:   Fri,  7 Dec 2018 13:32:53 +0100
Message-Id: <1544185974-5932-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544185974-5932-1-git-send-email-krzk@kernel.org>
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new linux,trigger-pattern property for initialization of LED
pattern trigger.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/leds/common.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index aa1399814a2a..4c65e854bb91 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -37,6 +37,13 @@ Optional properties for child nodes:
      "ide-disk" - LED indicates IDE disk activity (deprecated),
                   in new implementations use "disk-activity"
      "timer" - LED flashes at a fixed, configurable rate
+     "pattern" - LED alters the brightness for the specified duration with one
+                 software timer (see
+                 Documentation/ABI/testing/sysfs-class-led-trigger-pattern)
+
+- linux,trigger-pattern : Default pattern for "pattern" trigger (see
+                          Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+                          for description of format)
 
 - led-max-microamp : Maximum LED supply current in microamperes. This property
                      can be made mandatory for the board configurations
-- 
2.7.4

