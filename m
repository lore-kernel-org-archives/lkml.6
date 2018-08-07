Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE2C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BDB21524
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EV47RCaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BDB21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbeHGTfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:35:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46399 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389148AbeHGTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:35:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so8884467pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a59LxUcKC10cZBrNB2xPj0F/GHLzuHlp566+Njh0szk=;
        b=EV47RCaweQuxINNb7MRhJ5pa7YNcaWIFE29gwVR3bMozB1OQBn2EAulpg1zllDXmn/
         8vDLfby1ckSO8z69IM/GBn0NxpBlimmIgFHnJ7nfJOLknsaxh9gghWSwew/APKDKonA4
         IuFSx4RXBke/T6oNEMlMk8nncr9weyTyxKT5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a59LxUcKC10cZBrNB2xPj0F/GHLzuHlp566+Njh0szk=;
        b=L9ar8mpQjEwlCZmX+7NasVGearzg77DsyO8HYVzKphwmXdo6Gnncaf7SftFVWld4lK
         jLZm1JwLGsAr/uWHEScOnuYXTmPtFgTbpf56b17Wwu7SfxuH9JEro80YhoBuu9ip/NMg
         0mQoWNyNvjxrwRsYFH41Bl0D9D0f+FvCnJAT9ZNXn2234ffQ7YkrqNEO0+mcsT/50P5k
         xepUV+sBHHrcKiRWIvV9bf3mlw7+DvxPXQb+hyNoSK8+yKHx4WfvtFFdqX9pq4lZ8rUc
         sj9VFKB1HhIONFgQX7Fgh0nQOZ1zK1ZP+f1KTEkrH7BQK9dwuP6MM5EbbLpDYRDz8a7A
         XZgw==
X-Gm-Message-State: AOUpUlF/CdYH6zv3JzhIS67e6EB8Cp+df3+ibN89VDGnQWIXCQSZUkNp
        yGS2y+FtBDBm73weMZvktqAIfA==
X-Google-Smtp-Source: AAOMgpceAFxUt1iwwZYl65waOMrEROVWXSDwExVEp2XG0f1pVxf2hBfb+LFbU6U3CNtUymOTbuBWLQ==
X-Received: by 2002:a63:d10c:: with SMTP id k12-v6mr19853890pgg.49.1533662390263;
        Tue, 07 Aug 2018 10:19:50 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 16-v6sm3398059pfp.6.2018.08.07.10.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:19:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] ASoC: rt5677: Fix initialization of rt5677_of_match.data
Date:   Tue,  7 Aug 2018 10:19:40 -0700
Message-Id: <20180807171940.150507-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver expects to find the device id in rt5677_of_match.data, however
it is currently assigned to rt5677_of_match.type. Fix this.

The problem was found with the help of clang:
  sound/soc/codecs/rt5677.c:5010:36: warning: expression which evaluates to
  zero treated as a null pointer constant of type 'const void *'
  [-Wnon-literal-null-conversion]
    { .compatible = "realtek,rt5677", RT5677 },
                                      ^~~~~~

Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module sources")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
Changes in v2:
- assign device id to data instead of 'type'
- updated subject and commit message
- added: 'Fixes' tag
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8a0181a2db08..47feef30dadb 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
 };
 
 static const struct of_device_id rt5677_of_match[] = {
-	{ .compatible = "realtek,rt5677", RT5677 },
+	{ .compatible = "realtek,rt5677", .data = (const void *)RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
-- 
2.18.0.597.ga71716f1ad-goog

