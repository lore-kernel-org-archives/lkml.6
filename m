Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeCFMdt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:33:49 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:47683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:33:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Maciej Purski <m.purski@samsung.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Tirupathi Reddy <tirupath@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: don't try to use DT information without CONFIG_OF
Date: Tue,  6 Mar 2018 13:33:09 +0100
Message-Id: <20180306123333.84344-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:BGYgv7pUkkHyltTvcAZw1zXyUwHrrQrD1YPUBSJ/Bbkby1NiTV7
 +ni8zSn9rGZ1mGsu7hVIl2w087OEsfBLMIX9WB7OYylejU8ggJUW6LaOe5a2eTKMNsndzLQ
 EU1KLw0eqRC924hq4orM+yPqguGGemBKdwtka5+wb6WSjPY7Kl3FbFgktd68c9jotTlsymc
 SQf+1h2gSCjnWfyZqYpOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ik+xxJ1bCwI=:m4EcTV7Txri5m54UtSRnSW
 APiFHy68sUDVChlzEosePxOKRvmh5Q0rpRJLEBrsXHl1dvpbsMS8XfKH9PBgYsyMCGFAnlarp
 UE/fBorjwjOLWilsrMEBofkRxkPnV8xnIzXc9fsOP05jVk3sKQBFXlJ7hSoV4mX/Y242fZmUk
 OZOV8M3ADUEGvzE6TKUoG+l86S2A66DM1Z9/PI3hxJto5N2avhXR5PACSfJ54Su0zUHHsYFlf
 3+SGiWTtB1vmbunzr1NAGGY9qJ4Ez7BPAtzyX+XMqrMgKiLQ6qPS8eyNQPyL+J0mPmhP4ZpbP
 n9Kd5VAJtyxD7XnH3gvDILp+OJH5wwema/B+QKucIAVc41k91vqW5OcpAIPvwCHbEWOjsmTm7
 xOVwJ18rqJ8TwheG7aiPYDVODQxaUlgRwsY25hQ1IxYtX/pUNr+hShwAr5nFKmopmjdEkl/Pr
 tQUlzfOpP7GtFP8Jswk+T6yjiTP5Oy3MIhw6U2VE8pqhnBXqJ3ChmrGRLdOxuP0tOFm3phTrP
 ShSLANjGV3mzudKQjmFlT+6OSns27sr2BmbV4je2Qh1XGK+mo5dYXqFWbrGqdyeBqRIHn9Qvv
 swYK9z6NXT9R+GYJi1ERO8uKRGRYTpOn3AQYELR1N9/0CjEdNZsob+Yhb6x+4Yvfn9Xihza2v
 nInjNpj/21vsBJC3t4p06KiVRXAgNGMXIqCCMWVcKAhAqPfJd1FpC68zi8IDEZiHHxu/U61IL
 Q81NXj8ElWxe57kH/LaWygaHmfwU56/mJHKJ7g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/regulator/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dedf737a2bad..dbc3381105fb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4351,6 +4351,9 @@ static int regulator_register_fill_coupling_array(struct device *dev,
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
 
+	if (!IS_ENABLED(CONFIG_OF))
+		return 0;
+
 	if (regulator_fill_coupling_array(rdev))
 		rdev_dbg(rdev, "unable to resolve coupling\n");
 
@@ -4359,7 +4362,12 @@ static int regulator_register_fill_coupling_array(struct device *dev,
 
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
2.9.0
