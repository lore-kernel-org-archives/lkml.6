Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F9620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F9620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeLIWFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:05:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36914 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbeLIWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:05:17 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73K-0002ic-9t; Sun, 09 Dec 2018 21:55:54 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003Id-2U; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        "Mauricio Faria de Oliveira" <mfo@canonical.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.434579274@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 081/328] partitions/aix: fix usage of uninitialized
 lv_info and lvname structures
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mfo@canonical.com>

commit 14cb2c8a6c5dae57ee3e2da10fa3db2b9087e39e upstream.

The if-block that sets a successful return value in aix_partition()
uses 'lvip[].pps_per_lv' and 'n[].name' potentially uninitialized.

For example, if 'numlvs' is zero or alloc_lvn() fails, neither is
initialized, but are used anyway if alloc_pvd() succeeds after it.

So, make the alloc_pvd() call conditional on their initialization.

This has been hit when attaching an apparently corrupted/stressed
AIX LUN, misleading the kernel to pr_warn() invalid data and hang.

    [...] partition (null) (11 pp's found) is not contiguous
    [...] partition (null) (2 pp's found) is not contiguous
    [...] partition (null) (3 pp's found) is not contiguous
    [...] partition (null) (64 pp's found) is not contiguous

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 block/partitions/aix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -177,7 +177,7 @@ int aix_partition(struct parsed_partitio
 	u32 vgda_sector = 0;
 	u32 vgda_len = 0;
 	int numlvs = 0;
-	struct pvd *pvd;
+	struct pvd *pvd = NULL;
 	struct lv_info {
 		unsigned short pps_per_lv;
 		unsigned short pps_found;
@@ -231,10 +231,11 @@ int aix_partition(struct parsed_partitio
 				if (lvip[i].pps_per_lv)
 					foundlvs += 1;
 			}
+			/* pvd loops depend on n[].name and lvip[].pps_per_lv */
+			pvd = alloc_pvd(state, vgda_sector + 17);
 		}
 		put_dev_sector(sect);
 	}
-	pvd = alloc_pvd(state, vgda_sector + 17);
 	if (pvd) {
 		int numpps = be16_to_cpu(pvd->pp_count);
 		int psn_part1 = be32_to_cpu(pvd->psn_part1);

