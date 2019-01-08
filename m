Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D08C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2765720883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gCKIcJRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfAHR2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:28:30 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3288 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfAHR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:28:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c34ddae0001>; Tue, 08 Jan 2019 09:28:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Jan 2019 09:28:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Jan 2019 09:28:27 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Jan
 2019 17:28:26 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Jan 2019 17:28:26 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c34ddb90000>; Tue, 08 Jan 2019 09:28:26 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Matthias Reichl <hias@horus.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ASoC: core: Fix deferral of machine drivers
Date:   Tue, 8 Jan 2019 17:28:14 +0000
Message-ID: <1546968494-22993-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546968494; bh=gYTYJBESlX59KQBKhfMQ6Axa0wNX4GBYoD0QfJ0d+hk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=gCKIcJRdq5ekjo7ayGeo6i7G7OCK/KjqrwJStTFRMviVoOYeLG6eQSf4q8cZrEj6F
         y/IAnGoYa+dwk0lH/lQfWFVYNk06KIIQnFlyPdC7Ja3I6Zv8qd2Nv7+yqK0AXgTH6g
         /bkIjfIiO02q6cTyj623jfiVqbA7kGlJxCfJwzaOd1CPXeDhiQVizkHK3RA8efUfAs
         jl0nOLQjVY/s5lJ6ty7MJsOazBc8nOYiywuqaxYoBS25DJz/8Nw0KrnooBJGvZ53B6
         RUUItVbf2yacuhXFLFXdi/v55pNw6VLzdtLpnOO4IKHtA+N2oGv55OvD2AeJ3vHFoU
         7rb8XyrvVp2WA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for
platform") added a new member to the snd_soc_dai_link structure for
storing a pointer for a platform link component. The pointer for this
platform link component was allocated, if not already populated by the
machine driver, using devm_kzalloc() such that the memory would be
automatically freed on error or removal of the soundcard. However, this
introduced a new problem, because if the probing of the soundcard is
deferred, then although the memory allocated for the platform link
component is freed, if the snd_soc_dai_link structure is declared
statically by the machine driver, then the pointer in the DAI link
structure will never be clearer. This means that when the soundcard is
probed again, memory for the platform link component will not be
allocated again because the address of the pointer was not cleared
and this causes sound core to access memory that is no longer valid.

In most cases this causes the following error condition to be triggered
and causes probing the soundcard to fail.

 tegra-snd-sgtl5000 sound: ASoC: Both platform name/of_node are set for
  sgtl5000

Unfortunately, because this platform link component is allocated before
the DAI links are added to the soundcard, there is no easy way to clear
this pointer on teardown if an error occurs.

The pointer for this platform link component was added for future
proofing and communalising the structures for storing various data.
Although a machine driver maybe used by more than one platform and so
this platform data may vary from platform to platform, there is only
ever a single instance for a given platform. Therefore, rather than
dynamically allocate the platform link component structure, make it a
static member of the snd_soc_dai_link to fix the problem.

It should be noted that if the platform_name of platform_of_node members
of the snd_soc_dai_link structure are populated, these will always be
used regardless of if the new platform.name or platform.of_node members
are populated.

Fixes: daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for platform")

Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 include/sound/simple_card_utils.h     |  2 +-
 include/sound/soc.h                   |  2 +-
 sound/soc/generic/audio-graph-card.c  |  4 +++-
 sound/soc/generic/simple-card-utils.c |  4 ++--
 sound/soc/generic/simple-card.c       |  6 ++++--
 sound/soc/soc-core.c                  | 18 +++++++-----------
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 6d69ed2bd7b1..6d5842c3c09f 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -75,7 +75,7 @@ void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 				   &dai_link->codec_dai_name,			\
 				   list_name, cells_name, NULL)
 #define asoc_simple_card_parse_platform(node, dai_link, list_name, cells_name)	\
