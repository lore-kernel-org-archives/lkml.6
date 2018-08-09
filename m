Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF7FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0249A21EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jDZRO0YJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0249A21EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbeHITnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:43:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41061 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHITnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:43:13 -0400
Received: by mail-pl0-f65.google.com with SMTP id w19-v6so2815527ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PZigMv/NuNF8UbcJd/LJW13I1cMX3NeIrMDBejzYkc=;
        b=jDZRO0YJryoUxVmiJncvdmfYLdzAmLtvcFzHfS0U/XOwHKnZkBl2g4++RVI3kF/giZ
         e10KXB4m8B9+C/cXWB0f63Lv8kXAw8LhIf7kqk4UTiUrPnE5S/gUz4Xe2z+gtdK9Ywqn
         ZdTJsby+zpuzZi/Uo5B7wIV7Uwqf+XNxYhRbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PZigMv/NuNF8UbcJd/LJW13I1cMX3NeIrMDBejzYkc=;
        b=LSbOFMw8q4kWV7a4CEKtWHK2IDobZ+vuwjM5Wce7jAeoOnW/jhx3mp0GRNq3vgJfph
         mBUOnzpdda+UtMPTfeCtmdUMKsEbRYYoB06kwQ18aieq38wp6VwbEXjs3cbi7hbC79CI
         ZkXLXqdfMoeD6I52Z/MEvGKNf2D6ESF0xW/hAUgIZSgnY0dBCDqIi+A0Rt52l0w2nxsR
         S9LeX3jEQpqtyPfy7+B76C9FnwlWjWRLPOoFwtGMgm0FichJ/SIPzraKdhFo1Y0awIjl
         Mj3xirdQ2at70jZLktqWH6qy/rnF8SLso82rlyc56E48QKBqJNgbqCd6y7Mzu5ZFuDRV
         /2eA==
X-Gm-Message-State: AOUpUlG/aDTCL7MvVS3xEfBe4zlAGAndx5SBRPGw2cJ1LYzV9OmUvJCT
        AZfEQlBMTnucTaq8FUmJx4vf1Q==
X-Google-Smtp-Source: AA+uWPwdE5Vrt+nXmRgacmLIYTbQo/CMxEOZfzemXcXx2T4bUxOYQI8+u9IdJPFLia/WEdc7Qe+ZWg==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr2891804pls.185.1533835043967;
        Thu, 09 Aug 2018 10:17:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d75-v6sm12866009pfd.49.2018.08.09.10.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:17:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/7] firmware: coreboot: Fix probe and simplify code
Date:   Thu,  9 Aug 2018 10:17:15 -0700
Message-Id: <20180809171722.144325-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks the coreboot firmware driver a bit to fix some bugs
and then simplify the code by changing the design to get rid of the
different platform drivers, remap memory with memremap(), and use devm
to simplify error paths. There's some risk in changing to memremap() but
I think that should work out alright. It will either return memory
directly, or fallback to ioremap_cache() as has been done before.

Changes from v2:
 * A bunch more patches
 * Fix iounmap missing on error path
 * Fix bus getting unregistered on driver unbind and never registered
   again
 * Request exclusive access to table region
 * Pull out table signature check to driver probe

Changes from v1:
 * Split out fixlet for DT based driver from platform driver change

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>

Stephen Boyd (7):
  firmware: coreboot: Let OF core populate platform device
  firmware: coreboot: Unmap ioregion on failure
  firmware: coreboot: Make bus registration symmetric
  firmware: coreboot: Collapse platform drivers into bus core
  firmware: coreboot: Remap RAM with memremap() instead of ioremap()
  firmware: coreboot: Only populate devices in coreboot_table_init()
  firmware: coreboot: Request table region for exclusive access

 drivers/firmware/google/Kconfig               |  26 ++--
 drivers/firmware/google/Makefile              |   2 -
 drivers/firmware/google/coreboot_table-acpi.c |  88 ------------
 drivers/firmware/google/coreboot_table-of.c   |  82 -----------
 drivers/firmware/google/coreboot_table.c      | 135 +++++++++++++-----
 drivers/firmware/google/coreboot_table.h      |   6 -
 6 files changed, 107 insertions(+), 232 deletions(-)
 delete mode 100644 drivers/firmware/google/coreboot_table-acpi.c
 delete mode 100644 drivers/firmware/google/coreboot_table-of.c

-- 
Sent by a computer through tubes

