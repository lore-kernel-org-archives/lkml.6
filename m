Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeBWKYQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43191 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeBWKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:11 -0500
X-Google-Smtp-Source: AH8x226fj8zUcwMAsMg3NRpWU7xv80dLvEEqKKWfr2DoXT4ekY7HBi69N0V1dipfaDSY9GhDvCiogQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: [PATCH V7 02/13] of: platform: Make of_platform_bus_create() global
Date: Fri, 23 Feb 2018 15:53:41 +0530
Message-Id: <0f725b5b58bcdc22d03a436ad8243b98c962593a.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot constraints core needs to create platform or AMBA devices
corresponding to a compatible string and not for rest of the nodes in
DT. of_platform_bus_create() fits in the best to achieve that.

Allow it to be used outside of platform.c.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/platform.c       |  8 ++++----
 include/linux/of_platform.h | 11 +++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 72853f9043e6..dfbb9f38cb37 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -392,10 +392,10 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
  * Creates a platform_device for the provided device_node, and optionally
  * recursively create devices for all the child nodes.
  */
-static int of_platform_bus_create(struct device_node *bus,
-				  const struct of_device_id *matches,
-				  const struct of_dev_auxdata *lookup,
-				  struct device *parent, bool strict)
+int of_platform_bus_create(struct device_node *bus,
+			   const struct of_device_id *matches,
+			   const struct of_dev_auxdata *lookup,
+			   struct device *parent, bool strict)
 {
 	const struct of_dev_auxdata *auxdata;
 	struct device_node *child;
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 5fb20afaf895..7a5313553c2a 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -76,6 +76,10 @@ extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
 #ifdef CONFIG_OF_ADDRESS
+extern int of_platform_bus_create(struct device_node *bus,
+				  const struct of_device_id *matches,
+				  const struct of_dev_auxdata *lookup,
+				  struct device *parent, bool strict);
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
@@ -89,6 +93,13 @@ extern int devm_of_platform_populate(struct device *dev);
 
 extern void devm_of_platform_depopulate(struct device *dev);
 #else
+static inline int of_platform_bus_create(struct device_node *bus,
+					 const struct of_device_id *matches,
+					 const struct of_dev_auxdata *lookup,
+					 struct device *parent, bool strict)
+{
+	return -ENODEV;
+}
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
 					const struct of_dev_auxdata *lookup,
-- 
2.15.0.194.g9af6a3dea062
