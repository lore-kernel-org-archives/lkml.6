Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE85C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D1520839
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D1520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeHFGFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 02:05:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbeHFGFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 02:05:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w763rq9J006394
        for <linux-kernel@vger.kernel.org>; Sun, 5 Aug 2018 23:58:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kpb4ywums-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 23:58:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Mon, 6 Aug 2018 04:58:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 04:58:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w763wQRG35586060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 03:58:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48D69A4051;
        Mon,  6 Aug 2018 06:58:35 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4051A4040;
        Mon,  6 Aug 2018 06:58:34 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 06:58:34 +0100 (BST)
Received: from intelligence.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BC112A01A5;
        Mon,  6 Aug 2018 13:58:24 +1000 (AEST)
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To:     linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Cc:     fbarrat@linux.vnet.ibm.com
Subject: [RFC PATCH 1/2] checkpatch: Correctly detect git commit references that span 3 lines
Date:   Mon,  6 Aug 2018 13:58:08 +1000
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
x-cbid: 18080603-4275-0000-0000-000002A44976
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080603-4276-0000-0000-000037AC6EFB
Message-Id: <20180806035809.24752-1-andrew.donnellan@au1.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=802 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a patch contains a commit reference that happens to span 3 lines, e.g.:

===
With the optimizations for TLB invalidation from commit 0cef77c7798a
("powerpc/64s/radix: flush remote CPUs out of single-threaded
mm_cpumask"), the scope of a TLBI (global vs. local) can now be
influenced by the value of the 'copros' counter of the memory context.
===

checkpatch will return a GIT_COMMIT_ID error even though the reference
actually follows the correct format.

Fix the GIT_COMMIT_ID test so it can match against a reference that spans 3
lines.

Reported-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Sending this as an RFC because I don't actually know how to Perl or regex,
this whole test looks pretty gross and this patch just makes it gross-er,
and it's only lightly tested. Suggestions on how to do this more neatly are
welcome.

We currently have checkpatch running on every incoming patch on
linuxppc-dev, and we've already hit this bug at least twice in the past
couple of weeks.
---
 scripts/checkpatch.pl | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 447857ffaf6b..aca4d758112a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2669,27 +2669,60 @@ sub process {
 			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
 			}
-
 			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
 			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
 			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
 			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
+
 			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+				# Reference fits on 1 line
 				$orig_desc = $1;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
+				# line 1: 'commit <hash>',
+				# line 2: '("description")'
 				$orig_desc = $1;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
+				# line 1: 'commit <hash> ("description',
+				# line 2: 'description continued")'
 				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
 				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
 				$orig_desc .= " " . $1;
 				$hasparens = 1;
+			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
+				 defined $rawlines[$linenr] &&
+				 defined $rawlines[$linenr + 1] &&
+				 $rawlines[$linenr] =~ /^\s*\("[^"]+/ &&
+				 $rawlines[$linenr + 1] =~ /^\s*[^"]+"\)/) {
+				# line 1: 'commit <hash>',
+				# line 2: '("description'
+				# line 3: 'description continued")'
+				$rawlines[$linenr] =~ /^\s*\("([^"]+)/;
+				$orig_desc = $1;
+				$rawlines[$linenr + 1] =~ /^\s*([^"]+)"\)/;
+				$orig_desc .= " " . $1;
+				$hasparens = 1;
+			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+				 defined $rawlines[$linenr] &&
+				 defined $rawlines[$linenr + 1] &&
+				 $rawlines[$linenr] =~ /^\s*[^"]+$/ &&
+				 $rawlines[$linenr + 1] =~ /^\s*[^"]+"\)/) {
+				# line 1: 'commit <hash> ("description',
+				# line 2: 'description continued'
+				# line 3: 'description continued")'
+				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				$orig_desc = $1;
+				$rawlines[$linenr] =~ /^\s*([^"]+)$/;
+				$orig_desc .= " " . $1;
+				$rawlines[$linenr + 1] =~ /^\s*([^"]+)"\)/;
+				$orig_desc .= " " . $1;
+				$hasparens = 1;
 			}
 
 			($id, $description) = git_commit_info($orig_commit,
-- 
2.11.0

