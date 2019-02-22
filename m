Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B012070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT16gM5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBVTfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:35:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35643 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:35:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so1558187pfa.2;
        Fri, 22 Feb 2019 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQL1EEwK6NnKOtdqQG3M+wi9O2P4+a93b/SQspi5YpM=;
        b=vT16gM5ZTxafYJKSY/CZLt9eDn/xKofhq9tFBjdOdBmOFMldCGELC551mfl64cIPIK
         AeOcAGDVWLHbh8rp4kuxI9i/aGpn4NtTgWOvHA+/Kwbun7f6sdbiMqL5oOHkh7Cn2wMZ
         r/dmhxykwAlqLpa2MYfSPnSpoR3VnX1i/HTeaf/49P8MkJyhCGdYb/fkY8yfIetbwtRQ
         6/XnJ1KGaOmOSImLOfIBCZCDFYmZAhkmeS76Ngjm4wTAwSbpsP79ONvsApJkHaJnUUjB
         5FFluIOg3noIgJmmuBbjZnwanibpwa7YhIoOOYS7ia3kx+nX0y6CJJRzp4xh84mhv4XR
         oByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQL1EEwK6NnKOtdqQG3M+wi9O2P4+a93b/SQspi5YpM=;
        b=cBQNk2ICByjnXfBPCKD3evPi7EXgrAmworlIwcTfk+4g0NhTouMugmUuzwKfBT5ArI
         O2JuxkLVmCusSBhVcWPSs9KBuWvDA82mDAQl0jWLfEyOkGZsRav67bO6dBEZ88Fvdv8O
         zA6JuU3V7f13/JAjfli6K1MU+jq0S43sIauY/NGruwEPS6nPOHXHCv82FYkphoYe2m0u
         saKjJrB6w3iqb9eeSDVtcOgG1BGI4xymT7EoNMQ77CFFovHrjsTHaQSzplbqutn6090i
         kGt6XHQOt9/J5y42EMTLAIr6nR+fYK50cedxW7dgOemLJHc67uRG/WPCnTgjxc7eiXlE
         TScQ==
X-Gm-Message-State: AHQUAubI/He3taEZH0mVcOuFO4ptnbz/Vu3fh/CD64ZX388ucFWmkA8P
        Rs3wU4eR8xJ2DuzcNzR3TEU=
X-Google-Smtp-Source: AHgI3IZk1RyZfWQsi57vD/JQ+++CuTk7M8IdMsDCyG7m7fXk7Z4QFTqvrTr09JY1LNM7ATZ+jrjStA==
X-Received: by 2002:aa7:9090:: with SMTP id i16mr5683573pfa.85.1550864129743;
        Fri, 22 Feb 2019 11:35:29 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:35:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
Date:   Fri, 22 Feb 2019 22:34:19 +0300
Message-Id: <20190222193426.10747-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds support for the Trusted Foundations firmware on
NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
firmware and upstream kernel can't boot on those devices without the
firmware support.

Changelog:

v6:     - One patch got messed up accidentally in v5, this is fixed now.

        - Squashed "Support L2 cache maintenance done via firmware" patch
          into the "Add firmware calls..." patch.

        - The l2x0_init() firmware callback is now invoked unconditionally
          because it is always a NO-OP on T114+ and is a NO-OP on T20/30
          if firmware node is missed in device-tree, hence there is no
          need to check the machine's DT compatible as it was done in the
          previous versions of the series.

v5:     - Fixed machine hanging on disabling D-cache during suspend,
          turned out there are slight variations in behaviour between
          firmware version in regards to cache-management. Thanks to
          Robert Yang for reporting the problem and helping with the
          solution.

v4:     - Fixed Thumb2-kernel hanging on Tegra20, turned out it was not a
          good idea to switch CPU into Thumb2 mode right after jumping into
          the reset handler.

        - Moved LP2-mode-set firmware call invocation to a later stage to
          better replicate what downstream kernel does. This change was
          suggested by Robert Yang and fixes system hang on Ouya game
          console.

        - Added references to the original work made by Michał Mirosław
          into commit messages of the relevant patches.

v3:     - Implemented suspend-resume support.

        - Reworked arm/firmware/trusted_foundations.c a tad. Now cache
          is getting properly initialized, cache enabling / disabling is
          supported.

v2:
        - The "Don't apply CPU erratas in insecure mode" patch got some
          cleanup, in particular resolved the messiness in
          __tegra_cpu_reset_handler_data.

        - Added a comment to tf_cache_write_sec(), justifying the warning
          message.

Dmitry Osipenko (7):
  ARM: trusted_foundations: Implement L2 cache initialization callback
  ARM: trusted_foundations: Make prepare_idle call to take mode argument
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Set up L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode
  ARM: tegra: Add firmware calls required for suspend-resume on Tegra30

 arch/arm/firmware/trusted_foundations.c    | 80 +++++++++++++++++++++-
 arch/arm/include/asm/firmware.h            |  2 +-
 arch/arm/include/asm/trusted_foundations.h | 13 ++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
 arch/arm/mach-tegra/pm.c                   | 49 +++++++++++++
 arch/arm/mach-tegra/reset-handler.S        | 50 +++++++++++---
 arch/arm/mach-tegra/reset.c                |  3 +
 arch/arm/mach-tegra/reset.h                |  9 ++-
 arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
 arch/arm/mach-tegra/sleep.S                | 14 ++--
 arch/arm/mach-tegra/tegra.c                |  2 +
 11 files changed, 207 insertions(+), 22 deletions(-)

-- 
2.20.1

