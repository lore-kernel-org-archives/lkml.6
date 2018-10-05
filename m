Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F3214C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRzmZtgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3F3214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeJEXOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeJEXOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4531D213A2;
        Fri,  5 Oct 2018 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756077;
        bh=x1aSC0lNDaRPPQdsC44OK7b7BmBY74Cb1cHh8IOEesQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRzmZtgK6SdEy0P1Kw6FQ2vDUN3k461KvgoXN9tWD32Gm198ODuLm/eY4tw7g3moN
         aGivBU1MYZct5J23Iqufq5wXMpFDUBDcSHJFn6Ii8iXbVZClVyLPV2Bvj/AURlC3k1
         z++CSEtc12Adrb1hQlh+BICkoBuXOv04Bs9LdaYs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 13/48] ASoC: rsnd: adg: care clock-frequency size
Date:   Fri,  5 Oct 2018 12:13:49 -0400
Message-Id: <20181005161424.20521-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 69235ccf491d2e26aefd465c0d3ccd1e3b2a9a9c ]

ADG has buffer over flow bug if DT has more than 3 clock-frequency.
This patch fixup this issue, and uses first 2 values.

	clock-frequency = <x y>;	/* this is OK */
	clock-frequency = <x y z>;	/* this is NG */

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/sh/rcar/adg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 4672688cac32..b7c1f34ec280 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -465,6 +465,11 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 		goto rsnd_adg_get_clkout_end;
 
 	req_size = prop->length / sizeof(u32);
+	if (req_size > REQ_SIZE) {
+		dev_err(dev,
+			"too many clock-frequency, use top %d\n", REQ_SIZE);
+		req_size = REQ_SIZE;
+	}
 
 	of_property_read_u32_array(np, "clock-frequency", req_rate, req_size);
 	req_48kHz_rate = 0;
-- 
2.17.1

