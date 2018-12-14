Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A4C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C554021479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789051;
	bh=BGf8r2ELi+gVM6Jjwi9TSeywR+iQggwnTBvUN9jICSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V1+4jtxKKIlCNPDj1gVTm23gW4IXEtLvUI6BIG5N9Z8T+ISdYmm9Krs/pwO8WWBjO
	 YY2253k44d9LkHajJyPDiCRB5XHbGuuNHJTEmF2YlSBum2RmqMsJ+7pas5rLFwSnUU
	 WbuDjF3dGgKoBoG5izvRQlfxGaFDKWtYLfXZ94Ac=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C554021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbeLNMEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbeLNMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C362146F;
        Fri, 14 Dec 2018 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789047;
        bh=BGf8r2ELi+gVM6Jjwi9TSeywR+iQggwnTBvUN9jICSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXp2WJxQxcEsCIHQ7brIPu5x+0yChFJcvZ9CtuRsf39LrAVlNpRnCEeYZCjCekIQM
         AU63rE1HLQhKokNpFfwP6fKtJi7RXync1DKJCTVoOs84W/SQ3ppuUB44ONYEgshj7A
         YWuyluuNu3k0D5jjKW4l/UgKODZhU6k/p5kvyW14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 051/142] ASoC: qcom: Set dai_link id to each dai_link
Date:   Fri, 14 Dec 2018 12:58:56 +0100
Message-Id: <20181214115749.102220471@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



