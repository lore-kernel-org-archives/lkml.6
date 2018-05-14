Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqLZ6AkIpMbXuhsjtccAp3ZZ4vmU3wViYI0ckAeUCr0HTYyUnGyicI0dr47JCVzDJjKMx+N
ARC-Seal: i=1; a=rsa-sha256; t=1526281799; cv=none;
        d=google.com; s=arc-20160816;
        b=WMi3CgLcBQfCn2sDtPwJC7sK6A/bbMWE6GPk5lXKcLW0Q8BSAs1IBnGTU/CV2l0gBr
         tUBvI2hq/4PlpteJu850ev5IR6jkrZCUvK7h/5F8inPSYj+YdGEC1sr6P56pZkVUY3Us
         80TCNb5a45nuMRE/MLYvMG0LCIxAZvHlBODDxCxWnPiJ7cac8pedXTWRf8PfCJZQqeU1
         H0FcG3TBvym72IBBtl+XccZSIcE88GiOgfUAt8AKSg3ZsrJmzBzobcuFzcZmShk1LrzD
         WE9EZRBsfX451aS/RITzf0SGn7JK/DNztxSi/RoT0gJZ+xD25yY9G6bAxYBzJ27Baly/
         REnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qVahjOU5i3IyoXVBekXXtdUZhrf/iSppk2y82d9u1uM=;
        b=oheP2yX659hbTNW4n0NpDe3Ckg8so9ABrNANAInb1kM3s7RHOXxyk2AzoF0R4fc032
         Si5cZuJttkBOZmPnygznnSCjf0XjQVEBuisCADz70vuB81bfzP384Q9dHmCkJEkAWW7V
         IGfLBsu8LrLWCx5JBeI8/N3zmWefzRXUbavOcSznheR//NvcRu5nmGO8t84fOvQryb/i
         N5f1V9m33IqNEorol/GJUfr6GAvamzDvnS+JBu5x+eEQ/ynPTskGJBaHeg7lbSfRlPV4
         HTCDJmFhGCsxUTQivvz5xYarNSlWlB3foygm8/nLFpvnEYXi8BfhkJuMGZRrLSfBAc9M
         DRbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=er8zwe/a;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=er8zwe/a;
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
Subject: [PATCH 4.4 56/56] perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
Date: Mon, 14 May 2018 08:49:01 +0200
Message-Id: <20180514064800.102939692@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422464525970940?=
X-GMAIL-MSGID: =?utf-8?q?1600422464525970940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 46b1b577229a091b137831becaa0fae8690ee15a upstream.

> arch/x86/events/intel/cstate.c:307 cstate_pmu_event_init() warn: potential spectre issue 'pkg_msr' (local cap)
> arch/x86/events/intel/core.c:337 intel_pmu_event_map() warn: potential spectre issue 'intel_perfmon_event_map'
> arch/x86/events/intel/knc.c:122 knc_pmu_event_map() warn: potential spectre issue 'knc_perfmon_event_map'
> arch/x86/events/intel/p4.c:722 p4_pmu_event_map() warn: potential spectre issue 'p4_general_events'
> arch/x86/events/intel/p6.c:116 p6_pmu_event_map() warn: potential spectre issue 'p6_perfmon_event_map'
> arch/x86/events/amd/core.c:132 amd_pmu_event_map() warn: potential spectre issue 'amd_perfmon_event_map'

Userspace controls @attr, sanitize @attr->config before passing it on
to x86_pmu::event_map().

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
 arch/x86/kernel/cpu/perf_event.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/nospec.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -407,6 +408,8 @@ int x86_setup_perfctr(struct perf_event
 	if (attr->config >= x86_pmu.max_events)
 		return -EINVAL;
 
+	attr->config = array_index_nospec((unsigned long)attr->config, x86_pmu.max_events);
+
 	/*
 	 * The generic map:
 	 */
