Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D124C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFEF2571B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFEF2571B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966172AbeF1Uo4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:44:56 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38604 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754803AbeF1Unw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:43:52 -0400
Received: by mail-yw0-f194.google.com with SMTP id w13-v6so2637605ywa.5;
        Thu, 28 Jun 2018 13:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03fLRQWBWjrnrq//f5qAO73beSpbPCDyJ89HOkL1LXw=;
        b=WhYEVbBVh3tT3kVArB86yGL0uhOhYNqwNJSnVvog0dwTIae1gsDBZGrEBwrv3B/SHb
         tPRMoH2OuYBwN9r50GwEP6EOs077Dqgs5sBUt/KTQpjU8ZrVfPIdHXToZoX8e4Kqfm7s
         eUEeUwWQXFDcrt2dFw52gf5Df+agF7aiCoPb4tKWj2DYueomdR4KuwOaS8E7K3EACm7y
         rGc/G5cGIGxS/mR6OKE96MaBc0mfHGutV2v8bT3uzutpSR8X8wwnQJdhfJfZ6gortV8J
         ws5GDSTGAwSaA3aESf7GeBC4q94AM9BDpMm9RqQ0NWUBiTkimm2HDrMqRGbIqbth9dBU
         qt+A==
X-Gm-Message-State: APt69E2k2wc4//OeYvKpjpidgO8BMuNb3yV7Nqv6FOv/5j4xpw6wAquc
        nagUedqWPQHvdkgH4AuoTw==
X-Google-Smtp-Source: AAOMgpfn0zgZj1ATNtUYfYACGnKmLV4RgkpotXeiGc0jfPhArI21UiJZjMMliNSoKQPy81weH9KELQ==
X-Received: by 2002:a0d:d981:: with SMTP id b123-v6mr1317270ywe.64.1530218632091;
        Thu, 28 Jun 2018 13:43:52 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm427913ywi.32.2018.06.28.13.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 13:43:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/6] dt-bindings: pinctrl: add a 'pinctrl-use-default' property
Date:   Thu, 28 Jun 2018 14:43:40 -0600
Message-Id: <20180628204344.13973-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628204344.13973-1-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
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

