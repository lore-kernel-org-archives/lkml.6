Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A34C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D7C20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895316;
	bh=KDFAx57a4qcoL4L/6eCJjIoQN9endTSqX8iRADhs+MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYBevcfun/4rAsgoc16sV/kmDmIjOygonT5VSFQmDib7oYZCCBUMdVPqErNn3uf8K
	 j0jOGUEfAGdI1CbSOGAulITs7JKDff+vRZuVUJspEGICFjdKwNvMnrYLwy3yNBYakx
	 Yzidakqx4dn8WPHN/MQJ4g1DRimKZpOzNOka2U04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfBKO2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbfBKO2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B302E20844;
        Mon, 11 Feb 2019 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895311;
        bh=KDFAx57a4qcoL4L/6eCJjIoQN9endTSqX8iRADhs+MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7NuuTQC8gzt+vNX+avwsXUnmm2QfYXSpcW0VBJu526QRdzvusIAO2MisUFGjNHHv
         5xRwD5sjerXDSNaylUqWPuwEmLTYI76wYHtB5/aFXyhBSnJDSUlb1fBDWmjqexYzb8
         oiLdzTKf52x8Xs6BhHFKnYN7/nJnU8OlzYCLpG+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 163/352] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Date:   Mon, 11 Feb 2019 15:16:30 +0100
Message-Id: <20190211141857.314147920@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 6ec19fb4a934..2e75b5bc5f1d 100644
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



