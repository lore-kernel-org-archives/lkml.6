Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeE3LNi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:13:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60707 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752266AbeE3LHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:32 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Raghava Aditya Renukunta" <RaghavaAditya.Renukunta@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.268473431@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 034/153] scsi: aacraid: Fix udev inquiry race condition
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

commit f4e8708d3104437fd7716e957f38c265b0c509ef upstream.

When udev requests for a devices inquiry string, it might create multiple
threads causing a race condition on the shared inquiry resource string.

Created a buffer with the string for each thread.

Fixes: 3bc8070fb75b3315 ([SCSI] aacraid: SMC vendor identification)
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.2:
 - s/sup_adap_info->adapter_type_text/dev->supplement_adapter_info.AdapterTypeText/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -758,8 +758,16 @@ static void setinqstr(struct aac_dev *de
 	memset(str, ' ', sizeof(*str));
 
 	if (dev->supplement_adapter_info.AdapterTypeText[0]) {
-		char * cp = dev->supplement_adapter_info.AdapterTypeText;
 		int c;
+		char *cp;
+		char *cname = kmemdup(dev->supplement_adapter_info.AdapterTypeText,
+				sizeof(dev->supplement_adapter_info.AdapterTypeText),
+								GFP_ATOMIC);
+
+		if (!cname)
+			return;
+
+		cp = cname;
 		if ((cp[0] == 'A') && (cp[1] == 'O') && (cp[2] == 'C'))
 			inqstrcpy("SMC", str->vid);
 		else {
@@ -768,8 +776,7 @@ static void setinqstr(struct aac_dev *de
 				++cp;
 			c = *cp;
 			*cp = '\0';
-			inqstrcpy (dev->supplement_adapter_info.AdapterTypeText,
-				   str->vid);
+			inqstrcpy(cname, str->vid);
 			*cp = c;
 			while (*cp && *cp != ' ')
 				++cp;
@@ -783,8 +790,8 @@ static void setinqstr(struct aac_dev *de
 			cp[sizeof(str->pid)] = '\0';
 		}
 		inqstrcpy (cp, str->pid);
-		if (c)
-			cp[sizeof(str->pid)] = c;
+
+		kfree(cname);
 	} else {
 		struct aac_driver_ident *mp = aac_get_driver_ident(dev->cardtype);
 
