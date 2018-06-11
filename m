Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wzCQCCwlHltceAAAmS7hNA
	; Mon, 11 Jun 2018 07:32:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2C188607BB; Mon, 11 Jun 2018 07:32:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A35F760791;
	Mon, 11 Jun 2018 07:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A35F760791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeFKHcE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:32:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753964AbeFKHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:32:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B7SdUG076988
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 03:32:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jhmbc1cgj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 03:32:02 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 11 Jun 2018 08:32:01 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 08:31:58 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B7Vvap35651742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 07:31:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18CE11C050;
        Mon, 11 Jun 2018 08:22:35 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E9F111C04A;
        Mon, 11 Jun 2018 08:22:35 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 08:22:35 +0100 (BST)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2] perf record: Support s390 random socket_id assignment
Date: Mon, 11 Jun 2018 09:31:52 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18061107-0012-0000-0000-0000027E002F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061107-0013-0000-0000-000020AF0EE3
Message-Id: <20180611073153.15592-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 the socket identifier assigned to a CPU identifier is
random and (depending on the configuration of the LPAR) may be higher
than the CPU identifier. This is currently not supported.

Fix this by allowing arbitrary socket identifiers being assigned to
CPU id.

Output before:

[root@p23lp27 perf]# ./perf report --header -I -v
 ...
 socket_id number is too big.You may need to upgrade the perf tool.
 Error:
 The perf.data file has no samples!
 # ========
 # captured on    : Tue May 29 09:29:57 2018
 # header version : 1
 ...
 # Core ID and Socket ID information is not available
 ...
[root@p23lp27 perf]#

Output after:
[root@p23lp27 perf]# ./perf report --header -I -v
 ...
 Error:
 The perf.data file has no samples!
 # ========
 # captured on    : Tue May 29 09:29:57 2018
 # header version : 1
 ...
 # CPU 0: Core ID 0, Socket ID 6
 # CPU 1: Core ID 1, Socket ID 3
 # CPU 2: Core ID -1, Socket ID -1
 ...
[root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/header.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a8bff2178fbc..34e9d6b9d945 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2113,6 +2113,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
 	struct perf_header *ph = ff->ph;
+	bool do_core_id_test = true;
 
 	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
 	if (!ph->env.cpu)
@@ -2167,6 +2168,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
+	/* On s390 the socket_id number is not related to the numbers of cpus.
+	 * The socket_id number might be higher than the numbers of cpus.
+	 * This depends on the configuration.
+	 */
+	if (ph->env.arch && !strncmp(ph->env.arch, "s390", 4))
+		do_core_id_test = false;
+
 	for (i = 0; i < (u32)cpu_nr; i++) {
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
@@ -2176,7 +2184,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
+		if (do_core_id_test && nr != (u32)-1 && nr > (u32)cpu_nr) {
 			pr_debug("socket_id number is too big."
 				 "You may need to upgrade the perf tool.\n");
 			goto free_cpu;
-- 
2.14.3
