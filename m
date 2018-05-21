Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp4t8fW3No5Pro6cqq1KRMBh8yauEeH4fLFivXbfDjuRbxHczYwHjuzekSaPO0iCRNeT1lR
ARC-Seal: i=1; a=rsa-sha256; t=1526937779; cv=none;
        d=google.com; s=arc-20160816;
        b=CowxkwBEzWCTx0wkXL6Bkc5SWsDKEVirO5nkZhj8s9cFhRdhsaLngijFu/Sy+EudWP
         jRFSauqG4xkIdig6AEz2cHs7FyhkwT0jOUJAdx+P6g2CNhtHUh08qTVAh1ndnnhB3yaN
         rl3FSEeg4Oo+8IjrQaQuHGFLpLxxQ67noBRrcQr9TjCAS0l7RqMJDpA9MMODIJL924pK
         C3sLuhc2gSsYcCEmgn2XJYxNAeNWOQOv09mYItq+XZQZOC8JIEsZGrpJQ5jia9T5cav0
         Z3H6bUj7jY5jIlufnMVcmJ57kyVWJEUWF5Ghl5VJUxqz4LLCDY6wxqG9SxrKMLtbhoUk
         YKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HU2M2JbZ3VzASzUqEkr17pnRTRGot2kf40bviCU2MAM=;
        b=BRLrUF5Q3YnCkE+aqBL0gAldAxLsQLYBrOdLrYfbc5+hU+ps2cZqxMmfUZgEjMRFdD
         R90HCMJFnz+u5q3R76ZVGFf8AT351oOL0tqIXlLlZjPu2Y/KoLT/yu/OvYCOG6ly68Ub
         M5Wt0IAy6JEgI/7KM7a8E+cvqYLzQ0OofQdEfdk5ypgDlbi2vkTL7qBV0SBeKOGL7p9X
         4H9KvwyKAQHhG+Uur2uwZJCvJk6hLSd8AtoIfjEqTQ6pqMtN1mprfBJWH5shUFb2/Tny
         yr/pD7Tbrw+3o9JBDpYn3quf/rmguGpTD55z0xnmZdevdfQNdFjw6XPhqGhmb0j3mQze
         UeVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=T1wtziou;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=T1wtziou;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 022/110] tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}
Date: Mon, 21 May 2018 23:11:19 +0200
Message-Id: <20180521210505.832255089@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109886542706508?=
X-GMAIL-MSGID: =?utf-8?q?1601110308574973936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 45dd9b0666a162f8e4be76096716670cf1741f0e upstream.

Doing an audit of trace events, I discovered two trace events in the xen
subsystem that use a hack to create zero data size trace events. This is not
what trace events are for. Trace events add memory footprint overhead, and
if all you need to do is see if a function is hit or not, simply make that
function noinline and use function tracer filtering.

Worse yet, the hack used was:

 __array(char, x, 0)

Which creates a static string of zero in length. There's assumptions about
such constructs in ftrace that this is a dynamic string that is nul
terminated. This is not the case with these tracepoints and can cause
problems in various parts of ftrace.

Nuke the trace events!

Link: http://lkml.kernel.org/r/20180509144605.5a220327@gandalf.local.home

Cc: stable@vger.kernel.org
Fixes: 95a7d76897c1e ("xen/mmu: Use Xen specific TLB flush instead of the generic one.")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/mmu.c         |    4 +---
 arch/x86/xen/mmu_pv.c      |    4 +---
 include/trace/events/xen.h |   16 ----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -42,13 +42,11 @@ xmaddr_t arbitrary_virt_to_machine(void
 }
 EXPORT_SYMBOL_GPL(arbitrary_virt_to_machine);
 
-static void xen_flush_tlb_all(void)
+static noinline void xen_flush_tlb_all(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb_all(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1280,13 +1280,11 @@ unsigned long xen_read_cr2_direct(void)
 	return this_cpu_read(xen_vcpu_info.arch.cr2);
 }
 
-static void xen_flush_tlb(void)
+static noinline void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -352,22 +352,6 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_pin);
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_unpin);
 
-TRACE_EVENT(xen_mmu_flush_tlb_all,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
-TRACE_EVENT(xen_mmu_flush_tlb,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
 TRACE_EVENT(xen_mmu_flush_tlb_one_user,
 	    TP_PROTO(unsigned long addr),
 	    TP_ARGS(addr),
