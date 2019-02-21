Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B96C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BA82089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712416;
	bh=0cor4zG7tEu0YQZb8qGx2QNk58jFZMsl/vFNRv5o3Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S1pSkOY/LyU5tQuVcUTE1oFt5ooZ2x6g16copvyzpvBUPg2nvkHucuexweCSfIU4P
	 uK31hpS2rLpdLEvQFGEgSwhsf8sHOoyg+5sh/e5YfwsUQL3fC31M2+E0gJMruusGZM
	 HFTtCyKkStL1ZdaoITpW8ZKx2q11Qou5nshUkq8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfBUB0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBUB0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:53 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B79A21848;
        Thu, 21 Feb 2019 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712412;
        bh=0cor4zG7tEu0YQZb8qGx2QNk58jFZMsl/vFNRv5o3Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrFPU/GyR89OhenLx/HN0Ypf2T3bmStFBIbN0CD6VZ5yqRKqQCgVTCsPbpnI/ad9K
         bkPojPptowr/6MrW8oqhKPnUgaDkAvltYAymQKtqj+xQLglMlRWIq8HW+pgMrF7IPq
         6xg11nQEQHGsC8EGmIB30OEJaR/R8H6G0B8BzmDI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/17] perf script: Allow +- operator for type specific fields option
Date:   Wed, 20 Feb 2019 22:25:46 -0300
Message-Id: <20190221012549.4069-15-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add support to add/remove fields for specific event types in -F option.
It's now possible to use '+-' after event type, like:

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

Committer testing:

Couldn't make the test above work, but tested it with:

  # perf probe -x hello main
  Added new event:
    probe_hello:main     (on main in /home/acme/c/hello)

  You can now use it in all perf tools, such as:

	  perf record -e probe_hello:main -aR sleep 1

  # perf record -e probe_hello:main ./hello
  hello, world
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.025 MB perf.data (1 samples) ]
  # perf script
           hello 21454 [002] 254116.874005: probe_hello:main: (401126)
  #
  # perf script -Ftrace:+period,-cpu
           hello 21454 254116.874005:          1 probe_hello:main: (401126)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1

