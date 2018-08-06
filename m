Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA739C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0921A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF0921A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbeHFP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:27:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731997AbeHFP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76DEHIh119395
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 09:17:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpm97xvf8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:17:52 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Aug 2018 14:17:50 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 14:17:47 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76DHkuF44105944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 13:17:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E470A4059;
        Mon,  6 Aug 2018 16:17:54 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9500A4040;
        Mon,  6 Aug 2018 16:17:53 +0100 (BST)
Received: from localhost (unknown [9.152.212.144])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Aug 2018 16:17:53 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:17:44 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/4] trace: avoid calling cc-option -mrecord-mcount for every
 Makefile
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18080613-0028-0000-0000-000002E63373
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080613-0029-0000-0000-0000239E55B9
Message-Id: <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if CONFIG_FTRACE_MCOUNT_RECORD is enabled -mrecord-mcount
compiler flag support is tested for every Makefile.

Top 4 cc-option usages:
    511 -mrecord-mcount
     11  -fno-stack-protector
      9 -Wno-override-init
      2 -fsched-pressure

To address that move cc-option from scripts/Makefile.build to top Makefile
and export CC_USING_RECORD_MCOUNT to be used in original place.

While doing that also add -mrecord-mcount to CC_FLAGS_FTRACE (if gcc
actually supports it).

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 Makefile               | 7 +++++++
 scripts/Makefile.build | 9 +++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 503f533277c7..621ebdbfbf89 100644
--- a/Makefile
+++ b/Makefile
@@ -743,6 +743,13 @@ ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
 endif
+ifdef CONFIG_FTRACE_MCOUNT_RECORD
+  # gcc 5 supports generating the mcount tables directly
+  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
+    CC_FLAGS_FTRACE	+= -mrecord-mcount
+    export CC_USING_RECORD_MCOUNT := 1
+  endif
+endif
 ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
     CC_FLAGS_FTRACE	+= -mfentry
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 514ed63ff571..42ecb8cf7666 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -206,11 +206,8 @@ cmd_modversions_c =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
-# gcc 5 supports generating the mcount tables directly
-ifneq ($(call cc-option,-mrecord-mcount,y),y)
-KBUILD_CFLAGS += -mrecord-mcount
-else
-# else do it all manually
+ifndef CC_USING_RECORD_MCOUNT
+# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
@@ -239,7 +236,7 @@ cmd_record_mcount =						\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
 	fi;
-endif # -record-mcount
+endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
-- 
2.18.0.13.gd42ae10

