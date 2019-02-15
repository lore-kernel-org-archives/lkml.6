Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AAD2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198498;
	bh=vgAZTghB/jhMIJxUcevslnE0uTi2u6sWioi6BD5T28M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v0NfqLS2Noy3eWIylr6d3BDYNedCqqadgi6NoudKr/kSDDD9Hb7byp82KRE7vbj3w
	 3NYIfuk3evIBYLCNlGGs29CqVqkB7EsmzN2PCCE/r4eMMm/mD+Zx4pc4qvGWcr2HQr
	 6yvBbp3fQytSAZduFq+ZgnS16BSQPWpKi5MgP2lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfBOClh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388279AbfBOCJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4BC206BA;
        Fri, 15 Feb 2019 02:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196575;
        bh=vgAZTghB/jhMIJxUcevslnE0uTi2u6sWioi6BD5T28M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tm8aa5sMtnnHhS5oD82YzNhWhkGRsSyl/VI2rYUgyQ9vLjAFJ7Fw0teHNNieK7Nas
         wqOVcBX84KKLp9/xVcOFoGvp6EEYXUH9PjvHcOhafmJ8+jJQTQRqWvBKLQRAdWvLwF
         4EiIek1aF7c5u4yllJQELX0J7j3Fsf5XyYnh5LCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 22/77] ASoC: core: Don't defer probe on optional, NULL components
Date:   Thu, 14 Feb 2019 21:08:00 -0500
Message-Id: <20190215020855.176727-22-sashal@kernel.org>
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

From: Matthias Reichl <hias@horus.com>

[ Upstream commit 2833548ecbb385a289124077ab4d812258a867d5 ]

cpu and platform are optional components in DAI links. For example
codec-codec links usually have no platform set.

Call snd_soc_find_component only if the name or of_node of
a cpu or platform is set. Otherwise it will return NULL and
soc_init_dai_link bails out immediately with -EPROBE_DEFER,
meaning registering a card with NULL cpu or platform in DAI links
can never succeed.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e4da6656f65f..0324729001e5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1135,7 +1135,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if platform dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->platform->of_node, link->platform->name))
+	if ((link->platform->of_node || link->platform->name) &&
+	    !soc_find_component(link->platform->of_node, link->platform->name))
 		return -EPROBE_DEFER;
 
 	/*
@@ -1154,7 +1155,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if cpu dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+	if ((link->cpu_of_node || link->cpu_name) &&
+	    !soc_find_component(link->cpu_of_node, link->cpu_name))
 		return -EPROBE_DEFER;
 
 	/*
-- 
2.19.1

