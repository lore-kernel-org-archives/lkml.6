Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1F720862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1F720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeG0IE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:04:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbeG0IE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:04:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6R6db4K059357
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:44:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kfv3m5411-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:44:03 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 27 Jul 2018 07:44:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 07:44:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6R6hxjf32440366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 06:43:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 403FEA4040;
        Fri, 27 Jul 2018 09:44:12 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F08DCA404D;
        Fri, 27 Jul 2018 09:44:11 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 09:44:11 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf build: Fix installation directory for bpf
Date:   Fri, 27 Jul 2018 08:43:56 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18072706-0028-0000-0000-000002E0F069
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072706-0029-0000-0000-00002398E71A
Message-Id: <20180727064356.76595-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf tool build and install is controlled via makefile. Make install
creates directories and copies files. Among them are header files
installed in /usr/lib/include/perf/bpf/.

However all listed examples are installing its header files in
  /usr/lib/<tool-name>/...[/include]/header.h
and not in
  /usr/lib/include/<tool-name>/.../header.h.

Background information:
Building the Fedora 28 glibc RPM on s390x and s390 fails on s390
(gcc -m31) as gcc is not able to find header-files like stdbool.h.
In the glibc.spec file, you can see that glibc is configured with
"--with-headers". In this case, first -nostdinc is added to the
CFLAGS and then further include paths are added via -isystem.
One of those paths should contain header files like stdbool.h.

In order to get this path, gcc is invoked with:
- on Fedora 28 (with 4.18 kernel):
  $ gcc -print-file-name=include
  /usr/lib/gcc/s390x-redhat-linux/8/include
  $ gcc -m31 -print-file-name=include
  /usr/lib/gcc/s390x-redhat-linux/8/../../../../lib/include
  => If perf is installed, this is: /usr/lib/include
  On my machine this directory is only containing the directory "perf".
  If perf is not installed gcc returns: /usr/lib/gcc/s390x-redhat-linux/8/\
						include

-on Ubuntu 18.04 (with 4.15 kernel):
  $ gcc  -print-file-name=include
  /usr/lib/gcc/s390x-linux-gnu/7/include
  $ gcc -m31 -print-file-name=include
  /usr/lib/gcc/s390x-linux-gnu/7/include
  => gcc returns the correct path even if perf is installed.

In each case, the introduction of the subdirectory /usr/lib/include
leads to the regression that one can not build the glibc RPM for
s390 anymore as gcc can not find headers like stdbool.h.

To remedy this install bpf.h to /usr/lib/perf/include/bpf/bpf.h

Output before using command ./perf test -Fv 40:
echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		 -I/root/lib/include/perf/bpf ...
                             ^^^^^^^^^^^^
...
[root@p23lp27 perf]# ./perf test -F 40
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Ok
40.2: BPF pinning                                         : Ok
40.3: BPF prologue generation                             : Ok
40.4: BPF relocation checker                              : Ok
[root@p23lp27 perf]#

Output after using command ./perf test -Fv 40:
echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		 -I/root/lib/perf/include/bpf ...
                             ^^^^^^^^^^^^
...
[root@p23lp27 perf]# ./perf test -F 40
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Ok
40.2: BPF pinning                                         : Ok
40.3: BPF prologue generation                             : Ok
40.4: BPF relocation checker                              : Ok
[root@p23lp27 perf]#

Suggested-by: Stefan Liebler <stli@linux.ibm.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f5a3b402589e..67b042738ed7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -905,8 +905,8 @@ bindir = $(abspath $(prefix)/$(bindir_relative))
 mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
-perf_include_dir = lib/include/perf
-perf_examples_dir = lib/examples/perf
+perf_include_dir = lib/perf/include
+perf_examples_dir = lib/perf/examples
 sharedir = $(prefix)/share
 template_dir = share/perf-core/templates
 STRACE_GROUPS_DIR = share/perf-core/strace/groups
-- 
2.17.0

