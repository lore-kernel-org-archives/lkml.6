Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C39ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658C02148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658C02148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbeIXRlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:41:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIXRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:41:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 511CE106F;
        Mon, 24 Sep 2018 11:39:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 055/105] partitions/aix: fix usage of uninitialized lv_info and lvname structures
Date:   Mon, 24 Sep 2018 13:33:41 +0200
Message-Id: <20180924113119.195864457@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit 14cb2c8a6c5dae57ee3e2da10fa3db2b9087e39e ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partitions/aix.c |    5 +++--
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


