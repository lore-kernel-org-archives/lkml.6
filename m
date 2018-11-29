Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19596C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E312146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ml2JU/Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E312146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbeK3ESx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:18:53 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38282 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeK3ESx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:18:53 -0500
Received: by mail-wr1-f47.google.com with SMTP id v13so2678962wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDZYnVtWLsDZ/FqO2YF8F2ucRzaosHJ5NrkNw1iiQpo=;
        b=Ml2JU/Nsm+p9XVR71z8quf3XfYdTK3wh8gdPK7JrBkhEsNfHoBjIbdJMictHV6VIia
         kOcuJNuVjF0a5mL5I90XlyQhT/iChtysxrNZ01+e97JfECc8RRiUaLUXCpTtmv+FZdoW
         2cKtnuRV5EBG04O2JWiV94Nmbt6AUKs+F8sns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDZYnVtWLsDZ/FqO2YF8F2ucRzaosHJ5NrkNw1iiQpo=;
        b=nbJj8WKGqi1ZcjQTuxdzwDPt2BU7WM/wJJ6LdXLK7zExtmyc4aulGZ5JlCSRtPj1fq
         oDt4znrMkZ5+1iMVy5E72O1ZaPZ3KPlVoIU3UCW0wEEEAF6qgFmTn/W2+5ja26Q0ajWt
         tpK1Nxorg8qk6j/I1h6HCLcfywZndfbzsrGIgyXIj4nL/3jYfTk2K47C8DNLbt5JVW2K
         ONTk21il1avjqRzqrjqUMzOLqKsJ4mlaSra7zBFg0JbJ/kZeVU4g0hV+YMSwgrWUfMJ9
         /lgxFAhXGM9kJKvBGteH2yFxvwVmP/7+rdF/D2oB5x5E+bakwuPY9pX5bBtf73CCUt52
         QlFA==
X-Gm-Message-State: AA+aEWaz3Weg+v04Mf6gQMIKhseXY60xPbHqpAsto1tMEQmRmqC5BosD
        dZxU/9Q+ttzWCVViiiETxv/yQg==
X-Google-Smtp-Source: AFSGD/WLspHd9RCIef2tbaSJ9hXUUUXe/4BSL/eZ7lxWsDKjRSiuDtc8stzOOvwqbO0zYGWuI7rdkw==
X-Received: by 2002:adf:8421:: with SMTP id 30mr2223962wrf.153.1543511567279;
        Thu, 29 Nov 2018 09:12:47 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:46 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [GIT PULL 00/11] EFI updates
Date:   Thu, 29 Nov 2018 18:12:19 +0100
Message-Id: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 976b489120cdab2b1b3a41ffa14661db43d58190:

  efi: Prevent GICv3 WARN() by mapping the memreserve table before first use (2018-11-27 13:50:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to 1d29afdbf7ae878a23627ebee81efcd213f11749:

  efi/x86: earlyprintk - Fix infinite loop on some screen widths (2018-11-28 17:58:42 +0100)

----------------------------------------------------------------
EFI updates for v4.21:
- Allocate the E820 buffer before doing the GetMemoryMap/ExitBootServices
  dance so we don't run out of space (Eric)
- Clear EFI boot services mappings when freeing the memory (Sai)
- Harden efivars against callers that invoke it on non-EFI boots (Arend)
- Reduce the number of memblock reservations resulting from extensive
  use of the new efi_mem_reserve_persistent() API (Ard)
- Other assorted fixes and cleanups.

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi: permit multiple entries in persistent memreserve data structure
      efi: reduce the amount of memblock reservations for persistent allocations

Arend van Spriel (1):
      firmware: efi: add NULL pointer checks in efivars api functions

Eric Snowberg (1):
      x86/efi: Allocate e820 buffer before calling efi_exit_boot_service

Julien Thierry (2):
      efi/fdt: Indentation fix
      efi/fdt: Simplify get_fdt flow

Nathan Chancellor (1):
      efi/libstub: Disable some warnings for x86{,_64}

Sai Praneeth Prakhya (3):
      x86/mm/pageattr: Introduce helper function to unmap EFI boot services
      x86/efi: Unmap EFI boot services code/data regions from efi_pgd
      x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86

YiFei Zhu (1):
      efi/x86: earlyprintk - Fix infinite loop on some screen widths

 arch/x86/boot/compressed/eboot.c        | 65 ++++++++++++++--------
 arch/x86/include/asm/efi.h              |  2 +
 arch/x86/include/asm/pgtable_types.h    |  8 ++-
 arch/x86/mm/pageattr.c                  | 40 ++++++++++++-
 arch/x86/platform/efi/early_printk.c    |  2 +-
 arch/x86/platform/efi/efi.c             |  2 +
 arch/x86/platform/efi/quirks.c          | 25 +++++++++
 drivers/firmware/efi/efi.c              | 55 +++++++++++++-----
 drivers/firmware/efi/libstub/Makefile   |  5 +-
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 drivers/firmware/efi/libstub/fdt.c      | 30 +++++-----
 drivers/firmware/efi/vars.c             | 99 ++++++++++++++++++++++++++-------
 include/linux/efi.h                     | 19 +++++--
 init/main.c                             |  4 --
 14 files changed, 269 insertions(+), 89 deletions(-)
