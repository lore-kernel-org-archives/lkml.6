Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D98D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="A9cImrBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfBKGuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:50:13 -0500
Received: from host.euro-space.net ([87.117.239.2]:33543 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKGuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:50:13 -0500
X-Greylist: delayed 2638 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 01:50:12 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TIZQT3bwdAXw37qkVf0LlRxUXbQzzIx23lY3MwciOJQ=; b=A9cImrBL7muVl+cOQxt7jwcmBN
        ekM6IiyYB5Zh7bekQ/2uCUovQmIraHkJtmt21stfyrS7PvahDz5AJfjozLHDxoQfE/Pd99OSX7Uya
        RZy/IBCJKrrkGbfMKdIfuSRPKYHm0jkOJJtW34DpeBK8PJLX6QyYmZ0zGrDn+PuA6L0MlansnLy7q
        axmr4kt4EG1dqCBJFNseeJGMp+yPiya8OukqeB1LRo4Ryqxe3NWHNVe4R1zbEhWIXZPfBud3NmhSh
        CX+GDtRSthziaYEQVmVFlZNk0IHYMo2bPPLnGXe/wjAzY1JWUfaJL3UEVfZeSiyQyumA+JKvwJcsj
        50nt/Eng==;
Received: from x4d03a3f8.dyn.telefonica.de ([77.3.163.248]:51990 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gt4jN-0005JU-46; Mon, 11 Feb 2019 06:06:13 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 1/2] ASoC: pcm3060: Add soft reset on probe
Date:   Mon, 11 Feb 2019 07:08:38 +0100
Message-Id: <20190211060839.21417-1-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Softly reset registers values on module probe

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 6714aa8d9026..543cb86fd764 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -287,6 +287,14 @@ int pcm3060_probe(struct device *dev)
 	int rc;
 	struct pcm3060_priv *priv = dev_get_drvdata(dev);
 
+	/* soft reset */
+	rc = regmap_update_bits(priv->regmap, PCM3060_REG64,
+				PCM3060_REG_MRST, 0);
+	if (rc) {
+		dev_err(dev, "failed to reset component, rc=%d\n", rc);
+		return rc;
+	}
+
 	if (dev->of_node)
 		pcm3060_parse_dt(dev->of_node, priv);
 
-- 
2.13.6

