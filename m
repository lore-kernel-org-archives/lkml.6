Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+aJ/EjA9kWTUGCCL8EyMRwvZek4MEkvuKh+YTV4OSFmYGOvHyqTswaRVxGa5f/I/Qod90A
ARC-Seal: i=1; a=rsa-sha256; t=1523399243; cv=none;
        d=google.com; s=arc-20160816;
        b=ijf2Uk7LNuB20dm57M/4nElCi15Sg79TThT7ljwdkRvmDDh7cdN9H7iUo1s1ir+aSU
         5zLOtSbfNx2nP4oMThzrO7L65aZ2T7yMZNSdKsfgRVofUOq6TCX/3yawpEUqp5NFFYQl
         Cupwy7vfXzXq6kSWeNVMppyWA19vxif04evJpKmCA+f3axmI+fzvuVFMxjqnNVWhGxlZ
         wgGPKLufhRS/GgKmXP9Zh+NlF0FU3Ek1YREcrctC2fUqp18uveNOPzX7zg+JSidcl1j0
         vBBeG2SR/iidzgauSZBGjR7ZDaSZ5RTq7TtpRmoRNmKq66r0nG7gzUTeThbqXCmsHiv+
         86dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LDhEviO4VM1r0IE6E4bsdUKxoX3bMl9IoNxz2DYXHf4=;
        b=LUbCBKqAnp++AqECf5FvtUHjbiwWDoJkdD6AiH45yGYN17aKyeqL1Mi1968aAUIg67
         mnatcXN+jIRfJqas6PDEibv+YFzoTzsNSZEmwFqJoWXgIsuzeZvmUG+nSxU63AkvIohz
         1LRoe/eTpFKqFdGWmrA02PHyG+SElhjG/VVI8RmQHfKF0Iz4v6Me2Y4JmPgqt0Hd9irQ
         Ad2fqwTDtO9BtNIr6d0If+r1BnP9Sy5DT1+1ifgdtk6UwzC886xHzEMg9pouo7camAMp
         PkQi5ZfAME9DbepFgNrwRhAn/HdR2Ah48Y2Eef5DOqhBfsni09lPoheZJ8Z0LTy6SpFQ
         znYQ==
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
Subject: [PATCH 4.15 009/168] perf probe: Find versioned symbols from map
Date: Wed, 11 Apr 2018 00:22:31 +0200
Message-Id: <20180410212800.619524126@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399884410254344?=
X-GMAIL-MSGID: =?utf-8?q?1597399884410254344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -94,6 +94,11 @@ static int prefix_underscores_count(cons
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
@@ -349,6 +349,7 @@ bool elf__needs_adjust_symbols(GElf_Ehdr
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
 
+const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
