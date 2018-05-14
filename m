Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrVuLQxDvuJCtnORo3mqeCD+Bp+8d0irCFVJL8NMsdMNtfgF4C1PuJJEk5EkH6l4h4rQKh2
ARC-Seal: i=1; a=rsa-sha256; t=1526282282; cv=none;
        d=google.com; s=arc-20160816;
        b=YZ46MzMcSU9hrKsRGDKUEhVWsdZstGbkjFiffX8uIU0iBWKlBSxhi815cy4MKeb8R5
         6MEFCwTma1dS5o1FXaw7eiZA6EdJQ55NM8mDr13ELxe3qB/1GtXXT8pwsQHvmEr6dMi8
         b447vJoHq7j+mnl65HvGY/MKqS9YS6rWcjCO9a4ucs0yZmFsy323X8OKXU6bA5IFmDhH
         OmlQslfsForQcyF5+SAxoYJBJS98R1fhXzfu8IVqEsy8LXhLYLy8s+8DyhjhaaDtifrt
         lLEpWnKpzWYGc+FxWjsY6b7Is9oanfDTW/8Ihuwp7ehLkb+p4GoQzfiZaiCq+odZ8yRz
         tflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wyI+GfxkdxrcRy0a9fQbbHkv84n4cRPu7W6I5KxdPRY=;
        b=YhQWKeT34x8+yTvucqgsqfFX0cRx0DEtOGF+bxI0JObqTcUr8MuQ9qjKIWjLzFb886
         rz5NFBeApfi/sZr7vlu8ckkc7OaAFBVznKEaC2OLt8pWekYE/puXcmbUNDPEebOHLadh
         sClFTi9U2niPbODKkqp8sK7uoi4HD0AxI5SZr6vsTEiu+GnTSRCVbVq18yYeee7RreyF
         rGIn3g/TrjGNx9KN87VYlCuCmlHNuwBZUR4Don7PP2AVRFti5TJKP8eUo8Jetwxe5+Iy
         V7IzsAh4fzqx23cf6vt9Mc4oxJB7L7AtDKJ/eEWzLcc3GSlarWAUClcUe08majzOKux0
         HGuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fWIIoR71;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fWIIoR71;
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
Subject: [PATCH 4.14 57/62] perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr
Date: Mon, 14 May 2018 08:49:13 +0200
Message-Id: <20180514064819.639223840@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422456852165802?=
X-GMAIL-MSGID: =?utf-8?q?1600422970893293759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -91,6 +91,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -301,6 +302,7 @@ static int cstate_pmu_event_init(struct
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
+		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!pkg_msr[cfg].attr)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
