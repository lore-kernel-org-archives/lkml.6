Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034CA25FBC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1q5FJ6bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034CA25FBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964973AbeFYRp4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934377AbeFYRlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:03 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B0325C82;
        Mon, 25 Jun 2018 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948463;
        bh=L6vTVnAyD1N+Sk8XFabgctSRqDMnC9TZ+sx+OKp7pO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1q5FJ6bdgg6KmsrnErzhvPU/00eLz+IwKPgdbWSvC8JatArEhpFQbEHYyfOCG6J6N
         6hfHf/KYfQXd5vIOSGUWYgpLrity9Plgv331TgK/rLyrGgiIKobh31wf94VM5XlE9/
         59BU8+7Z6T89MliVC2Ph4yYmoeMR8ND64kKdfTXk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/19] perf record: Support s390 random socket_id assignment
Date:   Mon, 25 Jun 2018 14:40:27 -0300
Message-Id: <20180625174045.25765-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

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
-- 
2.14.3

