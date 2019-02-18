Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EE02177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499486;
	bh=NZedyh42inb2hcJAJS57CP8u/bwikYxsV3j1JjUVXOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VOPkxxAWCw7JxMsFadodpaYSJKQFAKj0g0+GaerHvlS208Y/lGQT/InUG5XZNMWFu
	 9lYD9vo2yTmzPz60u8xpHM3Cr+kHJLkEPjcrkQONw3T3YElm0oJI39zy4W92aLZNle
	 877DjIvmVuYiS5GY2tciDuHmErN44qVg6GiCC21Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391285AbfBROSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391473AbfBROK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:10:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A53217D9;
        Mon, 18 Feb 2019 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499025;
        bh=NZedyh42inb2hcJAJS57CP8u/bwikYxsV3j1JjUVXOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ods6iwJsTFVKqf5/lirSh97n4UEI/VM+qgdqRUz7H+JU8VsbXabgFZ1kSGpgSPt0w
         pJSYdnD1hnTlqUw+Ek2lukbBDU3cv9Msf1jVGR4wmjas0hYN9Xv/3rUh3gp+CVWwAE
         wvQAOX6UcpXvy/A75mIjvGuzcdYekkU275R6tuzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 027/108] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Date:   Mon, 18 Feb 2019 14:43:23 +0100
Message-Id: <20190218133520.791461795@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
index 081e406b3713..009d1893901b 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -219,7 +219,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
-	depends on ARCH_MXC && I2C
+	depends on ARCH_MXC && !ARM64 && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
-- 
2.19.1



