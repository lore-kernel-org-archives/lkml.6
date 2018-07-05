Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF2C6778E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AC0240EC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AC0240EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbeGEQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:41:45 -0400
Received: from foss.arm.com ([217.140.101.70]:53512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754220AbeGEQlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:41:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C02501650;
        Thu,  5 Jul 2018 09:41:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2538B3F5BA;
        Thu,  5 Jul 2018 09:41:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, will.deacon@arm.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: [PATCHv3 07/12] atomics: add common header generation files
Date:   Thu,  5 Jul 2018 17:40:48 +0100
Message-Id: <20180705164053.10073-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To minimize repetition, to allow for future rework, and to ensure
regularity of the various atomic APIs, we'd like to automatically
generate (the bulk of) a number of headers related to atomics.

This patch adds the infrastructure to do so, leaving actual conversion
of headers to subsequent patches. This infrastructure consists of:

* atomics.tbl - a table describing the functions in the atomics API,
  with names, prototypes, and metadata describing the variants that
  exist (e.g fetch/return, acquire/release/relaxed). Note that the
  return type is dependent on the particular variant.

* atomic-tbl.sh - a library of routines useful for dealing with
  atomics.tbl (e.g. querying which variants exist, or generating
  argument/parameter lists for a given function variant).

* gen-atomic-fallback.sh - a script which generates a header of
  fallbacks, covering cases where architecture omit certain functions
  (e.g. omitting relaxed variants).

* gen-atomic-long.sh - a script which generates wrappers providing the
  atomic_long API atomic of the relevant atomic or atomic64 API,
  ensuring the APIs are consistent.

* gen-atomic-instrumented.sh - a script which generates atomic* wrappers
  atop of arch_atomic* functions, with automatically generated KASAN
  instrumentation.

* fallbacks/* - a set of fallback implementations for atomics, which
  should be used when no implementation of a given atomic is provided.
  These are used by gen-atomic-fallback.sh to generate fallbacks, and
  these are also used by other scripts to determine the set of optional
  atomics (as required to generate preprocessor guards correctly).

  Fallbacks may use the following variables:

  ${atomic}     atomic prefix: atomic/atomic64/atomic_long, which can be
		used to derive the atomic type, and to prefix functions

  ${int}        integer type: int/s64/long

  ${pfx}        variant prefix, e.g. fetch_

  ${name}       base function name, e.g. add

  ${sfx}        variant suffix, e.g. _return

  ${order}      order suffix, e.g. _relaxed

  ${atomicname} full name, e.g. atomic64_fetch_add_relaxed

  ${ret}        return type of the function, e.g. void

  ${retstmt}    a return statement (with a trailing space), unless the
                variant returns void

  ${params}     parameter list for the function declaration, e.g.
                "int i, atomic_t *v"

  ${args}       argument list for invoking the function, e.g. "i, v"

  ... for clarity, ${ret}, ${retstmt}, ${params}, and ${args} are
  open-coded for fallbacks where these do not vary, or are critical to
  understanding the logic of the fallback.

The MAINTAINERS entry for the atomic infrastructure is updated to cover
the new scripts.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS                                  |   1 +
 scripts/atomic/atomic-tbl.sh                 | 186 +++++++++++++++++++++++++++
 scripts/atomic/atomics.tbl                   |  41 ++++++
 scripts/atomic/fallbacks/acquire             |   9 ++
 scripts/atomic/fallbacks/add_negative        |  16 +++
 scripts/atomic/fallbacks/add_unless          |  16 +++
 scripts/atomic/fallbacks/andnot              |   7 +
 scripts/atomic/fallbacks/dec                 |   7 +
 scripts/atomic/fallbacks/dec_and_test        |  15 +++
 scripts/atomic/fallbacks/dec_if_positive     |  15 +++
 scripts/atomic/fallbacks/dec_unless_positive |  14 ++
 scripts/atomic/fallbacks/fence               |  11 ++
 scripts/atomic/fallbacks/fetch_add_unless    |  23 ++++
 scripts/atomic/fallbacks/inc                 |   7 +
 scripts/atomic/fallbacks/inc_and_test        |  15 +++
 scripts/atomic/fallbacks/inc_not_zero        |  14 ++
 scripts/atomic/fallbacks/inc_unless_negative |  14 ++
 scripts/atomic/fallbacks/read_acquire        |   7 +
 scripts/atomic/fallbacks/release             |   8 ++
 scripts/atomic/fallbacks/set_release         |   7 +
 scripts/atomic/fallbacks/sub_and_test        |  16 +++
 scripts/atomic/fallbacks/try_cmpxchg         |  11 ++
 scripts/atomic/gen-atomic-fallback.sh        | 181 ++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-instrumented.sh    | 182 ++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh            | 101 +++++++++++++++
 25 files changed, 924 insertions(+)
 create mode 100755 scripts/atomic/atomic-tbl.sh
 create mode 100644 scripts/atomic/atomics.tbl
 create mode 100644 scripts/atomic/fallbacks/acquire
 create mode 100644 scripts/atomic/fallbacks/add_negative
 create mode 100644 scripts/atomic/fallbacks/add_unless
 create mode 100644 scripts/atomic/fallbacks/andnot
 create mode 100644 scripts/atomic/fallbacks/dec
 create mode 100644 scripts/atomic/fallbacks/dec_and_test
 create mode 100644 scripts/atomic/fallbacks/dec_if_positive
 create mode 100644 scripts/atomic/fallbacks/dec_unless_positive
 create mode 100644 scripts/atomic/fallbacks/fence
 create mode 100644 scripts/atomic/fallbacks/fetch_add_unless
 create mode 100644 scripts/atomic/fallbacks/inc
 create mode 100644 scripts/atomic/fallbacks/inc_and_test
 create mode 100644 scripts/atomic/fallbacks/inc_not_zero
 create mode 100644 scripts/atomic/fallbacks/inc_unless_negative
 create mode 100644 scripts/atomic/fallbacks/read_acquire
 create mode 100644 scripts/atomic/fallbacks/release
 create mode 100644 scripts/atomic/fallbacks/set_release
 create mode 100644 scripts/atomic/fallbacks/sub_and_test
 create mode 100644 scripts/atomic/fallbacks/try_cmpxchg
 create mode 100755 scripts/atomic/gen-atomic-fallback.sh
 create mode 100755 scripts/atomic/gen-atomic-instrumented.sh
 create mode 100755 scripts/atomic/gen-atomic-long.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index edf3cf5ea691..6615a29ed5c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2514,6 +2514,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
+F:	scripts/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
new file mode 100755
index 000000000000..9d6be538a987
--- /dev/null
+++ b/scripts/atomic/atomic-tbl.sh
@@ -0,0 +1,186 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# helpers for dealing with atomics.tbl
+
+#meta_in(meta, match)
+meta_in()
+{
+	case "$1" in
+	[$2]) return 0;;
+	esac
+
+	return 1
+}
+
+#meta_has_ret(meta)
+meta_has_ret()
+{
+	meta_in "$1" "bBiIfFlR"
+}
+
+#meta_has_acquire(meta)
+meta_has_acquire()
+{
+	meta_in "$1" "BFIlR"
+}
+
+#meta_has_release(meta)
+meta_has_release()
+{
+	meta_in "$1" "BFIRs"
+}
+
+#meta_has_relaxed(meta)
+meta_has_relaxed()
+{
+	meta_in "$1" "BFIR"
+}
+
+#find_fallback_template(pfx, name, sfx, order)
+find_fallback_template()
+{
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+
+	local base=""
+	local file=""
+
+	# We may have fallbacks for a specific case (e.g. read_acquire()), or
+	# an entire class, e.g. *inc*().
+	#
+	# Start at the most specific, and fall back to the most general. Once
+	# we find a specific fallback, don't bother looking for more.
+	for base in "${pfx}${name}${sfx}${order}" "${name}"; do
+		file="${ATOMICDIR}/fallbacks/${base}"
+
+		if [ -f "${file}" ]; then
+			printf "${file}"
+			break
+		fi
+	done
+}
+
+#gen_ret_type(meta, int)
+gen_ret_type() {
+	local meta="$1"; shift
+	local int="$1"; shift
+
+	case "${meta}" in
+	[sv]) printf "void";;
+	[bB]) printf "bool";;
+	[aiIfFlR]) printf "${int}";;
+	esac
+}
+
+#gen_ret_stmt(meta)
+gen_ret_stmt()
+{
+	if meta_has_ret "${meta}"; then
+		printf "return ";
+	fi
+}
+
+# gen_param_name(arg)
+gen_param_name()
+{
+	# strip off the leading 'c' for 'cv'
+	local name="${1#c}"
+	printf "${name#*:}"
+}
+
+# gen_param_type(arg, int, atomic)
+gen_param_type()
+{
+	local type="${1%%:*}"; shift
+	local int="$1"; shift
+	local atomic="$1"; shift
+
+	case "${type}" in
+	i) type="${int} ";;
+	p) type="${int} *";;
+	v) type="${atomic}_t *";;
+	cv) type="const ${atomic}_t *";;
+	esac
+
+	printf "${type}"
+}
+
+#gen_param(arg, int, atomic)
+gen_param()
+{
+	local arg="$1"; shift
+	local int="$1"; shift
+	local atomic="$1"; shift
+	local name="$(gen_param_name "${arg}")"
+	local type="$(gen_param_type "${arg}" "${int}" "${atomic}")"
+
+	printf "${type}${name}"
+}
+
+#gen_params(int, atomic, arg...)
+gen_params()
+{
+	local int="$1"; shift
+	local atomic="$1"; shift
+
+	while [ "$#" -gt 0 ]; do
+		gen_param "$1" "${int}" "${atomic}"
+		[ "$#" -gt 1 ] && printf ", "
+		shift;
+	done
+}
+
+#gen_args(arg...)
+gen_args()
+{
+	while [ "$#" -gt 0 ]; do
+		printf "$(gen_param_name "$1")"
+		[ "$#" -gt 1 ] && printf ", "
+		shift;
+	done
+}
+
+#gen_proto_order_variants(meta, pfx, name, sfx, ...)
+gen_proto_order_variants()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+
+	gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+
+	if meta_has_acquire "${meta}"; then
+		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
+	fi
+	if meta_has_release "${meta}"; then
+		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+	fi
+	if meta_has_relaxed "${meta}"; then
+		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_relaxed" "$@"
+	fi
+}
+
+#gen_proto_variants(meta, name, ...)
+gen_proto_variants()
+{
+	local meta="$1"; shift
+	local name="$1"; shift
+	local pfx=""
+	local sfx=""
+
+	meta_in "${meta}" "fF" && pfx="fetch_"
+	meta_in "${meta}" "R" && sfx="_return"
+
+	gen_proto_order_variants "${meta}" "${pfx}" "${name}" "${sfx}" "$@"
+}
+
+#gen_proto(meta, ...)
+gen_proto() {
+	local meta="$1"; shift
+	for m in $(echo "${meta}" | fold -w1); do
+		gen_proto_variants "${m}" "$@"
+	done
+}
diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
new file mode 100644
index 000000000000..fbee2f6190d9
--- /dev/null
+++ b/scripts/atomic/atomics.tbl
@@ -0,0 +1,41 @@
+# name	meta	args...
+#
+# Where meta contains a string of variants to generate.
+# Upper-case implies _{acquire,release,relaxed} variants.
+# Valid meta values are:
+# * B/b	- bool: returns bool
+# * v	- void: returns void
+# * I/i	- int: returns base type
+# * R	- return: returns base type (has _return variants)
+# * F/f	- fetch: returns base type (has fetch_ variants)
+# * l	- load: returns base type (has _acquire order variant)
+# * s	- store: returns void (has _release order variant)
+#
+# Where args contains list of type[:name], where type is:
+# * cv	- const pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
+# * v	- pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
+# * i	- base type (int/s64/long)
+# * p	- pointer to base type (int/s64/long)
+#
+read			l	cv
+set			s	v	i
+add			vRF	i	v
+sub			vRF	i	v
+inc			vRF	v
+dec			vRF	v
+and			vF	i	v
+andnot			vF	i	v
+or			vF	i	v
+xor			vF	i	v
+xchg			I	v	i
+cmpxchg			I	v	i:old	i:new
+try_cmpxchg		B	v	p:old	i:new
+sub_and_test		b	i	v
+dec_and_test		b	v
+inc_and_test		b	v
+add_negative		b	i	v
+add_unless		fb	v	i:a	i:u
+inc_not_zero		b	v
+inc_unless_negative	b	v
+dec_unless_positive	b	v
+dec_if_positive		i	v
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
new file mode 100644
index 000000000000..e38871e64db6
--- /dev/null
+++ b/scripts/atomic/fallbacks/acquire
@@ -0,0 +1,9 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_${pfx}${name}${sfx}_acquire(${params})
+{
+	${ret} ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	__atomic_acquire_fence();
+	return ret;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
new file mode 100644
index 000000000000..e6f4815637de
--- /dev/null
+++ b/scripts/atomic/fallbacks/add_negative
@@ -0,0 +1,16 @@
+cat <<EOF
+/**
+ * ${atomic}_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static inline bool
+${atomic}_add_negative(${int} i, ${atomic}_t *v)
+{
+	return ${atomic}_add_return(i, v) < 0;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
new file mode 100644
index 000000000000..792533885fbf
--- /dev/null
+++ b/scripts/atomic/fallbacks/add_unless
@@ -0,0 +1,16 @@
+cat << EOF
+/**
+ * ${atomic}_add_unless - add unless the number is already a given value
+ * @v: pointer of type ${atomic}_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static inline bool
+${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+{
+	return ${atomic}_fetch_add_unless(v, a, u) != u;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
new file mode 100644
index 000000000000..9f3a3216b5e3
--- /dev/null
+++ b/scripts/atomic/fallbacks/andnot
@@ -0,0 +1,7 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
+{
+	${retstmt}${atomic}_${pfx}and${sfx}${order}(~i, v);
+}
+EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
new file mode 100644
index 000000000000..10bbc82be31d
--- /dev/null
+++ b/scripts/atomic/fallbacks/dec
@@ -0,0 +1,7 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
+{
+	${retstmt}${atomic}_${pfx}sub${sfx}${order}(1, v);
+}
+EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
new file mode 100644
index 000000000000..0ce7103b3df2
--- /dev/null
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -0,0 +1,15 @@
+cat <<EOF
+/**
+ * ${atomic}_dec_and_test - decrement and test
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static inline bool
+${atomic}_dec_and_test(${atomic}_t *v)
+{
+	return ${atomic}_dec_return(v) == 0;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
new file mode 100644
index 000000000000..c52eacec43c8
--- /dev/null
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -0,0 +1,15 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_dec_if_positive(${atomic}_t *v)
+{
+	${int} dec, c = ${atomic}_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!${atomic}_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
new file mode 100644
index 000000000000..8a2578f14268
--- /dev/null
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -0,0 +1,14 @@
+cat <<EOF
+static inline bool
+${atomic}_dec_unless_positive(${atomic}_t *v)
+{
+	${int} c = ${atomic}_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!${atomic}_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
new file mode 100644
index 000000000000..82f68fa6931a
--- /dev/null
+++ b/scripts/atomic/fallbacks/fence
@@ -0,0 +1,11 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_${pfx}${name}${sfx}(${params})
+{
+	${ret} ret;
+	__atomic_pre_full_fence();
+	ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	__atomic_post_full_fence();
+	return ret;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
new file mode 100644
index 000000000000..d2c091db7eae
--- /dev/null
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -0,0 +1,23 @@
+cat << EOF
+/**
+ * ${atomic}_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type ${atomic}_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static inline ${int}
+${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+{
+	${int} c = ${atomic}_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!${atomic}_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
new file mode 100644
index 000000000000..f866b3ad2353
--- /dev/null
+++ b/scripts/atomic/fallbacks/inc
@@ -0,0 +1,7 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
+{
+	${retstmt}${atomic}_${pfx}add${sfx}${order}(1, v);
+}
+EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
new file mode 100644
index 000000000000..4e2068869f7e
--- /dev/null
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -0,0 +1,15 @@
+cat <<EOF
+/**
+ * ${atomic}_inc_and_test - increment and test
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static inline bool
+${atomic}_inc_and_test(${atomic}_t *v)
+{
+	return ${atomic}_inc_return(v) == 0;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
new file mode 100644
index 000000000000..a7c45c8d107c
--- /dev/null
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -0,0 +1,14 @@
+cat <<EOF
+/**
+ * ${atomic}_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static inline bool
+${atomic}_inc_not_zero(${atomic}_t *v)
+{
+	return ${atomic}_add_unless(v, 1, 0);
+}
+EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
new file mode 100644
index 000000000000..0c266e71dbd4
--- /dev/null
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -0,0 +1,14 @@
+cat <<EOF
+static inline bool
+${atomic}_inc_unless_negative(${atomic}_t *v)
+{
+	${int} c = ${atomic}_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!${atomic}_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
new file mode 100644
index 000000000000..75863b5203f7
--- /dev/null
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -0,0 +1,7 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_read_acquire(const ${atomic}_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+EOF
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
new file mode 100644
index 000000000000..3f628a3802d9
--- /dev/null
+++ b/scripts/atomic/fallbacks/release
@@ -0,0 +1,8 @@
+cat <<EOF
+static inline ${ret}
+${atomic}_${pfx}${name}${sfx}_release(${params})
+{
+	__atomic_release_fence();
+	${retstmt}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+}
+EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
new file mode 100644
index 000000000000..45bb5e0cfc08
--- /dev/null
+++ b/scripts/atomic/fallbacks/set_release
@@ -0,0 +1,7 @@
+cat <<EOF
+static inline void
+${atomic}_set_release(${atomic}_t *v, ${int} i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+EOF
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
new file mode 100644
index 000000000000..289ef17a2d7a
--- /dev/null
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -0,0 +1,16 @@
+cat <<EOF
+/**
+ * ${atomic}_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static inline bool
+${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
+{
+	return ${atomic}_sub_return(i, v) == 0;
+}
+EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
new file mode 100644
index 000000000000..4ed85e2f5378
--- /dev/null
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -0,0 +1,11 @@
+cat <<EOF
+static inline bool
+${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
+{
+	${int} r, o = *old;
+	r = ${atomic}_cmpxchg${order}(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+EOF
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
new file mode 100755
index 000000000000..1bd7c1707633
--- /dev/null
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -0,0 +1,181 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ATOMICDIR=$(dirname $0)
+
+. ${ATOMICDIR}/atomic-tbl.sh
+
+#gen_template_fallback(template, meta, pfx, name, sfx, order, atomic, int, args...)
+gen_template_fallback()
+{
+	local template="$1"; shift
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	local atomic="$1"; shift
+	local int="$1"; shift
+
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+
+	local ret="$(gen_ret_type "${meta}" "${int}")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local args="$(gen_args "$@")"
+
+	if [ ! -z "${template}" ]; then
+		printf "#ifndef ${atomicname}\n"
+		. ${template}
+		printf "#define ${atomicname} ${atomicname}\n"
+		printf "#endif\n\n"
+	fi
+}
+
+#gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
+gen_proto_fallback()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+
+	local tmpl="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
+	gen_template_fallback "${tmpl}" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
+}
+
+#gen_basic_fallbacks(basename)
+gen_basic_fallbacks()
+{
+	local basename="$1"; shift
+cat << EOF
+#define ${basename}_acquire ${basename}
+#define ${basename}_release ${basename}
+#define ${basename}_relaxed ${basename}
+EOF
+}
+
+#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
+gen_proto_order_variants()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local atomic="$1"
+
+	local basename="${atomic}_${pfx}${name}${sfx}"
+
+	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
+
+	# If we don't have relaxed atomics, then we don't bother with ordering fallbacks
+	# read_acquire and set_release need to be templated, though
+	if ! meta_has_relaxed "${meta}"; then
+		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+
+		if meta_has_acquire "${meta}"; then
+			gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
+		fi
+
+		if meta_has_release "${meta}"; then
+			gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+		fi
+
+		return
+	fi
+
+	printf "#ifndef ${basename}_relaxed\n"
+
+	if [ ! -z "${template}" ]; then
+		printf "#ifdef ${basename}\n"
+	fi
+
+	gen_basic_fallbacks "${basename}"
+
+	if [ ! -z "${template}" ]; then
+		printf "#endif /* ${atomic}_${pfx}${name}${sfx} */\n\n"
+		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
+		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_relaxed" "$@"
+	fi
+
+	printf "#else /* ${basename}_relaxed */\n\n"
+
+	gen_template_fallback "${ATOMICDIR}/fallbacks/acquire"  "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
+	gen_template_fallback "${ATOMICDIR}/fallbacks/release"  "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+	gen_template_fallback "${ATOMICDIR}/fallbacks/fence"  "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+
+	printf "#endif /* ${basename}_relaxed */\n\n"
+}
+
+gen_xchg_fallbacks()
+{
+	local xchg="$1"; shift
+cat <<EOF
+#ifndef ${xchg}_relaxed
+#define ${xchg}_relaxed		${xchg}
+#define ${xchg}_acquire		${xchg}
+#define ${xchg}_release		${xchg}
+#else /* ${xchg}_relaxed */
+
+#ifndef ${xchg}_acquire
+#define ${xchg}_acquire(...) \\
+	__atomic_op_acquire(${xchg}, __VA_ARGS__)
+#endif
+
+#ifndef ${xchg}_release
+#define ${xchg}_release(...) \\
+	__atomic_op_release(${xchg}, __VA_ARGS__)
+#endif
+
+#ifndef ${xchg}
+#define ${xchg}(...) \\
+	__atomic_op_fence(${xchg}, __VA_ARGS__)
+#endif
+
+#endif /* ${xchg}_relaxed */
+
+EOF
+}
+
+cat << EOF
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by $0
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_FALLBACK_H
+#define _LINUX_ATOMIC_FALLBACK_H
+
+EOF
+
+for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+	gen_xchg_fallbacks "${xchg}"
+done
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+done
+
+cat <<EOF
+#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+done
+
+cat <<EOF
+#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
+#endif /* _LINUX_ATOMIC_FALLBACK_H */
+EOF
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
new file mode 100755
index 000000000000..e09812372b17
--- /dev/null
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -0,0 +1,182 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ATOMICDIR=$(dirname $0)
+
+. ${ATOMICDIR}/atomic-tbl.sh
+
+#gen_param_check(arg)
+gen_param_check()
+{
+	local arg="$1"; shift
+	local type="${arg%%:*}"
+	local name="$(gen_param_name "${arg}")"
+	local rw="write"
+
+	case "${type#c}" in
+	i) return;;
+	esac
+
+	# We don't write to constant parameters
+	[ ${type#c} != ${type} ] && rw="read"
+
+	printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
+}
+
+#gen_param_check(arg...)
+gen_params_checks()
+{
+	while [ "$#" -gt 0 ]; do
+		gen_param_check "$1"
+		shift;
+	done
+}
+
+# gen_guard(meta, atomic, pfx, name, sfx, order)
+gen_guard()
+{
+	local meta="$1"; shift
+	local atomic="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+
+	local atomicname="arch_${atomic}_${pfx}${name}${sfx}${order}"
+
+	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
+
+	# We definitely need a preprocessor symbol for this atomic if it is an
+	# ordering variant, or if there's a generic fallback.
+	if [ ! -z "${order}" ] || [ ! -z "${template}" ]; then
+		printf "defined(${atomicname})"
+		return
+	fi
+
+	# If this is a base variant, but a relaxed variant *may* exist, then we
+	# only have a preprocessor symbol if the relaxed variant isn't defined
+	if meta_has_relaxed "${meta}"; then
+		printf "!defined(${atomicname}_relaxed) || defined(${atomicname})"
+	fi
+}
+
+#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+gen_proto_order_variant()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	local atomic="$1"; shift
+	local int="$1"; shift
+
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+
+	local guard="$(gen_guard "${meta}" "${atomic}" "${pfx}" "${name}" "${sfx}" "${order}")"
+
+	local ret="$(gen_ret_type "${meta}" "${int}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local checks="$(gen_params_checks "$@")"
+	local args="$(gen_args "$@")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+
+	[ ! -z "${guard}" ] && printf "#if ${guard}\n"
+
+cat <<EOF
+static inline ${ret}
+${atomicname}(${params})
+{
+${checks}
+	${retstmt}arch_${atomicname}(${args});
+}
+#define ${atomicname} ${atomicname}
+EOF
+
+	[ ! -z "${guard}" ] && printf "#endif\n"
+
+	printf "\n"
+}
+
+gen_xchg()
+{
+	local xchg="$1"; shift
+	local mult="$1"; shift
+
+cat <<EOF
+#define ${xchg}(ptr, ...)						\\
+({									\\
+	typeof(ptr) __ai_ptr = (ptr);					\\
+	kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
+	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
+})
+EOF
+}
+
+gen_optional_xchg()
+{
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local guard="defined(arch_${name}${sfx})"
+
+	[ -z "${sfx}" ] && guard="!defined(arch_${name}_relaxed) || defined(arch_${name})"
+
+	printf "#if ${guard}\n"
+	gen_xchg "${name}${sfx}" ""
+	printf "#endif\n\n"
+}
+
+cat << EOF
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by $0
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides wrappers with KASAN instrumentation for atomic operations.
+ * To use this functionality an arch's atomic.h file needs to define all
+ * atomic operations with arch_ prefix (e.g. arch_atomic_read()) and include
+ * this file at the end. This file provides atomic_read() that forwards to
+ * arch_atomic_read() for actual atomic operation.
+ * Note: if an arch atomic operation is implemented by means of other atomic
+ * operations (e.g. atomic_read()/atomic_cmpxchg() loop), then it needs to use
+ * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
+ * double instrumentation.
+ */
+#ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
+#define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
+
+#include <linux/build_bug.h>
+#include <linux/kasan-checks.h>
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+done
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+done
+
+for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+	for order in "" "_acquire" "_release" "_relaxed"; do
+		gen_optional_xchg "${xchg}" "${order}"
+	done
+done
+
+for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
+	gen_xchg "${xchg}" ""
+	printf "\n"
+done
+
+gen_xchg "cmpxchg_double" "2 * "
+
+printf "\n\n"
+
+gen_xchg "cmpxchg_double_local" "2 * "
+
+cat <<EOF
+
+#endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
+EOF
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
new file mode 100755
index 000000000000..c240a7231b2e
--- /dev/null
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ATOMICDIR=$(dirname $0)
+
+. ${ATOMICDIR}/atomic-tbl.sh
+
+#gen_cast(arg, int, atomic)
+gen_cast()
+{
+	local arg="$1"; shift
+	local int="$1"; shift
+	local atomic="$1"; shift
+
+	[ "${arg%%:*}" = "p" ] || return
+
+	printf "($(gen_param_type "${arg}" "${int}" "${atomic}"))"
+}
+
+#gen_args_cast(int, atomic, arg...)
+gen_args_cast()
+{
+	local int="$1"; shift
+	local atomic="$1"; shift
+
+	while [ "$#" -gt 0 ]; do
+		local cast="$(gen_cast "$1" "${int}" "${atomic}")"
+		local arg="$(gen_param_name "$1")"
+		printf "${cast}${arg}"
+		[ "$#" -gt 1 ] && printf ", "
+		shift;
+	done
+}
+
+#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+gen_proto_order_variant()
+{
+	local meta="$1"; shift
+	local name="$1$2$3$4"; shift; shift; shift; shift
+	local atomic="$1"; shift
+	local int="$1"; shift
+
+	local ret="$(gen_ret_type "${meta}" "long")"
+	local params="$(gen_params "long" "atomic_long" "$@")"
+	local argscast="$(gen_args_cast "${int}" "${atomic}" "$@")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+
+cat <<EOF
+static inline ${ret}
+atomic_long_${name}(${params})
+{
+	${retstmt}${atomic}_${name}(${argscast});
+}
+
+EOF
+}
+
+cat << EOF
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by $0
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _ASM_GENERIC_ATOMIC_LONG_H
+#define _ASM_GENERIC_ATOMIC_LONG_H
+
+#include <asm/types.h>
+
+#ifdef CONFIG_64BIT
+typedef atomic64_t atomic_long_t;
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#else
+typedef atomic_t atomic_long_t;
+#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#endif
+
+#ifdef CONFIG_64BIT
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+done
+
+cat <<EOF
+#else /* CONFIG_64BIT */
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+done
+
+cat <<EOF
+#endif /* CONFIG_64BIT */
+#endif /* _ASM_GENERIC_ATOMIC_LONG_H */
+EOF
-- 
2.11.0

