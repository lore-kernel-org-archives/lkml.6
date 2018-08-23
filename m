Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514EEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1445F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1445F2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbeHWMR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbeHWMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:56 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBF96C5C;
        Thu, 23 Aug 2018 08:49:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 113/324] perf record: Support s390 random socket_id assignment
Date:   Thu, 23 Aug 2018 09:52:59 +0200
Message-Id: <20180823075001.502301778@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 01766229533f9bdb1144a41b4345c8c7286da7b4 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/header.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2113,6 +2113,7 @@ static int process_cpu_topology(struct f
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
 	struct perf_header *ph = ff->ph;
+	bool do_core_id_test = true;
 
 	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
 	if (!ph->env.cpu)
@@ -2167,6 +2168,13 @@ static int process_cpu_topology(struct f
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
@@ -2176,7 +2184,7 @@ static int process_cpu_topology(struct f
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
+		if (do_core_id_test && nr != (u32)-1 && nr > (u32)cpu_nr) {
 			pr_debug("socket_id number is too big."
 				 "You may need to upgrade the perf tool.\n");
 			goto free_cpu;


