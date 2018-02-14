Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031068AbeBNOya (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:54:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:40069 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030382AbeBNOy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:54:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="30710983"
Date: Wed, 14 Feb 2018 22:51:43 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/char/tpm/tpm_eventlog_efi.c:53:23-30: WARNING opportunity
 for kmemdep
Message-ID: <201802142241.R6vMmx0M%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   61f14c015f5be9151ba25e638d349f4d40cb7cd4
commit: 58cc1e4faf10a73c4302825ffd37a47d410fc1b5 tpm: parse TPM event logs based on EFI table
date:   5 weeks ago


coccinelle warnings: (new ones prefixed by >>)

>> drivers/char/tpm/tpm_eventlog_efi.c:53:23-30: WARNING opportunity for kmemdep

vim +53 drivers/char/tpm/tpm_eventlog_efi.c

    22	
    23		struct linux_efi_tpm_eventlog *log_tbl;
    24		struct tpm_bios_log *log;
    25		u32 log_size;
    26		u8 tpm_log_version;
    27	
    28		if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
    29			return -ENODEV;
    30	
    31		if (efi.tpm_log == EFI_INVALID_TABLE_ADDR)
    32			return -ENODEV;
    33	
    34		log = &chip->log;
    35	
    36		log_tbl = memremap(efi.tpm_log, sizeof(*log_tbl), MEMREMAP_WB);
    37		if (!log_tbl) {
    38			pr_err("Could not map UEFI TPM log table !\n");
    39			return -ENOMEM;
    40		}
    41	
    42		log_size = log_tbl->size;
    43		memunmap(log_tbl);
    44	
    45		log_tbl = memremap(efi.tpm_log, sizeof(*log_tbl) + log_size,
    46				   MEMREMAP_WB);
    47		if (!log_tbl) {
    48			pr_err("Could not map UEFI TPM log table payload!\n");
    49			return -ENOMEM;
    50		}
    51	
    52		/* malloc EventLog space */
  > 53		log->bios_event_log = kmalloc(log_size, GFP_KERNEL);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
