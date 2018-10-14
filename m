Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EAC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5669720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5669720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeJNXrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:47:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35588 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbeJNXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cS-Fs; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00008u-8L; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>,
        "Mark Brown" <broonie@kernel.org>,
        "David Rhodes" <david.rhodes@cirrus.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.939677843@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 007/366] regmap: Don't use format_val in regmap_bulk_read
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 9ae27a8d1f3ebff09191fb8cb1341414547293b2 upstream.

A bulk read can be implemented either through regmap_raw_read, or
by reading each register individually using regmap_read.  Both
regmap_read and regmap_bulk_read should return values in native
endian. In the individual case the current implementation calls
format_val to put the data into the output array, which can cause
endian issues. The regmap_read will have already converted the data
into native endian, if the hosts endian differs from the device then
format_val will switch the endian back again.

Rather than using format_val simply use the code that is called if
there is no format_val function. This code supports all cases except
24-bit but there don't appear to be any users of regmap_bulk_read for
24-bit. Additionally, it would have to be a big endian host for the
old code to actually function correctly anyway.

Fixes: 15b8d2c41fe5 ("regmap: Fix regmap_bulk_read in BE mode")
Reported-by: David Rhodes <david.rhodes@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[bwh: Backported to 3.16:
 - 64-bit I/O is not supported
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2240,39 +2240,30 @@ int regmap_bulk_read(struct regmap *map,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
 	} else {
+		u32 *u32 = val;
+		u16 *u16 = val;
+		u8 *u8 = val;
+
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
+
 			ret = regmap_read(map, reg + (i * map->reg_stride),
 					  &ival);
 			if (ret != 0)
 				return ret;
 
-			if (map->format.format_val) {
-				map->format.format_val(val + (i * val_bytes), ival, 0);
-			} else {
-				/* Devices providing read and write
-				 * operations can use the bulk I/O
-				 * functions if they define a val_bytes,
-				 * we assume that the values are native
-				 * endian.
-				 */
-				u32 *u32 = val;
-				u16 *u16 = val;
-				u8 *u8 = val;
-
-				switch (map->format.val_bytes) {
-				case 4:
-					u32[i] = ival;
-					break;
-				case 2:
-					u16[i] = ival;
-					break;
-				case 1:
-					u8[i] = ival;
-					break;
-				default:
-					return -EINVAL;
-				}
+			switch (map->format.val_bytes) {
+			case 4:
+				u32[i] = ival;
+				break;
+			case 2:
+				u16[i] = ival;
+				break;
+			case 1:
+				u8[i] = ival;
+				break;
+			default:
+				return -EINVAL;
 			}
 		}
 	}

