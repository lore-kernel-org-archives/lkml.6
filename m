Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD757C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FE924EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FE924EAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeFZGwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:52:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeFZGwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:52:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6pmT01591095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:51:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6pmmw1591092;
        Mon, 25 Jun 2018 23:51:48 -0700
Date:   Mon, 25 Jun 2018 23:51:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-01766229533f9bdb1144a41b4345c8c7286da7b4@git.kernel.org>
Cc:     heiko.carstens@de.ibm.com, brueckner@linux.ibm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, acme@redhat.com, schwidefsky@de.ibm.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: acme@redhat.com, tmricht@linux.ibm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          schwidefsky@de.ibm.com, brueckner@linux.ibm.com,
          heiko.carstens@de.ibm.com, mingo@kernel.org
In-Reply-To: <20180611073153.15592-1-tmricht@linux.ibm.com>
References: <20180611073153.15592-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Support s390 random socket_id
 assignment
Git-Commit-ID: 01766229533f9bdb1144a41b4345c8c7286da7b4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  01766229533f9bdb1144a41b4345c8c7286da7b4
Gitweb:     https://git.kernel.org/tip/01766229533f9bdb1144a41b4345c8c7286da7b4
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 11 Jun 2018 09:31:52 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:35 -0300

perf record: Support s390 random socket_id assignment

On s390 the socket identifier assigned to a CPU identifier is random and
(depending on the configuration of the LPAR) may be higher than the CPU
identifier. This is currently not supported.

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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180611073153.15592-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 540cd2dcd3e7..59fcc790c865 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2129,6 +2129,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
 	struct perf_header *ph = ff->ph;
+	bool do_core_id_test = true;
 
 	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
 	if (!ph->env.cpu)
@@ -2183,6 +2184,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2192,7 +2200,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
+		if (do_core_id_test && nr != (u32)-1 && nr > (u32)cpu_nr) {
 			pr_debug("socket_id number is too big."
 				 "You may need to upgrade the perf tool.\n");
 			goto free_cpu;
