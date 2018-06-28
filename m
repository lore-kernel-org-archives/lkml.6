Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F361C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE35427157
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GBmvU5cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE35427157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964953AbeF1JvF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:51:05 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51770 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935130AbeF1JvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:51:01 -0400
Received: by mail-wm0-f48.google.com with SMTP id w137-v6so8922772wmw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ARtV1cznqG24rBF2AF5nqqzrZQXWYZ1uBxNixv9xCQs=;
        b=GBmvU5cOsTz0YQXsiwaWRNOdMCRi8gmA4d75fpmUxnFUUCPHvt3PFyBjwcI5ra2z01
         VWKKhU2evGA6M4SxCS8Q3UbO4CNMSD8phwe+ITc7KAV4BO8Z4eXxChpww9GZC5YiHigd
         ZVO7DhwAxbCsQdg6lniBAY1hH91VtHhC16udalzEiyNJD3R4AEa3nFcSShmizAOlWHZQ
         RTmpoOOtZ7R6jhx2Baih0m0b5E8j6tGuuzlms9Lm/cOjAie8W3B7VEGapflP5HaxWt29
         ExEaikCmqNSSb62+WbTnfyfgs6q0K08dE+rrI0HL6v+o7FyfN3R2FNpFZMkpCBnaVAf0
         dqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ARtV1cznqG24rBF2AF5nqqzrZQXWYZ1uBxNixv9xCQs=;
        b=OhbjRupFIjAvhzKG0nANWbGN8R7HeGz0zasdhpe+TBvS3uDSqxxfWN8kDdlF47xl60
         aPxGWAVeCnmr11nXkjI6baAoqBPNCCD7IySVPCjGO+y0fpgeucNxCGV4p2juB7U916RA
         P7NMIe1rCURBKk/CY8dA9rDBQR0ZpIWURaBdF0pweQAIhmWcHzhkuVQ7h+OWbMt4NU5i
         1PuOV3JH/RmA0Zd79YGww+p50w8LcejIOiITGL16A2X5HjGXD38kKNRdvizpj6NOaa3e
         qVlLMld4aHZVhOKmniOUmoKLPXy6g0idvuXexJikcrx9lw3bKtXwzLF0w3RV3ve1oTM5
         TY6Q==
X-Gm-Message-State: APt69E2gkCxfj4QNg77rhl88HVNW3elCRRY1P7Hv+57tEQZMXK8nJN+X
        AqykstY9XYwsJhM1viBBq3JavA==
X-Google-Smtp-Source: AAOMgpe5epXL6EcGJfmPAygXITRBzc97+5RzYhgdTswJoD83/MftlWfJ7N14sLV5EN8AMd8DrjWvpQ==
X-Received: by 2002:a1c:c91a:: with SMTP id f26-v6mr7939021wmb.140.1530179460450;
        Thu, 28 Jun 2018 02:51:00 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w67-v6sm6413476wmw.0.2018.06.28.02.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 02:50:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM64: dts: meson-axg: first round of daughter card updates
Date:   Thu, 28 Jun 2018 11:50:51 +0200
Message-Id: <20180628095054.13433-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a speaker amplifier and some leds present on daughter
cards which are connected to the s400 board.

Kevin, please note that the bindings documentation update for the tas5707
has been queued for next in Mark Brown's ASoC tree. Not having it won't
break anything but you may get checkpatch warning.

Jerome Brunet (3):
  ARM64: dts: meson-axg: add s400 microphone card leds
  ARM64: dts: meson-axg: add s400 main 12v supply
  ARM64: dts: meson-axg: add s400 speaker amplifier

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

-- 
2.14.4

