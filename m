Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7DC10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C692229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191566;
	bh=rvJmRUmCiz0QfuV2fkgrG2rwMBxRtS5DhMfnTXyUyDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f8QbpNlXie3kooXCrWLngsmv8zMqairjJ6hpsOKalvqQHoCDLHZU27ocahTA23AKo
	 2YJIPIkTSeMEH2aIRFCQ+qtWyG28f/Iiwe9TM2LhbdT2r0BwfkJVXW+mZ9g3ahj+mT
	 FLFTwKXn+NYDw7w0bQOC6nv5jkXyCaWerfRqmSXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfBOAqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730319AbfBOAqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:46:02 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C678222C9;
        Fri, 15 Feb 2019 00:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191562;
        bh=rvJmRUmCiz0QfuV2fkgrG2rwMBxRtS5DhMfnTXyUyDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z684/gF4fQUNNvf7HwIlhWeByfvH8j1Ejb/jd23GtQEKPIeDP/DKFdrDj1ZcNjt4d
         BaTHpa+fPt9LgpHkWXDSWAuEO4KmVF+QQYvYQ9jqOfX/PnBLzDKYjrCWtPNzbesNoR
         JwC1Q73+/xjY3n67VAggmVszoDX+ACwCiSqbV+vY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/43] perf report: Add s390 diagnosic sampling descriptor size
Date:   Thu, 14 Feb 2019 21:44:59 -0300
Message-Id: <20190215004539.23571-4-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

On IBM z13 machine types 2964 and 2965 the descriptor
sizes for sampling and diagnostic sampling entries
might be missing in the trailer entry and are set to zero.

This leads to a perf report failure when processing diagnostic
sampling entries.

This patch adds missing descriptor sizes when the trailer entry
contains zero for these fields.

Output before:
  [root@s38lp82 perf]#  ./perf report --stdio | fgrep Samples
  0xabbf0 [0x8]: failed to process type: 68
  Error:
  failed to process sample
  [root@s38lp82 perf]#

Output after:
  [root@s38lp82 perf]#  ./perf report --stdio | fgrep Samples
  # Total Lost Samples: 0
  # Samples: 3K of event 'SF_CYCLES_BASIC_DIAG'
  # Samples: 162  of event 'CF_DIAG'
  [root@s38lp82 perf]#

Fixes: 2b1444f2e28b ("perf report: Add raw report support for s390 auxiliary trace")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190211100627.85714-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index d9525d220db1..c215704931dc 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -352,6 +352,11 @@ static bool s390_cpumsf_validate(int machine_type,
 			*dsdes = 85;
 			*bsdes = 32;
 			break;
+		case 2964:
+		case 2965:
+			*dsdes = 112;
+			*bsdes = 32;
+			break;
 		default:
 			/* Illegal trailer entry */
 			return false;
-- 
2.19.1

