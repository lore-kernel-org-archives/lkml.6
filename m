Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqtGQab3PQL5We7c7Mc3VA9oUGV4zARbK7XuWCqYFzacr7HOHWaJSiQ7qLZMTVDoEnQ6Hg+
ARC-Seal: i=1; a=rsa-sha256; t=1526282363; cv=none;
        d=google.com; s=arc-20160816;
        b=ct0h6I90cOdl6mR56oEdx0okY0HQhxN6emQTvrwx5zo2RzU7F81/+rd/eXnGZPZzK/
         PybTgYSM93QiaVIZo6yZtqf0PLGXG8E5NcHbUzcyARC3J6AVNoWSqj9xjUG1HLoC/hb3
         wTG8uo7E6YT6mS2KQHmIeptbrRMlGiubo7ZYCuGDq8rs/zeKkb/X0nalSh+T0j2cB7gh
         7LoxBL0ShObO9weqwlUElMJqNmnF3qC7fdcIKHwlD2TN4U3bA98Q1l2A6/kX0xnxwL0I
         pLJ0RMLbc9tcQ7Jsc1XkveNFUVCpR5NBPOBM8wQRdYgdlbbMx8oAWovF3l98hMA7W6NA
         dbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1BvlFt2dhqMnMl0ncF0J87D5GDN5KTkPt3pLnsSfa7A=;
        b=AOj/EGtJp6E78KqKEAtK+Z4MCWWTFbNEuFNiBsOwBGfQnAZny/yuS3yBi4Io17RVuo
         znzfJEvPTeP8g640ZK+FtAO0F2EBVRspsfGQ/SYRLpPbGzNu2Y6AeDvollBOIhpVWN3F
         y+fq6hcBkIJ2xN8uhA04B0641eGcDTOotUxoRR1Au6rDQ7i0nrD+9Z64Jna0xQCc+yC2
         qYEkFJPSFipQ08nOefeV1NYZ5TRqGJLY7Y8A52thzK8MkjC66fA+H+lsKV5VRK5M/i7i
         TsVpvfjc2ZssElNZjMQGyfs6eqWdBepD49BxLqNfc3yeisW9ypUntm8pgmt0Ot8UZqlr
         Oo8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xCSkDfGe;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xCSkDfGe;
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
Subject: [PATCH 4.9 33/36] perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr
Date: Mon, 14 May 2018 08:49:07 +0200
Message-Id: <20180514064806.797623501@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422456852165802?=
X-GMAIL-MSGID: =?utf-8?q?1600423055859843928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/events/intel/cstate.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -90,6 +90,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -300,6 +301,7 @@ static int cstate_pmu_event_init(struct
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
+		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!pkg_msr[cfg].attr)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
