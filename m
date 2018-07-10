Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BA02089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BA02089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933575AbeGJN6g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:58:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933330AbeGJN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:58:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ADss4U146226
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:58:31 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k4wt01v5h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:58:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 10 Jul 2018 14:58:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 14:58:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6ADwQos37748848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 13:58:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29EFD11C04A;
        Tue, 10 Jul 2018 16:58:49 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABC1011C05B;
        Tue, 10 Jul 2018 16:58:47 +0100 (BST)
Received: from localhost.localdomain (unknown [9.195.22.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 16:58:47 +0100 (BST)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        ravi.bangoria@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.vnet.ibm.com, maynard@us.ibm.com,
        kim.phillips@arm.com
Subject: [PATCH 3/5] perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
Date:   Tue, 10 Jul 2018 19:28:15 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <cover.1530724939.git.sandipan@linux.ibm.com>
References: <cover.1530724939.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1530724939.git.sandipan@linux.ibm.com>
References: <cover.1530724939.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071013-0020-0000-0000-000002A4F987
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071013-0021-0000-0000-000020F13A18
Message-Id: <49621ec5f37109f0655e5a8c32287ad68d85a1e5.1530724939.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For powerpc64, this test currently fails due to a mismatch in
the expected output.

This can be observed on a powerpc64le system running Fedora 27
as shown below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

Before:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 23948
  ping 23965 [003] 71136.075084: probe_libc:inet_pton: (7fff996aaf28)
  7fff996aaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fff9965fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  FAIL: expected backtrace entry 2 "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc-2.26.so\)$" got "7fff9965fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

After:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 24638
  ping 24655 [001] 71208.525396: probe_libc:inet_pton: (7fffa245af28)
  7fffa245af28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fffa240fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  7fffa24105b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
  138d52d70 main+0x3e0 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 94e513e62b34..1220e5e052bb 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -26,6 +26,12 @@ trace_libc_inet_pton_backtrace() {
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
+	ppc64|ppc64le)
+		eventattr='max-stack=4'
+		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		;;
 	*)
 		eventattr='max-stack=3'
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-- 
2.14.4

