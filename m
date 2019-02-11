Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD460C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC11E222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898094;
	bh=b5JFNVr6TVcRjYGAOsk8gJDz+eJ4ExLgJNcoP+OQCVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gj4eBkmhVJw/OSwbAWs+LE06khvTuRPZ5vNfUlTxAc00p3yPGFfbwuw4aIqXLetf6
	 0ZFO3nR2mO+5io+V2PEBMKaAQXkPbb9UMrT+X06NF4WWZGuaAbX3AWpF7j6wn/MWPR
	 7KMDXSwwnTYt3M0aFbtlFjef/ROEhTRcPP85oveQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbfBKPOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391064AbfBKPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:08:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6C4222A7;
        Mon, 11 Feb 2019 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897697;
        bh=b5JFNVr6TVcRjYGAOsk8gJDz+eJ4ExLgJNcoP+OQCVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1i3CgKdRUQdI8HxYuKlAUX7bRxl6r416SlD97JgnlvyPsGpz7voY4qP17GC8TtVB
         Hv2afj+z0q4rfQcXCYlWpv1uSIl/SbGt4J0AYzq0bC4vcbV4NDDXYWa2dHf6Yh75er
         urFwF1cVFpKf8eamDH6bWuxBBO1z5YNjOv6yFOkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 053/137] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Date:   Mon, 11 Feb 2019 15:18:54 +0100
Message-Id: <20190211141816.863476953@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 19bdcac71775..a732b3a065c9 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -220,7 +220,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
-	depends on ARCH_MXC && I2C
+	depends on ARCH_MXC && !ARM64 && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
-- 
2.19.1



