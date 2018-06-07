Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vmhiMQJYGVsVfgAAmS7hNA
	; Thu, 07 Jun 2018 16:08:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E204E608B8; Thu,  7 Jun 2018 16:08:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5D492605A2;
	Thu,  7 Jun 2018 16:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D492605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934503AbeFGQFD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:05:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39257 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933019AbeFGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zn-90; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002on-4k; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Raghava Aditya Renukunta" <RaghavaAditya.Renukunta@microsemi.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.371512497@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 094/410] scsi: aacraid: Fix udev inquiry race condition
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

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

commit f4e8708d3104437fd7716e957f38c265b0c509ef upstream.

When udev requests for a devices inquiry string, it might create multiple
threads causing a race condition on the shared inquiry resource string.

Created a buffer with the string for each thread.

Fixes: 3bc8070fb75b3315 ([SCSI] aacraid: SMC vendor identification)
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.16:
 - s/sup_adap_info->adapter_type_text/dev->supplement_adapter_info.AdapterTypeText/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -770,8 +770,16 @@ static void setinqstr(struct aac_dev *de
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
@@ -780,8 +788,7 @@ static void setinqstr(struct aac_dev *de
 				++cp;
 			c = *cp;
 			*cp = '\0';
-			inqstrcpy (dev->supplement_adapter_info.AdapterTypeText,
-				   str->vid);
+			inqstrcpy(cname, str->vid);
 			*cp = c;
 			while (*cp && *cp != ' ')
 				++cp;
@@ -795,8 +802,8 @@ static void setinqstr(struct aac_dev *de
 			cp[sizeof(str->pid)] = '\0';
 		}
 		inqstrcpy (cp, str->pid);
-		if (c)
-			cp[sizeof(str->pid)] = c;
+
+		kfree(cname);
 	} else {
 		struct aac_driver_ident *mp = aac_get_driver_ident(dev->cardtype);
 
