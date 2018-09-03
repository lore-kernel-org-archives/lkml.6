Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B35C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461C22077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461C22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbeICVjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:39:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeICVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:39:43 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B91AD14;
        Mon,  3 Sep 2018 17:18:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Ofer Levi <oferle@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 066/165] arc: [plat-eznps] fix printk warning in arc/plat-eznps/mtm.c
Date:   Mon,  3 Sep 2018 18:55:52 +0200
Message-Id: <20180903165658.428765344@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 9e2ea405543d9ddfe05b351f1679e53bd9c11f80 ]

Fix printk format warning in arch/arc/plat-eznps/mtm.c:

In file included from ../include/linux/printk.h:7,
                 from ../include/linux/kernel.h:14,
                 from ../include/linux/list.h:9,
                 from ../include/linux/smp.h:12,
                 from ../arch/arc/plat-eznps/mtm.c:17:
../arch/arc/plat-eznps/mtm.c: In function 'set_mtm_hs_ctr':
../include/linux/kern_levels.h:5:18: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long int' [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^~~~~~
../include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
 #define KERN_ERR KERN_SOH "3" /* error conditions */
                  ^~~~~~~~
../include/linux/printk.h:308:9: note: in expansion of macro 'KERN_ERR'
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~
../arch/arc/plat-eznps/mtm.c:166:3: note: in expansion of macro 'pr_err'
   pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
   ^~~~~~
../arch/arc/plat-eznps/mtm.c:166:40: note: format string is defined here
   pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
                                       ~^
                                       %ld
The hs_ctr variable can just be int instead of long, so also change
kstrtol() to kstrtoint() and leave the format string as %d.

Also add 2 header files since they are used in mtm.c and we prefer
not to depend on accidental/indirect #includes.

Cc: linux-snps-arc@lists.infradead.org
Cc: Ofer Levi <oferle@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/plat-eznps/mtm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arc/plat-eznps/mtm.c
+++ b/arch/arc/plat-eznps/mtm.c
@@ -15,6 +15,8 @@
  */
 
 #include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <asm/arcregs.h>
@@ -157,10 +159,10 @@ void mtm_enable_core(unsigned int cpu)
 /* Verify and set the value of the mtm hs counter */
 static int __init set_mtm_hs_ctr(char *ctr_str)
 {
-	long hs_ctr;
+	int hs_ctr;
 	int ret;
 
-	ret = kstrtol(ctr_str, 0, &hs_ctr);
+	ret = kstrtoint(ctr_str, 0, &hs_ctr);
 
 	if (ret || hs_ctr > MT_HS_CNT_MAX || hs_ctr < MT_HS_CNT_MIN) {
 		pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",


