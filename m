Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+oeKo5Q9yWDG1i4CVM82H+lvGNB0ppkpW/J81OREmkAVNa4b2++GhOu5CJh+Ky2UrcitXx
ARC-Seal: i=1; a=rsa-sha256; t=1523399219; cv=none;
        d=google.com; s=arc-20160816;
        b=Dg63gKbpygJFWVp38Vgb4jhalA6D+BjpsmSCdb0ZMYlDpVHgX5oTNKEbs/Rt27F+U2
         yYrO0M8Aov02qaZcQzXlfsEzWoRI3W+bzEVFqnizByu7ro+Jp8CRzW1gFYZuNyvfH6an
         8QjSbiX173IKDwUe03B6rTDs5tW64LerChSHe4YgcXtQjjnF/S+GNpa8xMjQAad6MjTG
         9MRlFtuEFkzX4LCNErUc79DgIifbQLNkeO7oW7vV12Vc46BoH47v97lOpLl1M7x9YrP6
         hQvWSnaEze43s+FO0O0GTChYz9UeSNXhWsQgryGZr8DIvD0NJdvU/8El3nWapgTEXFnn
         mdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NIHCMqcoSl3v7WmrxS6bL/iKpQl18cE951zDsGPc+6A=;
        b=uF2U1rV9HDAco85xebxWP/+MqWbt2AalVEQEzBg9qloyk5liO3RmXKC6DIAZDuAnu1
         HazMi14bRpFg6GHbWG7cglkKGVAAFTNeebe8eMWh9bxp1jH0YKMZcRuk8p2UDhWd9IuR
         BKYWYzZXGJbytAdPwHXTLT9IYf3xW6KiXbV4g3v0LDzv5Rc6bndEt3w8ayPjDOKi2ayQ
         E4i8DLcNYufVNNHb+pfL7Iw52qLlcUPAMAyWaf+Emg4lbJOhNWg2oO/E30u1VOh+7K/B
         a0U47UsC7o3RTfDAP7LJD4+oXEQpTVZ/2umNrmFLj4sHsBhm7YOa9WtwNwgmyjbTdCLw
         d7nA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 011/168] perf evsel: Fix swap for samples with raw data
Date: Wed, 11 Apr 2018 00:22:33 +0200
Message-Id: <20180410212800.697659051@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399859622122145?=
X-GMAIL-MSGID: =?utf-8?q?1597399859622122145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit f9d8adb345d7adbb2d3431eea73beb89c8d6d612 ]

When we detect a different endianity we swap event before processing.
It's tricky for samples because we have no idea what's inside. We treat
it as an array of u64s, swap them and later on we swap back parts which
are different.

We mangle this way also the tracepoint raw data, which ends up in report
showing wrong data:

  1.95%  comm=Q^B pid=29285 prio=16777216 target_cpu=000
  1.67%  comm=l^B pid=0 prio=16777216 target_cpu=000

Luckily the traceevent library handles the endianity by itself (thank
you Steven!), so we can pass the RAW data directly in the other
endianity.

  2.51%  comm=beah-rhts-task pid=1175 prio=120 target_cpu=002
  2.23%  comm=kworker/0:0 pid=11566 prio=120 target_cpu=000

The fix is basically to swap back the raw data if different endianity is
detected.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20171129184346.3656-1-jolsa@kernel.org
[ Add util/memswap.c to python-ext-sources to link missing mem_bswap_64() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/evsel.c            |   20 +++++++++++++++++---
 tools/perf/util/python-ext-sources |    1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -36,6 +36,7 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "stat.h"
+#include "memswap.h"
 #include "util/parse-branch-options.h"
 
 #include "sane_ctype.h"
@@ -2120,14 +2121,27 @@ int perf_evsel__parse_sample(struct perf
 	if (type & PERF_SAMPLE_RAW) {
 		OVERFLOW_CHECK_u64(array);
 		u.val64 = *array;
-		if (WARN_ONCE(swapped,
-			      "Endianness of raw data not corrected!\n")) {
-			/* undo swap of u64, then swap on individual u32s */
+
+		/*
+		 * Undo swap of u64, then swap on individual u32s,
+		 * get the size of the raw area and undo all of the
+		 * swap. The pevent interface handles endianity by
+		 * itself.
+		 */
+		if (swapped) {
 			u.val64 = bswap_64(u.val64);
 			u.val32[0] = bswap_32(u.val32[0]);
 			u.val32[1] = bswap_32(u.val32[1]);
 		}
 		data->raw_size = u.val32[0];
+
+		/*
+		 * The raw data is aligned on 64bits including the
+		 * u32 size, so it's safe to use mem_bswap_64.
+		 */
+		if (swapped)
+			mem_bswap_64((void *) array, data->raw_size);
+
 		array = (void *)array + sizeof(u32);
 
 		OVERFLOW_CHECK(array, data->raw_size, max_size);
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -10,6 +10,7 @@ util/ctype.c
 util/evlist.c
 util/evsel.c
 util/cpumap.c
+util/memswap.c
 util/mmap.c
 util/namespaces.c
 ../lib/bitmap.c
