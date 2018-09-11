Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B0BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376EB20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQ9Q4pLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376EB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeILA4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:56:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52502 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeILA4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:56:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8BJmqqV034405;
        Tue, 11 Sep 2018 19:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=yIwNgiKIZVqMhXkKWE4vmAFplcPMQ8sJVGtYgxV8ctA=;
 b=AQ9Q4pLU39ZpptEZFYEZ8nfW1jszgnQvn08DQHWbSsf9Pj0y3SRzcWQ4jRsoaISTy353
 6K92WMDy7cbUagMvd3uvOwZvGRxSH4nZJgJfDEd5Uq17zfmDwaw2STURbBp39xpdDQIM
 P9aP6Lyl0NUUmmu0Sd0za+U3e2d7Nk7wBL7bOnCMbqllrYzFI1PCJK5VKYXFSyJns5gt
 PLS6l9OLXcK/dvolVS5fygjon6s4NIwj/7p3RWocjrM5XfOeTVORESkXZeOENq9Bjx8p
 STZ805DiK8NTkm2MpGOn+g6fEscNuiRNMM163/dR2ioocy8zo9rFbHQh7QN9iklp8EPq 1Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5utee7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 19:54:51 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8BJsoaC031893
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 19:54:50 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8BJsnK9022788;
        Tue, 11 Sep 2018 19:54:49 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 12:54:49 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, jgross@suse.com,
        andy@strugglers.net, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] x86/EISA: Don't probe EISA bus for Xen PV guests
Date:   Tue, 11 Sep 2018 15:55:38 -0400
Message-Id: <20180911195538.23289-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9013 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=661
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unprivileged Xen PV guests this is normal memory and ioremap will
not be able to properly map it.

While at it, since ioremap may return NULL, add a test for pointer's
validity.

Reported-by: Andy Smith <andy@strugglers.net>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kernel/eisa.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index f260e452e4f8..fcf3de1712c8 100644
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
+	if (p && readl(p) == 'E' + ('I'<<8) + ('S'<<16) + ('A'<<24))
 		EISA_bus = 1;
 	iounmap(p);
 	return 0;
-- 
2.17.1

