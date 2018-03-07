Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeCGOPw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:15:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50374 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754481AbeCGOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:15:34 -0500
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Maciej Purski <m.purski@samsung.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Tirupathi Reddy <tirupath@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: don't try to use DT information without CONFIG_OF" to the regulator tree
In-Reply-To: <20180306123333.84344-1-arnd@arndb.de>
Message-Id: <E1etZqr-0001dt-39@debutante>
Date: Wed, 07 Mar 2018 14:15:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: don't try to use DT information without CONFIG_OF

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 30f00f4897a093bb2b0308caab7855d6b75e9e1b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 13:33:09 +0100
Subject: [PATCH] regulator: don't try to use DT information without CONFIG_OF

The coupled regulator support requires CONFIG_OF today, otherwise
we get a link error:

drivers/regulator/core.o: In function `regulator_fill_coupling_array':
core.c:(.text+0x3e44): undefined reference to `of_parse_coupled_regulator'
drivers/regulator/core.o: In function `regulator_register':
core.c:(.text+0x5eb4): undefined reference to `of_get_n_coupled'
core.c:(.text+0x5f08): undefined reference to `of_check_coupling_data'

This changes the affected functions to return success when CONFIG_OF
is disabled, which should result in the same behavior as before.

Fixes: cf6fc8064766 ("regulator: core: Resolve coupled regulators")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d68244ad9423..e685f8b94acf 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4345,6 +4345,9 @@ static int regulator_register_fill_coupling_array(struct device *dev,
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
 
+	if (!IS_ENABLED(CONFIG_OF))
+		return 0;
+
 	if (regulator_fill_coupling_array(rdev))
 		rdev_dbg(rdev, "unable to resolve coupling\n");
 
@@ -4353,7 +4356,12 @@ static int regulator_register_fill_coupling_array(struct device *dev,
 
 static int regulator_resolve_coupling(struct regulator_dev *rdev)
 {
-	int n_phandles = of_get_n_coupled(rdev);
+	int n_phandles;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return 0;
+
+	n_phandles = of_get_n_coupled(rdev);
 
 	if (n_phandles + 1 > MAX_COUPLED) {
 		rdev_err(rdev, "too many regulators coupled\n");
-- 
2.16.2
