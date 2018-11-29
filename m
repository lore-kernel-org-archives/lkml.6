Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1507C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B946A2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xQv1MluT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B946A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeK3BgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388794AbeK3BgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B7E2146D;
        Thu, 29 Nov 2018 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501832;
        bh=AymR6oZv7wASwLo8yhhD4drcOa6t9ljFNsE+dj4dr9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQv1MluT5WjBVwIkij3g/mgaeJ2kYrxyrVrADkurJmBcsKiuEmnbxHZcfAhLwd12+
         3eKUoF5S/kWYbVmyTo+LD+2rFG96VFY4iNNDzyRYUlHl5ThaGRCgPXy7ZWbTH5kBfO
         AvUiwZ2MvAfbp9haWjRK2hwSqoyTxsc5WPcKWAfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.19 025/110] iwlwifi: mvm: dont use SAR Geo if basic SAR is not used
Date:   Thu, 29 Nov 2018 15:11:56 +0100
Message-Id: <20181129135922.278011244@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>

commit 5d041c46ccb9b48acc110e214beff5e2789311df upstream.

We can't use SAR Geo if basic SAR is not enabled, since the SAR Geo
tables define offsets in relation to the basic SAR table in use.

To fix this, make iwl_mvm_sar_init() return one in case WRDS is not
available, so we can skip reading WGDS entirely.

Fixes: a6bff3cb19b7 ("iwlwifi: mvm: add GEO_TX_POWER_LIMIT cmd for geographic tx power table")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |   36 +++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -915,6 +915,11 @@ static int iwl_mvm_sar_get_ewrd_table(st
 	return -ENOENT;
 }
 
+static int iwl_mvm_sar_get_wgds_table(struct iwl_mvm *mvm)
+{
+	return -ENOENT;
+}
+
 static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 {
 	return 0;
@@ -941,8 +946,11 @@ static int iwl_mvm_sar_init(struct iwl_m
 		IWL_DEBUG_RADIO(mvm,
 				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
 				ret);
-		/* if not available, don't fail and don't bother with EWRD */
-		return 0;
+		/*
+		 * If not available, don't fail and don't bother with EWRD.
+		 * Return 1 to tell that we can't use WGDS either.
+		 */
+		return 1;
 	}
 
 	ret = iwl_mvm_sar_get_ewrd_table(mvm);
@@ -955,9 +963,13 @@ static int iwl_mvm_sar_init(struct iwl_m
 	/* choose profile 1 (WRDS) as default for both chains */
 	ret = iwl_mvm_sar_select_profile(mvm, 1, 1);
 
-	/* if we don't have profile 0 from BIOS, just skip it */
+	/*
+	 * If we don't have profile 0 from BIOS, just skip it.  This
+	 * means that SAR Geo will not be enabled either, even if we
+	 * have other valid profiles.
+	 */
 	if (ret == -ENOENT)
-		return 0;
+		return 1;
 
 	return ret;
 }
@@ -1155,11 +1167,19 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		iwl_mvm_unref(mvm, IWL_MVM_REF_UCODE_DOWN);
 
 	ret = iwl_mvm_sar_init(mvm);
-	if (ret)
-		goto error;
+	if (ret == 0) {
+		ret = iwl_mvm_sar_geo_init(mvm);
+	} else if (ret > 0 && !iwl_mvm_sar_get_wgds_table(mvm)) {
+		/*
+		 * If basic SAR is not available, we check for WGDS,
+		 * which should *not* be available either.  If it is
+		 * available, issue an error, because we can't use SAR
+		 * Geo without basic SAR.
+		 */
+		IWL_ERR(mvm, "BIOS contains WGDS but no WRDS\n");
+	}
 
-	ret = iwl_mvm_sar_geo_init(mvm);
-	if (ret)
+	if (ret < 0)
 		goto error;
 
 	iwl_mvm_leds_sync(mvm);


