Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3824D8A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED3824D8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936066AbeF1Un6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:43:58 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36778 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbeF1Unz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:43:55 -0400
Received: by mail-yw0-f196.google.com with SMTP id t198-v6so2638621ywc.3;
        Thu, 28 Jun 2018 13:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7/gCfwC9TpQBpbvN/SumEqY62ZoUZbnVSDG91crI5Zs=;
        b=HXG5ucJyxAD1h0dXEd8Q/IbGJOCMwtKGakMJlMPokzOd1MqT6f75iyTbpaE2MrTeS0
         UCLOgRFP5GeWOtE9E/PLCw04h/t8M6UnNYXwKBOdh01Qf6knvy0q6P0fCm/M9epBMpb5
         dAvyHMPYm04NGznH3ZsqSSWkAj6SAJtDCbo6bKI4MyGW7ys3xe4uoWadXH5yvXlZrR+W
         fUzX1UdDWxCd1ejc9IzvYyPW2JGY3OlUalwbsVMjkD35wbfbmVufzqAAlqUb1qyjzD4X
         2ELsOOCyqNKVEnf96L1/IjWZ43Ox4evJ82Ah9p4XR9he51Qdk3cojWpZLNKpYqWXNCQy
         eRxg==
X-Gm-Message-State: APt69E04LmyUh3RXopeIZoxVwwUs+bxocIr6U+fJbndlTvK9qHdepxia
        7XN16DUWLsY4fvLP4kXBBQ==
X-Google-Smtp-Source: AAOMgpdaOT09N9JmNLBB3Vn4UbU/Jpvxmv+bYpHeSpUSzNTvBQTnW2ufRTg3SwPX1FGZK9SN5qonTQ==
X-Received: by 2002:a81:6846:: with SMTP id d67-v6mr5994393ywc.386.1530218634460;
        Thu, 28 Jun 2018 13:43:54 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm427913ywi.32.2018.06.28.13.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 13:43:53 -0700 (PDT)
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
Subject: [PATCH v3 3/6] pinctrl: Support stopping deferred probe after initcalls
Date:   Thu, 28 Jun 2018 14:43:41 -0600
Message-Id: <20180628204344.13973-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628204344.13973-1-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinctrl drivers are a common dependency which can prevent a system
booting even if the default or bootloader configured settings can work.
If a pinctrl node in DT indicates that the default pin setup can be used
with the 'pinctrl-use-default' property, then only defer probe until
initcalls are done. If the deferred probe timeout is enabled or loadable
modules are disabled, then we'll stop deferring probe regardless of the
DT property. This gives platforms the option to work without their
pinctrl driver being enabled.

Dropped the pinctrl specific deferring probe message as the driver core
can print deferred probe related messages if needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Drop pinctrl deferred probe msg in favor of driver core messages
- Move the handling of "pinctrl-use-default" option out of driver core
- Stop deferring probe if modules are not enabled.

Linus, I reworked this a bit, so didn't add your ack.

 drivers/pinctrl/devicetree.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index c4aa411f5935..2969ff3162c3 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -111,17 +111,24 @@ static int dt_to_map_one_config(struct pinctrl *p,
 	int ret;
 	struct pinctrl_map *map;
 	unsigned num_maps;
+	bool allow_default = false;

 	/* Find the pin controller containing np_config */
 	np_pctldev = of_node_get(np_config);
 	for (;;) {
+		if (!allow_default)
+			allow_default = of_property_read_bool(np_pctldev,
+							      "pinctrl-use-default");
+
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
-			dev_info(p->dev, "could not find pctldev for node %pOF, deferring probe\n",
-				np_config);
 			of_node_put(np_pctldev);
-			/* OK let's just assume this will appear later then */
-			return -EPROBE_DEFER;
+			ret = driver_deferred_probe_check_state(p->dev);
+			/* keep deferring if modules are enabled unless we've timed out */
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret == -ENODEV)
+				ret = -EPROBE_DEFER;
+
+			return ret;
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
--
2.17.1
