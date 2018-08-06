Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977E7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDC121A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDC121A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbeHFP1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:27:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732659AbeHFP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76DEAxe158095
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 09:17:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kppddhuv4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:17:53 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Aug 2018 14:17:52 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 14:17:48 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76DHlgX35979296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 13:17:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E8B442041;
        Mon,  6 Aug 2018 16:17:57 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B99944203F;
        Mon,  6 Aug 2018 16:17:56 +0100 (BST)
Received: from localhost (unknown [9.152.212.144])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Aug 2018 16:17:56 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:17:46 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/4] trace: add -mcount-nop option support
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18080613-4275-0000-0000-000002A51DC1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080613-4276-0000-0000-000037AD1EDF
Message-Id: <patch-3.thread-aa7b8d.git-e02ed2dc082b.your-ad-here.call-01533557518-ext-9465@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-mcount-nop gcc option generates the calls to the profiling functions
as nops which allows to avoid patching mcount jump with NOP instructions
initially.

-mcount-nop gcc option will be activated if platform selects
HAVE_NOP_MCOUNT and gcc actually supports it.
In addition to that CC_USING_NOP_MCOUNT is defined and could be used by
architectures to adapt ftrace patching behavior.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 Makefile              | 6 ++++++
 kernel/trace/Kconfig  | 5 +++++
 kernel/trace/ftrace.c | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 621ebdbfbf89..281f4ededf3a 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,12 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
     CC_FLAGS_FTRACE	+= -mrecord-mcount
     export CC_USING_RECORD_MCOUNT := 1
   endif
+  ifdef CONFIG_HAVE_NOP_MCOUNT
+    ifeq ($(call cc-option-yn, -mnop-mcount),y)
+      CC_FLAGS_FTRACE	+= -mnop-mcount
+      CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+    endif
+  endif
 endif
 ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..855109214e3d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -47,6 +47,11 @@ config HAVE_FENTRY
 	help
 	  Arch supports the gcc options -pg with -mfentry
 
+config HAVE_NOP_MCOUNT
+	bool
+	help
+	  Arch supports the gcc options -pg with -mrecord-mcount and -nop-mcount
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index caf9cbf35816..310dfcb20d5b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2981,12 +2981,14 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			p = &pg->records[i];
 			p->flags = rec_flags;
 
+#ifndef CC_USING_NOP_MCOUNT
 			/*
 			 * Do the initial record conversion from mcount jump
 			 * to the NOP instructions.
 			 */
 			if (!ftrace_code_disable(mod, p))
 				break;
+#endif
 
 			update_cnt++;
 		}
-- 
2.18.0.13.gd42ae10

