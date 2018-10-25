Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55037ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F35620883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G08Rp2mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F35620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeJYWxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbeJYWxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:41 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D2920873;
        Thu, 25 Oct 2018 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477244;
        bh=CIHqw0/4NBhvW71AY1KjYce+F6Lcb50bkkVc5qPfFZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G08Rp2mwG+K6s/fqmx4xkXTDbY3Y/aCvfs6GvOcNwRs0YhT5juPMhReNqvdKGBSyJ
         goBpG3Um4du3v3Jc4pj+UwjWh2UT/e3U3jxDEwHabTnKiOjfcVwz2z+IfrugutncAz
         KBX81WM3q3y7HMa6GwcudgtwARsICJpmnzZNBEd0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 72/98] ASoC: dapm: Don't add prefix to widget stream name
Date:   Thu, 25 Oct 2018 10:18:27 -0400
Message-Id: <20181025141853.214051-72-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit a798c24a69b64f09e2d323ac8155a36373e5d5fd ]

Commit fdb6eb0a1287 ("ASoC: dapm: Modify widget stream name according to
prefix") fixed the case where a DAPM route between a DAI widget and a
DAC/ADC/AIF widget with a matching stream name was not created when the
DAPM context was using a prefix.

Unfortunately the patch introduced a few issues on its own like leaking the
dynamically allocated stream name memory and also not checking whether the
allocation succeeded in the first place.

It is also incomplete in that it still does not handle the case where
stream name of the widget is a substring of the stream name of the DAI,
which is explicitly allowed and works fine if no DAPM prefix is used.

Revert the commit and take a slightly different approach to solving the
issue. Instead of comparing the widget's stream name to the name of the DAI
widget compare it to the stream name of the DAI widget. The stream name of
the DAI widget is identical to the name of the DAI widget except that it
wont have the DAPM prefix added. So this approach behaves identical
regardless to whether the DAPM context uses a prefix or not.

We don't have to worry about potentially matching with a widget with the
same stream name, but from a different DAPM context with a different
prefix, since the code already makes sure that both the DAI widget and the
matched widget are from the same DAPM context.

Fixes: fdb6eb0a1287 ("ASoC: dapm: Modify widget stream name according to prefix")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dapm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d8ac9e5e2c00..d15c34e2f04f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3087,16 +3087,10 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	}
 
 	prefix = soc_dapm_prefix(dapm);
-	if (prefix) {
+	if (prefix)
 		w->name = kasprintf(GFP_KERNEL, "%s %s", prefix, widget->name);
-		if (widget->sname)
-			w->sname = kasprintf(GFP_KERNEL, "%s %s", prefix,
-					     widget->sname);
-	} else {
+	else
 		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
-		if (widget->sname)
-			w->sname = kasprintf(GFP_KERNEL, "%s", widget->sname);
-	}
 	if (w->name == NULL) {
 		kfree(w);
 		return NULL;
@@ -3422,7 +3416,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 				break;
 			}
 
-			if (!w->sname || !strstr(w->sname, dai_w->name))
+			if (!w->sname || !strstr(w->sname, dai_w->sname))
 				continue;
 
 			if (dai_w->id == snd_soc_dapm_dai_in) {
-- 
2.17.1

