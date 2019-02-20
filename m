Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D025C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C82086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665711;
	bh=ZbpPSJViKaFdLlIqHlf8+UTH48rOu13UlYzESNLHlXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CM0XLbgCdsGIVY5I+dWDDiBGQ6v7nI35aiFo6yHrCy35kHqZN0b0WGtsaEhCvqz9h
	 QzJpShVDHi1QovKkbpAYR/Cqkml2FbwzbhHuChnsLYUDkEOzDrHm3E8bVgzmIz494m
	 B6d/5eEfr0BSkiWuQKXO6lYtJWiTosYrWRkhnltk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfBTM23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfBTM2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5D16C05B017;
        Wed, 20 Feb 2019 12:28:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 469B260141;
        Wed, 20 Feb 2019 12:28:07 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/6] perf script: Allow +- operator for type specific fields option
Date:   Wed, 20 Feb 2019 13:27:57 +0100
Message-Id: <20190220122800.864-4-jolsa@kernel.org>
In-Reply-To: <20190220122800.864-1-jolsa@kernel.org>
References: <20190220122800.864-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 20 Feb 2019 12:28:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to add/remove fields for specific event types
in -F option.  It's now possible to use '+-' after event type,
like:

  # cat > test.c
  #include <stdio.h>

  int main(void)
  {
     printf("Hello world\n");
     while(1) {}
  }
  ^D
  # gcc -g -o test test.c
  # perf probe -x test 'test.c:5'
  # perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
  ...

  # perf script -Ftrace:+period,-cpu
            test  3859 396291.117343:      10275 cpu/cpu-cycles,period=10000/:      7f..
            test  3859 396291.118234:      11041 cpu/cpu-cycles,period=10000/:  ffffff..
            test  3859 396291.118234:          1              probe_test:main:
            test  3859 396291.118248:       8668 cpu/cpu-cycles,period=10000/:  ffffff..
            test  3859 396291.118263:      10139 cpu/cpu-cycles,period=10000/:  ffffff..

Link: http://lkml.kernel.org/n/tip-gpd58vbcgsk4zx041zwl85e8@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-script.txt | 6 ++++++
 tools/perf/builtin-script.c              | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9e4def08d569..2e19fd7ffe35 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -159,6 +159,12 @@ OPTIONS
 	the override, and the result of the above is that only S/W and H/W
 	events are displayed with the given fields.
 
+	It's possible tp add/remove fields only for specific event type:
+
+		-Fsw:-cpu,-period
+
+	removes cpu and period from software events.
+
 	For the 'wildcard' option if a user selected field is invalid for an
 	event type, a message is displayed to the user that the option is
 	ignored for that type. For example:
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8d5fe092525c..373ea151dc60 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2560,6 +2560,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 			pr_warning("Overriding previous field request for %s events.\n",
 				   event_type(type));
 
+		/* Don't override defaults for +- */
+		if (strchr(tok, '+') || strchr(tok, '-'))
+			goto parse;
+
 		output[type].fields = 0;
 		output[type].user_set = true;
 		output[type].wildcard_set = false;
@@ -2644,6 +2648,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				rc = -EINVAL;
 				goto out;
 			}
+			if (change == REMOVE)
+				output[type].fields &= ~all_output_options[i].field;
+			else
+				output[type].fields |= all_output_options[i].field;
 			output[type].user_set = true;
 			output[type].wildcard_set = true;
 		}
-- 
2.17.2

