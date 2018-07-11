Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88663C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC532083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnRQ+lOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC532083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeGKJoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36316 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbeGKJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so1845630wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iFOMyQqGOXD/QIDrU+xj/gu260Q3y5L/BZ1kLkX9Wxw=;
        b=ZnRQ+lOQ95ftJzJkybHlcHXU8Gffg4UPaLeBN8TcmvSDQXj8reBp69SGjEju6rb0i8
         EqfpiBmeMNsmuocr+JCsdGQsVcyKhVVjv57SoAqMOs/tqzVb+O56tGzJukKR0opB0vc/
         bK0n8ChgztdNvAzr/Z985UxiF9G+UIxKbgqhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iFOMyQqGOXD/QIDrU+xj/gu260Q3y5L/BZ1kLkX9Wxw=;
        b=QQG1WV8C+inZWxB6zTTarQNaMwv8xQb9xXMN+IimrarmlQRiD9shE5wYIfkaUyPr91
         jCeghToZXxe7mOnkxujwtPRkWpYFKTy0ibH6F0SPZbNiwoy98NcgNMFqEz/3wrKvRqOH
         ubZs1ugaxe5Orpzjho8ecimc0ne7xpv11PcHUa+yTAkjQqcT1dPFjtBEkKVJAv/Vtbau
         v4HKDi5mBJcrOUCouMLxQaPt3POxd0vbMYC7wxumgY7cq/ZFx7v772YF75Qs8wRSCgiD
         hO/kpvsVx6pP0L3oBetWROrEEH1448wrCvDMF+wuhCfurCeQ3vBc4UG8ayYqY5ruWuy3
         H1+w==
X-Gm-Message-State: APt69E2XfjJslrQzWFXz8Itct2abnihimifTDLYYWRMeehXzjto5+V7+
        6Kd6itavPItJscWMTTL8+xhuMQ==
X-Google-Smtp-Source: AAOMgpfv5vhYNHgetgW7/uzqPRoA/ZuMZ5P7/IzoHcAS+U/RU7TxhqabrEY1hlqNRHEl0VdponcwSQ==
X-Received: by 2002:a1c:37cd:: with SMTP id e196-v6mr15873238wma.84.1531302048232;
        Wed, 11 Jul 2018 02:40:48 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1641311wmt.29.2018.07.11.02.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:40:47 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [GIT PULL 0/8] EFI changes for v4.19
Date:   Wed, 11 Jul 2018 11:40:32 +0200
Message-Id: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to 6a3524a55f16437d210f61bbb53c7c099b18babe:

  fbdev/efifb: honour UEFI memory map attributes when mapping the fb (2018-07-11 11:23:26 +0200)

----------------------------------------------------------------
EFI changes for v4.19, batch #1:
- Perform UEFI runtime services calls from a work queue so the calls into the
  firmware occur from a kernel thread (Sai)
- Honor the UEFI memory map attributes for live memory regions configured by
  UEFI as a framebuffer. This works around a coherency problem with KVM guests
  running on ARM. (Ard)
- Cleanup for the x86 EFI stub code (Ingo)
- A timekeeping fix from Arnd
- Gradually phase out the DTB loader in the ARM version of the EFI stub. (Ard)
- Drop an unused function declaration (Sai)

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi/libstub/arm: add opt-in Kconfig option for the DTB loader
      efi: drop type and attribute checks in efi_mem_desc_lookup()
      fbdev/efifb: honour UEFI memory map attributes when mapping the fb

Arnd Bergmann (1):
      efi: cper: avoid using get_seconds()

Ingo Molnar (1):
      efi/x86: Clean up the eboot code

Sai Praneeth (3):
      efi/x86: Use non-blocking SetVariable() for efi_delete_dummy_variable()
      efi: Use a work queue to invoke EFI Runtime Services
      efi: Remove the declaration of efi_late_init() as the function is unused

 arch/x86/boot/compressed/eboot.c        | 245 ++++++++++++++++----------------
 arch/x86/platform/efi/quirks.c          |  14 +-
 drivers/firmware/efi/Kconfig            |  12 ++
 drivers/firmware/efi/cper.c             |  17 ++-
 drivers/firmware/efi/efi.c              |  22 ++-
 drivers/firmware/efi/esrt.c             |   5 +-
 drivers/firmware/efi/libstub/arm-stub.c |   7 +-
 drivers/firmware/efi/runtime-wrappers.c | 202 ++++++++++++++++++++++++--
 drivers/video/fbdev/efifb.c             |  51 +++++--
 include/linux/efi.h                     |   5 +-
 10 files changed, 413 insertions(+), 167 deletions(-)