-	asoc_simple_card_parse_dai(node, dai_link->platform,					\
+	asoc_simple_card_parse_dai(node, &dai_link->platform,			\
 		&dai_link->platform_of_node,					\
 		NULL, list_name, cells_name, NULL)
 int asoc_simple_card_parse_dai(struct device_node *node,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec1de856ee7..8b7ffc60006a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -925,7 +925,7 @@ struct snd_soc_dai_link {
 	 */
 	const char *platform_name;
 	struct device_node *platform_of_node;
-	struct snd_soc_dai_link_component *platform;
+	struct snd_soc_dai_link_component platform;
 
 	int id;	/* optional ID for machine driver link identification */
 
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 3ec96cdc683b..e961d45ce141 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -687,7 +687,9 @@ static int graph_probe(struct platform_device *pdev)
 	for (i = 0; i < li.link; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
-		dai_link[i].platform	= &dai_props[i].platform;
+		dai_link[i].platform.name = dai_props[i].platform.name;
+		dai_link[i].platform.of_node = dai_props[i].platform.of_node;
+		dai_link[i].platform.dai_name = dai_props[i].platform.dai_name;
 	}
 
 	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 336895f7fd1e..74910c7841ec 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -397,8 +397,8 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
 int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
-	if (!dai_link->platform->of_node)
-		dai_link->platform->of_node = dai_link->cpu_of_node;
+	if (!dai_link->platform.of_node)
+		dai_link->platform.of_node = dai_link->cpu_of_node;
 
 	return 0;
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 479de236e694..b6402e09bba2 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -732,7 +732,9 @@ static int simple_probe(struct platform_device *pdev)
 	for (i = 0; i < li.link; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
-		dai_link[i].platform	= &dai_props[i].platform;
+		dai_link[i].platform.name = dai_props[i].platform.name;
+		dai_link[i].platform.of_node = dai_props[i].platform.of_node;
+		dai_link[i].platform.dai_name = dai_props[i].platform.dai_name;
 	}
 
 	priv->dai_props		= dai_props;
@@ -782,7 +784,7 @@ static int simple_probe(struct platform_device *pdev)
 		codecs->name		= cinfo->codec;
 		codecs->dai_name	= cinfo->codec_dai.name;
 
-		platform		= dai_link->platform;
+		platform		= &dai_link->platform;
 		platform->name		= cinfo->platform;
 
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..466099995e44 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -915,7 +915,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	/* find one from the set of registered platforms */
 	for_each_component(component) {
-		if (!snd_soc_is_matching_component(dai_link->platform,
+		if (!snd_soc_is_matching_component(&dai_link->platform,
 						   component))
 			continue;
 
@@ -1026,7 +1026,7 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
-	struct snd_soc_dai_link_component *platform = dai_link->platform;
+	struct snd_soc_dai_link_component *platform = &dai_link->platform;
 
 	/*
 	 * FIXME
@@ -1034,14 +1034,10 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	 * this function should be removed in the future
 	 */
 	/* convert Legacy platform link */
-	if (!platform) {
-		platform = devm_kzalloc(card->dev,
-				sizeof(struct snd_soc_dai_link_component),
-				GFP_KERNEL);
-		if (!platform)
-			return -ENOMEM;
+	if (dai_link->platform_name || dai_link->platform_of_node) {
+		dev_dbg(card->dev,
+			"ASoC: Defaulting to legacy platform data!\n");
 
-		dai_link->platform	= platform;
 		platform->name		= dai_link->platform_name;
 		platform->of_node	= dai_link->platform_of_node;
 		platform->dai_name	= NULL;
@@ -1123,7 +1119,7 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Platform may be specified by either name or OF node, but
 	 * can be left unspecified, and a dummy platform will be used.
 	 */
-	if (link->platform->name && link->platform->of_node) {
+	if (link->platform.name && link->platform.of_node) {
 		dev_err(card->dev,
 			"ASoC: Both platform name/of_node are set for %s\n",
 			link->name);
@@ -1921,7 +1917,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 				dev_err(card->dev, "init platform error");
 				continue;
 			}
-			dai_link->platform->name = component->name;
+			dai_link->platform.name = component->name;
 
 			/* convert non BE into BE */
 			dai_link->no_pcm = 1;
-- 
2.7.4

