Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54A2C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802DB20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOYt8oGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802DB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeLEKOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:14:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbeLEJgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:13 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5DC20879;
        Wed,  5 Dec 2018 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002572;
        bh=LyzNZm8xssXwgpVwTq3u0L9AzwzCPWzrD+VCS14zSAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOYt8oGwRlO6IfM1d4sdLtzq7Ft9j9ED/Ovb64Pef9CCzU7ChsDTDvnrN5AsAvOz3
         0ZxImhKQH9WOF6NER4Ybc3Hl4LgkQRBEgSnLrg7AJo2kBIo71eQCYd+PCjHn09Cu7h
         W3TwRe4HV6UjQRCj9OULncIPglGoGyA/mqVW2Afo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 003/123] ASoC: rsnd: fixup clock start checker
Date:   Wed,  5 Dec 2018 04:33:55 -0500
Message-Id: <20181205093555.5386-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 3ee9a76a8c5a10e1bfb04b81db767c6d562ddaf3 ]

commit 4d230d12710646 ("ASoC: rsnd: fixup not to call clk_get/set under
non-atomic") fixuped clock start timing. But it exchanged clock start
checker from ssi->usrcnt to ssi->rate.

Current rsnd_ssi_master_clk_start() is called from .prepare,
but some player (for example GStreamer) might calls it many times.
In such case, the checker might returns error even though it was not
error. It should check ssi->usrcnt instead of ssi->rate.
This patch fixup it. Without this patch, GStreamer can't switch
48kHz / 44.1kHz.

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3f880ec66459..a566dae3ec8a 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -283,7 +283,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	if (ssi->rate) {
+	if (ssi->usrcnt > 1) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
 			return -EINVAL;
-- 
2.17.1

