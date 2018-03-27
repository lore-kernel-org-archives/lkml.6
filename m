Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48tQBi4k1ynjQtCE9aVfne9OAdoxgcyLXbNC/eQ2kBz9rq6CaCU/+ru3dDJcjjCTE/pU/2H
ARC-Seal: i=1; a=rsa-sha256; t=1522168668; cv=none;
        d=google.com; s=arc-20160816;
        b=EUmywhLrW9ZyGUM/bqpykIX623CDoAlicP8WHImoOnZy1GDKClcNqqFRKJTBbqFa1A
         kgxu4hoZpT3M32cJgn+I8zxEMUu1QM77/qcl6ToriM1KgoZMRioo7Dh32H3DFRpq3HAp
         DeDHm8w/54ayCExRj439wKWp/dF5Ej6lTTaN5AakpOgw/0LtGTA6TDgH2LY7nn6gZHsB
         5W9CWsZqyffMQ4o3BpO+Y/lBFRcdKbAT8NKwKjQBR0q2F+48Bfx4WNEqx3EqT9QL/L1h
         4VQvP2pR5LrBA19EU5jJCe6nkLCPwYejF71sIR/5qk0/aCIgkXUts3fbG+X/eJ8Hm/c8
         A+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZYMw6Y3KWPa4DMofcKPawXHP5szninevGMzJ0XpE0tU=;
        b=GoeX74ScZPTbC91WYGiGQzPWyhUBF1BL6Srot78zMb0KBB0Jl8+9aObAPbnaZgNdWE
         7p/pA816PPb2qCgyzvUYS0bzee0hUh1oBRWlViB/3DhCTYMdw0v9N4AO4VzwuIKfI+DV
         riLNty22tFoaanJiqT6TirWpFxcLpSHL+anXpl+8hK+W+eRFBzyeUkHeQE8X2D/GBgFg
         MPDGDd1weOXZVhX6Kk8YDoZBcXoRo4fPW5Sxte61SXd2hhI//B7/o6et41mM44kGFvny
         o5H+GBXZwoBlMtsrGnOAkLSjUagt9Y29zhWDb5QX6QZ1H2CoNBDgaSzmNB+LutaptyZz
         MmoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ephraim Park <ephiepark@fb.com>,
	Song Liu <songliubraving@fb.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	jolsa@redhat.com,
	kernel-team@fb.com,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 089/101] perf/core: Fix ctx_event_type in ctx_resched()
Date: Tue, 27 Mar 2018 18:28:01 +0200
Message-Id: <20180327162755.502643123@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109534205598912?=
X-GMAIL-MSGID: =?utf-8?q?1596109534205598912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <songliubraving@fb.com>

commit bd903afeb504db5655a45bb4cf86f38be5b1bf62 upstream.

In ctx_resched(), EVENT_FLEXIBLE should be sched_out when EVENT_PINNED is
added. However, ctx_resched() calculates ctx_event_type before checking
this condition. As a result, pinned events will NOT get higher priority
than flexible events.

The following shows this issue on an Intel CPU (where ref-cycles can
only use one hardware counter).

  1. First start:
       perf stat -C 0 -e ref-cycles  -I 1000
  2. Then, in the second console, run:
       perf stat -C 0 -e ref-cycles:D -I 1000

The second perf uses pinned events, which is expected to have higher
priority. However, because it failed in ctx_resched(). It is never
run.

This patch fixes this by calculating ctx_event_type after re-evaluating
event_type.

Reported-by: Ephraim Park <ephiepark@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <jolsa@redhat.com>
Cc: <kernel-team@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 487f05e18aa4 ("perf/core: Optimize event rescheduling on active contexts")
Link: http://lkml.kernel.org/r/20180306055504.3283731-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2322,7 +2322,7 @@ static void ctx_resched(struct perf_cpu_
 			struct perf_event_context *task_ctx,
 			enum event_type_t event_type)
 {
-	enum event_type_t ctx_event_type = event_type & EVENT_ALL;
+	enum event_type_t ctx_event_type;
 	bool cpu_event = !!(event_type & EVENT_CPU);
 
 	/*
@@ -2332,6 +2332,8 @@ static void ctx_resched(struct perf_cpu_
 	if (event_type & EVENT_PINNED)
 		event_type |= EVENT_FLEXIBLE;
 
+	ctx_event_type = event_type & EVENT_ALL;
+
 	perf_pmu_disable(cpuctx->ctx.pmu);
 	if (task_ctx)
 		task_ctx_sched_out(cpuctx, task_ctx, event_type);
