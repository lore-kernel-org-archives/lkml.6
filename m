Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E88C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10432089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10432089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJCPqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:46:34 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57459 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJCPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:46:34 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7czn-00027c-Jo from Jiada_Wang@mentor.com ; Wed, 03 Oct 2018 01:59:03 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 3 Oct 2018 01:59:00 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next v2 0/9] ASoC: rsnd: support to use different BUSIF for GEN3
Date:   Wed, 3 Oct 2018 17:58:46 +0900
Message-ID: <20181003085855.4305-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Rcar audio DMA/SSIU already support to use different BUSIF to transfer data,
but BUSIF is fixed at 0. This patchset adds busif property to dai stream,
GEN3 series can automatically select BUSIF to transfer data,
based on channel and SSI mode (currently only BUSIF0 is selected).

Device tree files are updated to use extended audio dmac register,
and add dma request number for busif0 ~ busif7 for GEN3.

---
v2:
- Instead of configure BUSIF by kctl interface "SSI Out/In BUSIF",
  use rsnd_ssi_select_busif() to automatically select BUSIF.
- Keep 'rxu/txu' dma request, to keep compatibility with GEN2 series
- Re-order patch-set to satisfy git bisect  

v1: initial version

Jiada Wang (9):
  arm64: r8a7795: add dma request number for busif0 ~ busif7
  arm64: r8a7796: add dma request number for busif0 ~ busif7
  arm64: r8a774a1: add dma request number for busif0 ~ busif7
  arm64: r8a7795: change to use extended audio dmac register
  arm64: r8a7796: change to use extended audio dmac register
  arm64: r8a774a1: change to use extended audio dmac register
  arm64: r8a77965: change to use extended audio dmac register
  ASoC: rsnd: ssi: Request dedicated dma channels for busif0 to 7
  ASoC: rsnd: add busif property to dai stream

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 166 +++++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 166 +++++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 166 +++++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi |   2 +-
 sound/soc/sh/rcar/core.c                  |   3 +
 sound/soc/sh/rcar/dma.c                   |  31 ++++
 sound/soc/sh/rcar/rsnd.h                  |   3 +
 sound/soc/sh/rcar/ssi.c                   |  58 +++++++-
 8 files changed, 525 insertions(+), 70 deletions(-)

-- 
2.17.0

