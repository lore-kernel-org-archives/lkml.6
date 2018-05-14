Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoicDYbDjjNBBqjT1yLX7vZrKZks4qAG4h2n8gSb2/l4uQ1UA6K8kdqVmwD/3iZAjfIe811
ARC-Seal: i=1; a=rsa-sha256; t=1526282366; cv=none;
        d=google.com; s=arc-20160816;
        b=VyJipCn/mPHPfZiJQ1xGQboUGYMszqGr7tBeAdnap90XgUZLcWe08m/oEBsYhu3No+
         PCTNhPPG21MRmoAGn+vnEGulWjDBmD109XySkBnNzpQ6uDE6wHyEctrVzCaphIDLh1lc
         nfYgIyZIvYFa9fb0/gizF7arb0/ClQLy/aAfnhjHAV8UgFJ44r2FWw+KDWtFAez5SVSr
         ozHRqwRSum97wfe6W83vQiAny4ntQNCmKVTyLxiAHDZhJCgTOFzeqjJjViZGqCT9mmCH
         V+4Gb4Xqv28uvULYSaYrlsfdVHflV5IwDsyxPOwvIM4vMUKFJnLpMPI28A7HuVybxYDp
         fbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Oxh3MCBhFC3ma/EQzO+gzY81FqA/zAOW28JJ/NKfMJA=;
        b=vKKDfbPykP3VmhcEOG83vitsT571srYxR0V1UUDj9FASrN0tRqdMplDUonKTGFaiPD
         ETs728wRwJeUXKz1dxAm42+I0t6J/lfxZIXMMgzuiq15AnlTmCrZe4DDjJl8cNBOVJXa
         GklUW5eIOuthRhqnoicezl7zwLsO2Rsq13WDUhoTDrDaFSB3sOYzqGyGJ+kHzZ+7eBdG
         k/eczR+lgR3jWyYiyeeHtc2Q+wYhpRND1HXT+oTu+JDS0yqIHE1WbXjhP2SJxLbUgOcg
         WwQp7SzQvG2F1vJue7GmPShUnIVMohq8gYcbeFDmkB8/qS3b+YkEXVerrLb/t/1Tzai6
         yiWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DbZHOjG4;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DbZHOjG4;
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
Subject: [PATCH 4.9 34/36] perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
Date: Mon, 14 May 2018 08:49:08 +0200
Message-Id: <20180514064806.875211318@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422459223722103?=
X-GMAIL-MSGID: =?utf-8?q?1600423058708754128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1,4 +1,5 @@
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/intel-family.h>
 
 enum perf_msr_id {
@@ -136,9 +137,6 @@ static int msr_event_init(struct perf_ev
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (cfg >= PERF_MSR_EVENT_MAX)
-		return -EINVAL;
-
 	/* unsupported modes and filters */
 	if (event->attr.exclude_user   ||
 	    event->attr.exclude_kernel ||
@@ -149,6 +147,11 @@ static int msr_event_init(struct perf_ev
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	if (cfg >= PERF_MSR_EVENT_MAX)
+		return -EINVAL;
+
+	cfg = array_index_nospec((unsigned long)cfg, PERF_MSR_EVENT_MAX);
+
 	if (!msr[cfg].attr)
 		return -EINVAL;
 
