Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C62AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6CA22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/UDKhyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6CA22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeKOEAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:00:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41648 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOEAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:00:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so8275225pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/gFgsl0bsNkHR/7/X8VMDkU2ct6+OqwgkAS4l61N8P8=;
        b=f/UDKhylvpmxx8A1SNBMnMG/Vta3kHKqJXBEK4OkNfRvA8e4NF7pWL49Ms44fJe64m
         CQxeAeEMXUm8cppFxTb2fPHekfVaPqlimqfLd1Jqyv9j5HpJAvmwckyxFjl0oJqCSwp0
         jAS6e5djoM94wnrsLcy9N3nPlURXr0lcjnEGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/gFgsl0bsNkHR/7/X8VMDkU2ct6+OqwgkAS4l61N8P8=;
        b=Jrk6sgTTcv9/wTtlkAfThbk4VUZHlVbodwGWN+CaxezVKpqIfPwjGwnf9vpM2N+0+k
         6eaw8lY7m/X+iCz+rYkpWpN6qy38BH52qf8uZKpRkwhrpMJRk2Ez8IZoODehDRBoijF7
         G+RLp7o0PK5xJbF+8muyV8+jYLCKLEL5SGFwq1adAHPRI+dmzFTvPOWtmjNJrpsClOii
         6O+f3hJ3c9fyxpMx2yDg9se8NB+qQQ8NQFroLDWzsVvKinvBf2HD/19L9etlHEMMRK8i
         VTCHyTk2YmdjI+J29jS2D/5HMt9NTTUrYspqjsJC85PKevjo/x298uGJ7enik9BWPOpX
         Isiw==
X-Gm-Message-State: AGRZ1gL6rjfJ8B8tNxeQpNlVZJsHt5twpTEd03eyBHvCDBHMUJPqCVYm
        2geIwq2ZqJfz1i9IJSOpzv00omLPTGBP1w==
X-Google-Smtp-Source: AJdET5c6CG3bXpETDyM7w7gyxnCZNi1ucZHkX5iMeD22RQ8bOO6HOwybt7bVeDrmxguo68nRle1rYw==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr2674292pgt.243.1542218156773;
        Wed, 14 Nov 2018 09:55:56 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id i2-v6sm21301738pgq.35.2018.11.14.09.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:55:55 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [GIT PULL 0/5] EFI fixes for v4.20
Date:   Wed, 14 Nov 2018 09:55:39 -0800
Message-Id: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to 844d2592ed2f1903f8e38d8d395fd0d38ecdd536:

  efi: permit calling efi_mem_reserve_persistent from atomic context (2018-11-14 05:49:28 -0800)

----------------------------------------------------------------
EFI fixes for v4.20:
- fix incorrect 'on stack' annotation of efi_rts_work (all EFI arches)
- revert deferred memory map unmapping on ARM
- pack the FDT before handing over to the OS (ARM, arm64)
- fixes for new persistent memreserve feature (ARM, arm64)

----------------------------------------------------------------
Ard Biesheuvel (4):
      efi: arm: revert deferred unmap of early memmap mapping
      efi/arm: libstub: pack FDT after populating it
      efi/arm: defer persistent reservations until after paging_init()
      efi: permit calling efi_mem_reserve_persistent from atomic context

Waiman Long (1):
      efi: Fix debugobjects warning on efi_rts_work

 arch/arm64/kernel/setup.c               |  1 +
 drivers/firmware/efi/arm-init.c         |  4 ++++
 drivers/firmware/efi/arm-runtime.c      |  2 +-
 drivers/firmware/efi/efi.c              | 35 ++++++++++++++++++++++-----------
 drivers/firmware/efi/libstub/arm-stub.c |  3 +++
 drivers/firmware/efi/libstub/fdt.c      |  4 ++++
 drivers/firmware/efi/memmap.c           |  3 +++
 drivers/firmware/efi/runtime-wrappers.c |  2 +-
 include/linux/efi.h                     |  7 +++++++
 9 files changed, 47 insertions(+), 14 deletions(-)
