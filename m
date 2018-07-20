Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8EECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B0320673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ib3uSTEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B0320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeGTCO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:14:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45595 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbeGTCO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:14:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id 94-v6so4416679ple.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HWTNJmWbTJdVYWTHFFuQ+FPfWaFnqO1S7lo5zGq4wvI=;
        b=ib3uSTEGYvJBLKnNVE2yoMAfMiKrkX+EXsYlnSVD7AHbyi0JPWRJe1ZEten44yJhzB
         yQrLfwJzVbSdTW8kReO7Rll50kVmbV4xvVoljACteGd5iopYpSwtbub9VAotkioBBfbJ
         V9cYzDacs1hThe/N97YRH8+ioGXa/JRgqwSME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HWTNJmWbTJdVYWTHFFuQ+FPfWaFnqO1S7lo5zGq4wvI=;
        b=N0pB2XCmAXngQ0b93jbFzm3H2owdpr9Nt1O7tfANUDhSaQ1LchwpQHX9ZkJa9oo+2k
         BfLGHHKJoQuvwFa48Xwe9OsUC5gwQ7NCsb5IKt+DCqjL6Rc5dMuDkeGX0CIZ01xyR02G
         10aiJvvqF+T4DuNVGwgfq1U3Vtg59iVu5n/JzEMKVRkpARO1cA9tyzotV4Ndh3P61zs6
         L5MV1EcBHa204oPDAodYtzwXYLu6CclDAiGVy04nBBeV5PUve4dtUgu0w7IcpNKixvAV
         0MgMBakdRSIbhoBLEZToUm6W/cFK3oxFyRFMKlBVMEj43gaoHMFooDQVGbm8FtU4qJ5L
         hI9A==
X-Gm-Message-State: AOUpUlEIDdP0Xl82+Q0arsvLWC0sYMES1AkStee+CGwK1qKjVGxr04T1
        efcBu6m1kPjIfjfFFtL5bWPNxg==
X-Google-Smtp-Source: AAOMgpc90Yk74xs9/+5uBLv5OEYIZTkgGWdbhqF+xdZibvBCfGPzAZDE4tMMh79CNhecr/8NyAIbOA==
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr40306plx.318.1532050151179;
        Thu, 19 Jul 2018 18:29:11 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id u11-v6sm572058pfd.117.2018.07.19.18.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:29:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [GIT PULL 0/1] EFI fix for v4.18
Date:   Fri, 20 Jul 2018 10:28:45 +0900
Message-Id: <20180720012846.23560-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to b0d2fc41203d3712585b71d8f14914ff6a266278:

  x86/efi: Access EFI MMIO data as unencrypted when SEV is active (2018-07-17 11:10:56 +0800)

----------------------------------------------------------------
Apply a fix from Brijesh to prevent the [unencrypted] SPI flash from
being mapped with the encryption bit set when running with SEV enabled.

----------------------------------------------------------------
Brijesh Singh (1):
      x86/efi: Access EFI MMIO data as unencrypted when SEV is active

 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
