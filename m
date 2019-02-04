Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC78C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F972081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfBDNlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:41:05 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:39440 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBDNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:41:04 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gqeUd-0004fs-P4 from Jiada_Wang@mentor.com ; Mon, 04 Feb 2019 05:40:59 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 4 Feb 2019 05:40:56 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: rsnd: ssiu: correct shift bit for ssiu9
Date:   Mon, 4 Feb 2019 22:41:05 +0900
Message-ID: <20190204134105.15243-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently "0xf << 36" is used to
clear SSIU-9 internal buffer state, which overflows 32-bit value
according to user reference manual, it is always bit4 ~ bit7
of SSI_SYS_STATUS[1,3,5,7] registers indicate
SSIU-9's buffer state, so "0xf << 4" should be used.

This patch fix incorrect shifting issue in SSIU-9 case

Fixes: commit b7169ddea2f2 ("ASoC: rsnd: remove RSND_REG_ from rsnd_reg")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 2f3085a54eba..b11677489a5e 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -79,7 +79,7 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 		break;
 	case 9:
 		for (i = 0; i < 4; i++)
-			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << (id * 4));
+			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << 4);
 		break;
 	}
 
-- 
2.19.2

