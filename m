Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DFC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A43820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A43820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLIV5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:57:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36268 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbeLIVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:40 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW730-0002po-7a; Sun, 09 Dec 2018 21:55:35 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003Z2-Mf; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, xen-devel@lists.xenproject.org,
        "Thomas Gleixner" <tglx@linutronix.de>, jgross@suse.com,
        hpa@zytor.com, "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Andy Smith" <andy@strugglers.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.175880549@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 233/328] x86/EISA: Don't probe EISA bus for Xen PV guests
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit 6a92b11169a65b3f8cc512c75a252cbd0d096ba0 upstream.

For unprivileged Xen PV guests this is normal memory and ioremap will
not be able to properly map it.

While at it, since ioremap may return NULL, add a test for pointer's
validity.

Reported-by: Andy Smith <andy@strugglers.net>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: xen-devel@lists.xenproject.org
Cc: jgross@suse.com
Link: https://lkml.kernel.org/r/20180911195538.23289-1-boris.ostrovsky@oracle.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/eisa.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -6,11 +6,17 @@
 #include <linux/ioport.h>
 #include <linux/eisa.h>
 
+#include <xen/xen.h>
+
 static __init int eisa_bus_probe(void)
 {
-	void __iomem *p = ioremap(0x0FFFD9, 4);
+	void __iomem *p;
+
+	if (xen_pv_domain() && !xen_initial_domain())
+		return 0;
 
-	if (readl(p) == 'E' + ('I'<<8) + ('S'<<16) + ('A'<<24))
+	p = ioremap(0x0FFFD9, 4);
+	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
 		EISA_bus = 1;
 	iounmap(p);
 	return 0;

