Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87587C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F962084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0l9bLEcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F962084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeLEJhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbeLEJhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:37:47 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ECD720879;
        Wed,  5 Dec 2018 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002667;
        bh=AyJod8U+ikxaftQCbs4PZwe8VtgCRBnWdinqyNKOiNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0l9bLEcMjN0rDp1GOw5PT0wJkM4Rytl0xGm8DX9bTENj1DWZ+5hCf7gA0dpnvnbds
         HZk/MyGdKrSIVGRgH0u2NGKGU45SWfYEiHWEXGfiuNXZTEo9oxNrDG0uoW1DtciA/+
         AZpuClnvq63YmN91jR609OgR1zKyLvrX5mT+Kmn8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 032/123] ASoC: qcom: Set dai_link id to each dai_link
Date:   Wed,  5 Dec 2018 04:34:24 -0500
Message-Id: <20181205093555.5386-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohit kumar <rohitkr@codeaurora.org>

[ Upstream commit 67fd1437d11620de8768b22fe20942e752ed52e9 ]

Frontend dai_link id is used for closing ADM sessions.
During concurrent usecase when one session is closed,
it closes other ADM session associated with other usecase
too. Dai_link->id should always point to Frontend dai id.
Set cpu_dai id as dai_link id to fix the issue.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index eb1b9da05dd4..4715527054e5 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -13,6 +13,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	struct device_node *cpu = NULL;
 	struct device *dev = card->dev;
 	struct snd_soc_dai_link *link;
+	struct of_phandle_args args;
 	int ret, num_links;
 
 	ret = snd_soc_of_parse_card_name(card, "model");
@@ -47,12 +48,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
-		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-		if (!link->cpu_of_node) {
+		ret = of_parse_phandle_with_args(cpu, "sound-dai",
+					"#sound-dai-cells", 0, &args);
+		if (ret) {
 			dev_err(card->dev, "error getting cpu phandle\n");
-			ret = -EINVAL;
 			goto err;
 		}
+		link->cpu_of_node = args.np;
+		link->id = args.args[0];
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
 		if (ret) {
-- 
2.17.1

