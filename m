Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4DEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA26208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hk7OtWIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA26208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbeFQNpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 09:45:35 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47028 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754339AbeFQNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 09:45:34 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7852E5C00F6;
        Sun, 17 Jun 2018 15:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529243133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=sk6Fbjh5a8Kv6MrDZ2eC/sOiWjq3V+FEVhVk2bKQvfU=;
        b=hk7OtWIBqL6awwP8n4MtzdptR3W+mEBJa8lVhJ2XxXiXEGKAjEPYQgeMRnTs3JBGzWHQWE
        GmsRjGjmSPxiYdofAvqXVLGJDgDGd8AUKMIxPWhWiuPvqlPkL6X+NffKPEpb696Bj/grXE
        1+UZjGKP6IgsTzFRqHe8ATAHQEE1jc8=
From:   Stefan Agner <stefan@agner.ch>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stefan Agner <stefan@agner.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: PCM1789: unconditionally flush work
Date:   Sun, 17 Jun 2018 15:45:29 +0200
Message-Id: <20180617134532.1070-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work is guaranteed to be initialized on exit. Drop the unnecessary
if statement and always call flush_work.

This fixes a warning seen with clang:
sound/soc/codecs/pcm1789.c:265:13: warning: address of 'priv->work' will
      always evaluate to 'true' [-Wpointer-bool-conversion]
        if (&priv->work)
        ~~   ~~~~~~^~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/codecs/pcm1789.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm1789.c b/sound/soc/codecs/pcm1789.c
index 21f15219b3ad..8df6447c76a6 100644
--- a/sound/soc/codecs/pcm1789.c
+++ b/sound/soc/codecs/pcm1789.c
@@ -262,8 +262,7 @@ int pcm1789_common_exit(struct device *dev)
 {
 	struct pcm1789_private *priv = dev_get_drvdata(dev);
 
-	if (&priv->work)
-		flush_work(&priv->work);
+	flush_work(&priv->work);
 
 	return 0;
 }
-- 
2.17.1

