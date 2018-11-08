Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0C3ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539A2089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9RleS31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9539A2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeKIHe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbeKIHeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:25 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A7920892;
        Thu,  8 Nov 2018 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714217;
        bh=XAlvau8UTBKwxeJWYlKCEChu5CWvK+6T/IMc2GVeNKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9RleS31wwpr/wkHH4jrTIiMC3hCzEbFc6BrtCHBpDKBI0wKmjaChyqySZu+WwE/3
         Uv1abtO7Pr507zci+k2dIMrMdl/uuz1vG+Cihb+ukpUUVEGjAJ26QUBJTC3JAK4+EE
         1easxVVve1p0dWn5E0XiPYUanHPtG3wLQMjjbiQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 101/144] ASoC: dapm: Dont add prefix to widget stream name
Date:   Thu,  8 Nov 2018 13:51:12 -0800
Message-Id: <20181108215105.054215866@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



