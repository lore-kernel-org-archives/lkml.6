Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435A52192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198516;
	bh=sMaUNYBVvOww3Zn8HmhRH0yapZu8yW9SqNRyjKrtgSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hPg1sbZIJC657w/RMlJms63E8pxxqpddiPEsB2oSm/PH4ykI+2l9MO9DCuz2TR3RY
	 4o//TqCFT8z3vq42F6RU2LMHnGG/5T47uGAUf0Gf1AnWmCuvhwmnV5JYBwWmUWq0Kj
	 qyO4QYsKE9YeW/MuVAqFnmN29tuM4u3uDH/ZJFA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbfBOCJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731765AbfBOCJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C508E2229F;
        Fri, 15 Feb 2019 02:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196568;
        bh=sMaUNYBVvOww3Zn8HmhRH0yapZu8yW9SqNRyjKrtgSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JctNL4Srhcqw4EoK2b2SbbYUvIhdCO3MkxwE7GpwibfGRx0Qbk9aTJI+TfbstzW9A
         M9q075XdtDJbxKtNWy2L6DKwD9Ktvg7Zl8sNiNJt+rUTIxXJl0SYIldmi1pJeKj51N
         GE1Mgh5bp3db057GkBaslJS+eejJCuRlIq7MYqa8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Curtis Malainey <cujomalainey@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 16/77] ASoC: soc-core: fix init platform memory handling
Date:   Thu, 14 Feb 2019 21:07:54 -0500
Message-Id: <20190215020855.176727-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Curtis Malainey <cujomalainey@chromium.org>

[ Upstream commit 09ac6a817bd687e7f5dac00470262efdd72f9319 ]

snd_soc_init_platform initializes pointers to snd_soc_dai_link which is
statically allocated and it does this by devm_kzalloc. In the event of
an EPROBE_DEFER the memory will be freed and the pointers are left
dangling. snd_soc_init_platform sees the dangling pointers and assumes
they are pointing to initialized memory and does not reallocate them on
the second probe attempt which results in a use after free bug since
devm has freed the memory from the first probe attempt.

Since the intention for snd_soc_dai_link->platform is that it can be set
statically by the machine driver we need to respect the pointer in the
event we did not set it but still catch dangling pointers. The solution
is to add a flag to track whether the pointer was dynamically allocated
or not.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc.h  |  6 ++++++
 sound/soc/soc-core.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3e0ac310a3df..e721082c84a3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -985,6 +985,12 @@ struct snd_soc_dai_link {
 	/* Do not create a PCM for this DAI link (Backend link) */
 	unsigned int ignore:1;
 
+	/*
+	 * This driver uses legacy platform naming. Set by the core, machine
+	 * drivers should not modify this value.
+	 */
+	unsigned int legacy_platform:1;
+
 	struct list_head list; /* DAI link list of the soc card */
 	struct snd_soc_dobj dobj; /* For topology */
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0b91d8fc6ca2..17632da21ba7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1034,17 +1034,18 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	 * this function should be removed in the future
 	 */
 	/* convert Legacy platform link */
-	if (!platform) {
+	if (!platform || dai_link->legacy_platform) {
 		platform = devm_kzalloc(card->dev,
 				sizeof(struct snd_soc_dai_link_component),
 				GFP_KERNEL);
 		if (!platform)
 			return -ENOMEM;
 
-		dai_link->platform	= platform;
-		platform->name		= dai_link->platform_name;
-		platform->of_node	= dai_link->platform_of_node;
-		platform->dai_name	= NULL;
+		dai_link->platform	  = platform;
+		dai_link->legacy_platform = 1;
+		platform->name		  = dai_link->platform_name;
+		platform->of_node	  = dai_link->platform_of_node;
+		platform->dai_name	  = NULL;
 	}
 
 	/* if there's no platform we match on the empty platform */
-- 
2.19.1

