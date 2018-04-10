Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48BQBv6wfy/WKaJMA26Buqe0+Ud2wrxQva6BIS0ip0u4AWBvhTGlfxrrraPQbutZI7uI1Pw
ARC-Seal: i=1; a=rsa-sha256; t=1523399693; cv=none;
        d=google.com; s=arc-20160816;
        b=BEVCTHjMeKDdwWdvzn821jYRr4LlvjJnUhhBKMay0tCkBC9NmUnjTqQ2J14LwVv+NN
         LYlLHQ9ud38Ns4uiSL34EHnDstuIvwI0VqlqCyh0k3drHgu+QT/VaQGumvlmdQL8dEeL
         hU6uhbWH3M75JQZv98Bh/Na988024swJen+0lEse3pbmRejpBxtuSLU6cw45Zfw9svB2
         OwJezJHBrEzjX4ObdnAL3N33EtCt85pzQBEHKcntTOeCVmhfRZALc/RiyqGIclcK8QCO
         aPbk3M76nBkBMxH2YR7TEAG2xCcYC6hRitciACSLi0FIQyG+1MBdPFQB3a/xniP33dAi
         Xptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yOygl7RoU4Ch5lsK/idhxNZwdV+7XtkelWEY41YL3wM=;
        b=me1AWtV6tCGiDZjMFYqVsRhI+TGgsGVAT6AaxNmUQoDkwo75lGISSTnGgSugffNf08
         qYGE8k8ju9vz1/1CA3WpowhoCrzyfAmVtX2YpvyvQoEJzPkIoVHja8BNrk/LpKR+lrJb
         f6TFWEO2oNEiGkgLrmAoytJ0nO4M/+Fdknvl4/4HDY8mbyFRDYAG03dsBlHB+HGOSWzM
         Xs78V9z3oH6ek54OWtft0gd2G5sOjXQU0Z+/0Ezz4QwvKh3IwDaqUjTmWXF/gom4GSER
         F0xX08g3LTyfVt6YbTWogYLPVFboo2q5FXkRS+Whxx5EF2x1XRLVz41lBzSXVQ6nzV/E
         6dRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Richter <tmricht@linux.vnet.ibm.com>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paul Clarke <pc@us.ibm.com>,
	bhargavb <bhargavaramudu@gmail.com>,
	linux-rt-users@vger.kernel.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 009/138] perf probe: Find versioned symbols from map
Date: Wed, 11 Apr 2018 00:23:19 +0200
Message-Id: <20180410212903.244714179@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399884410254344?=
X-GMAIL-MSGID: =?utf-8?q?1597400357050322208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>


[ Upstream commit 4b3a2716dd785fabb9f6ac80c1d53cb29a88169d ]

Commit d80406453ad4 ("perf symbols: Allow user probes on versioned
symbols") allows user to find default versioned symbols (with "@@") in
map. However, it did not enable normal versioned symbol (with "@") for
perf-probe.  E.g.

  =====
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Failed to find symbol malloc_get_state in /usr/lib64/libc-2.25.so
    Error: Failed to add events.
  =====

This solves above issue by improving perf-probe symbol search function,
as below.

  =====
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Added new event:
    probe_libc:malloc_get_state (on malloc_get_state in /usr/lib64/libc-2.25.so)

  You can now use it in all perf tools, such as:

	  perf record -e probe_libc:malloc_get_state -aR sleep 1

  # ./perf probe -l
    probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
  =====

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275049269.24652.1639103455496216255.stgit@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/arch/powerpc/util/sym-handling.c |    8 ++++++++
 tools/perf/util/probe-event.c               |   20 ++++++++++++++++++--
 tools/perf/util/symbol.c                    |    5 +++++
 tools/perf/util/symbol.h                    |    1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -64,6 +64,14 @@ int arch__compare_symbol_names_n(const c
 
 	return strncmp(namea, nameb, n);
 }
+
+const char *arch__normalize_symbol_name(const char *name)
+{
+	/* Skip over initial dot */
+	if (name && *name == '.')
+		name++;
+	return name;
+}
 #endif
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2792,16 +2792,32 @@ static int find_probe_functions(struct m
 	int found = 0;
 	struct symbol *sym;
 	struct rb_node *tmp;
+	const char *norm, *ver;
+	char *buf = NULL;
 
 	if (map__load(map) < 0)
 		return 0;
 
 	map__for_each_symbol(map, sym, tmp) {
-		if (strglobmatch(sym->name, name)) {
+		norm = arch__normalize_symbol_name(sym->name);
+		if (!norm)
+			continue;
+
+		/* We don't care about default symbol or not */
+		ver = strchr(norm, '@');
+		if (ver) {
+			buf = strndup(norm, ver - norm);
+			if (!buf)
+				return -ENOMEM;
+			norm = buf;
+		}
+		if (strglobmatch(norm, name)) {
 			found++;
 			if (syms && found < probe_conf.max_probes)
 				syms[found - 1] = sym;
 		}
+		if (buf)
+			zfree(&buf);
 	}
 
 	return found;
@@ -2847,7 +2863,7 @@ static int find_probe_trace_events_from_
 	 * same name but different addresses, this lists all the symbols.
 	 */
 	num_matched_functions = find_probe_functions(map, pp->function, syms);
-	if (num_matched_functions == 0) {
+	if (num_matched_functions <= 0) {
 		pr_err("Failed to find symbol %s in %s\n", pp->function,
 			pev->target ? : "kernel");
 		ret = -ENOENT;
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -93,6 +93,11 @@ static int prefix_underscores_count(cons
 	return tail - str;
 }
 
+const char * __weak arch__normalize_symbol_name(const char *name)
+{
+	return name;
+}
+
 int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
 {
 	return strcmp(namea, nameb);
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -347,6 +347,7 @@ bool elf__needs_adjust_symbols(GElf_Ehdr
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
 
+const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
