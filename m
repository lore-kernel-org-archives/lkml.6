Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B01C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A4D2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692169;
	bh=bW9Mx5/dtJ5t0zcvQan9XmREg7IlVtESyzkil8bukpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFER9WaAWsniqNzQteLC78qaqhSFmy9HqwFNmiBFwFN3YI44ffikuYj/R4SJk+UuS
	 7feDQhi8qhbnqrrin5pQG1M3dIKsEOiohj8QP+zB6QIgZ3cjLIWGRPWN4qPoQypNMX
	 uRovDVlKnuG8i+HjJN+BSgNYSRfbj5xdzrwF+dzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbfA1QQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387910AbfA1QQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F732086C;
        Mon, 28 Jan 2019 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692164;
        bh=bW9Mx5/dtJ5t0zcvQan9XmREg7IlVtESyzkil8bukpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIO3mV3VEDzfmfpGzW4UT6Y0EJYeqh9aR0+cGg9oFPqJEYS4mcFRumMYks7Xn6WhH
         jSyPaat6wrkx7y7DjHvXW6xQCewk+J9tAAp9TSJGe7ATFs9ZiyavbpHgtTi2uq55/0
         41BLh2sFMqrfKqjWIXOUzajd24MwuwxWkbu1GmeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 096/170] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Date:   Mon, 28 Jan 2019 11:10:46 -0500
Message-Id: <20190128161200.55107-96-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit add6883619a9e3bf9658eaff1a547354131bbcd9 ]

eukrea-tlv320.c machine driver runs on non-DT platforms
and include <asm/mach-types.h> header file in order to be able
to use some machine_is_eukrea_xxx() macros.

Building it for ARM64 causes the following build error:

sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory

Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
driver when ARM64 is selected.

This is needed in preparation for the i.MX8M support.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 37f9b6201918..4087deeda7cf 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -221,7 +221,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
-	depends on ARCH_MXC && I2C
+	depends on ARCH_MXC && !ARM64 && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
-- 
2.19.1

