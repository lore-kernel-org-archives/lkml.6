Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE9A271A0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Rmmfwlgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE9A271A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeF1J56 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:57:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54835 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeF1J55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:57:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so8880381wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ONiei6RmaUl6H3XQTFyawkMW5vALH4DATytRQukQTEg=;
        b=RmmfwlgdmyRS3zl0XPyZsev8u8+JuYETd9gSVYh2Q2GDXhu4FBlCqzNQsDX0kEBeZ5
         o2RGw06Mtc3fPVKuzhDNVCJY5DRJmIeuiQFcAddAinHfonXb0y86gxSSgPMdyelJ/S/S
         nT1eEoSNUzE82QVigebnNLeC9t824dCSi/4bxHmlzhhCu5CEwRzSbHeN1/eVsevimqY/
         syK4JSpGdmDoLl6frV43YgbH28oG1Q8AIiz5Zr4ruRhnhv4hSZcKw0bmHNg/hoXcKLGp
         z794FePcOzTcfVZlS9a7oclpx8qhWPGx0MhJsImTpJM8Zaf9LkYByIxIUPEiASvB0GZn
         EAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ONiei6RmaUl6H3XQTFyawkMW5vALH4DATytRQukQTEg=;
        b=f/vovcb5XiTjK82Kps7j/kgMqmr8KSekd08/A8usvOu0/VKLwP6o14s9ylmGz/J2si
         TKvwcV6Uw9HenAjuz+TA665YDJIvGPAlo5XTeQhFAkO7khpfLCvJaL+eF1Pkke/2Zg4V
         33A7zvPDGV7Ez1UmNsAgfjs3MOWF7WzmsNo5oJxFyxvCw1USbc5LLZqK8Udbm+qcaP4F
         oMFSVoEzfvMrgO7QxT956xlHUAsyU9xi1TAvnTZwbpOyT8alQdJd7AmJW8Kbtq0zkbVD
         hUz9wjqxSG5uoT0Ry6ZtASAX0NYokNfgdRYWniUm9uFTOVKz8Bb86LjVz7VlAsdysZq6
         uXLA==
X-Gm-Message-State: APt69E0+7HJltYHpSVvmFfzkrr/eufxvoS5J8X2MlvNXoViJyBO9x6Qc
        HddC4OGuxjyw7v2eRqovoCtFIg==
X-Google-Smtp-Source: AAOMgpcFMoYMCYAbDTLEwa/CJbywazqV+Krctp5JTXPP9jNqmrEnLbI3IQKNkR+wz9ASonfbmNOZKg==
X-Received: by 2002:a1c:150d:: with SMTP id 13-v6mr8079709wmv.100.1530179876043;
        Thu, 28 Jun 2018 02:57:56 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:57:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
Date:   Thu, 28 Jun 2018 11:57:35 +0200
Message-Id: <20180628095748.4462-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series moves all aemif/nand users to using the ti-aemif platform
driver located in drivers/memory instead of the older API located in
mach-davinci.

First five patches add necessary changes to the clock driver. Next
seven convert the board files to using the ti-aemif driver. Last patch
removes now dead code.

v1 -> v2:
- added missing clock lookups for ti-aemif where needed
- removed an unnecessary davinci_nand clock lookup from psc-da850
- moved the .id field initialization of aemif platform devices next to .name
- tweaked the commit message for the last patch

v2 -> v3:
- in patch 6: change the davinci_nand device's id to -1 and keep the
  includes sorted

Bartosz Golaszewski (13):
  clk: davinci: psc-da850: remove the 'davinci_nand.0" lookup
  clk: davinci: psc-dm365: use two lookup entries for the aemif clock
  clk: davinci: psc-dm644x: use two lookup entries for the aemif clock
  clk: davinci: psc-dm646x: use two lookup entries for the aemif clock
  clk: davinci: psc-da830: add a lookup entry for aemif clock
  ARM: davinci: omapl138-hawk: add aemif & nand support
  ARM: davinci: da850-evm: use aemif platform driver in legacy mode
  ARM: davinci: dm365-evm: use the ti-aemif soc driver
  ARM: davinci: dm644x-evm: use aemif platform driver
  ARM: davinci: da830-evm: use aemif platform driver
  ARM: davinci: dm646x-evm: use aemif platform driver
  ARM: davinci: mityomapl138: use aemif platform driver
  ARM: davinci: unduplicate aemif support

 arch/arm/mach-davinci/Makefile                |   2 +-
 arch/arm/mach-davinci/aemif.c                 | 218 ------------------
 arch/arm/mach-davinci/board-da830-evm.c       |  56 ++++-
 arch/arm/mach-davinci/board-da850-evm.c       |  93 ++++----
 arch/arm/mach-davinci/board-dm365-evm.c       |  59 +++--
 arch/arm/mach-davinci/board-dm644x-evm.c      |  55 +++--
 arch/arm/mach-davinci/board-dm646x-evm.c      |  52 ++++-
 arch/arm/mach-davinci/board-mityomapl138.c    |  55 +++--
 arch/arm/mach-davinci/board-omapl138-hawk.c   | 132 +++++++++++
 drivers/clk/davinci/psc-da830.c               |   3 +-
 drivers/clk/davinci/psc-da850.c               |   3 +-
 drivers/clk/davinci/psc-dm365.c               |   3 +-
 drivers/clk/davinci/psc-dm644x.c              |   3 +-
 drivers/clk/davinci/psc-dm646x.c              |   3 +-
 .../linux/platform_data/mtd-davinci-aemif.h   |   1 -
 15 files changed, 407 insertions(+), 331 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/aemif.c

-- 
2.17.1

