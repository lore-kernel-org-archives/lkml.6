Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA3220879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnMOOSHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA3220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeLEJif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeLEJic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:32 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1416D20851;
        Wed,  5 Dec 2018 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002711;
        bh=VB7TMmUs7fC6wzd1xKxaWcpWimkesSZV2nxfjXx+fyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnMOOSHCiuZD7jGlW53xULpOf3wKvMplRtPlnHjDwtsL9UAEtJOyRFZ25cSfC3RU2
         SWfK6e7YldnFZXgFKMDj0WqYj+e4r/qBeAtaW2hEiFJOBNsP6xVXSHItmNwrB+g2Qk
         T7+ft+TjrMniQH8JXR2owSrLFYlAuOmIIRTB6urQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keyon Jie <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 046/123] ASoC: acpi: fix: continue searching when machine is ignored
Date:   Wed,  5 Dec 2018 04:34:38 -0500
Message-Id: <20181205093555.5386-46-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keyon Jie <yang.jie@linux.intel.com>

[ Upstream commit a3e620f8422832afd832ad5e20aa97d0c72bada8 ]

The machine_quirk may return NULL which means the acpi entries should be
skipped and search for next matched entry is needed, here add return
check here and continue for NULL case.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-acpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index b8e72b52db30..4fb29f0e561e 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -10,11 +10,17 @@ struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
 	struct snd_soc_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach_alt;
 
 	for (mach = machines; mach->id[0]; mach++) {
 		if (acpi_dev_present(mach->id, NULL, -1)) {
-			if (mach->machine_quirk)
-				mach = mach->machine_quirk(mach);
+			if (mach->machine_quirk) {
+				mach_alt = mach->machine_quirk(mach);
+				if (!mach_alt)
+					continue; /* not full match, ignore */
+				mach = mach_alt;
+			}
+
 			return mach;
 		}
 	}
-- 
2.17.1

