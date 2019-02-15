Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B82C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A4F2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198572;
	bh=mCLY9l9vTMsa1CECzFczBaVueKplL14xfsMm0i6+fQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wy0EP01LlRWa/qrAQjaa6X3VNFjpLJIIcjIQIDqiXaJqoXdB6J2jsfEHjkRUpUSNd
	 t2hyHAhsar0vcZHKfaXRO04SIUb+K0uVs4zQJ49ICKL+VoxQqekw3k39xjjbiHYGO6
	 EC/VLTgHJxtLVJv9M9mRL7Rp/ILa3/mgpObBYM/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfBOCmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731545AbfBOCJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6C5206BA;
        Fri, 15 Feb 2019 02:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196550;
        bh=mCLY9l9vTMsa1CECzFczBaVueKplL14xfsMm0i6+fQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3lr1m6DUplcduEP6ZtEc2tviItyHMzpjN9gf4WCcRX7vEGVQ9MMdxIqLdl/7cha9
         3ouC52nmmoHF6FZRxKZ4iOltJJ+ondvr1mMMZ8In35u2Ao2uyXH79WmUAWJY3P6rtP
         vPoGwAZZibk5xjGFU6ic8oMhedulN2AhWkdHROxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 10/77] ASoC: soc-core: Hold client_mutex around soc_init_dai_link()
Date:   Thu, 14 Feb 2019 21:07:48 -0500
Message-Id: <20190215020855.176727-10-sashal@kernel.org>
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

From: Rohit kumar <rohitkr@codeaurora.org>

[ Upstream commit 04eb1efcd614d6f067b76a355b3a3599667959dc ]

soc_init_dai_link() calls soc_find_component() which needs
to be within client_mutex lock. Add client_mutex lock around
soc_init_dai_link() in snd_soc_register_card() to avoid
lockdep warning.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 74b12f90ea9b..0b91d8fc6ca2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,6 +1027,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
+
 	/*
 	 * FIXME
 	 *
@@ -2754,15 +2755,18 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	mutex_lock(&client_mutex);
 	for_each_card_prelinks(card, i, link) {
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
+			mutex_unlock(&client_mutex);
 			return ret;
 		}
 	}
+	mutex_unlock(&client_mutex);
 
 	dev_set_drvdata(card->dev, card);
 
-- 
2.19.1

