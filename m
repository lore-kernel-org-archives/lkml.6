Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeCETYZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:24:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54770 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932370AbeCETYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:24:23 -0500
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, david@lechnology.com,
        linux-kernel@vger.kernel.org
Subject: Applied "regmap: debugfs: Disambiguate dummy debugfs file name" to the regmap tree
In-Reply-To: <1520275929-2708-1-git-send-email-festevam@gmail.com>
Message-Id: <E1esvic-0004Ce-7u@debutante>
Date: Mon, 05 Mar 2018 19:24:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: debugfs: Disambiguate dummy debugfs file name

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a430ab205d29e7d1537b220fcf989b8080d8267f Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 5 Mar 2018 15:52:09 -0300
Subject: [PATCH] regmap: debugfs: Disambiguate dummy debugfs file name

Since commit 9b947a13e7f6 ("regmap: use debugfs even when no device")
allows the usage of regmap debugfs even when there is no device
associated, which causes several warnings like this:

(NULL device *): Failed to create debugfs directory

This happens when the debugfs file name is 'dummy'.

The first dummy debugfs creation works fine, but subsequent creations
fail as they have all the same name.

Disambiguate the 'dummy' debugfs file name by adding a suffix entry,
so that the names become dummy0, dummy1, dummy2, etc.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 7eb512ba2828..e3e7b91cc421 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -25,6 +25,7 @@ struct regmap_debugfs_node {
 	struct list_head link;
 };
 
+static unsigned int dummy_index;
 static struct dentry *regmap_debugfs_root;
 static LIST_HEAD(regmap_debugfs_early_list);
 static DEFINE_MUTEX(regmap_debugfs_early_lock);
@@ -573,6 +574,11 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 		name = devname;
 	}
 
+	if (!strcmp(name, "dummy")) {
+		name = kasprintf(GFP_KERNEL, "dummy%d", dummy_index);
+		dummy_index++;
+	}
+
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
 		dev_warn(map->dev, "Failed to create debugfs directory\n");
-- 
2.16.2
