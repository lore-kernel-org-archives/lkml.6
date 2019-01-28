Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA4FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A122171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692402;
	bh=ZVrx80Inkub/oRsTSZfg/YqaBwNpbFfnr5edmcteiN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S2/lx3ks+vHsOl7UrO5GKMiJqDVot9hcDVL+VC6T2EVgRqpTUv7eHOSG0C2UYUFrJ
	 DVZPSG8O7SbeqYOdihThtblx1gBupYohYp0Zjlxymw3pb4un/39pZW2jXenF2ud8wZ
	 v8IIVaZmnBJjcqxH61CpO0JjvfEg5mpnN8U9y7OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbfA1QUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbfA1QT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E9F21738;
        Mon, 28 Jan 2019 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692396;
        bh=ZVrx80Inkub/oRsTSZfg/YqaBwNpbFfnr5edmcteiN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LChhqSnG7lHYOLgz3PFScWsCPLZ4pNjn9TbVpHUMRmzuoJRQbjFmbECTGcQwWkMPk
         WEPyIlpInJemABKTa74XyXRLFtkpZGYJkXZdjhgAAWm05BNz51gIPpIxAbN97zVwLS
         lGbfV9x64lRPW4RVSq7rOWzysg09178fTOJ/gdUM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 003/107] ASoC: Intel: mrfld: fix uninitialized variable access
Date:   Mon, 28 Jan 2019 11:18:03 -0500
Message-Id: <20190128161947.57405-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 1539c7f23f256120f89f8b9ec53160790bce9ed2 ]

Randconfig testing revealed a very old bug, with gcc-8:

sound/soc/intel/atom/sst/sst_loader.c: In function 'sst_load_fw':
sound/soc/intel/atom/sst/sst_loader.c:357:5: error: 'fw' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (fw == NULL) {
     ^
sound/soc/intel/atom/sst/sst_loader.c:354:25: note: 'fw' was declared here
  const struct firmware *fw;

We must check the return code of request_firmware() before we look at the
pointer result that may be uninitialized when the function fails.

Fixes: 9012c9544eea ("ASoC: Intel: mrfld - Add DSP load and management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/atom/sst/sst_loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 33917146d9c4..054b1d514e8a 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -354,14 +354,14 @@ static int sst_request_fw(struct intel_sst_drv *sst)
 	const struct firmware *fw;
 
 	retval = request_firmware(&fw, sst->firmware_name, sst->dev);
-	if (fw == NULL) {
-		dev_err(sst->dev, "fw is returning as null\n");
-		return -EINVAL;
-	}
 	if (retval) {
 		dev_err(sst->dev, "request fw failed %d\n", retval);
 		return retval;
 	}
+	if (fw == NULL) {
+		dev_err(sst->dev, "fw is returning as null\n");
+		return -EINVAL;
+	}
 	mutex_lock(&sst->sst_lock);
 	retval = sst_cache_and_parse_fw(sst, fw);
 	mutex_unlock(&sst->sst_lock);
-- 
2.19.1

