Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757431AbeBPDVb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:21:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:1689 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757383AbeBPDVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:21:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="18576205"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org, mingo@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 2/3] Documentation: convert trace/ftrace-design.txt to rst format
Date: Fri, 16 Feb 2018 11:12:18 +0800
Message-Id: <1518750739-12514-3-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
References: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 .../trace/{ftrace-design.txt => ftrace-design.rst} | 248 +++++++++++----------
 Documentation/trace/index.rst                      |   2 +
 2 files changed, 137 insertions(+), 113 deletions(-)
 rename Documentation/trace/{ftrace-design.txt => ftrace-design.rst} (75%)

diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.rst
similarity index 75%
rename from Documentation/trace/ftrace-design.txt
rename to Documentation/trace/ftrace-design.rst
index a273dd0..0f32a85 100644
--- a/Documentation/trace/ftrace-design.txt
+++ b/Documentation/trace/ftrace-design.rst
@@ -1,6 +1,8 @@
-		function tracer guts
-		====================
-		By Mike Frysinger
+======================
+Function Tracer Design
+======================
+
+:Author: Mike Frysinger
 
 Introduction
 ------------
@@ -21,8 +23,8 @@ Prerequisites
 -------------
 
 Ftrace relies on these features being implemented:
- STACKTRACE_SUPPORT - implement save_stack_trace()
- TRACE_IRQFLAGS_SUPPORT - implement include/asm/irqflags.h
+  - STACKTRACE_SUPPORT - implement save_stack_trace()
+  - TRACE_IRQFLAGS_SUPPORT - implement include/asm/irqflags.h
 
 
 HAVE_FUNCTION_TRACER
@@ -32,9 +34,11 @@ You will need to implement the mcount and the ftrace_stub functions.
 
 The exact mcount symbol name will depend on your toolchain.  Some call it
 "mcount", "_mcount", or even "__mcount".  You can probably figure it out by
-running something like:
+running something like::
+
 	$ echo 'main(){}' | gcc -x c -S -o - - -pg | grep mcount
 	        call    mcount
+
 We'll make the assumption below that the symbol is "mcount" just to keep things
 nice and simple in the examples.
 
@@ -56,8 +60,9 @@ size of the mcount call that is embedded in the function).
 
 For example, if the function foo() calls bar(), when the bar() function calls
 mcount(), the arguments mcount() will pass to the tracer are:
-	"frompc" - the address bar() will use to return to foo()
-	"selfpc" - the address bar() (with mcount() size adjustment)
+
+  - "frompc" - the address bar() will use to return to foo()
+  - "selfpc" - the address bar() (with mcount() size adjustment)
 
 Also keep in mind that this mcount function will be called *a lot*, so
 optimizing for the default case of no tracer will help the smooth running of
@@ -67,39 +72,41 @@ means the code flow should usually be kept linear (i.e. no branching in the nop
 case).  This is of course an optimization and not a hard requirement.
 
 Here is some pseudo code that should help (these functions should actually be
-implemented in assembly):
+implemented in assembly)::
 
-void ftrace_stub(void)
-{
-	return;
-}
+	void ftrace_stub(void)
+	{
+		return;
+	}
 
-void mcount(void)
-{
-	/* save any bare state needed in order to do initial checking */
+	void mcount(void)
+	{
+		/* save any bare state needed in order to do initial checking */
 
-	extern void (*ftrace_trace_function)(unsigned long, unsigned long);
-	if (ftrace_trace_function != ftrace_stub)
-		goto do_trace;
+		extern void (*ftrace_trace_function)(unsigned long, unsigned long);
+		if (ftrace_trace_function != ftrace_stub)
+			goto do_trace;
 
-	/* restore any bare state */
+		/* restore any bare state */
 
-	return;
+		return;
 
-do_trace:
+	do_trace:
 
-	/* save all state needed by the ABI (see paragraph above) */
+		/* save all state needed by the ABI (see paragraph above) */
 
-	unsigned long frompc = ...;
-	unsigned long selfpc = <return address> - MCOUNT_INSN_SIZE;
-	ftrace_trace_function(frompc, selfpc);
+		unsigned long frompc = ...;
+		unsigned long selfpc = <return address> - MCOUNT_INSN_SIZE;
+		ftrace_trace_function(frompc, selfpc);
 
-	/* restore all state needed by the ABI */
-}
+		/* restore all state needed by the ABI */
+	}
 
 Don't forget to export mcount for modules !
-extern void mcount(void);
-EXPORT_SYMBOL(mcount);
+::
+
+	extern void mcount(void);
+	EXPORT_SYMBOL(mcount);
 
 
 HAVE_FUNCTION_GRAPH_TRACER
@@ -127,38 +134,40 @@ That function will simply call the common ftrace_return_to_handler function and
 that will return the original return address with which you can return to the
 original call site.
 
