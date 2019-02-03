Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADEEC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C052082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfBCO2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:28:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55468 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730001AbfBCOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:34 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdN-0006KL-Jh; Sun, 03 Feb 2019 14:20:33 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006tI-F7; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Biggers" <ebiggers@google.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.503687335@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 074/305] ima: fix showing large 'violations' or
 'runtime_measurements_count'
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 1e4c8dafbb6bf72fb5eca035b861e39c5896c2b7 upstream.

The 12 character temporary buffer is not necessarily long enough to hold
a 'long' value.  Increase it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/integrity/ima/ima_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -26,14 +26,14 @@
 #include "ima.h"
 
 static int valid_policy = 1;
-#define TMPBUFLEN 12
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
-	char tmpbuf[TMPBUFLEN];
+	char tmpbuf[32];	/* greater than largest 'long' string value */
 	ssize_t len;
 
-	len = scnprintf(tmpbuf, TMPBUFLEN, "%li\n", atomic_long_read(val));
+	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 

