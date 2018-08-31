Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED33C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B072077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J2nZETU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B072077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeHaTKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:10:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33587 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbeHaTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:10:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id r1-v6so1420263wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+joq8y0s8S8+q99bLOQNhv0kD3svoURWeMHlvYMUguc=;
        b=J2nZETU/P6oZHZGcOupbTGNqvF8KfPcx2XKU8MsbajAhHjfHxXnofSkLAPWpxkdn9+
         +mYV5Ct44pvzJA7ZtvdsCEamiU4vwFqzNzgC+4M9hZYow5iwoCowTclCWJWahwuVR34R
         XT7FQzSRII8QkZ665hcSVxqPAL+cCn3SnQHb0FKEJBUbDWuaKxgCkm535WB2CyoRZxaK
         r62NubOKs+StfUpQMB26SN4/g1xXfjicH5StDVMyFYK8kZ/YhCKt5+nQjwOeV0h//ZW0
         i+BwnCJKPjP2jUM12jP36abw5TnJ8flze0Q1GhvgdnVOK5bclXnBXnpC4Eibnqocle9R
         +f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+joq8y0s8S8+q99bLOQNhv0kD3svoURWeMHlvYMUguc=;
        b=uNjXDX9DX3wz7C6hRPvqgYr2wUKFaOWiSr3ZLexsq+FntTn+FEGPwGw9jpAVhLWUtx
         6Dj/n1nHrtKDydkqNFG8BbGjxRzqAQcdYH0rxWzmBKjN4ePzn2Rkbar9GOuSjLWJwf1q
         Gz3me4IyhnGJts9ESR2McjtZrlJ+ECEZK0GpgEehgO+I/UddVgwKRoZiQN6iPewdYjCs
         O1iR43PBekkS+OcVWP1LSwbq0nkjIVkqWkuhzeJCz2ydyF/+xgWQDUnsSoy0ifIp1wRb
         ygzkqPHp3PWMPpInsjiCRPfYxQmHzjJ9nOeoY/Ev7mzbnl7f54u5u6CMC0JoXD2jwvfi
         PHsA==
X-Gm-Message-State: APzg51CXhvGa8xaLq+O3toBpD+ZlMoRmF1ku59jwucGGoKWL9Fd1UtnV
        zzw5WTcQNBfu0hH29bVdZ38wOkT3+hA=
X-Google-Smtp-Source: ANB0VdYQNQ3PpaLsrwlZbTGXuQD9xFs5AyaStT0uuocMZ1qYqDZKyCYdzyxnqc1TdnOqczD+WNf5nw==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr4893831wms.70.1535727743635;
        Fri, 31 Aug 2018 08:02:23 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm8759797wmv.6.2018.08.31.08.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:02:22 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] arm64: dts: meson-axg: add pdm support
Date:   Fri, 31 Aug 2018 17:02:15 +0200
Message-Id: <20180831150218.8307-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds pdm support for amlogic AXG SoC.
It applies on top of the DT clean-up [0] I sent earlier

The related ASoC PDM patches can be found here [1]. While the ASoC patches
[2] are obviously needed to for the PDM to work, this series can be safely
applied without it.

[0]: https://lkml.kernel.org/r/20180829154551.26729-1-jbrunet@baylibre.com
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-4.20
[2]: https://lkml.kernel.org/r/20180829150051.18190-1-jbrunet@baylibre.com

Jerome Brunet (3):
  arm64: dts: meson-axg: add pdm
  arm64: dts: meson-axg: s400: add dmic codec
  arm64: dts: meson-axg: s400: add pdm to the sound card

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 27 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 12 +++++++++
 2 files changed, 39 insertions(+)

-- 
2.17.1

