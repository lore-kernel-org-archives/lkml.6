Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr88Xqwax+ImyeF4zuZQwvMW0SKM6MIuhnKiHOrlokXuKPdUdXOIZSoVdByIodHP4PnbR3q
ARC-Seal: i=1; a=rsa-sha256; t=1526281795; cv=none;
        d=google.com; s=arc-20160816;
        b=th/1G0dpq/TZGV93yBjnEOO2OvZzTpbsLPuBZJUN2KecKhoBsV3BUskxZUDoEFPPqj
         moXrSOMsFEUhJ5xbDcAXF54xqQv1T1UpOl1lUVkAv+8OtkV0f9riknYXZLHF9xxZAk4d
         CXmH1oqW4KJG3cdwI/+3CI+F+cByiCjyDd/rDIlt6htBignOKiLCFVg64exU+hcia7EI
         qYY5GAKbSZpHXDnNlWsWCH/kshqHfY8tqPOxbD1hbV6z9EZUPs3l+9m8TbXuYGR6Jibv
         kZhJAMGReTfgfCOI4WXt6LFQTNqg7Fzacw/FzTFyF/RwQLVRw645uN2C0Kv2DLRW95NG
         Uf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=jyRqyq/1z9KHVu8mayuMY/rvH46RRc6QV7X8JNZ3hoc=;
        b=BsRr/OBB77KwTYdf2x95OXlw/nx28ZwPO+pIqq6VKEBBcF673JIWYUKH1bsxA3Ou6v
         DmMli4Z692Q9efxSipS+k1VYtISR6sTnPPDMzYPpie+oW+0z64MohqzqBVfuOTBIqvcC
         LevNtcmAbPANbRf9avmGJhd0Y/xeO8oromoIrsv1U2Ko0boi16GmHantOkd1YJRvFKpl
         ZnjosgGvjUXcbFS6XK9lozjbd6BA6Hih63v9paRxxqIQ82IcAW+3/I25APZ3rgAx2MM8
         EdDd7IV5nYGGtrrbzZduaZIk37os4dq3QyfOsWsNPsWGJI0eKD2xR6EReyVMHPDlx/Lz
         ghHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V0/1/fwl;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V0/1/fwl;
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
Subject: [PATCH 4.4 54/56] perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
Date: Mon, 14 May 2018 08:48:59 +0200
Message-Id: <20180514064759.879843333@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422459223722103?=
X-GMAIL-MSGID: =?utf-8?q?1600422459223722103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/kernel/cpu/perf_event_msr.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/perf_event_msr.c
+++ b/arch/x86/kernel/cpu/perf_event_msr.c
@@ -1,4 +1,5 @@
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 
 enum perf_msr_id {
 	PERF_MSR_TSC			= 0,
@@ -115,9 +116,6 @@ static int msr_event_init(struct perf_ev
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (cfg >= PERF_MSR_EVENT_MAX)
-		return -EINVAL;
-
 	/* unsupported modes and filters */
 	if (event->attr.exclude_user   ||
 	    event->attr.exclude_kernel ||
@@ -128,6 +126,11 @@ static int msr_event_init(struct perf_ev
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	if (cfg >= PERF_MSR_EVENT_MAX)
+		return -EINVAL;
+
+	cfg = array_index_nospec((unsigned long)cfg, PERF_MSR_EVENT_MAX);
+
 	if (!msr[cfg].attr)
 		return -EINVAL;
 
