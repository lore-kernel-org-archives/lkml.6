Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B71ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3822064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8GJ596u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3822064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeGWXZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:25:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54537 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbeGWXZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:25:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so581858wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7solSrVdPRwjnV/M/sUvZyZgjJdnb6BWxwHcSoLmjtI=;
        b=I8GJ596uxBJK2EAdsBb74r1/mAO/xQ3s19LVL9Jn7CvwTZkoS+KL3DRRYpY7Bw/ya8
         hk+AG0R8aJziYUWYTnRr5B5D023Z7fank6nGdu4Nc6P85mtKTo0tkIlkhjiIsF4Ukrif
         q5tPTQaZ60uq92YRZGkUjHtGmd1HpZlXLXGfvymnH0zKLKcYP9Tcugf3xGuvRBAf0/pC
         2TSZ4GIJUyvC+ujAGUgM7Y5uLF12KvXjXSgRJEXv9q9fV5iLpLdpsaJ+r9X9wa4WeQcU
         nCU+surF9Piltu2Iu1SBDoGYR/0HK6007O/+Pf7v7u++VLP9yN5LyMjsUWyM/L8Ci2ZQ
         hnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7solSrVdPRwjnV/M/sUvZyZgjJdnb6BWxwHcSoLmjtI=;
        b=plQa0YdPB3OH+kGzPNEuaMFB61SoA+ElnqXclwlWI4KPZlUPGSYIEy3H/wQrIcHJHx
         vhIKDgr6rjwEQLmKVLZl29RhLt4d0mAJ5A5d/Ea4Ak5egiiCGwxKaENVVi6+nRaifhx+
         vlimc3AZ+gJfcXk2b4wAcNGaOG9vAm2SwM2hJ2AcsU0jaYmPiM8Jea1O8+zJLEtkwpJc
         U95b69ugOyulMM4uCfwSUelJrnelcj0Gvw/bJoQx92yacX1mN9UYNly18XRebQWoijSt
         /ssC9NHBvdPEtGpLl7zCx52wsBSDuXzn4vnNF9gfsF3+VzPkPz0yInYhTKkvYZExRgN0
         QD6A==
X-Gm-Message-State: AOUpUlHnBS++gLIxET2Dc5HY/kj7v1WrftunfU7NJhad7REcFMYr5eZR
        Uu1pCxcbP/udOWm0zsZOYvo=
X-Google-Smtp-Source: AAOMgpf2LYXBJDZGdqU2V4S3zcwM7REPI/Cg8VGqg4qSCKaRlYlk/ko+rRzCPD4SSyM/DWyFe40VaQ==
X-Received: by 2002:a1c:6f88:: with SMTP id c8-v6mr403187wmi.49.1532384506814;
        Mon, 23 Jul 2018 15:21:46 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id j3-v6sm11869387wrt.70.2018.07.23.15.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:21:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 5AA99640805;
        Tue, 24 Jul 2018 01:21:44 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g3oZ6ceysNUF; Tue, 24 Jul 2018 01:21:42 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id CC3A96408BB; Tue, 24 Jul 2018 01:21:42 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     aaro.koskinen@iki.fi, jhogan@kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Georgios Tsotsos <tsotsos@gmail.com>
Subject: [PATCH] Staging: octeon: Apply Licence and resolves warnings according to TODO list. There are also a few "checks" that probably should revised but i think most of them could be resolved by breaking down cvmx_usb_poll_channel()
Date:   Tue, 24 Jul 2018 01:21:17 +0300
Message-Id: <20180723222117.542-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 55 ++++++++++++++++++---------------
 drivers/staging/octeon-usb/octeon-hcd.h |  1 +
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cded30f145aa..472ad5917ad2 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -377,27 +378,29 @@ struct octeon_hcd {
 };
 
 /* This macro spins on a register waiting for it to reach a condition. */
-#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	    \
-	({int result;							    \
-	do {								    \
-		u64 done = cvmx_get_cycle() + (u64)timeout_usec *	    \
-			   octeon_get_clock_rate() / 1000000;		    \
-		union _union c;						    \
-									    \
-		while (1) {						    \
-			c.u32 = cvmx_usb_read_csr32(usb, address);	    \
-									    \
-			if (cond) {					    \
-				result = 0;				    \
-				break;					    \
-			} else if (cvmx_get_cycle() > done) {		    \
-				result = -1;				    \
-				break;					    \
-			} else						    \
-				__delay(100);				    \
-		}							    \
-	} while (0);							    \
-	result; })
+#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	\
+({									\
+	int result;							\
+	do {								\
+		u64 done = cvmx_get_cycle() + (u64)(timeout_usec) *	\
+			   octeon_get_clock_rate() / 1000000;		\
+		union _union c;						\
+									\
+		while (1) {						\
+			c.u32 = cvmx_usb_read_csr32(usb, address);	\
+									\
+			if (cond) {					\
+				result = 0;				\
+				break;					\
+			} else if (cvmx_get_cycle() > done) {		\
+				result = -1;				\
+				break;					\
+			} else						\
+				__delay(100);				\
+		}							\
+	} while (0);							\
+	result;								\
+})
 
 /*
  * This macro logically sets a single field in a CSR. It does the sequence
@@ -2636,12 +2639,14 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 				hcintmsk.u32 = 0;
 				hcintmsk.s.chhltdmsk = 1;
 				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCINTMSKX(channel, usb->index),
-						     hcintmsk.u32);
+						CVMX_USBCX_HCINTMSKX(channel,
+						usb->index),
+						hcintmsk.u32);
 				usbc_hcchar.s.chdis = 1;
 				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCCHARX(channel, usb->index),
-						     usbc_hcchar.u32);
+						CVMX_USBCX_HCCHARX(channel,
+						usb->index),
+						usbc_hcchar.u32);
 				return 0;
 			} else if (usbc_hcint.s.xfercompl) {
 				/*
diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
index 3353aefe662e..769c36cf6614 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.h
+++ b/drivers/staging/octeon-usb/octeon-hcd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Octeon HCD hardware register definitions.
  *
-- 
2.16.4

