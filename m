Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41442C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA892157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqhomcFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA892157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeI0PII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36225 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0PIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id n23-v6so1177152wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KVG4d54MN+QvRtt8dG/HSGTrOOhSH49LKqSlAtKzsJs=;
        b=aqhomcFgPubda4vykvLbba4jRIuP7TDtbfG00MtUpw22EMvMyHuBvd7GJIUSZtNrFn
         yQ35jBQdl/IesAJMiv6cy0VyzikWUyqXQ2EDQhj6gyiqL368gBVENhHmAGZwcBUI0Zs2
         BUieAodZIUvahZ1MV4sEabbeAwCvuL8Zkye28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KVG4d54MN+QvRtt8dG/HSGTrOOhSH49LKqSlAtKzsJs=;
        b=OmkmtfzG21wgr/wEx70e8OwXbSciCwUE1+K8Agwhu3qD/nf8WsWrRygmeslkfr9YAe
         sBBdYl3yKqcoTuH2dv0aTzcf16GM63Ks9+St8zOHOGwC3FoQJXi4wyyDfsgZ8Qkr+kLA
         EdPipTnclAnofxVE0IlFsP41PQGd+Wes+J+HJl1gb7W+GAiKgcMlrAQuOXkDPA+nzw47
         GbBOfzWICB95mLc0qd2H6VshfPgbPjf4G2z1l/Zq47tVb2MCqZ9tF8AjFfT4vnSxhtog
         mTFh5RkByU46aIQmwTFwb0OixPe/xa7m42kq6vQH5PNZwLeTXHfKJyrnB3g00uQIsUxt
         618Q==
X-Gm-Message-State: ABuFfohLreMsAsb7ZvVFQtLg+S0P7yoIPBlJAfqRXDvMWD66Xj0ZYoWw
        0jk8wgsFcfn0E51gx+op9IB4qYNZqnA=
X-Google-Smtp-Source: ACcGV60EngvrA17LYWzjIUq/nHzG6OSwMRl4uzn+NvC1wTyCBDDBGbQgVcAVUyF7fjBn2lLrQwtUWg==
X-Received: by 2002:a1c:f4e:: with SMTP id 75-v6mr4300007wmp.79.1538038255840;
        Thu, 27 Sep 2018 01:50:55 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:50:54 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: [GIT PULL 00/11] EFI updates for v4.20
Date:   Thu, 27 Sep 2018 10:50:27 +0200
Message-Id: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas, Ingo,

Please pull/cherry-pick the below. Note that the first three patches will
be depended upon by an irqchip series that Marc Zyngier has sent out last
week, and that targets the next release as well. So please advise how to
proceed with that: we could simply apply those patches first and use the
resulting commit in tip.git as a stable branch, I suppose, but I'll let
Marc chime in in case he has any other ideas.

Thanks,
Ard. 

[0] https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com/

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to 9c1442a9d039a1a3302fa93e9a11001c5f23b624:

  x86: boot: Fix EFI stub alignment (2018-09-26 12:15:01 +0200)

----------------------------------------------------------------
EFI updates for v4.20:
- Add support for enlisting the help of the EFI firmware to create memory
  reservations that persist across kexec.
- Add page fault handling to the runtime services support code on x86 so
  we can gracefully recover from buggy EFI firmware.
- Fix command line handling on x86 for the boot path that omits the stub's
  PE/COFF entry point.
- Other assorted fixes.

----------------------------------------------------------------
Aaron Ma (1):
      efi/x86: earlyprintk - Add 64bit efi fb address support

Alistair Strachan (1):
      efi/libstub: arm: support building with clang

Ard Biesheuvel (3):
      efi: honour memory reservations passed via a linux specific config table
      efi/arm: libstub: add a root memreserve config table
      efi: add API to reserve memory persistently across kexec reboot

Ben Hutchings (1):
      x86: boot: Fix EFI stub alignment

Hans de Goede (1):
      efi/x86: Call efi_parse_options() from efi_main()

Ivan Hu (1):
      efi/efi_test: add exporting ResetSystem runtime service

Sai Praneeth (2):
      efi: Make efi_rts_work accessible to efi page fault handler
      efi/x86: Handle page faults occurring while running EFI runtime services

Sebastian Andrzej Siewior (1):
      efi/x86: drop task_lock() from efi_switch_mm()

 arch/x86/boot/compressed/eboot.c        | 10 +++++
 arch/x86/boot/tools/build.c             |  7 +++
 arch/x86/include/asm/efi.h              |  1 +
 arch/x86/mm/fault.c                     |  9 ++++
 arch/x86/platform/efi/early_printk.c    |  8 +++-
 arch/x86/platform/efi/efi_64.c          | 10 ++---
 arch/x86/platform/efi/quirks.c          | 78 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c              | 59 ++++++++++++++++++++++++-
 drivers/firmware/efi/libstub/Makefile   |  3 +-
 drivers/firmware/efi/libstub/arm-stub.c | 27 ++++++++++++
 drivers/firmware/efi/runtime-wrappers.c | 61 +++++++-------------------
 drivers/firmware/efi/test/efi_test.c    | 27 ++++++++++++
 drivers/firmware/efi/test/efi_test.h    | 10 +++++
 include/linux/efi.h                     | 51 +++++++++++++++++++++
 14 files changed, 307 insertions(+), 54 deletions(-)
