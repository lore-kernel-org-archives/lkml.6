Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpwVhPnasyKY2r4dCM3lblDZo3d9D+s7DuI01D+ZDEcQF0RlGRt0tihMRj9SU5HawPHOalS
ARC-Seal: i=1; a=rsa-sha256; t=1526282285; cv=none;
        d=google.com; s=arc-20160816;
        b=Fh9/p2LoeBCCg8z4F9aELp0L/PASPdIjGfAKsBZ4ysNWjjkNyFghi9FOtV6OXrsQ/v
         Ss5wdyVhM+eNVjVFEbQYaP+QX23S3M8ZEDjlM5PxIj37IlWi7OQtyVzAuzpTg5oYmFnu
         E6E9szhrnNEWJoTi/b5m/ruQ1uk6LGUqHT5Rv2lH1hIqi0U0Iohfkf7CjqGqiF726iCN
         lNIVu5D6TK2pQ4pkvrygR/mL0lCqZMEypJu5lKIY010VN39zvQ5Qh+yQeQvLdBxKspFQ
         FG2dWkZC9ot7Vef14MS096CJJwMfVDf8XH8pBZMEl/pkF4/7Mn3WjSwmhONP+avEnXMq
         51wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ac2iqe18ToomIBDsLR7OyovVR31TGqKVHwHPtBbO9p0=;
        b=dZUEl7mBM+fs34p03dSUYtz29vmL23SEtuE+uLCpySvD/NIDRA9xdBh/DPLgxHETl7
         zQJRpAYSgVH0fi/btsCO5Mz0mn87jG19j3vOeeznRV5a5DoL3Zt/JCbdKdWMgInRKeoe
         3Pv1UcxxkvRWG4EJiCe08pV1xbqUCE5pSAllj2zvZ7NgilCIudKoC1GlT+12xRIIn86W
         hI1Vse8/qs2Su7VvyNopMmbkVai7ZboQuuopP21j20TT/SN8AqWDtHT0FinVIgxiazNM
         RyxOUm9SpAtE1n7sT0JYyzeE13T4o56O4FEg7xPN8T+RXxStLoos4byualu65aXtOySr
         U+YA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gqO/kt+K;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gqO/kt+K;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 58/62] perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
Date: Mon, 14 May 2018 08:49:14 +0200
Message-Id: <20180514064819.692565508@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422459223722103?=
X-GMAIL-MSGID: =?utf-8?q?1600422973410348667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 06ce6e9b6d6c09d4129c6e24a1314a395d816c10 upstream.

> arch/x86/events/msr.c:178 msr_event_init() warn: potential spectre issue 'msr' (local cap)

Userspace controls @attr, sanitize cfg (attr->config) before using it
to index an array.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/msr.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/intel-family.h>
 
 enum perf_msr_id {
@@ -145,9 +146,6 @@ static int msr_event_init(struct perf_ev
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (cfg >= PERF_MSR_EVENT_MAX)
-		return -EINVAL;
-
 	/* unsupported modes and filters */
 	if (event->attr.exclude_user   ||
 	    event->attr.exclude_kernel ||
@@ -158,6 +156,11 @@ static int msr_event_init(struct perf_ev
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	if (cfg >= PERF_MSR_EVENT_MAX)
+		return -EINVAL;
+
+	cfg = array_index_nospec((unsigned long)cfg, PERF_MSR_EVENT_MAX);
+
 	if (!msr[cfg].attr)
 		return -EINVAL;
 
