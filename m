Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9218FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6EB2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPCtgmje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6EB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbeKLKEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730390AbeKLIRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:13 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B528A214F1;
        Sun, 11 Nov 2018 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975237;
        bh=D0pgE4jWvDwl/FH/X3umVw7y6lLx2jdgocbPehHz2LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPCtgmjeWVNpa2hgDnfQ1NZxgi/n/fZ5TuvGkHnWhzcBIO2Xz8K23MWmLW+/YH3wd
         rze8pCqv7br5UhG/27/Szo60w+NgHkVSGDL/lr53PpF/0MpDo+Zl0QGsrWlpcHm0f6
         r3so3dKol/gLUefancG7k31oZ9lzLrn4D8DD28/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/361] iwlwifi: mvm: check for n_profiles validity in EWRD ACPI
Date:   Sun, 11 Nov 2018 14:17:02 -0800
Message-Id: <20181111221630.564065250@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -704,8 +704,12 @@ static int iwl_mvm_sar_get_ewrd_table(st
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


