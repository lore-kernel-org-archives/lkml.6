Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqLHd7Qo4uenUh73F1nlm1J6cmTfhBNplcMmrWmlAWIt+sv+ifEfvr3Gzl5k+MH09rHcI21
ARC-Seal: i=1; a=rsa-sha256; t=1526281792; cv=none;
        d=google.com; s=arc-20160816;
        b=AqQKNPhhRKHFc3GO/5Re95K9UTjnwt/3PcKB+BxumQb2QSn/Zhp6InGIYJVT8kF1WX
         4+5FfSgQMmQVuDxmV1Xog7OVdzVzx2l9Y5GflZipjps0Cdv2abAptpKmLD8/2iFxHYuU
         9H44UhvCdo5kOe0fThz1fRwfi0SqWhk3eh1B5gF9sqKbjl9FIs1JmLrqlgmASfnFlOdf
         mew+/jz+Qk+X1wKDNCdDB2YR/20udFL0TWhgtOYl/4kGSSVeOF/qs7yFyQv5wcO1ksC6
         iQWTbvqtloE315rUpzrxtchKwhnNKmBs9Aczn06vhm1R/te10e6HIP6pxM2iDbtl2Vdt
         hDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4A7rmPFyWylShK+amUFgdvx4ffWO3GhxbNC/3EtZvr0=;
        b=dzdN22Cj8TvNP4JjxlClKZ6YIl87kDSEtZKQYglzOWmpId6VU+Y5Sd5qcVHoLo6xbo
         Y4XNFmaLyCZXwHEHpc/YoIdm5G9AnqAVgdoPH+GkO4jKQwPr7j5HOBeUXFAwRwvo4Jif
         XZwyQlfB8S7DvYjxysnGuGixhcnxfqfTiOt8Tps3hJpyXWcvhvk9z/+EEV3s7IOCp7EI
         BEZd86WkCztWDf2Q69OsEH5DHqEu9GZUU8WwZS+cRdrG8g3cRKP/mWv5zUGlO3GNJr/x
         bawO9GZwePsPB+AD5TcD2ji453gEKlPiFVmonONzFjtTr4U1Efqih9vyM3KfEo3cc9VH
         x0Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ssB3qdue;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ssB3qdue;
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
Subject: [PATCH 4.4 53/56] perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr
Date: Mon, 14 May 2018 08:48:58 +0200
Message-Id: <20180514064759.762178200@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422456852165802?=
X-GMAIL-MSGID: =?utf-8?q?1600422456852165802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit a5f81290ce475489fa2551c01a07470c1a4c932e upstream.

> arch/x86/events/intel/cstate.c:307 cstate_pmu_event_init() warn: potential spectre issue 'pkg_msr' (local cap)

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
 arch/x86/kernel/cpu/perf_event_intel_cstate.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/cpu/perf_event_intel_cstate.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_cstate.c
@@ -88,6 +88,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include "perf_event.h"
 
@@ -409,6 +410,7 @@ static int cstate_pmu_event_init(struct
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
+		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!pkg_msr[cfg].attr)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
