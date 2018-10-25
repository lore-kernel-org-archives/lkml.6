Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D415C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJYQKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:10:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:57378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbeJYQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:10:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E298AF63;
        Thu, 25 Oct 2018 07:38:28 +0000 (UTC)
Date:   Thu, 25 Oct 2018 09:38:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 4.20
Message-ID: <20181025073832.GA13240@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the EDAC tree was busier than usual this cycle as the shortlog below
shows.

There's a merge commit of a shared base with tip's x86/cpu branch, which
is part of this merge commit

  fec98069fb72 ("Merge branch 'x86-cpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

in your tree. It needed to be done in order to pick up dependent changes
for Hygon Dhyana's addition to amd64_edac.

Also, this pull request is carrying an ACPI DSM driver which is used
to ask the platform to supply the DIMM location of a reported hardware
error and thus simplify all the EDAC logic when trying to map the error
address to the respective DIMM.

That driver got committed to the tree a bit late for my taste and it
doesn't have a user yet - that user is soaking here:

  https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-for-4.20-skx-3

and I'm planing to send it to you at the end of the merge window after
it has been tested a couple more times.

Now, any concerns about the introduction of potential regressions due to
its timely addition should be dwarfed by it falling into the category of
future firmware/hardware enablement and that hardware not shipping yet.
So, as it is, it should not break any existing users of skx_edac.

But, if you still feel that this should soak more and get more
hammering, lemme know and I'll redo the pull request accordingly.

I have added the relevant gents to CC, should you have any further
questions.

Please pull,
thanks!

--
The following changes since commit c9661c1e80b609cd038db7c908e061f0535804ef:

  x86/cpu: Create Hygon Dhyana architecture support file (2018-09-27 16:14:05 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_4.20

for you to fetch changes up to 4cf841e398503990df640f7a7c5b2ea56f11c08c:

  ACPI/ADXL: Add address translation interface using an ACPI DSM (2018-10-16 10:03:00 +0200)

----------------------------------------------------------------
- amd64_edac: AMD family 0x17, models 0x10-0x2f support (Michael Jin)
	      Hygon Dhyana support (Pu Wen)

- sb_edac: New maintainer + fixes (Tony Luck)
	   Error reporting improvements and fixes (Qiuxu Zhuo)

- ghes_edac: SMBIOS handle type 17 for DIMM locating and per-DIMM error
	     accounting (Fan Wu)

- altera_edac: Stratix10 support and refactoring (Thor Thayer)

Out of tree addition:

- acpi_adxl: Address Translation interface using an ACPI DSM (Tony Luck)

- the usual amount of other misc fixes and cleanups all over.

----------------------------------------------------------------
Andy Shevchenko (1):
      EDAC: Get rid of custom ICPU() macro

Arnd Bergmann (1):
      EDAC, altera: Work around int-to-pointer-cast warnings

Borislav Petkov (1):
      Merge branch 'tip-x86-hygon' into edac-for-4.20

Dan Carpenter (1):
      EDAC, thunderx: Fix memory leak in thunderx_l2c_threaded_isr()

Fan Wu (1):
      EDAC, ghes: Use CPER module handles to locate DIMMs

Justin Ernst (1):
      EDAC: Raise the maximum number of memory controllers

Michael Jin (1):
      EDAC, amd64: Add Family 17h, models 10h-2fh support

Pu Wen (1):
      EDAC, amd64: Add Hygon Dhyana support

Qiuxu Zhuo (4):
      EDAC, sb_edac: Return early on ADDRV bit and address type test
      EDAC, sb_edac: Fix reporting for patrol scrubber errors
      EDAC: Correct DIMM capacity unit symbol
      EDAC, skx_edac: Fix logical channel intermediate decoding

Thor Thayer (6):
      arm64: dts: stratix10: Additions to EDAC System Manager
      EDAC, altera: Combine Stratix10 and Arria10 probe functions
      arm64: dts: stratix10: Add SDRAM node
      EDAC, altera: Merge Stratix10 into the Arria10 SDRAM probe routine
      EDAC, altera: Add Stratix10 peripheral support
      arm64: dts: stratix10: Add peripheral EDAC nodes

Tony Luck (4):
      MAINTAINERS: Update maintainer for drivers/edac/sb_edac.c
      EDAC, sb_edac: Fix signedness bugs in *_get_ha() functions
      EDAC, {i7core,sb,skx}_edac: Fix uncorrected error counting
      ACPI/ADXL: Add address translation interface using an ACPI DSM

YueHaibing (1):
      EDAC, i7core: Remove set but not used variable pvt

 MAINTAINERS                                       |   3 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi |  37 +-
 drivers/acpi/Kconfig                              |   3 +
 drivers/acpi/Makefile                             |   3 +
 drivers/acpi/acpi_adxl.c                          | 192 +++++++
 drivers/edac/altera_edac.c                        | 667 +++++++---------------
 drivers/edac/altera_edac.h                        |  73 +--
 drivers/edac/amd64_edac.c                         |  24 +-
 drivers/edac/amd64_edac.h                         |   3 +
 drivers/edac/ghes_edac.c                          |  23 +
 drivers/edac/i3200_edac.c                         |   2 +-
 drivers/edac/i7core_edac.c                        |   5 +-
 drivers/edac/mce_amd.c                            |   4 +-
 drivers/edac/sb_edac.c                            | 204 +++++--
 drivers/edac/skx_edac.c                           |   7 +-
 drivers/edac/thunderx_edac.c                      |   4 +-
 include/linux/adxl.h                              |  13 +
 include/linux/edac.h                              |   5 +-
 18 files changed, 715 insertions(+), 557 deletions(-)
 create mode 100644 drivers/acpi/acpi_adxl.c
 create mode 100644 include/linux/adxl.h

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
