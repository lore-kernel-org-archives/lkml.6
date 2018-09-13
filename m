Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E2DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DDB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DDB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIMQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:09:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbeIMQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:09:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8DAxBiS036165
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:00:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mfp90rvc6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:00:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Thu, 13 Sep 2018 12:00:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Sep 2018 12:00:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8DB0eFr58196080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Sep 2018 11:00:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD80D4C046;
        Thu, 13 Sep 2018 14:00:31 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ACF44C059;
        Thu, 13 Sep 2018 14:00:31 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Sep 2018 14:00:31 +0100 (BST)
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
To:     arnd@arndb.de
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greentime Hu <green.hu@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] vmlinux.lds.h: Fix incomplete .text.exit discards
Date:   Thu, 13 Sep 2018 12:59:59 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180913110000.63934-1-oberpar@linux.ibm.com>
References: <20180913110000.63934-1-oberpar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091311-4275-0000-0000-000002B9D475
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091311-4276-0000-0000-000037C30D59
Message-Id: <20180913110000.63934-2-oberpar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=675 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809130113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_GCOV_PROFILE_ALL=y causes linker errors on ARM:

  `.text.exit' referenced in section `.ARM.exidx.text.exit':
  defined in discarded section `.text.exit'

  `.text.exit' referenced in section `.fini_array.00100':
  defined in discarded section `.text.exit'

And related errors on NDS32:

  `.text.exit' referenced in section `.dtors.65435':
  defined in discarded section `.text.exit'

The gcov compiler flags cause certain compiler versions to generate
additional destructor-related sections that are not yet handled by the
linker script, resulting in references between discarded and
non-discarded sections.

Since destructors are not used in the Linux kernel, fix this by
discarding these additional sections.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Greentime Hu <green.hu@gmail.com>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 arch/arm/kernel/vmlinux.lds.h     | 2 ++
 include/asm-generic/vmlinux.lds.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index ae5fdff18406..8247bc15addc 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -49,6 +49,8 @@
 #define ARM_DISCARD							\
 		*(.ARM.exidx.exit.text)					\
 		*(.ARM.extab.exit.text)					\
+		*(.ARM.exidx.text.exit)					\
+		*(.ARM.extab.text.exit)					\
 		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))		\
 		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))		\
 		ARM_EXIT_DISCARD(EXIT_TEXT)				\
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..b4d74b1c1e1d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -613,8 +613,8 @@
 
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
-	*(.fini_array)							\
-	*(.dtors)							\
+	*(.fini_array .fini_array.*)					\
+	*(.dtors .dtors.*)						\
 	MEM_DISCARD(exit.data*)						\
 	MEM_DISCARD(exit.rodata*)
 
-- 
2.17.0

