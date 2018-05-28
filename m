Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424887AbeE1Lrr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423149AbeE1LKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 144/272] firmware: fix checking for return values for fw_add_devm_name()
Date: Mon, 28 May 2018 12:02:57 +0200
Message-Id: <20180528100253.130106800@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

[ Upstream commit d15d7311550983be97dca44ad68cbc2ca001297b ]

Currently fw_add_devm_name() returns 1 if the firmware cache
was already set. This makes it complicated for us to check for
correctness. It is actually non-fatal if the firmware cache
is already setup, so just return 0, and simplify the checkers.

fw_add_devm_name() adds device's name onto the devres for the
device so that prior to suspend we cache the firmware onto memory,
so that on resume the firmware is reliably available. We never
were checking for success for this call though, meaning in some
really rare cases we my have never setup the firmware cache for
a device, which could in turn make resume fail.

This is all theoretical, no known issues have been reported.
This small issue has been present way since the addition of the
devres firmware cache names on v3.7.

Fixes: f531f05ae9437 ("firmware loader: store firmware name into devres list")
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_class.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -524,7 +524,7 @@ static int fw_add_devm_name(struct devic
 
 	fwn = fw_find_devm_name(dev, name);
 	if (fwn)
-		return 1;
+		return 0;
 
 	fwn = devres_alloc(fw_name_devm_release, sizeof(struct fw_name_devm),
 			   GFP_KERNEL);
@@ -552,6 +552,7 @@ static int assign_fw(struct firmware *fw
 		     unsigned int opt_flags)
 {
 	struct fw_priv *fw_priv = fw->priv;
+	int ret;
 
 	mutex_lock(&fw_lock);
 	if (!fw_priv->size || fw_state_is_aborted(fw_priv)) {
@@ -568,8 +569,13 @@ static int assign_fw(struct firmware *fw
 	 */
 	/* don't cache firmware handled without uevent */
 	if (device && (opt_flags & FW_OPT_UEVENT) &&
-	    !(opt_flags & FW_OPT_NOCACHE))
-		fw_add_devm_name(device, fw_priv->fw_name);
+	    !(opt_flags & FW_OPT_NOCACHE)) {
+		ret = fw_add_devm_name(device, fw_priv->fw_name);
+		if (ret) {
+			mutex_unlock(&fw_lock);
+			return ret;
+		}
+	}
 
 	/*
 	 * After caching firmware image is started, let it piggyback
