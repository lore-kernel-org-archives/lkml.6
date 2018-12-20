Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6761EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299392176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeLTMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:02:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:41720 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbeLTMCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:02:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 04:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,376,1539673200"; 
   d="scan'208";a="127635660"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Dec 2018 04:02:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4B2A7141; Thu, 20 Dec 2018 14:02:41 +0200 (EET)
Date:   Thu, 20 Dec 2018 15:02:41 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] x86/cpu: sort cpuinfo flags
Message-ID: <20181220120240.ermrc3hnixkin2yg@black.fi.intel.com>
References: <20181219195014.A0962820@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219195014.A0962820@viggo.jf.intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 07:50:14PM +0000, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I frequently find myself contemplating my life choices as I try to
> find 3-character entries in the 1,000-character, unsorted "flags:"
> field of /proc/cpuinfo.
> 
> Sort that field, giving me hours back in my day.
> 
> This eats up ~1200 bytes (NCAPINTS*2*32) of space for the sorted
> array.  I used an 'unsigned short' to use 1/4 of the space on 64-bit
> that would have been needed had pointers been used in the array.
> 
> An alternatve, requiring no array, would be to do the sort at runtime,
> but it seems ridiculous for a 500-cpu system to do 500 sorts for each
> 'cat /proc/cpuinfo'.
> 
> Another would be to just cache the *string* that results from this,
> which would be even faster at runtime because it could do a single
> seq_printf() and would consume less space.  But, that would
> require a bit more infrastructure to make sure that the produced
> string never changed and was consistent across all CPUs, unless
> we want to store a string per 'struct cpuinfo_x86'.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
> Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
> Cc: linux-kernel@vger.kernel.org
> ---

Below is my attempt on doing the same. The key difference is that the
sorted array is generated at compile-time by mkcapflags.sh.

The patch also sorts bugs.

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 7d442722ef24..37cc8ccaec8f 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -34,6 +34,7 @@ enum cpuid_leafs
 
 #ifdef CONFIG_X86_FEATURE_NAMES
 extern const char * const x86_cap_flags[NCAPINTS*32];
+extern const unsigned short x86_sorted_cap_flags[];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
@@ -47,6 +48,7 @@ extern const char * const x86_power_flags[32];
  * X86_BUG_<name> - NCAPINTS*32.
  */
 extern const char * const x86_bug_flags[NBUGINTS*32];
+extern const unsigned short x86_sorted_bug_flags[];
 
 #define test_cpu_cap(c, bit)						\
 	 test_bit(bit, (unsigned long *)((c)->x86_capability))
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index d0dfb892c72f..e40c3ee9cd58 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -7,17 +7,9 @@
 IN=$1
 OUT=$2
 
-dump_array()
+dump_values()
 {
-	ARRAY=$1
-	SIZE=$2
-	PFX=$3
-	POSTFIX=$4
-
-	PFX_SZ=$(echo $PFX | wc -c)
-	TABS="$(printf '\t\t\t\t\t')"
-
-	echo "const char * const $ARRAY[$SIZE] = {"
+	PFX=$1
 
 	# Iterate through any input lines starting with #define $PFX
 	sed -n -e 's/\t/ /g' -e "s/^ *# *define *$PFX//p" $IN |
@@ -34,19 +26,58 @@ dump_array()
 		# Name is uppercase, VALUE is all lowercase
 		VALUE="$(echo "$VALUE" | tr A-Z a-z)"
 
-        if [ -n "$POSTFIX" ]; then
-            T=$(( $PFX_SZ + $(echo $POSTFIX | wc -c) + 2 ))
-	        TABS="$(printf '\t\t\t\t\t\t')"
-		    TABCOUNT=$(( ( 6*8 - ($T + 1) - $(echo "$NAME" | wc -c) ) / 8 ))
-		    printf "\t[%s - %s]%.*s = %s,\n" "$PFX$NAME" "$POSTFIX" "$TABCOUNT" "$TABS" "$VALUE"
-        else
-		    TABCOUNT=$(( ( 5*8 - ($PFX_SZ + 1) - $(echo "$NAME" | wc -c) ) / 8 ))
-            printf "\t[%s]%.*s = %s,\n" "$PFX$NAME" "$TABCOUNT" "$TABS" "$VALUE"
-        fi
+		echo "$NAME $VALUE"
+	done
+}
+
+dump_array()
+{
+	ARRAY=$1
+	SIZE=$2
+	PFX=$3
+	POSTFIX=$4
+
+	PFX_SZ=$(echo $PFX | wc -c)
+	TABS="$(printf '\t\t\t\t\t')"
+
+	echo "const char * const $ARRAY[$SIZE] = {"
+
+	dump_values "$PFX" |
+	while read NAME VALUE
+	do
+		if [ -n "$POSTFIX" ]; then
+			T=$(( $PFX_SZ + $(echo $POSTFIX | wc -c) + 2 ))
+			TABS="$(printf '\t\t\t\t\t\t')"
+			TABCOUNT=$(( ( 6*8 - ($T + 1) - $(echo "$NAME" | wc -c) ) / 8 ))
+			printf "\t[%s - %s]%.*s = %s,\n" "$PFX$NAME" "$POSTFIX" "$TABCOUNT" "$TABS" "$VALUE"
+		else
+			TABCOUNT=$(( ( 5*8 - ($PFX_SZ + 1) - $(echo "$NAME" | wc -c) ) / 8 ))
+			printf "\t[%s]%.*s = %s,\n" "$PFX$NAME" "$TABCOUNT" "$TABS" "$VALUE"
+		fi
 	done
 	echo "};"
 }
 
