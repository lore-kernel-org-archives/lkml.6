Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB803C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659522084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025931;
	bh=Ej7n/hiAmfCsee/tHZC5k+fujzG8T3GoZCx7xMMv7HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JbtpY43AxnqxIYDCPKg5/v7xW3AGFzuKnUnSgb5DcO3z3lrKPKC9DZlp2NFhMFP7k
	 XgnABv39QDGCJdIJyyShSc+c6gcJUZbmbaIynK4/ToWaDDjfDKUTU85ZBsZrOLSgvc
	 4zP25pUOmbMtZs7zVlDmvTyYRPTpe0pK/NjJwiVk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659522084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeLEQFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeLEQF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 972CB37F41;
        Wed,  5 Dec 2018 16:05:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18F3B5C5FE;
        Wed,  5 Dec 2018 16:05:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 5/8] perf tools: Add block term support for tracepoints
Date:   Wed,  5 Dec 2018 17:05:06 +0100
Message-Id: <20181205160509.1168-6-jolsa@kernel.org>
In-Reply-To: <20181205160509.1168-1-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 16:05:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to specify 'block' term for tracepoint in the -e command
line option, like:

  # perf record -e raw_syscalls:sys_enter/block/ -p ...
  # perf trace  -e raw_syscalls:sys_enter/block/ -p ...

to set this tracepoint as blocking (sets struct perf_event_attr::block)

It's allowed only for syscall tracepoint events
attached to process.

Link: http://lkml.kernel.org/n/tip-jj5uwlt3izp1gpk8jcspulze@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c        | 4 ++++
 tools/perf/util/evsel.h        | 2 ++
 tools/perf/util/parse-events.c | 8 ++++++++
 tools/perf/util/parse-events.h | 1 +
 tools/perf/util/parse-events.l | 1 +
 5 files changed, 16 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e4943e8f811b..886b0dbec534 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -811,6 +811,9 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_BLOCK:
+			attr->block = term->val.block ? 1 : 0;
+			break;
 		default:
 			break;
 		}
@@ -1655,6 +1658,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(context_switch, p_unsigned);
 	PRINT_ATTRf(write_backward, p_unsigned);
 	PRINT_ATTRf(namespaces, p_unsigned);
+	PRINT_ATTRf(block, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 82a289ce8b0c..c5d11035a21b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -50,6 +50,7 @@ enum term_type {
 	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
+	PERF_EVSEL__CONFIG_TERM_BLOCK,
 };
 
 struct perf_evsel_config_term {
@@ -67,6 +68,7 @@ struct perf_evsel_config_term {
 		bool	overwrite;
 		char	*branch;
 		unsigned long max_events;
+		bool	block;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index caecd2d9494a..6b6e70f1ae1f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -930,6 +930,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
+	[PARSE_EVENTS__TERM_TYPE_BLOCK]			= "block",
 };
 
 static bool config_term_shrinked;
@@ -1041,6 +1042,9 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_BLOCK:
+		CHECK_TYPE_VAL(NUM);
+		break;
 	default:
 		err->str = strdup("unknown term");
 		err->idx = term->err_term;
@@ -1091,6 +1095,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
+	case PARSE_EVENTS__TERM_TYPE_BLOCK:
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
@@ -1179,6 +1184,9 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_BLOCK:
+			ADD_CONFIG_TERM(BLOCK, block, term->val.num ? 1 : 0);
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5ed035cbcbb7..204f4bf1c62a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -75,6 +75,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
+	PARSE_EVENTS__TERM_TYPE_BLOCK,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7805c71aaae2..69141fb38347 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -274,6 +274,7 @@ inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
 no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
+block			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_BLOCK); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.17.2

