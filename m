Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F95C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E1F2064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E1F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeHWLgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:36:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHWLgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:36:38 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33A16C83;
        Thu, 23 Aug 2018 08:08:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 047/130] perf test session topology: Fix test on s390
Date:   Thu, 23 Aug 2018 09:52:43 +0200
Message-Id: <20180823074930.298718113@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit b930e62ecd362843002bdf84c2940439822af321 ]

On s390 this test case fails because the socket identifiction numbers
assigned to the CPU are higher than the CPU identification numbers.

F/ix this by adding the platform architecture into the perf data header
flag information. This helps identifiing the test platform and handles
s390 specifics in process_cpu_topology().

Before:

  [root@p23lp27 perf]# perf test -vvvvv -F 39
  39: Session topology                                      :
  --- start ---
  templ file: /tmp/perf-test-iUv755
  socket_id number is too big.You may need to upgrade the perf tool.
  ---- end ----
  Session topology: Skip
  [root@p23lp27 perf]#

After:

  [root@p23lp27 perf]# perf test -vvvvv -F 39
  39: Session topology                                      :
  --- start ---
  templ file: /tmp/perf-test-8X8VTs
  CPU 0, core 0, socket 6
  CPU 1, core 1, socket 3
  ---- end ----
  Session topology: Ok
  [root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: c84974ed9fb6 ("perf test: Add entry to test cpu topology")
Link: http://lkml.kernel.org/r/20180611073153.15592-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/topology.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -42,6 +42,7 @@ static int session_write_header(char *pa
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
 
 	session->header.data_size += DATA_SIZE;
 


