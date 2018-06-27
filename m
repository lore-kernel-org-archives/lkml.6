Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ECBC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439D52687A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D8yNvC09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439D52687A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeF0Hju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:39:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36822 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeF0Hjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:39:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id u18-v6so4326373wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=oxSA3vbD1+02LpZe66yKDqZcr9urSq52qoOumlvmMUM=;
        b=D8yNvC09OgPJ55uKcdFEIfIJrwX4cIDMyLsxJ0UC8TZUKSvqXiC+yN4/AVzk6zzPgW
         DE9L+ZZxfBAg6znR+GU83OmC20cjOpjxxkVqAv9rKBKWLKDoZqH3pQV1v9fphWUUB4SL
         5KTleoBgdcpRC+M6maFftUMXS17PDz7Ta09yPlDEJVat0XQn0F9t3L4Eqy10AZyYxKkz
         FtJEybWfdkzfVQLkxSxl4S5XMFt4nDOtMR3FBvjPixraotEG0wa4NohTOvAju6qNbgtI
         Eh4aA933JCNXwHrShBdrmRc7qxin/E4+WG1M4wMhvRLUvF9KJSI77Fkt92K6+V3CSsCx
         Y8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oxSA3vbD1+02LpZe66yKDqZcr9urSq52qoOumlvmMUM=;
        b=JJVxgmtuHzFzTl6KOx9vLuxKOdYL7dLNqMv5lLv+ceZOfupzppQPAEi8i4ZNAa7yeX
         vfyolphUWapnrmh5Bai6wUBjBqDT5EaG6rWvBRQ+zunoqh71qU/DmTMtsTJQl5ktKJWx
         4TNgxNfowb9lN0/yiX/IAbyK3Y7ysEUU3M8RwnRvSfuSGNKuKktR9MJayPCmk1g1v/QQ
         6TvlaiXkUf600/4xs3RNIpSBBN5AZ+sKfo/bikzb88wAtWfcjzkNbuuOfdKMWyjwa7Gm
         IIfMv5bDpjPNIrMt1nGlKEdEajRp/zUDwsIr8SB7zHCTYoK9uKlDjkHaT1W426ynkSf+
         Oogg==
X-Gm-Message-State: APt69E0p+b6a6vitaHiZN/V6X6+aQEgIuV79B0CTyg7PjYgzkAwH8FRC
        mrigay9Jt7osNoK1j7CIEIT+Vw==
X-Google-Smtp-Source: AAOMgpeWOKACwsBFdDKwf1UbtnLV6cj4gEU2KCG6I5iUI4+a/JC/k8v4EFCfHecGsOxNIY3sdd6A7A==
X-Received: by 2002:a1c:f4c:: with SMTP id 73-v6mr3989404wmp.124.1530085182220;
        Wed, 27 Jun 2018 00:39:42 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m58-v6sm5852169wrf.61.2018.06.27.00.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 00:39:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] ASoC: add tas5707 support
Date:   Wed, 27 Jun 2018 09:39:35 +0200
Message-Id: <20180627073937.29912-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends the tas571x driver to support the tas5707
audio power amplifier.

Jerome Brunet (2):
  ASoC: tas571x: add tas5707 compatible
  ASoC: tas517x: add tas5707 support

Changes since v1 [0]:
 * Fixed double const as reported by kbuild robot [1]

[0]: https://lkml.kernel.org/r/20180626174056.6400-1-jbrunet@baylibre.com
[1]: https://lore.kernel.org/lkml/201806271000.j9AWAfLp%25fengguang.wu@intel.com/

 .../devicetree/bindings/sound/tas571x.txt          |   1 +
 sound/soc/codecs/Kconfig                           |   5 +-
 sound/soc/codecs/tas571x.c                         | 110 +++++++++++++++++++++
 sound/soc/codecs/tas571x.h                         |  16 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

-- 
2.14.4

