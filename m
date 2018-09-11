Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0191CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAAD206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAAD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeILClb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:41:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33573 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILClb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:41:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8BLdst52389069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Sep 2018 14:39:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8BLdsvg2389066;
        Tue, 11 Sep 2018 14:39:54 -0700
Date:   Tue, 11 Sep 2018 14:39:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Boris Ostrovsky <tipbot@zytor.com>
Message-ID: <tip-6a92b11169a65b3f8cc512c75a252cbd0d096ba0@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, andy@strugglers.net, boris.ostrovsky@oracle.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          boris.ostrovsky@oracle.com, andy@strugglers.net, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <20180911195538.23289-1-boris.ostrovsky@oracle.com>
References: <20180911195538.23289-1-boris.ostrovsky@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/EISA: Don't probe EISA bus for Xen PV guests
Git-Commit-ID: 6a92b11169a65b3f8cc512c75a252cbd0d096ba0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6a92b11169a65b3f8cc512c75a252cbd0d096ba0
Gitweb:     https://git.kernel.org/tip/6a92b11169a65b3f8cc512c75a252cbd0d096ba0
Author:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
AuthorDate: Tue, 11 Sep 2018 15:55:38 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 11 Sep 2018 23:36:50 +0200

x86/EISA: Don't probe EISA bus for Xen PV guests

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

---
 arch/x86/kernel/eisa.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index f260e452e4f8..e8c8c5d78dbd 100644
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
