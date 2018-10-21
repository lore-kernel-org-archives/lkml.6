Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7453C2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7453C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=videotron.qc.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJUX3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:29:47 -0400
Received: from alt34.smtp-out.videotron.ca ([24.53.0.23]:46753 "EHLO
        alt34.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbeJUX3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 19:29:47 -0400
Received: from localhost.localdomain ([70.81.202.49])
        by Videotron with SMTP
        id EFCugVB4DQBIBEFD3g0hSI; Sun, 21 Oct 2018 11:00:06 -0400
X-Authority-Analysis: v=2.3 cv=CKgEoyjD c=1 sm=1 tr=0
 a=WHmR/RjFJjHp+qGai9ucMg==:117 a=WHmR/RjFJjHp+qGai9ucMg==:17 a=QyXUC8HyAAAA:8
 a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=2orbdQcEAAAA:8 a=vS6d9CMd0HHiPuPBne4A:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=AjGcO6oz07-iQ99wixmX:22 a=h4LIIZcg-NqzSqH91z1c:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
From:   Sebastien Boisvert <sebhtml@videotron.qc.ca>
Cc:     Sebastien Boisvert <sebhtml@videotron.qc.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Elenie Godzaridis <arangradient@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pfn_t: force '~' to be parsed as an unary operator
Date:   Sun, 21 Oct 2018 10:59:39 -0400
Message-Id: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4wfF5swVtZGtKzVWfRbAaQpAb6Jh8Ha1SjqxDb0GiItqc2/sjAaODPA85TcQXe88u0eaH4fkylMeCKDrKCA5udw93+DVciKrH4D9sR1f5/ejyW6HJQpeoM
 wW464T8uFVAcSFMYiTdUH7G7en+YLEJxIJx36Ut+3mKn5ndx+JFXnVz7u4ZcaQ1BUbYY1wjOxe8p/v625CK8uR78yTzclsoxkqfSWZkTL1V5SrljSMpfPHy5
 TvDfZ0rTGX15o0Xx9vZzCPzN221/0O0CovehEjJ7EJES4prj8+vy471y0mp/a4RgxGiy2HeVD1tWrfxRl7FdN8FRufufjfCYqeh0yW9wSRwAO8IEtKGJQoOu
 WTHpt1lO2C4LX6xAK2iGDEhDQK85HW/+1wDRKtdX23zrC5Im/DAHvlOwR4XW3qby1rtNb7C2FygpNWGoKVSJ7mTUDjn7T8r9SArQn3LaJOB0NuWHgN76MJ3L
 a87Fs/HL+kC6n9cJFLcX9tDAujF3eJUZyKGeGA==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing the event "fs_dax:dax_pmd_insert_mapping" with perf produces this
warning:
      [fs_dax:dax_pmd_insert_mapping] unknown op '~'

It is printed in process_op (tools/lib/traceevent/event-parse.c) because '~'
is parsed as a binary operator.

perf reads the format of fs_dax:dax_pmd_insert_mapping ("print fmt") from
/sys/kernel/debug/tracing/events/fs_dax/dax_pmd_insert_mapping/format .

The format contains:

~(((u64) ~(~(((1UL) << 12)-1)))
         ^
         \ interpreted as a binary operator by process_op().

This part is generated in the declaration of the event class
dax_pmd_insert_mapping_class in include/trace/events/fs_dax.h :

		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
			PFN_FLAGS_TRACE),

This patch adds a pair of parentheses in the declaration of PFN_FLAGS_MASK to
make sure that '~' is parsed as a unary operator by perf.

The part of the format that was problematic is now:

~(((u64) (~(~(((1UL) << 12)-1))))

Now, all the '~' are parsed as unary operators.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Elenie Godzaridis <arangradient@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sebastien Boisvert <sebhtml@videotron.qc.ca>
---
 include/linux/pfn_t.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 21713dc14ce2..673546ba7342 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -10,7 +10,7 @@
  * PFN_DEV - pfn is not covered by system memmap by default
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
  */
-#define PFN_FLAGS_MASK (((u64) ~PAGE_MASK) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
+#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
 #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
 #define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
 #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
-- 
2.17.1

