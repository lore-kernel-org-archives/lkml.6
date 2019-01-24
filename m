Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86BDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AF7218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358890;
	bh=BBkxyk1wn67CE2FKPwc33pCrBHPzI5Z/oP61e1F7/l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uVfUTxEZn9IGbiwDnvxGLG6/21TX42Iwk67oQBECvibCCX+Pc7kxwOSM8175g/yr/
	 wa9EVEWTIt+HlmxNSdlTYAOq7VJl2oonLqE/Iq47Mk74Oo2ZEpbeIBwvHgElBjzYVa
	 sv4BZU3O6L8RXvu9rUQxC1rCb4Ojb7iWA1DIryio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfAXTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730718AbfAXTlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B8E20663;
        Thu, 24 Jan 2019 19:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358884;
        bh=BBkxyk1wn67CE2FKPwc33pCrBHPzI5Z/oP61e1F7/l8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wlttt1QDq71JUeK4mTmfelEB6l48Nd/ghDtaNpbcsXVqW8P3vZXeTT/inYh+rzgI7
         8vvOO0eQX5liasQF86IsaZCvq3TE5SbeoVzbDIknq0ZNBsAsOsI3/4hUtio2XmNysI
         SwaTYOykRjmDhRiZvUhJqCpHVltyJvp93Rlc7RP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 060/127] ASoC: use dma_ops of parent device for acp_audio_dma
Date:   Thu, 24 Jan 2019 20:20:06 +0100
Message-Id: <20190124190214.726936576@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

[ Upstream commit 23aa128bb28d9da69bb1bdb2b70e50128857884a ]

AMD platform device acp_audio_dma can only be created by parent PCI
device driver (drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c). Pass struct
device of the parent to snd_pcm_lib_preallocate_pages() so
dma_alloc_coherent() can use correct dma_ops. Otherwise, it will
use default dma_ops which is nommu_dma_ops on x86_64 even when
IOMMU is enabled and set to non passthrough mode.

Though platform device inherits some dma related fields during its
creation in mfd_add_device(), we can't simply pass its struct device
to snd_pcm_lib_preallocate_pages() because dma_ops is not among the
inherited fields. Even it were, drivers/iommu/amd_iommu.c would
ignore it because get_device_id() doesn't handle platform device.

This change shouldn't give us any trouble even struct device of the
parent becomes null or represents some non PCI device in the future,
because get_dma_ops() correctly handles null struct device or uses
the default dma_ops if struct device doesn't have it set.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cdebab2f8ce5..7ada2c1f4964 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1151,18 +1151,21 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
+	struct device *parent = component->dev->parent;
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 							    SNDRV_DMA_TYPE_DEV,
-							    NULL, ST_MIN_BUFFER,
+							    parent,
+							    ST_MIN_BUFFER,
 							    ST_MAX_BUFFER);
 		break;
 	default:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 							    SNDRV_DMA_TYPE_DEV,
-							    NULL, MIN_BUFFER,
+							    parent,
+							    MIN_BUFFER,
 							    MAX_BUFFER);
 		break;
 	}
-- 
2.19.1



