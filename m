Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BEBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE86208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE86208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933672AbeGIPmH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:42:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38170 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933650AbeGIPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:42:04 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so36733126oie.5;
        Mon, 09 Jul 2018 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGMIUtlDqT+EObEIlXTge4ecUvufNaOQ7TCKBj9GFsc=;
        b=IRvcRFe14+g7/HU2uW4Rp9WaFCF4FKKI8R8VNcfGxdbJi32YHQzBT19OXeJaPQTrwa
         BtLxttOHMFV7eiLiyvDNLJu9yY+kxYCuXb6THElOb25dRMO0MstKiNi9mI4/V/zMg5+V
         25e0Ifht9qC7Vhs+RmlnqPcQ7a1OboSgL4wV/TX+iXHWy64w3E5uHkktiy9J+9/vY3uL
         J3X2BoRO1mCFG4icvLjC1pdUQY1zcRjzINZeEpmqXLBh7YsqfFm54NwUovDZPc6tekKP
         7pIPTLUu41Ap89bzkCuvjToIPM+o//NXabF9LBUPpNWTdZGgqyaUin03JYLqpKj71fTO
         538g==
X-Gm-Message-State: APt69E2QSyqaMO1NCltd8huUHu6Nvh+Av3AQ39qnQyMc1lwjqDgtF+x9
        S0pEQo9eDY1LdojAUeS3Bg==
X-Google-Smtp-Source: AAOMgpeMpYlJEr6fbMXqH0xqDezptmdAVEdNJYuBl0SOx9aknrleTiYS2xmO0CFhjUd4P7xjDLokOA==
X-Received: by 2002:aca:f401:: with SMTP id s1-v6mr25350751oih.269.1531150924010;
        Mon, 09 Jul 2018 08:42:04 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id z196-v6sm30759391oig.12.2018.07.09.08.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:42:03 -0700 (PDT)
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
Subject: [PATCH v4 3/6] pinctrl: Support stopping deferred probe after initcalls
Date:   Mon,  9 Jul 2018 09:41:50 -0600
Message-Id: <20180709154153.15742-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709154153.15742-1-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
- Add Linus' R-by.

v3:
- Drop pinctrl deferred probe msg in favor of driver core messages
- Move the handling of "pinctrl-use-default" option out of driver core
- Stop deferring probe if modules are not enabled.

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
