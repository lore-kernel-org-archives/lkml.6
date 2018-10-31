Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787422054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2lHexk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787422054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeKAIxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbeKAIGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB0A20843;
        Wed, 31 Oct 2018 23:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027168;
        bh=UxzfIGUMoPAUg4bqFg44OEChrZ0+rcb80UnaLaNtRPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2lHexk13+D0/h0IIwMM2KHDCO8+279EmgoAu/4J4eBZPCll2PPs1JdzGhY9BMkYG
         vV2G2LvvHfynanimegIwpMS+aaol3xFqMS1wSvSiRarxepSiZZgLLWm52pznHyrwC+
         0PeqLjcCEgrBmKSJGyn3HG/9yMtrclq5V1r5Icwk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 029/146] iwlwifi: mvm: check for n_profiles validity in EWRD ACPI
Date:   Wed, 31 Oct 2018 19:03:44 -0400
Message-Id: <20181031230541.28822-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit 2e1976bb75263fbad918e82184b16a23bd721546 ]

When reading the profiles from the EWRD table in ACPI, we loop over
the data and set it into our internal table.  We use the number of
profiles specified in ACPI without checking its validity, so if the
ACPI table is corrupted and the number is larger than our array size,
we will try to make an out-of-bounds access.

Fix this by making sure the value specified in the ACPI table is
valid.

Fixes: 6996490501ed ("iwlwifi: mvm: add support for EWRD (Dynamic SAR) ACPI table")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6bb1a99a197a..48a3611d6a31 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -704,8 +704,12 @@ static int iwl_mvm_sar_get_ewrd_table(struct iwl_mvm *mvm)
 	enabled = !!(wifi_pkg->package.elements[1].integer.value);
 	n_profiles = wifi_pkg->package.elements[2].integer.value;
 
-	/* in case of BIOS bug */
-	if (n_profiles <= 0) {
+	/*
+	 * Check the validity of n_profiles.  The EWRD profiles start
+	 * from index 1, so the maximum value allowed here is
+	 * ACPI_SAR_PROFILES_NUM - 1.
+	 */
+	if (n_profiles <= 0 || n_profiles >= ACPI_SAR_PROFILE_NUM) {
 		ret = -EINVAL;
 		goto out_free;
 	}
-- 
2.17.1

