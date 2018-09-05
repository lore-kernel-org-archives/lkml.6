Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB44E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB44E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeIENqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:46:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39619 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbeIENqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:46:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 556BD206F6; Wed,  5 Sep 2018 11:16:54 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1DB6220737;
        Wed,  5 Sep 2018 11:16:44 +0200 (CEST)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 02/10] phy: Add configuration interface
Date:   Wed,  5 Sep 2018 11:16:33 +0200
Message-Id: <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy framework is only allowing to configure the power state of the PHY
using the init and power_on hooks, and their power_off and exit
counterparts.

While it works for most, simple, PHYs supported so far, some more advanced
PHYs need some configuration depending on runtime parameters. These PHYs
have been supported by a number of means already, often by using ad-hoc
drivers in their consumer drivers.

That doesn't work too well however, when a consumer device needs to deal
multiple PHYs, or when multiple consumers need to deal with the same PHY (a
DSI driver and a CSI driver for example).

So we'll add a new interface, through two funtions, phy_validate and
phy_configure. The first one will allow to check that a current
configuration, for a given mode, is applicable. It will also allow the PHY
driver to tune the settings given as parameters as it sees fit.

phy_configure will actually apply that configuration in the phy itself.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/phy/phy-core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/phy/phy.h | 42 ++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 35fd38c5a4a1..6eaf655e370f 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -408,6 +408,68 @@ int phy_calibrate(struct phy *phy)
 EXPORT_SYMBOL_GPL(phy_calibrate);
 
 /**
+ * phy_configure() - Changes the phy parameters
+ * @phy: the phy returned by phy_get()
+ * @mode: phy_mode the configuration is applicable to.
+ * @opts: New configuration to apply
+ *
+ * Used to change the PHY parameters. phy_init() must have
+ * been called on the phy.
+ *
+ * Returns: 0 if successful, an negative error code otherwise
+ */
+int phy_configure(struct phy *phy, enum phy_mode mode,
+		  union phy_configure_opts *opts)
+{
+	int ret;
+
+	if (!phy)
+		return -EINVAL;
+
+	if (!phy->ops->configure)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->configure(phy, mode, opts);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+
+/**
+ * phy_validate() - Checks the phy parameters
+ * @phy: the phy returned by phy_get()
+ * @mode: phy_mode the configuration is applicable to.
+ * @opts: Configuration to check
+ *
+ * Used to check that the current set of parameters can be handled by
+ * the phy. Implementations are free to tune the parameters passed as
+ * arguments if needed by some implementation detail or
+ * constraints. It will not change any actual configuration of the
+ * PHY, so calling it as many times as deemed fit will have no side
+ * effect.
+ *
+ * Returns: 0 if successful, an negative error code otherwise
+ */
+int phy_validate(struct phy *phy, enum phy_mode mode,
+		  union phy_configure_opts *opts)
+{
+	int ret;
+
+	if (!phy)
+		return -EINVAL;
+
+	if (!phy->ops->validate)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->validate(phy, mode, opts);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+
+/**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
  * @index: the index of the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9cba7fe16c23..3cc315dcfcd0 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -44,6 +44,12 @@ enum phy_mode {
 };
 
 /**
+ * union phy_configure_opts - Opaque generic phy configuration
+ */
+union phy_configure_opts {
+};
+
+/**
  * struct phy_ops - set of function pointers for performing phy operations
  * @init: operation to be performed for initializing phy
  * @exit: operation to be performed while exiting
@@ -60,6 +66,38 @@ struct phy_ops {
 	int	(*power_on)(struct phy *phy);
 	int	(*power_off)(struct phy *phy);
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
+
+	/**
+	 * @configure:
+	 *
+	 * Optional.
+	 *
+	 * Used to change the PHY parameters. phy_init() must have
+	 * been called on the phy.
+	 *
+	 * Returns: 0 if successful, an negative error code otherwise
+	 */
+	int	(*configure)(struct phy *phy, enum phy_mode mode,
+			     union phy_configure_opts *opts);
+
+	/**
+	 * @validate:
+	 *
+	 * Optional.
+	 *
+	 * Used to check that the current set of parameters can be
+	 * handled by the phy. Implementations are free to tune the
+	 * parameters passed as arguments if needed by some
+	 * implementation detail or constraints. It must not change
+	 * any actual configuration of the PHY, so calling it as many
+	 * times as deemed fit by the consumer must have no side
+	 * effect.
+	 *
+	 * Returns: 0 if the configuration can be applied, an negative
+	 * error code otherwise
+	 */
+	int	(*validate)(struct phy *phy, enum phy_mode mode,
+			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
 	struct module *owner;
@@ -164,6 +202,10 @@ int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
 int phy_set_mode(struct phy *phy, enum phy_mode mode);
+int phy_configure(struct phy *phy, enum phy_mode mode,
+		  union phy_configure_opts *opts);
+int phy_validate(struct phy *phy, enum phy_mode mode,
+		 union phy_configure_opts *opts);
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
 	return phy->attrs.mode;
-- 
git-series 0.9.1
