Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE8B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnLSABuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE8B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeKAIIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbeKAIIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F382084A;
        Wed, 31 Oct 2018 23:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027309;
        bh=+5X7dIC/QbjYxm/+gKy32O98nmODIuISS/rcNXrJd8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnLSABuRA+FqNGGOJ0IY6/U6WCagdBQq0diaSnuYGef73o7a41nWL7gKguIk/ZWCZ
         ikeASjvEtZN5z4zUymlPkZJwgUH0YFrHrDAchWo6XIvGRT4n0wkTZvdnUtFEIaJSMV
         b+hXJeJNt0g7a5u4kHwd8COKZyKIiqy7dB+LqLog=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 038/126] ice: update fw version check logic
Date:   Wed, 31 Oct 2018 19:06:26 -0400
Message-Id: <20181031230754.29029-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 396fbf9cab5dc07f8f87773062a8d35f54b40a05 ]

We have MAX_FW_API_VER_BRANCH, MAX_FW_API_VER_MAJOR, and
MAX_FW_API_VER_MINOR that we use in ice_controlq.h to test when a
firmware version is newer than expected. This is currently tested by
comparing each field separately. Thus, we compare the branch field
against the MAX_FW_API_VER_BRANCH, and so forth.

This means that currently, if we suppose that the max firmware version
is defined as 0.2.1, i.e.

Then firmware 0.1.3 will fail to load. This is because the minor version
3 is greater than the max minor version 1.

This is not intuitive, because of the notion that increasing the major
firmware version to 2 should mean any firmware version with a major
version is less than 2 should be considered older than 2...

In order to allow both 0.2.1 and 0.1.3 to load, you would have to define
the "max" firmware version as 0.2.3.. It is possible that such
a firmware version doesn't even exist yet!

Fix this by replacing the current logic with an updated check that
behaves as follows:

First, we check the major version. If it is greater than the expected
version, then we prevent driver load. Additionally, a warning message is
logged to indicate to the system administrator that they need to update
their driver. This is now the only case where the driver will refuse to
load.

Second, if the major version is less than the expected version, we log
an information message indicating the NVM should be updated.

Third, if the major version is exact, we'll then check the minor
version. If the minor version is more than two versions less than
expected, we log an information message indicating the NVM should be
updated. If it is more than two versions greater than the expected
version, we log an information message that the driver should be
updated.

To support this, the ice_aq_ver_check function needs its signature
updated to pass the HW structure. Since we now pass this structure,
there is no need to pass the firmware API versions separately.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 62be72fdc8f3..e783976c401d 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -518,22 +518,31 @@ ice_shutdown_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 
 /**
  * ice_aq_ver_check - Check the reported AQ API version.
- * @fw_branch: The "branch" of FW, typically describes the device type
- * @fw_major: The major version of the FW API
- * @fw_minor: The minor version increment of the FW API
+ * @hw: pointer to the hardware structure
  *
  * Checks if the driver should load on a given AQ API version.
  *
  * Return: 'true' iff the driver should attempt to load. 'false' otherwise.
  */
-static bool ice_aq_ver_check(u8 fw_branch, u8 fw_major, u8 fw_minor)
+static bool ice_aq_ver_check(struct ice_hw *hw)
 {
-	if (fw_branch != EXP_FW_API_VER_BRANCH)
-		return false;
-	if (fw_major != EXP_FW_API_VER_MAJOR)
-		return false;
-	if (fw_minor != EXP_FW_API_VER_MINOR)
+	if (hw->api_maj_ver > EXP_FW_API_VER_MAJOR) {
+		/* Major API version is newer than expected, don't load */
+		dev_warn(ice_hw_to_dev(hw),
+			 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
 		return false;
+	} else if (hw->api_maj_ver == EXP_FW_API_VER_MAJOR) {
+		if (hw->api_min_ver > (EXP_FW_API_VER_MINOR + 2))
+			dev_info(ice_hw_to_dev(hw),
+				 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
+		else if ((hw->api_min_ver + 2) < EXP_FW_API_VER_MINOR)
+			dev_info(ice_hw_to_dev(hw),
+				 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+	} else {
+		/* Major API version is older than expected, log a warning */
+		dev_info(ice_hw_to_dev(hw),
+			 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+	}
 	return true;
 }
 
@@ -588,8 +597,7 @@ static enum ice_status ice_init_check_adminq(struct ice_hw *hw)
 	if (status)
 		goto init_ctrlq_free_rq;
 
-	if (!ice_aq_ver_check(hw->api_branch, hw->api_maj_ver,
-			      hw->api_min_ver)) {
+	if (!ice_aq_ver_check(hw)) {
 		status = ICE_ERR_FW_API_VER;
 		goto init_ctrlq_free_rq;
 	}
-- 
2.17.1

