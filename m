Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69822175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfA3NBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:01:36 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:56870 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3NBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:01:36 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id C72DE6AB0CE;
        Wed, 30 Jan 2019 14:01:32 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 30 Jan
 2019 14:01:32 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 30 Jan 2019 14:01:32 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Schrempf Frieder" <frieder.schrempf@kontron.de>
Subject: [PATCH v3 0/5] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Topic: [PATCH v3 0/5] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Index: AQHUuJvsI+N0hB5xfUiobz2DATnTQw==
Date:   Wed, 30 Jan 2019 13:01:32 +0000
Message-ID: <20190130130111.32724-1-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: C72DE6AB0CE.A056D
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
Frieder Schrempf (5):
  mtd: nand: Always store info about bad block markers in chip struct
  mtd: nand: Make flags for bad block marker position more granular
  mtd: rawnand: Support bad block markers in first, second or last page
  mtd: rawnand: ESMT: Also use the last page for bad block markers
  mtd: rawnand: AMD: Also use the last page for bad block markers

 drivers/mtd/nand/onenand/onenand_base.c |  2 +-
 drivers/mtd/nand/onenand/onenand_bbt.c  |  2 +-
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
 include/linux/mtd/rawnand.h             | 16 +++++++
 15 files changed, 100 insertions(+), 62 deletions(-)

-- 
2.17.1