+dump_sorted_array()
+{
+	ARRAY=$1
+	PFX=$2
+
+	PFX_SZ=$(echo $PFX | wc -c)
+	TABS="$(printf '\t\t\t\t\t')"
+
+	echo "const unsigned short $ARRAY[] = {"
+
+	dump_values "$PFX" |
+	sort -k 2 |
+	while read NAME VALUE
+	do
+		TABCOUNT=$(( ( 6*8 - $PFX_SZ - $(echo "$NAME" | wc -c) ) / 8 ))
+		printf "\t%s%s,%.*s/* %s */\n" "$PFX" "$NAME" "$TABCOUNT" "$TABS" "$VALUE"
+	done
+	printf "\t-1\n};"
+}
+
 trap 'rm "$OUT"' EXIT
 
 (
@@ -58,8 +89,13 @@ trap 'rm "$OUT"' EXIT
 	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" ""
 	echo ""
 
+	dump_sorted_array "x86_sorted_cap_flags" "X86_FEATURE_"
+	echo ""
+
 	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32"
+	echo ""
 
+	dump_sorted_array "x86_sorted_bug_flags" "X86_BUG_"
 ) > $OUT
 
 trap - EXIT
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 2c8522a39ed5..4a5c1a4c7330 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -54,6 +54,51 @@ static void show_cpuinfo_misc(struct seq_file *m, struct cpuinfo_x86 *c)
 }
 #endif
 
+
+static void show_cpuinfo_flags(struct seq_file *m, struct cpuinfo_x86 *c)
+{
+	int i;
+
+	seq_puts(m, "flags\t\t:");
+
+	for (i = 0; i < 32*NCAPINTS; i++) {
+		/*
+		 * Go through the flag list in alphabetical
+		 * order to make reading this field easier.
+		 */
+		unsigned int cap = x86_sorted_cap_flags[i];
+
+		if (cap == (unsigned short)-1)
+			break;
+
+		if (cpu_has(c, cap) && x86_cap_flags[cap] != NULL)
+			seq_printf(m, " %s", x86_cap_flags[cap]);
+	}
+}
+
+
+static void show_cpuinfo_bugs(struct seq_file *m, struct cpuinfo_x86 *c)
+{
+	int i;
+	seq_puts(m, "\nbugs\t\t:");
+	for (i = 0; i < 32*NBUGINTS; i++) {
+		/*
+		 * Go through the flag list in alphabetical
+		 * order to make reading this field easier.
+		 */
+		unsigned int bug_bit = x86_sorted_bug_flags[i];
+		unsigned int bug;
+
+		if (bug_bit == (unsigned short)-1)
+			break;
+
+		bug = bug_bit - 32*NCAPINTS;
+
+		if (cpu_has_bug(c, bug_bit) && x86_bug_flags[bug])
+			seq_printf(m, " %s", x86_bug_flags[bug]);
+	}
+}
+
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	struct cpuinfo_x86 *c = v;
@@ -96,19 +141,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
-
-	seq_puts(m, "flags\t\t:");
-	for (i = 0; i < 32*NCAPINTS; i++)
-		if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
-			seq_printf(m, " %s", x86_cap_flags[i]);
-
-	seq_puts(m, "\nbugs\t\t:");
-	for (i = 0; i < 32*NBUGINTS; i++) {
-		unsigned int bug_bit = 32*NCAPINTS + i;
-
-		if (cpu_has_bug(c, bug_bit) && x86_bug_flags[i])
-			seq_printf(m, " %s", x86_bug_flags[i]);
-	}
+	show_cpuinfo_flags(m, c);
+	show_cpuinfo_bugs(m, c);
 
 	seq_printf(m, "\nbogomips\t: %lu.%02lu\n",
 		   c->loops_per_jiffy/(500000/HZ),
-- 
 Kirill A. Shutemov