-Here is the updated mcount pseudo code:
-void mcount(void)
-{
-...
-	if (ftrace_trace_function != ftrace_stub)
-		goto do_trace;
-
-+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-+	extern void (*ftrace_graph_return)(...);
-+	extern void (*ftrace_graph_entry)(...);
-+	if (ftrace_graph_return != ftrace_stub ||
-+	    ftrace_graph_entry != ftrace_graph_entry_stub)
-+		ftrace_graph_caller();
-+#endif
-
-	/* restore any bare state */
-...
-
-Here is the pseudo code for the new ftrace_graph_caller assembly function:
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-void ftrace_graph_caller(void)
-{
-	/* save all state needed by the ABI */
-
-	unsigned long *frompc = &...;
-	unsigned long selfpc = <return address> - MCOUNT_INSN_SIZE;
-	/* passing frame pointer up is optional -- see below */
-	prepare_ftrace_return(frompc, selfpc, frame_pointer);
-
-	/* restore all state needed by the ABI */
-}
-#endif
+Here is the updated mcount pseudo code::
+
+	void mcount(void)
+	{
+	...
+		if (ftrace_trace_function != ftrace_stub)
+			goto do_trace;
+
+	+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	+	extern void (*ftrace_graph_return)(...);
+	+	extern void (*ftrace_graph_entry)(...);
+	+	if (ftrace_graph_return != ftrace_stub ||
+	+	    ftrace_graph_entry != ftrace_graph_entry_stub)
+	+		ftrace_graph_caller();
+	+#endif
+
+		/* restore any bare state */
+	...
+
+Here is the pseudo code for the new ftrace_graph_caller assembly function::
+
+	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	void ftrace_graph_caller(void)
+	{
+		/* save all state needed by the ABI */
+
+		unsigned long *frompc = &...;
+		unsigned long selfpc = <return address> - MCOUNT_INSN_SIZE;
+		/* passing frame pointer up is optional -- see below */
+		prepare_ftrace_return(frompc, selfpc, frame_pointer);
+
+		/* restore all state needed by the ABI */
+	}
+	#endif
 
 For information on how to implement prepare_ftrace_return(), simply look at the
 x86 version (the frame pointer passing is optional; see the next section for
@@ -171,20 +180,21 @@ that the ABI that applies here is different from what applies to the mcount
 code.  Since you are returning from a function (after the epilogue), you might
 be able to skimp on things saved/restored (usually just registers used to pass
 return values).
+::
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-void return_to_handler(void)
-{
-	/* save all state needed by the ABI (see paragraph above) */
+	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	void return_to_handler(void)
+	{
+		/* save all state needed by the ABI (see paragraph above) */
 
-	void (*original_return_point)(void) = ftrace_return_to_handler();
+		void (*original_return_point)(void) = ftrace_return_to_handler();
 
-	/* restore all state needed by the ABI */
+		/* restore all state needed by the ABI */
 
-	/* this is usually either a return or a jump */
-	original_return_point();
-}
-#endif
+		/* this is usually either a return or a jump */
+		original_return_point();
+	}
+	#endif
 
 
 HAVE_FUNCTION_GRAPH_FP_TEST
@@ -228,20 +238,20 @@ HAVE_SYSCALL_TRACEPOINTS
 
 You need very few things to get the syscalls tracing in an arch.
 
-- Support HAVE_ARCH_TRACEHOOK (see arch/Kconfig).
-- Have a NR_syscalls variable in <asm/unistd.h> that provides the number
-  of syscalls supported by the arch.
-- Support the TIF_SYSCALL_TRACEPOINT thread flags.
-- Put the trace_sys_enter() and trace_sys_exit() tracepoints calls from ptrace
-  in the ptrace syscalls tracing path.
-- If the system call table on this arch is more complicated than a simple array
-  of addresses of the system calls, implement an arch_syscall_addr to return
-  the address of a given system call.
-- If the symbol names of the system calls do not match the function names on
-  this arch, define ARCH_HAS_SYSCALL_MATCH_SYM_NAME in asm/ftrace.h and
-  implement arch_syscall_match_sym_name with the appropriate logic to return
-  true if the function name corresponds with the symbol name.
-- Tag this arch as HAVE_SYSCALL_TRACEPOINTS.
+  - Support HAVE_ARCH_TRACEHOOK (see arch/Kconfig).
+  - Have a NR_syscalls variable in <asm/unistd.h> that provides the number
+    of syscalls supported by the arch.
+  - Support the TIF_SYSCALL_TRACEPOINT thread flags.
+  - Put the trace_sys_enter() and trace_sys_exit() tracepoints calls from ptrace
+    in the ptrace syscalls tracing path.
+  - If the system call table on this arch is more complicated than a simple array
+    of addresses of the system calls, implement an arch_syscall_addr to return
+    the address of a given system call.
+  - If the symbol names of the system calls do not match the function names on
+    this arch, define ARCH_HAS_SYSCALL_MATCH_SYM_NAME in asm/ftrace.h and
+    implement arch_syscall_match_sym_name with the appropriate logic to return
+    true if the function name corresponds with the symbol name.
+  - Tag this arch as HAVE_SYSCALL_TRACEPOINTS.
 
 
 HAVE_FTRACE_MCOUNT_RECORD
@@ -276,22 +286,28 @@ Once those are out of the way, you will need to implement:
 
 First you will need to fill out some arch details in your asm/ftrace.h.
 
-Define MCOUNT_ADDR as the address of your mcount symbol similar to:
+Define MCOUNT_ADDR as the address of your mcount symbol similar to::
+
 	#define MCOUNT_ADDR ((unsigned long)mcount)
-Since no one else will have a decl for that function, you will need to:
+
+Since no one else will have a decl for that function, you will need to::
+
 	extern void mcount(void);
 
 You will also need the helper function ftrace_call_adjust().  Most people
-will be able to stub it out like so:
+will be able to stub it out like so::
+
 	static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	{
 		return addr;
 	}
+
 <details to be filled>
 
 Lastly you will need the custom dyn_arch_ftrace structure.  If you need
 some extra state when runtime patching arbitrary call sites, this is the
-place.  For now though, create an empty struct:
+place.  For now though, create an empty struct::
+
 	struct dyn_arch_ftrace {
 		/* No extra data needed */
 	};
@@ -306,28 +322,28 @@ easier to have two separate definitions split up by #ifdefs.  Same goes for
 the ftrace_stub() as that will now be inlined in ftrace_caller().
 
 Before we get confused anymore, let's check out some pseudo code so you can
-implement your own stuff in assembly:
+implement your own stuff in assembly::
 
-void mcount(void)
-{
-	return;
-}
+	void mcount(void)
+	{
+		return;
+	}
 
-void ftrace_caller(void)
-{
-	/* save all state needed by the ABI (see paragraph above) */
+	void ftrace_caller(void)
+	{
+		/* save all state needed by the ABI (see paragraph above) */
 
-	unsigned long frompc = ...;
-	unsigned long selfpc = <return address> - MCOUNT_INSN_SIZE;
+		unsigned long frompc = ...;
+		unsigned long selfpc = <return address> - MCOUNT_INSN_SIZE;
 
-ftrace_call:
-	ftrace_stub(frompc, selfpc);
+	ftrace_call:
+		ftrace_stub(frompc, selfpc);
 
-	/* restore all state needed by the ABI */
+		/* restore all state needed by the ABI */
 
-ftrace_stub:
-	return;
-}
+	ftrace_stub:
+		return;
+	}
 
 This might look a little odd at first, but keep in mind that we will be runtime
 patching multiple things.  First, only functions that we actually want to trace
@@ -341,21 +357,23 @@ order to make it through the next section.
 
 Every arch has an init callback function.  If you need to do something early on
 to initialize some state, this is the time to do that.  Otherwise, this simple
-function below should be sufficient for most people:
+function below should be sufficient for most people::
 
-int __init ftrace_dyn_arch_init(void)
-{
-	return 0;
-}
+	int __init ftrace_dyn_arch_init(void)
+	{
+		return 0;
+	}
 
 There are two functions that are used to do runtime patching of arbitrary
 functions.  The first is used to turn the mcount call site into a nop (which
 is what helps us retain runtime performance when not tracing).  The second is
 used to turn the mcount call site into a call to an arbitrary location (but
 typically that is ftracer_caller()).  See the general function definition in
-linux/ftrace.h for the functions:
+linux/ftrace.h for the functions::
+
 	ftrace_make_nop()
 	ftrace_make_call()
+
 The rec->ip value is the address of the mcount call site that was collected
 by the scripts/recordmcount.pl during build time.
 
@@ -364,7 +382,8 @@ will be modifying the assembly code at the location of the ftrace_call symbol
 inside of the ftrace_caller() function.  So you should have sufficient padding
 at that location to support the new function calls you'll be inserting.  Some
 people will be using a "call" type instruction while others will be using a
-"branch" type instruction.  Specifically, the function is:
+"branch" type instruction.  Specifically, the function is::
+
 	ftrace_update_ftrace_func()
 
 
@@ -373,6 +392,7 @@ HAVE_DYNAMIC_FTRACE + HAVE_FUNCTION_GRAPH_TRACER
 
 The function grapher needs a few tweaks in order to work with dynamic ftrace.
 Basically, you will need to:
+
 	- update:
 		- ftrace_caller()
 		- ftrace_graph_call()
@@ -382,7 +402,9 @@ Basically, you will need to:
 		- ftrace_disable_ftrace_graph_caller()
 
 <details to be filled>
+
 Quick notes:
+
 	- add a nop stub after the ftrace_call location named ftrace_graph_call;
 	  stub needs to be large enough to support a call to ftrace_graph_caller()
 	- update ftrace_graph_caller() to work with being called by the new
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index d986ead..c8000ba 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -4,3 +4,5 @@ Linux Tracing Technologies
 
 .. toctree::
    :maxdepth: 2
+
+   ftrace-design
-- 
2.7.4
