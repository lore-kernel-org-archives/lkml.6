Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF2FECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2F21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA2F21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJROTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:19:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJROTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:19:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6JeTF707946
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:19:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6Jd9Z707943;
        Wed, 17 Oct 2018 23:19:39 -0700
Date:   Wed, 17 Oct 2018 23:19:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for David Miller <tipbot@zytor.com>
Message-ID: <tip-0ed149cf5239cc6e7e65bf00f769e8f1e91076c0@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        davem@davemloft.net, mingo@kernel.org, jolsa@kernel.org,
        kan.liang@intel.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, kan.liang@intel.com,
          jolsa@kernel.org, mingo@kernel.org, davem@davemloft.net,
          hpa@zytor.com, acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20181011.224655.716771175766946817.davem@davemloft.net>
References: <20181011.224655.716771175766946817.davem@davemloft.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cpu_map: Align cpu map synthesized events
 properly.
Git-Commit-ID: 0ed149cf5239cc6e7e65bf00f769e8f1e91076c0
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

Commit-ID:  0ed149cf5239cc6e7e65bf00f769e8f1e91076c0
Gitweb:     https://git.kernel.org/tip/0ed149cf5239cc6e7e65bf00f769e8f1e91076c0
Author:     David Miller <davem@davemloft.net>
AuthorDate: Thu, 11 Oct 2018 22:46:55 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Oct 2018 12:30:03 -0300

perf cpu_map: Align cpu map synthesized events properly.

The size of the resulting cpu map can be smaller than a multiple of
sizeof(u64), resulting in SIGBUS on cpus like Sparc as the next event
will not be aligned properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Fixes: 6c872901af07 ("perf cpu_map: Add cpu_map event synthesize function")
Link: http://lkml.kernel.org/r/20181011.224655.716771175766946817.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..0988eb3b844b 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1081,6 +1081,7 @@ void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max
 	}
 
 	*size += sizeof(struct cpu_map_data);
+	*size = PERF_ALIGN(*size, sizeof(u64));
 	return zalloc(*size);
 }
 
