Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC90C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C11521871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171202;
	bh=BFLEfxesnltk9FGznyg8U2npChLeFaEaACwoTSlPTS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vQKZdO5kwlMZt++ltcxv1aYxLemGUSKjLT9v8ZKgI5GFX1gKgQk3YQiUHvdJ4s5GV
	 T5tdm0M5xMXN2r2M3ow59P+Fl4aco0kgETWXG0X7cgXUYOZ0GquqzdT7SNQrG9OHo+
	 TdQ27OnItjlHJSuHmbQha8lmd6agMXpG6Z/xXWEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeLRWNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeLRWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:20 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22326218A2;
        Tue, 18 Dec 2018 22:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171199;
        bh=BFLEfxesnltk9FGznyg8U2npChLeFaEaACwoTSlPTS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtOwtR0UnWHjUTa0ajhfkZQjK5tUeOiRrTWb6yWV/7hg5CMmAR4JpaRLZF9Kn6QIF
         V6dpxnyPexThO+fRot0S6kM1Is/e2NNqTKj4/Zngl5wWKuf8JReirykliLTHCVaYyk
         vJpjH+bUBHLukFkQeizHAVSwGDhmz8CkZvA3mvdk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 38/63] perf config: Show the configuration when no arguments are provided
Date:   Tue, 18 Dec 2018 19:07:08 -0300
Message-Id: <20181218220733.15839-39-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

More convenient thah having to recall what letter is about
showing/listing/dumping the configuration, i.e. no arguments means
-l/--list:

  # perf config
  llvm.dump-obj=true
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  # perf config -l
  llvm.dump-obj=true
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  # perf config -h

   Usage: perf config [<file-option>] [options] [section.name[=value] ...]

      -l, --list            show current config variables
          --system          use system config file
          --user            use user config file

  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-z2n63avz6tliqb5gmu4l1dti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 514f70f95b57..d76f831f94c7 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -196,6 +196,7 @@ int cmd_config(int argc, const char **argv)
 			pr_err("Error: takes no arguments\n");
 			parse_options_usage(config_usage, config_options, "l", 1);
 		} else {
+do_action_list:
 			if (show_config(set) < 0) {
 				pr_err("Nothing configured, "
 				       "please check your %s \n", config_filename);
@@ -204,10 +205,8 @@ int cmd_config(int argc, const char **argv)
 		}
 		break;
 	default:
-		if (!argc) {
-			usage_with_options(config_usage, config_options);
-			break;
-		}
+		if (!argc)
+			goto do_action_list;
 
 		for (i = 0; argv[i]; i++) {
 			char *var, *value;
-- 
2.19.2

