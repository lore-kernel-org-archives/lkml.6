Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq216fXpSeRZUNYGKKZjI95vfZ9WxR16hMzylaiuMH9yesxpLk4Vr1AK9LdReWVK+v2bGxD
ARC-Seal: i=1; a=rsa-sha256; t=1526937376; cv=none;
        d=google.com; s=arc-20160816;
        b=WH2Cink2wGPbDGFhpOrPgOMg59WI0xf9IK+FJj1jb/s09f/IXhjOCojb7C2hQ/kugg
         bewxxMpIJ0DG0DcAVGgtZ92XFpmrgEdhSMpa9VeHTRivjdsLJw9HydQ/vjFMnEqcKvGn
         ZPdGWAcyIksS+P+4ZRv7Sgqal0ZSrGY4ANciiJL4O3PyO09hpZO3JxBqEaGC7v6MHzOE
         llN97Tx0V0GXffw0MhyEWfySRH+CQnypnoBJ5Pjdp40whDpEyfE00Hv1LxGArgbrc4k8
         l8hTRKhJisa5BUvf8dZKE0bbcipUs4xbMI1WWTFSD2g9F3ROz9wFGnqSly/J5lsgZDg/
         Yf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+5YH2BfSL41GzHElzeonBheJYdxbNy3saJB4tgWfkQg=;
        b=TryGpXPB2VXc24YxkZjdBWu+EhaxFs3c9imRV8CsCFqish70eruiwkIgfs86BNhLmJ
         Fs9BljsUN+BPLam/RLIdnPHJ+CvfVj/Lfs77VUsllFZZbFDGXRmQB5IvLU7lXTmCkcgs
         R9pySU2xXujjb2SFyTLXVRWgmXGN3NUS4rrVo8Hvc3/duExVrnxZGisCAWocCo+YOcYR
         X1lzzyQRB3zY9hp1yRfVZJ6mZrxzIOlD/GzpriQmD2QfZS3eMx7upIkwhNvCL7X6cfu8
         MWKj2FGbBUbK5OD386TVA/5t4Il/Hj5Jt+Wdz9B158I1V2ayS+n9/agJ6ySsQLJrJq1q
         lI+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qgjVi1y7;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qgjVi1y7;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 15/87] tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}
Date: Mon, 21 May 2018 23:10:51 +0200
Message-Id: <20180521210421.701469567@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109886542706508?=
X-GMAIL-MSGID: =?utf-8?q?1601109886542706508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/xen/mmu.c         |    4 ----
 include/trace/events/xen.h |   16 ----------------
 2 files changed, 20 deletions(-)

--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1317,8 +1317,6 @@ void xen_flush_tlb_all(void)
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb_all(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
@@ -1336,8 +1334,6 @@ static void xen_flush_tlb(void)
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -377,22 +377,6 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
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
 TRACE_EVENT(xen_mmu_flush_tlb_single,
 	    TP_PROTO(unsigned long addr),
 	    TP_ARGS(addr),
