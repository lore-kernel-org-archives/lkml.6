Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EBAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AB220659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uRTImr8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AB220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeH2S6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:58:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45270 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbeH2S6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:58:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so5128174wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1iTITd8wu1i/nqjU4QXnYmssrJxOfTvKFR6PIlAfM7c=;
        b=uRTImr8kvY8tGl2GkW8zwtCMDJLdcRiq3CVAevlm98C8uhYt4czPWoccF6o8tbP7Fv
         1nmmvuVqEf5cYHXM1nqJdEc7aANOoDXG/aaEDjyM3GT83+MAILYLw/H1MVdvXzVIC0nt
         a6EW65r9auE6VSp21gksBJshXITPr6t4PuLRQYsMBFA8UHtnDB84vzlPCfSh0T2RSyOE
         R692qNP9+m5zMxh0b5BmxSJofCBNy0OAvy5drSQT9mhNVb2T0sye9SXora9gpngheSQC
         uDDySCXeJv7tWY1EtPTABg3Eo+teM0GVNo2CXW4UklvC2xY0C4xWMkHLZ6SJXy51Dutb
         3kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1iTITd8wu1i/nqjU4QXnYmssrJxOfTvKFR6PIlAfM7c=;
        b=X9ZqMvipnmhj8FUAqvb3z8VD2iDGwoypHEpjsSSmDSYcCoELd0MbAYJdp4ZrFzZU9r
         Cc89Z4KPp8bKQSAINQwTXC2N8bc7ONCu49IDjHAuccDuoJhT8IBithpHcnBkrA1N130g
         07pghukhQWtEcxLrNGU4lcMo727MjtxKHVgcYbbTrWW8IMjb9y5oNp6ZUgCLLDf+f+0b
         jvtOxhVVnwZIdmV78PMAvMDgX4LspvFBJIZNH0tiSCyuFmYel/N8a4f53DousSPnOhz7
         AYOrlK4d99hlrREN8OIZgqfS6zMA5cg1ymb5dChjEly9W02xgpAUJHELj4x1tHMFZIkj
         0yRg==
X-Gm-Message-State: APzg51A591lKaMSV3SO6OR6rWY80tDmcRU1HrIgQgBQWuFAfJOoc5o2r
        4q9VbvSwTdmBxul1CzD7QPe8Zg==
X-Google-Smtp-Source: ANB0VdYWhznLcihB0UrNmIf2mjPquSPyoFXSMpOulNwXGlOXDq896NHdGFZo8Hb+T1aCiVvbYfkMxA==
X-Received: by 2002:adf:fc83:: with SMTP id g3-v6mr4594092wrr.216.1535554857645;
        Wed, 29 Aug 2018 08:00:57 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v46-v6sm7267217wrc.63.2018.08.29.08.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:00:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ASoC: meson-axg: add pdm input support
Date:   Wed, 29 Aug 2018 17:00:47 +0200
Message-Id: <20180829150051.18190-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to add the support for PDM input
backend found on the AXG SoC family.

The first 2 patches, for the dmic, are not specific to this amlogic
driver but it is useful to have them since the PDM input will use this
dmic codec.

Jerome Brunet (4):
  ASoC: dmic: add Kconfig prompt for the generic dmic codec.
  ASoC: dmic: add DT module alias
  ASoC: meson: add axg pdm input DT binding documentation
  ASoC: meson: add axg pdm input

 .../bindings/sound/amlogic,axg-pdm.txt        |  24 +
 sound/soc/codecs/Kconfig                      |   6 +-
 sound/soc/codecs/dmic.c                       |   1 +
 sound/soc/meson/Kconfig                       |   9 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-pdm.c                     | 654 ++++++++++++++++++
 6 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
 create mode 100644 sound/soc/meson/axg-pdm.c

-- 
2.17.1

