Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED3C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B44A21A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoOcF2c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B44A21A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbeHHXWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:22 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43258 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:22 -0400
Received: by mail-ed1-f42.google.com with SMTP id j21-v6so1879735edp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bHZ/LA96KBlOzsMK/48YGclkFZJjPl1YiC4tIgCYiCU=;
        b=NoOcF2c4ipj+VZGNKIEInGg04uvbwlG6QU+IPKHi4Lj8W5Uk+J5DngVnGeCNGtnbiE
         H56vYgCqcPSU68OW229XkRRrG22gAtlB/i988tuwg7LRLGQ0llH57sp2kan0+xoA9Hw/
         W6YFqswsKCNzgN05vCEAZoPbH9bw+ObY62xew6G1ZI5YtzgjTIlA7pFxc7BMg9bd2D0F
         bp1oDsYM3QVpTX5/tzg3uKwU2CT1e+rD/F4Q0sGoT7SnRgiwogWB4SgqvbSfWt0Kdy3L
         7H3ylcNbvM4NAa//h1DjgCzFCetXfJiHM2idP+AZa5SGkH4VSorPs5v1Av9y8HpRl6xP
         ZkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bHZ/LA96KBlOzsMK/48YGclkFZJjPl1YiC4tIgCYiCU=;
        b=iiZzt3AD2bwAvicxoOsP5cTn8kpauqsXpp+ZakP/i5gqwHf2iDNK/cAfX35TSIIvky
         wMY2dbHthbzIFuqC7AFbRasJRVQ5IQkQzxLyVAFsTNFTZ7TTVEpk+mIvxEYmh30FyGrF
         VqRaRNjNQQR7uPgFP44GQefIvplF+thl1Ll0GfcGm9XCWK8/wEnABwCuAEut2nJ8x12R
         KhhjQLPnFvZCe+GJAj91nmN9lEUuWcAV+v+um6oqR+0aRbwZrOalXlfmCFGYVSWY7noZ
         Md8Bwn8bsep9zcaun3Gb9VwLCtZYGEkMq8kOPgBqn3Dmr5VHLE841Unafstkcu0xWsXq
         aM5g==
X-Gm-Message-State: AOUpUlFXvvTNBEuYAYW53SxlsGY+gSPOFK17KThkTGdE9eJ1Ms9YF6gM
        ve1xSqRd1ISrcQ7D7sA2G408uf3uBec=
X-Google-Smtp-Source: AA+uWPx3TWjWeb7DC9Ueh4URia0xSjRRGAZpKdnbNziBKydn7wN4FtOAbMzGozh0oopMyUtVSch07A==
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr5077594edd.194.1533762055780;
        Wed, 08 Aug 2018 14:00:55 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:00:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 00/15] staging:rtl8192u: Coding style
Date:   Wed,  8 Aug 2018 22:00:21 +0100
Message-Id: <20180808210036.22580-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this second version of the series I've replaced the macros
eqMacAddr and cpMacAddr with functions suggested by Joe Perches
<joe@perches.com>

One issue with this change is that both of the functions now
used, defined in etherdevice.h, rely on the parameters being
u16 aligned. To achieve this I've re-ordered member variables
in two structures. This strikes me as being a bit shaky as
any change to a structure might upset that alignment.

Apart from that my only concern is renaming functions
which are exported symbols. As far as I can see they are
exported using EXPORT_SYMBOL but are not used anywhere.

John Whitmore (15):
  staging:rtl8192u: Remove macro eqMacAddr - Style
  staging:rtl8192u: Remove macro cpMacAddr - Style
  staging:rtl8192u: Replace magic number 6 with ETH_ALEN - Style
  staging:rtl8192u: Rename macro parameter __pIeeeDev - Style
  staging:rtl8192u: Rename __pTa - Style
  staging:rtl8192u: Lines should not end with a '(' - Style
  staging:rtl8192u: Rename Dot11d_Init - Style
  staging:rtl8192u: Rename Dot11d_Reset - Style
  staging:rtl8192u: Rename Dot11d_UpdateCountryIe - Style
  staging:rtl8192u: Rename dot11d_update_country_ie() parameters - Style
  staging:rtl8192u: Rename DOT11D_GetMaxTxPwrInDbm -  Style
  staging:rtl8192u: Rename Channel - Style
  staging:rtl8192u: Rename DOT11D_ScanComplete - Style
  staging:rtl8192u: Rename IsLegalChannel - Style
  staging:rtl8192u: Rename ToLegalChannel - Style

 drivers/staging/rtl8192u/ieee80211/dot11d.c   | 42 +++++-----
 drivers/staging/rtl8192u/ieee80211/dot11d.h   | 77 ++++++-------------
 .../staging/rtl8192u/ieee80211/ieee80211.h    | 11 +--
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 10 +--
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  6 +-
 drivers/staging/rtl8192u/r8192U_core.c        | 10 +--
 drivers/staging/rtl8192u/r819xU_phy.c         |  2 +-
 7 files changed, 63 insertions(+), 95 deletions(-)

-- 
2.18.0

