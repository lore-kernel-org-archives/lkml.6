Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EEFECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB282084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQV+z97E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB282084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeGTCdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45213 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGTCdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so5353961pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Eah585sJIDuBTHESe1cggy4rNc5Aw09RK1qDEfSOjhQ=;
        b=DQV+z97EhzptmipreJTQKZiPIQJ3U3QUjHT6j7vgllEvVXnwwMt9WN/2TuKjj+bLcc
         UIjNd2McLFrKW7twgufrVh5hqAniSSF1yxK/iSGkgCX3YRTFm5LVmMFgqQUbzHLspUcV
         H+VhJQdBp0uOh3nDhHhGn1tUZj/VrL/2AoB7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Eah585sJIDuBTHESe1cggy4rNc5Aw09RK1qDEfSOjhQ=;
        b=KX/3YkS96grRJxEu7g2nxpV9ExLCsKWRvfY/5riddSjvSIdWKifA7H46+AnamgcoUk
         HjuRlO4U/SwujQV5FIenT/GDKqQS7FjOuzmcp7X4IWudUXl1/TuscyCLcvpB5UJkxO9+
         G0JAnoUIlhQAUl9iMoJbqA3OZrHEfg7lW5XTS1Tt1lsRQSnpNOYM8AjHGUIkjPGi5THp
         ic7S4fWlWh6vtkH7SNvg8iHi2iWwbFk85fgR+OBR4xQeQTXH/ntVlQHd7d6JMn01tfVj
         54I4Z9iKUgHp3AWGcVmg62KWx7lXKz2ZJHHKIbqVYKpq0byDXjEtMmpq7mLGa4cn/eaI
         m+sA==
X-Gm-Message-State: AOUpUlEoqAuIp9CmaUAelNTY5NibLTEve6x7Eee3jtekyEjK2xxKTQJf
        LEYo88G66av2nGjcz0NI4r9gHA==
X-Google-Smtp-Source: AAOMgpdI6EqG30HeOvT4JZng0MSH/Zf2vDfVsfSZjeJaHifoXqCapUzNfjW/W3atkZ0Udpn/0qaHxw==
X-Received: by 2002:a62:21c3:: with SMTP id o64-v6mr105087pfj.21.1532051267017;
        Thu, 19 Jul 2018 18:47:47 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:47:46 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [GIT PULL 0/9] EFI changes for v4.19 (#2)
Date:   Fri, 20 Jul 2018 10:47:17 +0900
Message-Id: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 61f0d55569463a1af897117ff47d202b0ccb2e24:

  efi/esrt: Only call efi_mem_reserve() for boot services memory (2018-07-17 09:15:05 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-next

for you to fetch changes up to ea6854bfead2a7ac7e44274a5dbc69a567cf3e73:

  efivars: Call guid_parse() against guid_t type of variable (2018-07-18 07:17:20 +0800)

----------------------------------------------------------------
EFI changes for v4.19, batch #2:
- Make mixed mode UEFI runtime service invocations mutually exclusive, as
  mandated by the UEFI spec (Ard)
- GUID cleanups by Andy
- More stub code deduplication and cleanup (Lukas, Ard)

----------------------------------------------------------------
Andy Shevchenko (2):
      efi/cper: Use consistent types for UUIDs
      efivars: Call guid_parse() against guid_t type of variable

Ard Biesheuvel (6):
      efi/x86: prevent reentrant firmware calls in mixed mode
      efi/x86: merge setup_efi_pci32 and setup_efi_pci64 routines
      efi/x86: align efi_uga_draw_protocol typedef names to convention
      efi/x86: merge 32-bit and 64-bit UGA draw protocol setup routines
      efi/x86: add missing NULL initialization in UGA draw protocol discovery
      efi/x86: replace references to efi_early->is64 with efi_is_64bit()

Lukas Wunner (1):
      efi: Deduplicate efi_open_volume()

 arch/arm/include/asm/efi.h                     |   3 +
 arch/arm64/include/asm/efi.h                   |   3 +
 arch/x86/boot/compressed/eboot.c               | 316 ++++++-------------------
 arch/x86/boot/compressed/eboot.h               |  12 +-
 arch/x86/platform/efi/efi_64.c                 | 101 +++++++-
 drivers/firmware/efi/cper.c                    |   2 +-
 drivers/firmware/efi/libstub/arm-stub.c        |  25 --
 drivers/firmware/efi/libstub/efi-stub-helper.c |  31 ++-
 drivers/firmware/efi/libstub/efistub.h         |   3 -
 fs/efivarfs/inode.c                            |   4 +-
 include/linux/efi.h                            |  10 +
 11 files changed, 219 insertions(+), 291 deletions(-)
