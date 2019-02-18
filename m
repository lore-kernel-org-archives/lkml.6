Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15B2C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBFC218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5bIBUI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfBRATV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:19:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36188 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfBRATU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:19:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so7525449pgr.3;
        Sun, 17 Feb 2019 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbRr2RYMR54b7AhSan9xsBEduDl7IIBORSvu485az7g=;
        b=k5bIBUI5CFOxVPWatAXvBfSEsDsHuEBJNQEx2EXO53ONtwXca5aNp0R6O3lnwRrknC
         87o7BFl8F89mybGy7xdYmdVuLJm/G6NgL1Sm/qL2lwZRNv6peuZ42pdMTBcxE7E6U44S
         XP5vIkRqVYH0eXy3Eagp97c9ZQScYdw9iaFrExKu00llQWisNimIlFxPV45qlILovM/V
         Y5/DRAlvMRMQS34ha//lHWpRsAZshvx0PSLa3kisSyuSthB8rOAol4gGyXRYxTw5pT0f
         Ng+FK1t1RvnffCy3AqE6nMc//YLZJleIL9gjlaJXvPNq1d2o3im7VJ4mgCg+nzKYszTG
         4b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbRr2RYMR54b7AhSan9xsBEduDl7IIBORSvu485az7g=;
        b=knsfntna7GdyEG39+LP/TdcHs4fZRu3QKKi3s0ohP3aZCOrm/ilEY6Kpj/eDXerckA
         YjNkyJj9RU8pKOd+XgULAvegyBeGIBqD8qjPiUE/hEvd9P80L+aIMNasLhY9FPBfirMO
         c6bm10Z0XC4m9R8yBPqpqDhjlMfHNJpij4rQu/eTxavRLkMH4b8XnNy3h1PUq1bUD+J+
         lPMBLUQDSY4oYBWkYRmmOl3yz2FoFD53j1GMFpsmYX1INf/3xSjACV1G8cZ6Z+6Ju+U2
         mi/0W5sy24iAwsgNNFWEUnGPACg+WWZFsC9fg1AIDEu1+KC1KYKykil63yLNU/5j87OK
         dPCw==
X-Gm-Message-State: AHQUAuZLzzALBcjvQ7WUWefIFTv7+rET50PxZonM0qK92hRO2nxwK6Pi
        BTtBZ2DAEZujrC4MWW5e0i8=
X-Google-Smtp-Source: AHgI3IZjeEEDkocnHoB3ynLb3cTG5WtWPet77NkvY7hg3MhJUltqkvEt+kKOQI6amQQRIozvQWGmcg==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr22353524pfh.228.1550449159620;
        Sun, 17 Feb 2019 16:19:19 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 16:19:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
Date:   Mon, 18 Feb 2019 03:17:18 +0300
Message-Id: <20190218001726.16785-1-digetx@gmail.com>
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
 arch/arm/mach-tegra/pm.c                   | 50 ++++++++++++++
 arch/arm/mach-tegra/reset-handler.S        | 52 ++++++++++----
 arch/arm/mach-tegra/reset.c                |  3 +
 arch/arm/mach-tegra/reset.h                |  9 ++-
 arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
 arch/arm/mach-tegra/sleep.S                | 11 +--
 arch/arm/mach-tegra/tegra.c                | 10 +++
 11 files changed, 214 insertions(+), 23 deletions(-)

-- 
2.20.1

