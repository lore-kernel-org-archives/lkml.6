Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6017D2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6017D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbeKLFzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51826 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbeKLFzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtC-0000l6-OD; Sun, 11 Nov 2018 19:59:22 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001P0-FO; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Hendrik Brueckner" <brueckner@linux.ibm.com>,
        "Thomas Richter" <tmricht@linux.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.550935653@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 037/366] s390/cpum_sf: Add data entry sizes to
 sampling trailer entry
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

commit 77715b7ddb446bd39a06f3376e85f4bb95b29bb8 upstream.

The CPU Measurement sampling facility creates a trailer entry for each
Sample-Data-Block of stored samples. The trailer entry contains the sizes
(in bytes) of the stored sampling types:
 - basic-sampling data entry size
 - diagnostic-sampling data entry size
Both sizes are 2 bytes long.

This patch changes the trailer entry definition to reflect this.

Fixes: fcc77f507333 ("s390/cpum_sf: Atomically reset trailer entry fields of sample-data-blocks")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/include/asm/cpu_mf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -134,7 +134,9 @@ struct hws_trailer_entry {
 			unsigned int f:1;	/* 0 - Block Full Indicator   */
 			unsigned int a:1;	/* 1 - Alert request control  */
 			unsigned int t:1;	/* 2 - Timestamp format	      */
-			unsigned long long:61;	/* 3 - 63: Reserved	      */
+			unsigned int :29;	/* 3 - 31: Reserved	      */
+			unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
+			unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
 		};
 		unsigned long long flags;	/* 0 - 63: All indicators     */
 	};

