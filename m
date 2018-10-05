Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D1CC65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122A2214AB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDiSHOue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122A2214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbeJEXQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbeJEXQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A24208E7;
        Fri,  5 Oct 2018 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756201;
        bh=3zX0Y7IkgNFWc2h3WbDbShE824yDiXBXOTi814FJI1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDiSHOueG8LycRL0UDPHl2xEq3wtSTi7wamRhOmcJvHeyyA4+t8EkMAJtmreKNdmZ
         zhADBZooeNpUcVa1mv/r9NbE7NL6g23VaIRPNQmGS3ZFZFAtaf9dIA1ygpz10SCMgr
         RSEaucmN9Ra2PldISKKnKTknqQHAej7ZTdXTAeR0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 06/23] ASoC: rsnd: adg: care clock-frequency size
Date:   Fri,  5 Oct 2018 12:16:17 -0400
Message-Id: <20181005161634.20631-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161634.20631-1-sashal@kernel.org>
References: <20181005161634.20631-1-sashal@kernel.org>
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
index e28edb1f7263..eb7879bcc6a7 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -467,6 +467,11 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
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

