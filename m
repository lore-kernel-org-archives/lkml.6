Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21382C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4612086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfBADCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:02:25 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:42752 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBADCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:02:25 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gpP5x-0001rt-KJ from Jiada_Wang@mentor.com ; Thu, 31 Jan 2019 19:02:21 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 31 Jan 2019 19:02:18 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] ASoC: rsnd: allow to register kctrl with different cfg
Date:   Fri, 1 Feb 2019 12:02:25 +0900
Message-ID: <20190201030225.11391-1-jiada_wang@mentor.com>
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

Currently kctrl with same name can only be created once,
but in "MIX Playback Volume" case, same kctrl is used to
control different MIX volume for different dai-link.

this patch by check kctrl's cfg, allow to create kctrl
with same name but different cfg.

Fixes: commit 9c698e8481a1 ("ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 79659f7b32b9..909ee0948da1 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1526,14 +1526,15 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	int ret;
 
 	/*
-	 * 1) Avoid duplicate register (ex. MIXer case)
+	 * 1) Avoid duplicate register (ex. DVC case)
 	 * 2) re-register if card was rebinded
 	 */
 	list_for_each_entry(kctrl, &card->controls, list) {
 		struct rsnd_kctrl_cfg *c = kctrl->private_data;
 
 		if (strcmp(kctrl->id.name, name) == 0 &&
-		    c->mod == mod)
+		    c->mod == mod &&
+		    &c->val == &cfg->val)
 			return 0;
 	}
 
-- 
2.19.2

