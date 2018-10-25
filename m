Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF164C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B1420838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NgiuDA5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B1420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJYOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:48:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51372 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJYOsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:48:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9P6DhmE151806;
        Thu, 25 Oct 2018 06:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=/Q6KS1OSazIK805TNB4UP1WPq78ibI1NSa8qOZhJYxA=;
 b=NgiuDA5o8KeD8iXSO/PywAkZiZ03Seaye8NkpiDfxCmbR+PRJmv3iUJRA7RdBOGbuQvy
 MSzyAaxObodcGExBTJ2CMdK4Lmc+XQ1CtBO/Ddugovu/9HvSQZCYDybHXXUGHXSqGVrF
 6MRaZLZhJ/hyBEFU8eFQTBPNEyhg0hDcjRp3pyTEUwaE02YEWEL8oXkeEEUvxyWAkv+N
 oCcDOJbKL8L+KBDc2O/utYD7ddgeyDJHrBvoyFec2oAyhcoVrM8N7rXPUAhDaN2Y4gAR
 aos4hvpb9tXZ9G1gyonkNn3AFIprWqyRUn9j/78TQMpgpWWHxvM1GZvju3usLGHJFe1R Tg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usufhrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 06:16:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9P6GhfO000509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 06:16:43 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9P6Ggh7024848;
        Thu, 25 Oct 2018 06:16:42 GMT
Received: from kili.mountain (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 23:16:41 -0700
Date:   Thu, 25 Oct 2018 09:16:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/ioremap: tighten integer overflow checking
Message-ID: <20181025061633.t32bxslxj3h7jv2x@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current check is a bit off in the case where "phys_addr + size"
wraps to zero because then "last_addr" is set to ULONG_MAX which is >=
phys_addr.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/x86/mm/ioremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 5378d10f1d31..ee43df3ebe66 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -146,9 +146,9 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	void __iomem *ret_addr;
 
 	/* Don't allow wraparound or zero size */
-	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr)
+	if (!size || phys_addr + size < phys_addr)
 		return NULL;
+	last_addr = phys_addr + size - 1;
 
 	if (!phys_addr_valid(phys_addr)) {
 		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
-- 
2.11.0

