Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoE3Y5QfsKJrFzZOEEbxFhyWdqhFmzMaWNHH32eK176NwDPSSra/NXjWz0BXKKLqoxj5t0B
ARC-Seal: i=1; a=rsa-sha256; t=1526282391; cv=none;
        d=google.com; s=arc-20160816;
        b=wGVe4a6TfWvanwEYWTS0Z776WD76OqIO68YOe+lTqz9r/NzET5hgKuDoPkVP7nk31K
         NuSLbEOJ0b7/vEt6deGPQhcnxJXiM5MPkO41DFmptLkw+mgP4Clhdcbeh/sof2Nkapx/
         +uU71kUjb45tW46QikXuucYht/TXBsMY6U9uFE/V2NbmIPLS0lU+3jdMqtbuZwl4CqPU
         ZyTG0BndzfEwwKmpddxh+Z8D7bpmcyp9Q2Njp8z+Ej8LVLWtb+UaJlN4XYUSetsdM2lB
         hg4yH1J3GpvDgs3mFkdHqD4LigBxwxz9z1ew/X+AhW07w0js5HUUWL9ifsrJ182MDUL8
         qxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2jXZ0b7DEYcuDMTAsCESXmHzHc1xZzzH1Wwp5bErQ+s=;
        b=Tp9f5eAuXCGQfZD0SxbuouERXf6FRgMuvMcxZEssvTeChiaduyR03g6drp+Vhi7Pmt
         twGsfICbO0/Z3UdFPRHpVwRyv7+3wCM4gZnEPztXe3WP0Wi8Mvf6aIDSMtUbBq29mFKi
         6t8Oa0W1b2VzDqxa+hoHwfrIFSaJYARIZbnxzEmtcfPVu7PUaa3owQiWI7sdswPPDF6n
         sP8fQ8HfGkcVFPk+2M5lZbbjuHQ+MOQ7oeGrcxbMluW+cQP1AnkqdTn4QwuYOSNTpKMT
         T4nDjoYfwlJoKsbDgicl6TsfvnLTvcDNnF5vRL7KyI7PJrDcBX8teYDGcBPq0W54v19j
         K9ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OYc5D9AE;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OYc5D9AE;
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
Subject: [PATCH 4.16 70/72] perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
Date: Mon, 14 May 2018 08:49:27 +0200
Message-Id: <20180514064828.005763748@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422459223722103?=
X-GMAIL-MSGID: =?utf-8?q?1600423085245038606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -158,9 +159,6 @@ static int msr_event_init(struct perf_ev
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (cfg >= PERF_MSR_EVENT_MAX)
-		return -EINVAL;
-
 	/* unsupported modes and filters */
 	if (event->attr.exclude_user   ||
 	    event->attr.exclude_kernel ||
@@ -171,6 +169,11 @@ static int msr_event_init(struct perf_ev
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	if (cfg >= PERF_MSR_EVENT_MAX)
+		return -EINVAL;
+
+	cfg = array_index_nospec((unsigned long)cfg, PERF_MSR_EVENT_MAX);
+
 	if (!msr[cfg].attr)
 		return -EINVAL;
 
