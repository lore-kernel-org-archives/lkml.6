Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F068206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404652AbfBOJ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:26:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbfBOJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:26:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9QOu41115616
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:26:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9QNVe1115611;
        Fri, 15 Feb 2019 01:26:23 -0800
Date:   Fri, 15 Feb 2019 01:26:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-2187d87eacd46f6214ce3dc9cfd7a558375a4153@git.kernel.org>
Cc:     brueckner@linux.ibm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, schwidefsky@de.ibm.com,
        mingo@kernel.org, tmricht@linux.ibm.com, heiko.carstens@de.ibm.com,
        acme@redhat.com
Reply-To: mingo@kernel.org, schwidefsky@de.ibm.com,
          heiko.carstens@de.ibm.com, tmricht@linux.ibm.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          brueckner@linux.ibm.com, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20190211100627.85714-1-tmricht@linux.ibm.com>
References: <20190211100627.85714-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Add s390 diagnosic sampling descriptor
 size
Git-Commit-ID: 2187d87eacd46f6214ce3dc9cfd7a558375a4153
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

Commit-ID:  2187d87eacd46f6214ce3dc9cfd7a558375a4153
Gitweb:     https://git.kernel.org/tip/2187d87eacd46f6214ce3dc9cfd7a558375a4153
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 11 Feb 2019 11:06:27 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 13:31:08 -0300

perf report: Add s390 diagnosic sampling descriptor size

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
