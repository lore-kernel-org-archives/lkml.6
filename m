Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9389C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8236020880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8236020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeI3EaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:30:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51614 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbeI3ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000Gx-0g; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006yq-NE; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Markus Trippelsdorf" <markus@trippelsdorf.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.16014373@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 124/131] x86/tools: Fix gcc-7 warning in relocs.c
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Trippelsdorf <markus@trippelsdorf.de>

commit 7ebb916782949621ff6819acf373a06902df7679 upstream.

gcc-7 warns:

In file included from arch/x86/tools/relocs_64.c:17:0:
arch/x86/tools/relocs.c: In function ‘process_64’:
arch/x86/tools/relocs.c:953:2: warning: argument 1 null where non-null expected [-Wnonnull]
  qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/x86/tools/relocs.h:6:0,
                 from arch/x86/tools/relocs_64.c:1:
/usr/include/stdlib.h:741:13: note: in a call to function ‘qsort’ declared here
 extern void qsort

This happens because relocs16 is not used for ELF_BITS == 64,
so there is no point in trying to sort it.

Make the sort_relocs(&relocs16) call 32bit only.

Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>
Link: http://lkml.kernel.org/r/20161215124513.GA289@x4
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16: Also make sort_relocs(&relocs64) conditional,
 which was done upstream in commit 6d24c5f72dfb "x86-64: Handle PC-relative
 relocations on per-CPU data".]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -984,9 +984,12 @@ static void emit_relocs(int as_text, int
 		die("Segment relocations found but --realmode not specified\n");
 
 	/* Order the relocations for more efficient processing */
-	sort_relocs(&relocs16);
 	sort_relocs(&relocs32);
+#if ELF_BITS == 64
 	sort_relocs(&relocs64);
+#else
+	sort_relocs(&relocs16);
+#endif
 
 	/* Print the relocations */
 	if (as_text) {

