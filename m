Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FCD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfBRKm3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:42:29 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:56694 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:42:28 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 6A949600387;
        Mon, 18 Feb 2019 11:42:18 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Feb
 2019 11:42:18 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 18 Feb 2019 11:42:18 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Schrempf Frieder" <frieder.schrempf@kontron.de>
Subject: [PATCH v4 0/7] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Topic: [PATCH v4 0/7] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Index: AQHUx3aePo7JMrWUtkuj0rXSuXPgHQ==
Date:   Mon, 18 Feb 2019 10:42:17 +0000
Message-ID: <20190218104122.18788-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 6A949600387.AC325
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Currently supported bad block marker positions within the block are:
* in first page only
* in last page only
* in first or second page

After some cleanup and preparation in patch 1 and 2, we make it
possible to set NAND_BBM_FIRSTPAGE, NAND_BBM_SECONDPAGE and
NAND_BBM_LASTPAGE independently of each other (patch 3).

Some ESMT NANDs are known to have been shipped by the manufacturer
with bad block markers in the first or last page, instead of the
first or second page.

Also the datasheets for Cypress/Spansion/AMD NANDs claim that the
first, second *and* last page needs to be checked.

Therefore in patch 4 and 5 we set all three flags for
AMD/Spansion/Cypress and ESMT chips.
---
Changes in v4:
==============
* Move onenand changes to separate patch
* Add missing badblockpos field to onenand_chip struct
* Move cleanup of badblockpos field and flags to separate patch
* Move assignemnt of badblockpos from onenand_bbt.c to onenand_base.c
* Fix incorrect usage of bbt_options in nand_bbt.c
* Add R-b tags

Changes in v3:
==============
* Fix bit offsets for new flags in nand_chip->options
* Move separation of flags for first and second page markers to a
  separate patch
* Fix cover letter
* Fix S-o-b tag
* Add R-b tags

Changes in v2:
==============
* Rebase on 5.0-rc1
* Add patch to move bad block marker position info to a common place and
  rename/prepare existing flags
* improve/rename function nand_bbm_get_next_page() to use new flags
---
Frieder Schrempf (7):
  mtd: rawnand: Always store info about bad block markers in chip struct
  mtd: onenand: Store bad block marker position in chip struct
  mtd: nand: Cleanup flags and fields for bad block marker position
  mtd: nand: Make flags for bad block marker position more granular
  mtd: rawnand: Support bad block markers in first, second or last page
  mtd: rawnand: ESMT: Also use the last page for bad block markers
  mtd: rawnand: AMD: Also use the last page for bad block markers

 drivers/mtd/nand/onenand/onenand_base.c |  5 +-
 drivers/mtd/nand/onenand/onenand_bbt.c  |  3 --
 drivers/mtd/nand/raw/internals.h        |  1 +
 drivers/mtd/nand/raw/nand_amd.c         |  8 +++-
 drivers/mtd/nand/raw/nand_base.c        | 64 +++++++++++++++++--------
 drivers/mtd/nand/raw/nand_bbt.c         | 28 +++++------
 drivers/mtd/nand/raw/nand_esmt.c        |  9 +++-
 drivers/mtd/nand/raw/nand_hynix.c       |  4 +-
 drivers/mtd/nand/raw/nand_macronix.c    |  2 +-
 drivers/mtd/nand/raw/nand_micron.c      |  2 +-
 drivers/mtd/nand/raw/nand_samsung.c     |  4 +-
 drivers/mtd/nand/raw/nand_toshiba.c     |  2 +-
 drivers/mtd/nand/raw/sh_flctl.c         |  4 +-
 include/linux/mtd/bbm.h                 | 14 +-----
 include/linux/mtd/onenand.h             |  3 ++
 include/linux/mtd/rawnand.h             | 15 ++++++
 16 files changed, 104 insertions(+), 64 deletions(-)

-- 
2.17.1
