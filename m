Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8wv4A4FCGVvEfAAAmS7hNA
	; Thu, 07 Jun 2018 14:35:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B619A607DC; Thu,  7 Jun 2018 14:35:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 21644601D2;
	Thu,  7 Jun 2018 14:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21644601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934048AbeFGOf2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:35:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40385 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933817AbeFGOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:35:23 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zw-8V; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yp-GE; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Parag Warudkar" <parag.warudkar@gmail.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Jean Delvare" <jdelvare@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.219715334@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 192/410] firmware: dmi_scan: Fix handling of empty
 DMI strings
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

commit a7770ae194569e96a93c48aceb304edded9cc648 upstream.

The handling of empty DMI strings looks quite broken to me:
* Strings from 1 to 7 spaces are not considered empty.
* True empty DMI strings (string index set to 0) are not considered
  empty, and result in allocating a 0-char string.
* Strings with invalid index also result in allocating a 0-char
  string.
* Strings starting with 8 spaces are all considered empty, even if
  non-space characters follow (sounds like a weird thing to do, but
  I have actually seen occurrences of this in DMI tables before.)
* Strings which are considered empty are reported as 8 spaces,
  instead of being actually empty.

Some of these issues are the result of an off-by-one error in memcmp,
the rest is incorrect by design.

So let's get it square: missing strings and strings made of only
spaces, regardless of their length, should be treated as empty and
no memory should be allocated for them. All other strings are
non-empty and should be allocated.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 79da4721117f ("x86: fix DMI out of memory problems")
Cc: Parag Warudkar <parag.warudkar@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/firmware/dmi_scan.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -15,7 +15,7 @@
  * of and an antecedent to, SMBIOS, which stands for System
  * Management BIOS.  See further: http://www.dmtf.org/standards
  */
-static const char dmi_empty_string[] = "        ";
+static const char dmi_empty_string[] = "";
 
 static u16 __initdata dmi_ver;
 /*
@@ -36,25 +36,21 @@ static int dmi_memdev_nr;
 static const char * __init dmi_string_nosave(const struct dmi_header *dm, u8 s)
 {
 	const u8 *bp = ((u8 *) dm) + dm->length;
+	const u8 *nsp;
 
 	if (s) {
-		s--;
-		while (s > 0 && *bp) {
+		while (--s > 0 && *bp)
 			bp += strlen(bp) + 1;
-			s--;
-		}
 
-		if (*bp != 0) {
-			size_t len = strlen(bp)+1;
-			size_t cmp_len = len > 8 ? 8 : len;
-
-			if (!memcmp(bp, dmi_empty_string, cmp_len))
-				return dmi_empty_string;
+		/* Strings containing only spaces are considered empty */
+		nsp = bp;
+		while (*nsp == ' ')
+			nsp++;
+		if (*nsp != '\0')
 			return bp;
-		}
 	}
 
-	return "";
+	return dmi_empty_string;
 }
 
 static const char * __init dmi_string(const struct dmi_header *dm, u8 s)
