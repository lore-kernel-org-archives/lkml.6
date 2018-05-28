Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034915AbeE1Pst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968289AbeE1KQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:16:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Parag Warudkar <parag.warudkar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 055/268] firmware: dmi_scan: Fix handling of empty DMI strings
Date: Mon, 28 May 2018 12:00:29 +0200
Message-Id: <20180528100208.150575457@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit a7770ae194569e96a93c48aceb304edded9cc648 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/dmi_scan.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -18,7 +18,7 @@ EXPORT_SYMBOL_GPL(dmi_kobj);
  * of and an antecedent to, SMBIOS, which stands for System
  * Management BIOS.  See further: http://www.dmtf.org/standards
  */
-static const char dmi_empty_string[] = "        ";
+static const char dmi_empty_string[] = "";
 
 static u32 dmi_ver __initdata;
 static u32 dmi_len;
@@ -44,25 +44,21 @@ static int dmi_memdev_nr;
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
