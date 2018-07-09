Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7AEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317FC2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317FC2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbeGIPnm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:43:42 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43123 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932867AbeGIPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:42:02 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so36666070oib.10;
        Mon, 09 Jul 2018 08:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03fLRQWBWjrnrq//f5qAO73beSpbPCDyJ89HOkL1LXw=;
        b=Q2HH4gHxmP6vM/m8GZ2qSBKvuT1fv/R52qU0B/MCuGEyZ8VDeuR7JHAxNk/MA6hQ2H
         Lif0yEDQD1nL4VJ5+htjr9kYzVib1Gghzs9tf+6wZ6l++xofj7FWEDCcYNIqP/Hp7ooz
         7HpUYdNOUxiwubERYaK+EJ2VPfRZ5BJY7BOZva4bgW1jNbUTtrXUDLdNE31g/Y/iLbEs
         dv7n5Hj/fZX064cDR38AgkmMSAhd0FxBbD4lQCMTscOC7L3OqbmtjC8jKx3EcKcTVOrQ
         pRTIA8IGVa8ylXl+KW0bpL7JdtzCAyGdabUWH2wQ7zofJiODsSjOK+0M2EPXCrqFqiZZ
         KtOQ==
X-Gm-Message-State: APt69E3KIXmAkfm+tIfUfJnDLRQssduQYjjP9vNQ+XZ/oNfLChzv6oDO
        gc84u6YodPXijRhUUwbzyQ==
X-Google-Smtp-Source: AAOMgpeUE33/sCrpWJFxntA3qcfXLbA4kljyhyv+IzhJAWRZVkSGqCplNupuUWsyuqz/3P0jlYAX9g==
X-Received: by 2002:aca:665b:: with SMTP id a88-v6mr24312433oic.101.1531150922149;
        Mon, 09 Jul 2018 08:42:02 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id z196-v6sm30759391oig.12.2018.07.09.08.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:42:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/6] dt-bindings: pinctrl: add a 'pinctrl-use-default' property
Date:   Mon,  9 Jul 2018 09:41:49 -0600
Message-Id: <20180709154153.15742-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709154153.15742-1-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin setup may be optional in some cases such as the reset default works
or the pin setup is done by the bootloader. In these cases, it is optional
for the OS to support managing the pin controller and pin setup. In order
to support this scenario, add a property 'pinctrl-use-default' to indicate
that the pin configuration is optional.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-bindings.txt        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index ad9bbbba36e9..cef2b5855d60 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -103,6 +103,12 @@ Optional properties:
 #pinctrl-cells:	Number of pin control cells in addition to the index within the
 		pin controller device instance
 
+pinctrl-use-default: Boolean. Indicates that the OS can use the boot default
+		pin configuration. This allows using an OS that does not have a
+		driver for the pin controller. This property can be set either
+		globally for the pin controller or in child nodes for individual
+		pin group control.
+
 Pin controller devices should contain the pin configuration nodes that client
 devices reference.
 
-- 
2.17.1

