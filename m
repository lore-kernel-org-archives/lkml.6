Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeEBNzm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:55:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:58147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeEBNzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:55:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="225150743"
From: changbin.du@intel.com
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 2/5] regulator: add dummy function of_find_regulator_by_node
Date: Wed,  2 May 2018 21:44:57 +0800
Message-Id: <1525268700-10631-3-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

If device tree is not enabled, of_find_regulator_by_node() should have
a dummy function since the function call is still there.

This is to fix build error after CONFIG_NO_AUTO_INLINE is introduced.
If this option is enabled, GCC will not auto-inline functions that are
not explicitly marked as inline.

In this case (no CONFIG_OF), the copmiler will report error in function
regulator_dev_lookup().

W/O NO_AUTO_INLINE, function of_get_regulator() is auto-inlined and then
the call to of_find_regulator_by_node() is optimized out since
of_get_regulator() always return NULL.

W/ NO_AUTO_INLINE, the return value of of_get_regulator() is a variable
so the call to of_find_regulator_by_node() cannot be optimized out. So
we need a stub of_find_regulator_by_node().

static struct regulator_dev *regulator_dev_lookup(struct device *dev,
						  const char *supply)
{
	struct regulator_dev *r = NULL;
	struct device_node *node;
	struct regulator_map *map;
	const char *devname = NULL;

	regulator_supply_alias(&dev, &supply);

	/* first do a dt based lookup */
	if (dev && dev->of_node) {
		node = of_get_regulator(dev, supply);
		if (node) {
			r = of_find_regulator_by_node(node);
			if (r)
				return r;
	...

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 drivers/regulator/internal.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index abfd56e..24fde1e 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -56,14 +56,19 @@ static inline struct regulator_dev *dev_to_rdev(struct device *dev)
 	return container_of(dev, struct regulator_dev, dev);
 }
 
-struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
-
 #ifdef CONFIG_OF
+struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
 struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
 				 struct regulator_config *config,
 				 struct device_node **node);
 #else
+static inline struct regulator_dev *
+of_find_regulator_by_node(struct device_node *np)
+{
+	return NULL;
+}
+
 static inline struct regulator_init_data *
 regulator_of_get_init_data(struct device *dev,
 			   const struct regulator_desc *desc,
-- 
2.7.4
