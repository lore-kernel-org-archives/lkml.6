Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30631ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA31221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA31221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbeIXS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbeIXS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2034F108B;
        Mon, 24 Sep 2018 12:24:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Smith <andy@strugglers.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        xen-devel@lists.xenproject.org, jgross@suse.com
Subject: [PATCH 4.14 105/173] x86/EISA: Dont probe EISA bus for Xen PV guests
Date:   Mon, 24 Sep 2018 13:52:19 +0200
Message-Id: <20180924113123.789577727@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180911195538.23289-1-boris.ostrovsky@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/eisa.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -7,11 +7,17 @@
 #include <linux/eisa.h>
 #include <linux/io.h>
 
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


