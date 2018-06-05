Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeFETPg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:15:36 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33303 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeFETP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:15:28 -0400
X-Google-Smtp-Source: ADUXVKLY4NNjeAIfyNh/HY6iWGz9PxUfW7+6mQe8njh42DoAXM1sdC4Xb6YlP4u9aOtNBpK2w8t0RQ==
Date: Tue, 5 Jun 2018 12:15:25 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [GIT PULL 2/2] libata changes for v4.18-rc1
Message-ID: <20180605191525.GF1351649@devbig577.frc2.facebook.com>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

This is the second part of libata pull request.

* libata has always been limiting the maximum queue depth to 31, 1 set
  aside mostly for historical reasons.  This didn't use to make much
  difference but Jens found out that modern hard drives can actually
  perform measurably better with the extra one queue depth.  Jens
  updated libata core so that it can make use of full 32 queue depth.

* Damien updated command retry logic in error handling so that it
  doesn't unnecessarily retry when upper layer (SCSI) is gonna handle
  them.

* A couple misc changes.

Thanks.

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.18

for you to fetch changes up to 88e10092f6a623b88808f782b6637162b5b658fb:

  sata_fsl: use the right type for tag bitshift (2018-05-14 08:14:21 -0700)

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: hpt37x: Convert to use match_string() helper

Christoph Hellwig (1):
      sata_nv: don't use block layer bounce buffer

Damien Le Moal (5):
      libata: Fix comment typo in ata_eh_analyze_tf()
      libata: Fix ata_err_string()
      libata: Make ata_dev_set_mode() less verbose
      libata: Honor RQF_QUIET flag
      libata: Fix command retry decision

Jens Axboe (10):
      libata: introduce notion of separate hardware tags
      libata: convert core and drivers to ->hw_tag usage
      libata: bump ->qc_active to a 64-bit type
      libata: use ata_tag_internal() consistently
      libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
      sata_nv: set host can_queue count appropriately
      libata: add extra internal command
      libata: don't clamp queue depth to ATA_MAX_QUEUE - 1
      ahci: enable full queue depth of 32
      sata_fsl: use the right type for tag bitshift

 drivers/ata/acard-ahci.c     |  4 +-
 drivers/ata/ahci.h           |  2 +-
 drivers/ata/libahci.c        |  8 ++--
 drivers/ata/libata-core.c    | 61 ++++++++++++---------------
 drivers/ata/libata-eh.c      | 56 ++++++++++++++++++++-----
 drivers/ata/libata-scsi.c    | 19 +++++----
 drivers/ata/pata_hpt37x.c    | 13 +++---
 drivers/ata/sata_dwc_460ex.c | 14 +++----
 drivers/ata/sata_fsl.c       | 10 ++---
 drivers/ata/sata_mv.c        | 26 ++++++------
 drivers/ata/sata_nv.c        | 98 +++++++++++++++++++-------------------------
 drivers/ata/sata_sil24.c     |  6 +--
 include/linux/libata.h       | 22 +++++-----
 13 files changed, 177 insertions(+), 162 deletions(-)

--
tejun
