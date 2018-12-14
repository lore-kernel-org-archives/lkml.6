Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA1BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDF82146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788980;
	bh=VqVv3MVaWZ1EnqKzV1T5aPIyQlZ2MAK2hr/7w9JfD1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIDEtdU46RU45699y2LxdFKmJ9o8K//UkUesXLthFz3NqPEzJyjP3WPu/V9X5rbjr
	 3XrQjWTEGN9Vi3IierA9OZGgAVUpqCIf1voDQfWdCd48Ax/zs4b3SP4lm8UQWAySmM
	 5jmdUUcsO1IJg9XvinaNUYh1BTwTMEimQ4jqzBMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDF82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbeLNMC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730174AbeLNMC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30BC2146F;
        Fri, 14 Dec 2018 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788976;
        bh=VqVv3MVaWZ1EnqKzV1T5aPIyQlZ2MAK2hr/7w9JfD1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqiWAH6wVjZgx/ytRelv+jykSI0eWOSpeeixu5Ra/y8gS6nBttto/YXRQ9YW3ivDj
         27wStgZDtdPYjjL7Wk9GaHDQbsvMFy1QUNW4QxEY1F7GL1DTNLea+8M2eQNcxQQcdp
         Df7e+dpM1soYf1Xwp30V1olyeJPZpEuOKnojDgG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 023/142] ASoC: rsnd: fixup clock start checker
Date:   Fri, 14 Dec 2018 12:58:28 +0100
Message-Id: <20181214115747.986058299@linuxfoundation.org>
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
2.19.1



