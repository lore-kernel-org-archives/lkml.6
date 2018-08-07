Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA0C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E772192C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4nFATo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E772192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbeHGShv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:37:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45361 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbeHGShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:37:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so7310815pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ld+jKIMWSrU+bYVYA8Qq6rH31LQg01ROPMJMQLB33M=;
        b=m4nFATo446urwNwA63YL5uv1YONRJac7OzdLDghVu5YQ2B1Xzsz2E9rrThXUv5z8W0
         AQLohnP4E96LRRaTgYWuj1ImuPFTS63d6RbFBgLZM4yTEVi5U7uzqfhQOv4uFvrHVXrH
         mAFvREsABbg0566+UiTdulPOAjcRIFoeuBdug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ld+jKIMWSrU+bYVYA8Qq6rH31LQg01ROPMJMQLB33M=;
        b=ccTXZiX+kJPvqrVQ64nXIe997mukKbiD1IvMrTK4MQcD+Yo//bRaMh9Mv9vrn9YetR
         UN2dyd/d0tzrfqkRyqIiEhkT1h7rPbnmXZAw2VuX11Iy1g7s/Xpe1Ufa09UhZq+OVj/9
         saacBt1WAOr0MyzQTh4cX5teueuF4IzE0283FbFbO0TbphJkyYra0sRWFjfTOSK8MS8E
         julAxFhpip/5QMeL3vWLO5TO8e1blZI9e2jxg8dvy/piIMz3Vd/z/idUUKd9yBgh0DlW
         49GuIl/TJiTbOt7VgcFxX+fD5MGGkmueUPa4EChCXA7n8pf6UH3xUWFSJHo1zOJ9xIbE
         LXCw==
X-Gm-Message-State: AOUpUlFG5SB+6ptX8XMhNtDsZ6tNnpuK2IAfGzZXXhPhdiwnyStdvegr
        HxKO0ktLSiz/PNhNo6sPxyspUg==
X-Google-Smtp-Source: AAOMgpeHRlWG1XKRWUnQdv3jLWnuQWJHJG6um2FVJBy/xlBp1XhXyoPOD8BMrdIfhARvVW5DuP4AHA==
X-Received: by 2002:a17:902:5a4c:: with SMTP id f12-v6mr18545548plm.253.1533658968030;
        Tue, 07 Aug 2018 09:22:48 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f75-v6sm8429006pfk.85.2018.08.07.09.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 09:22:47 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ASoC: rt5677: Remove bogus device id from rt5677_of_match
Date:   Tue,  7 Aug 2018 09:22:34 -0700
Message-Id: <20180807162234.205212-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initializer of rt5677_of_match contains a bogus device id
(enum type) for the 'type' field (char []). Remove it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8a0181a2db08..7dab53b35cbf 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
 };
 
 static const struct of_device_id rt5677_of_match[] = {
-	{ .compatible = "realtek,rt5677", RT5677 },
+	{ .compatible = "realtek,rt5677", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
-- 
2.18.0.597.ga71716f1ad-goog

