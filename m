Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA507C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD52F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4nl0W25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBVSEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:04:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36368 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVSEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id v10so2413277lji.3;
        Fri, 22 Feb 2019 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJIfcNgdLwIOQgBq8MfHDWHd4OU+U5junDQOmjo7ne8=;
        b=U4nl0W25kjXAqzkYHIbSN0n/W8/x8GX5UgACZqpahcEb8Hak9t7bR/1iNs6lVzEWSo
         X5wWQ98QDBHwxKNofEUAovpjuToCDyiYDm3SKuuXvyGDGkHhAw9e7fhX1oY0lZriFkxh
         XyGc+I1pdkXebyadO6YkzQrNqSI8ghS3Q1OBfInl0qvaKI5dn+As6dw5vbeCy55pyvDs
         r8Zmrl1Zi/bCpbD58FBq6rWPIOEq7AygTloR5edQlKjNhSXie/FHBZ/QMUN0ISh7ip3k
         dnlEBWZ6ktpOqyUDPKW0NBCMKHtCec6jftG2YgDLqxne6ppf4uEop9uwIgnLb/Zp/SbF
         l2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJIfcNgdLwIOQgBq8MfHDWHd4OU+U5junDQOmjo7ne8=;
        b=kJT7ZdasmqouCjyFRQf4siFk0e4w7YMAbxqdrfqDqMyYtETAagT9U1Kfrg5yDWNmxs
         oE638KcbN8FnF5eZo1ZfhhzsW3tSguEIA3hBeViMg5ZFpRJpBtKI1s0Cz/pbGvF6A95M
         5DxWJKT/bfpedyapusL+xH9nK3M+sFfgUxdTwH7VZGdmxoqDwK+GfO7pa4TYXQ8cT+sh
         jwc7eF5cChKLxKkDkqA/8HzM/WxJ6EeODa3NEYmr8/4IBl4mMgQek4KKLy+NnROMrj9f
         LZGeoQtFe6pywhxJXvFdVx3geahUHG9W4ivCY2Hk4qfvcsEPfj2fNLTcQchSAXwnTIzS
         VIQw==
X-Gm-Message-State: AHQUAuYT6MTyfuapVLB1L8Mk+PozwtT2hiM/mThO6FUFkh610x70ZoYZ
        j7P7za0qU6vN3p/YgYDeOD4+qsqf
X-Google-Smtp-Source: AHgI3IZ7h0ngBjkJPtkp453YXg2cpHpft3qtKxSzFnOnhfwqVJHuR2K01nDXgpH/hGsO+ULFvak2dA==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr2835278lji.127.1550858669304;
        Fri, 22 Feb 2019 10:04:29 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:04:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] Support Trusted Foundations firmware on Tegra30
Date:   Fri, 22 Feb 2019 20:59:18 +0300
Message-Id: <20190222175926.23366-1-digetx@gmail.com>
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

Dmitry Osipenko (8):
  ARM: trusted_foundations: Implement L2 cache initialization callback
  ARM: trusted_foundations: Make prepare_idle call to take mode argument
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Set up L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode
  ARM: tegra: Support L2 cache maintenance done via firmware
  ARM: tegra: Add firmware calls required for suspend-resume

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
 arch/arm/mach-tegra/tegra.c                | 10 +++
 11 files changed, 215 insertions(+), 22 deletions(-)

-- 
2.20.1

