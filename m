Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeFETIM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:08:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38726 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFETIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:08:11 -0400
X-Google-Smtp-Source: ADUXVKLR+irgySyvG4afOyCFJaU5Ba7pCI8wYwRq3B2W+sEgOzMdZ0Stq0sWNnsvygQmvpqwByXBNw==
Date: Tue, 5 Jun 2018 12:08:07 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [GIT PULL 1/2] libata changes for v4.18-rc1
Message-ID: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

These two are fixes which missed v4.17.  I tried to merge these into
libata/for-4.18 but couldn't make "git request-pull" not generate huge
spurious diffstat without merging v4.17 in the middle, so I'm sending
them out as two spearate pull request.  Pulling into master should be
clean for both.

One is to remove an incorrect power management blacklist entry and the
other to fix a cdb buffer overrun which has been there for a very long
time.

The following changes since commit 4544e403eb25552aed7f0ee181a7a506b8800403:

  ahci: Add PCI ID for Cannon Lake PCH-LP AHCI (2018-05-24 07:03:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.17-fixes

for you to fetch changes up to 2cfce3a86b64b53f0a70e92a6a659c720c319b45:

  libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk (2018-05-31 08:45:37 -0700)

----------------------------------------------------------------
Dan Carpenter (1):
      libata: zpodd: small read overflow in eject_tray()

Hans de Goede (1):
      libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

 drivers/ata/libata-core.c  | 3 ---
 drivers/ata/libata-zpodd.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 346b163..9bfd2f7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4557,9 +4557,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 
-	/* Sandisk devices which are known to not handle LPM well */
-	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
-
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index de4ddd0..b3ed8f9 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -35,7 +35,7 @@ struct zpodd {
 static int eject_tray(struct ata_device *dev)
 {
 	struct ata_taskfile tf;
-	static const char cdb[] = {  GPCMD_START_STOP_UNIT,
+	static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_START_STOP_UNIT,
 		0, 0, 0,
 		0x02,     /* LoEj */
 		0, 0, 0, 0, 0, 0, 0,
-- 
tejun
