Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027172082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5M55vJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027172082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeKBWbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:31:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42013 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:31:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id h21-v6so1387385edq.9;
        Fri, 02 Nov 2018 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CA4F6hpNVa2Vq3rCmOKzWoRHbNMSECJ0jJ8b9IvX5c=;
        b=h5M55vJfhm1AuFNj7TjkPWsebkuccufryAU0O9OUQ0lQjmGntoG6FV8Vp8oe6TI60R
         v2n2NqiJJsdVIVWTgvJnNPwOdkDX+nfHLp+Lntk6kx49UnMCTI8sfcsekQEVypFlj2hy
         yHQVrbTKIKOM7Sz8XsUu46+9XnGVFolhE15V1uQoUorEmmdQx1A8Bt0cyId30fV2fGxB
         HXCGipCm4qWDRE/9o0c0xwyFAGM+szOoZvl5Of59oERkEQN5V6px3fyLToUSfKUibG7k
         KeSKrViCrZyfiG0iSbbNYt0ZUpZwRqHWwPvqPsydGBlQUVmaeBZgst/HP6QOs0QXcdzE
         WTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CA4F6hpNVa2Vq3rCmOKzWoRHbNMSECJ0jJ8b9IvX5c=;
        b=TOUsbW2k1pqyMzxpQfkeKtClD6LCRKsj3FDSSleVQPpo6hZcATlDjQmzSuid3u+MyY
         kscCANIZ++nmFvegCmoFAualyJ/BUrIGD+wpIqexkFIc6ngW//IYnFJYyiwllJW8T7Vd
         If1ZZqMjNANMJgr3K4JNmo1tSAn+Az6s8vI8ZIvYe/IlVCOloOZqWUejm1oVqHB2RTOX
         icCzI535noTS7K4VeM+Y2pOFGvVdzFTyNqxjND5GdwjIlUgyeHYNWRBvYqGbNjqXBFn3
         UOpxAyDYuMkgoz+SXhJKa7T5A5YZ0LaFwWQRJdVRzlCUyJa45DvNnO/OKiZln4YnD9sB
         L0Gg==
X-Gm-Message-State: AGRZ1gKhg6xv1LXP9XbXzOXZgZJKz5F2QufHuZhtOFy2QQLTOOieGpfx
        khKckdVATX5PO2XDf1pbaySFhb87
X-Google-Smtp-Source: AJdET5ewv930lkXyZW33qXWvQ2Z8W1neqhnxE5WruGQyx34GELSWV+Iclj0Uos2cJf0BRRNOQKp5jQ==
X-Received: by 2002:a17:906:5c45:: with SMTP id c5-v6mr6539580ejr.83.1541165041716;
        Fri, 02 Nov 2018 06:24:01 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id h3-v6sm10445347ede.42.2018.11.02.06.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 06:24:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v4.20-rc1
Date:   Fri,  2 Nov 2018 14:23:59 +0100
Message-Id: <20181102132359.11720-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.20-rc1

for you to fetch changes up to 2153bbc12f77fb2203276befc0f0dddbfb023bb1:

  pwm: lpss: Only set update bit if we are actually changing the settings (2018-10-16 13:16:15 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.20-rc1

This series contains a number of improvements to existing drivers, such
as LPSS. Some drivers, such as renesas-tpu and rcar get support for more
SoC generations. To round things off this fixes an issue with the sysfs
interface.

----------------------------------------------------------------
Biju Das (2):
      dt-bindings: pwm: rcar: Add r8a7744 support
      dt-bindings: pwm: renesas-tpu: Document r8a7744 support

Fabrice Gasnier (2):
      Revert "pwm: Set class for exported channels in sysfs"
      pwm: Send a uevent on the pwmchip device upon channel sysfs (un)export

Fabrizio Castro (1):
      dt-bindings: pwm: rcar: Add r8a774a1 support

Hans de Goede (8):
      ACPI / PM: Export acpi_device_get_power() for use by modular build drivers
      pwm: lpss: Add ACPI HID for second PWM controller on Cherry Trail devices
      pwm: lpss: Move struct pwm_lpss_chip definition to the header file
      pwm: lpss: Check PWM powerstate after resume on Cherry Trail devices
      pwm: lpss: Release runtime-pm reference from the driver's remove callback
      pwm: lpss: Add get_state callback
      pwm: lpss: Force runtime-resume on suspend on Cherry Trail
      pwm: lpss: Only set update bit if we are actually changing the settings

Sergei Shtylyov (3):
      dt-bindings: pwm: renesas: tpu: Fix "compatible" prop description
      dt-bindings: pwm: renesas: pwm-rcar: Document R8A779{7|8}0 bindings
      dt-bindings: pwm: renesas: tpu: Document R8A779{7|8}0 bindings

Thierry Reding (1):
      pwm: tegra: Remove gratuituous blank line

Vignesh R (2):
      dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
      pwm: Enable TI ECAP driver for ARCH_K3

Wolfram Sang (1):
      pwm: Use SPDX identifier for Renesas drivers

 .../devicetree/bindings/pwm/pwm-tiecap.txt         |  1 +
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  4 ++
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 10 +++-
 drivers/acpi/device_pm.c                           |  1 +
 drivers/pwm/Kconfig                                |  5 +-
 drivers/pwm/pwm-lpss-platform.c                    | 24 +++++++--
 drivers/pwm/pwm-lpss.c                             | 61 +++++++++++++++++-----
 drivers/pwm/pwm-lpss.h                             | 14 ++++-
 drivers/pwm/pwm-rcar.c                             |  5 +-
 drivers/pwm/pwm-renesas-tpu.c                      | 10 +---
 drivers/pwm/pwm-tegra.c                            |  1 -
 drivers/pwm/sysfs.c                                | 12 ++++-
 12 files changed, 110 insertions(+), 38 deletions(-)
