Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D98C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B064B2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B064B2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=barracuda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGIOxJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:53:09 -0400
Received: from bsf02.barracuda.com ([64.235.145.82]:45319 "EHLO
        bsf02.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeGIOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:53:07 -0400
X-Greylist: delayed 1158 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 10:53:07 EDT
X-ASG-Debug-ID: 1531146828-08636c15548e1510001-xx1T2L
Received: from IP-SCL-EXCH03.ad.cuda-inc.com (exchange.cuda-inc.com [10.8.96.79]) by bsf02.barracuda.com with ESMTP id HWrLP8taBTQfuzJY (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 09 Jul 2018 07:33:48 -0700 (PDT)
X-Barracuda-Envelope-From: jkuhn@barracuda.com
Received: from jkuhn-ubuntu-docker-host.cuda-inc.com (10.26.137.227) by
 IP-SCL-EXCH03.ad.cuda-inc.com (10.8.96.79) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Jul 2018 07:33:46 -0700
From:   Jon Kuhn <jkuhn@barracuda.com>
To:     Steve French <sfrench@samba.org>
CC:     Jon Kuhn <jkuhn@barracuda.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/cifs: don't translate SFM_SLASH (U+F026) to backslash
Date:   Mon, 9 Jul 2018 14:33:14 +0000
X-ASG-Orig-Subj: [PATCH] fs/cifs: don't translate SFM_SLASH (U+F026) to backslash
Message-ID: <20180709143314.4378-1-jkuhn@barracuda.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.26.137.227]
X-ClientProxiedBy: IP-MDW-EXCH03.ad.cuda-inc.com (10.16.96.23) To
 IP-SCL-EXCH03.ad.cuda-inc.com (10.8.96.79)
X-Barracuda-Connect: exchange.cuda-inc.com[10.8.96.79]
X-Barracuda-Start-Time: 1531146828
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://bsf02.barracuda.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at barracuda.com
X-Barracuda-Malware-Scanned: by bsmtpd at barracuda.com
X-Barracuda-Scan-Msg-Size: 1360
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using per-user scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.53280
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a Mac client saves an item containing a backslash to a file server
the backslash is represented in the CIFS/SMB protocol as as U+F026.
Before this change, listing a directory containing an item with a
backslash in its name will return that item with the backslash
represented with a true backslash character (U+005C) because
convert_sfm_character mapped U+F026 to U+005C when interpretting the
CIFS/SMB protocol response.  However, attempting to open or stat the
path using a true backslash will result in an error because
convert_to_sfm_char does not map U+005C back to U+F026 causing the
CIFS/SMB request to be made with the backslash represented as U+005C.

This change simply prevents the U+F026 to U+005C conversion from
happenning.  This is analogous to how the code does not do any
translation of UNI_SLASH (U+F000).

Signed-off-by: Jon Kuhn <jkuhn@barracuda.com>
---
 fs/cifs/cifs_unicode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/cifs/cifs_unicode.c b/fs/cifs/cifs_unicode.c
index b380e087..a2b2355e 100644
--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -105,9 +105,6 @@ convert_sfm_char(const __u16 src_char, char *target)
 	case SFM_LESSTHAN:
 		*target = '<';
 		break;
-	case SFM_SLASH:
-		*target = '\\';
-		break;
 	case SFM_SPACE:
 		*target = ' ';
 		break;
-- 
2.17.1


===========================================================
Learn how to protect users, data, and applications with security engineered for the public cloud by Barracuda. http://barracuda.com

DISCLAIMER:
This e-mail and any attachments to it contain confidential and proprietary material of Barracuda, its affiliates or agents, and is solely for the use of the intended recipient. Any review, use, disclosure, distribution or copying of this transmittal is prohibited except by or on behalf of the intended recipient. If you have received this transmittal in error, please notify the sender and destroy this e-mail and any attachments and all copies, whether electronic or printed.
===========================================================
