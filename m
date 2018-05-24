Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032060AbeEXRwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:52:25 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38181 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031168AbeEXRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:50:41 -0400
X-Google-Smtp-Source: AB8JxZrc2TdvR9ECx8yPlMYRSrZ2R1CNZMNxvJELm4B8RdNwGEwyTxURdT1WzEja3oLaycG3VzW0zg==
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/8] pinctrl: optionally stop deferring probe at end of initcalls
Date: Thu, 24 May 2018 12:50:21 -0500
Message-Id: <20180524175024.19874-6-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the pinctrl node in DT indicates that pin setup is optional and the
defaults can be used with the 'pinctrl-use-default', then only defer probe
until initcalls are done. This gives platforms the option to work without
their pinctrl driver being enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pinctrl/devicetree.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index b601039d6c69..74a31074b406 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -110,17 +110,23 @@ static int dt_to_map_one_config(struct pinctrl *p,
 	int ret;
 	struct pinctrl_map *map;
 	unsigned num_maps;
+	bool pctl_optional = false;
 
 	/* Find the pin controller containing np_config */
 	np_pctldev = of_node_get(np_config);
 	for (;;) {
+		if (!pctl_optional)
+			pctl_optional = of_property_read_bool(np_pctldev, "pinctrl-use-default");
+
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
-			dev_info(p->dev, "could not find pctldev for node %pOF, deferring probe\n",
-				np_config);
 			of_node_put(np_pctldev);
-			/* OK let's just assume this will appear later then */
-			return -EPROBE_DEFER;
+			ret = driver_deferred_probe_check_init_done(p->dev, pctl_optional);
+			if (ret == -EPROBE_DEFER)
+				/* OK let's just assume this will appear later then */
+				dev_info(p->dev, "could not find pctldev for node %pOF, deferring probe\n",
+					np_config);
+			return ret;
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (pctldev && (np_pctldev == p->dev->of_node))
-- 
2.17.0
