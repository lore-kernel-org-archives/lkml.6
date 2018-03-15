Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELt5o7mXzaEmfJKm5jqvQGj5dCuVfy+wcaPT+TzVJ6KdUK6330A40JipeTe/78EUb5t2EhUC
ARC-Seal: i=1; a=rsa-sha256; t=1521141384; cv=none;
        d=google.com; s=arc-20160816;
        b=eEGBnma4XtusrqLAUtfG3yX+4l68x5IYNUFcoaIGAWD2GCOpkkKbdalnCjJswGKzX7
         L7gD0FB35QNMoWCqEcjGe4wMttBV9qhPKVgZBtAMR9ngms6uxU37UHSN95cIPMPLC9BE
         Y/I4TSrHAb7a4MwMiGW1mmzAuoFoZBze3E9xGComBEBCtkNF9PqMGGZMeNieB4prc2+a
         s4YEBNzXlYRoxFfZkrAn3tio70EEgc8efGs4PLwAoAtlUb3JXlxcyuaA3nY0gfb/WLhc
         gYVhO4btMOAA0KVOsrMhnhUlGZnpyEQLFp8UCChwt9yt1hPzOVEPLpxh3+1E1hwKqcla
         YbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Aq54XUoVWNfdB2cFZXrk5ZPENBtBPfsBjPvN/1KofIA=;
        b=FhyTDonrbJTgFtBzA2O9jn9JWldmLg3i/sl1KHUI2SoKw5F5t1K9VmauSDlDTNmnbi
         8aV55fAdgdoVITwlZ7VzLmF3jdHscFuKNUSIvYU+5RsJVaklUIf/F7MXX2MWmDbF6sdh
         3BvqKH+ITCKNg15I4vXCfq4QB637d/jBfyu3iRLl1R9FHAk5jkEMh7armXZkEkWC+G8u
         AIduACf1Hlt2Km5evh2h/SkZGCIrUGJ620GFvoWySLB+aQDAyGO+9JxNFfRrTVy5Ly/K
         TXbn8SpRaOeoxdvfdVCDOScvGz8tDRKIecFdxUxhp03B60ZfI6++npNYtuFBVG4Nmvvb
         br3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 5/9] powerpc/64s: Add support for ori barrier_nospec patching
Date: Thu, 15 Mar 2018 20:15:54 +0100
Message-Id: <2d9d9b4157cc03d81d7c79f5269508694d94de70.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032349061266516?=
X-GMAIL-MSGID: =?utf-8?q?1595032349061266516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Based on the RFI patching. This is required to be able to disable the
speculation barrier.

Only one barrier type is supported and it does nothing when the firmware
does not enable it. Also re-patching modules is not supported So the
only meaningful thing that can be done is patching out the speculation
barrier at boot when the user says it is not wanted.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/barrier.h        |  4 ++--
 arch/powerpc/include/asm/feature-fixups.h |  9 +++++++++
 arch/powerpc/include/asm/setup.h          |  8 ++++++++
 arch/powerpc/kernel/setup_64.c            | 30 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  7 +++++++
 arch/powerpc/lib/feature-fixups.c         | 27 +++++++++++++++++++++++++++
 6 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 8e47b3abe405..4079a95e84c2 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -75,9 +75,9 @@ do {									\
 	___p1;								\
 })
 
-/* TODO: add patching so this can be disabled */
 /* Prevent speculative execution past this barrier. */
-#define barrier_nospec_asm ori 31,31,0
+#define barrier_nospec_asm SPEC_BARRIER_FIXUP_SECTION;			\
+				nop
 #ifdef __ASSEMBLY__
 #define barrier_nospec barrier_nospec_asm
 #else
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 1e82eb3caabd..9d3382618ffd 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -195,11 +195,20 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET 951b-952b;			\
 	.popsection;
 
+#define SPEC_BARRIER_FIXUP_SECTION			\
+953:							\
+	.pushsection __spec_barrier_fixup,"a";		\
+	.align 2;					\
+954:							\
+	FTR_ENTRY_OFFSET 953b-954b;			\
+	.popsection;
+
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
+extern long __start___spec_barrier_fixup, __stop___spec_barrier_fixup;
 
 void apply_feature_fixups(void);
 void setup_feature_keys(void);
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index bbcdf929be54..c7e9e66c2a38 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -49,8 +49,16 @@ enum l1d_flush_type {
 	L1D_FLUSH_MTTRIG	= 0x8,
 };
 
+/* These are bit flags */
+enum spec_barrier_type {
+	SPEC_BARRIER_NONE	= 0x1,
+	SPEC_BARRIER_ORI	= 0x2,
+};
+
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+void setup_barrier_nospec(enum spec_barrier_type, bool enable);
+void do_barrier_nospec_fixups(enum spec_barrier_type type);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4ec4a27b36a9..767240074cad 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -815,6 +815,10 @@ static enum l1d_flush_type enabled_flush_types;
 static void *l1d_flush_fallback_area;
 static bool no_rfi_flush;
 bool rfi_flush;
+enum spec_barrier_type powerpc_barrier_nospec;
+static enum spec_barrier_type barrier_nospec_type;
+static bool no_nospec;
+bool barrier_nospec_enabled;
 
 static int __init handle_no_rfi_flush(char *p)
 {
@@ -900,6 +904,32 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 		rfi_flush_enable(enable);
 }
 
+void barrier_nospec_enable(bool enable)
+{
+	barrier_nospec_enabled = enable;
+
+	if (enable) {
+		powerpc_barrier_nospec = barrier_nospec_type;
+		do_barrier_nospec_fixups(powerpc_barrier_nospec);
+		on_each_cpu(do_nothing, NULL, 1);
+	} else {
+		powerpc_barrier_nospec = SPEC_BARRIER_NONE;
+		do_barrier_nospec_fixups(powerpc_barrier_nospec);
+	}
+}
+
+void setup_barrier_nospec(enum spec_barrier_type type, bool enable)
+{
+	/*
+	 * Only one barrier type is supported and it does nothing when the
+	 * firmware does not enable it. So the only meaningful thing to do
+	 * here is check the user preference.
+	 */
+	barrier_nospec_type = SPEC_BARRIER_ORI;
+
+	barrier_nospec_enable(!no_nospec && enable);
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int rfi_flush_set(void *data, u64 val)
 {
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c8af90ff49f0..744b58ff77f1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -139,6 +139,13 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+
+	. = ALIGN(8);
+	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
+		__start___spec_barrier_fixup = .;
+		*(__spec_barrier_fixup)
+		__stop___spec_barrier_fixup = .;
+	}
 #endif
 
 	EXCEPTION_TABLE(0)
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 4cc2f0c5c863..dfeb7feeccef 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -159,6 +159,33 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
 						: "unknown");
 }
+
+void do_barrier_nospec_fixups(enum spec_barrier_type type)
+{
+	unsigned int instr, *dest;
+	long *start, *end;
+	int i;
+
+	start = PTRRELOC(&__start___spec_barrier_fixup),
+	end = PTRRELOC(&__stop___spec_barrier_fixup);
+
+	instr = 0x60000000; /* nop */
+
+	if (type == SPEC_BARRIER_ORI) {
+		pr_info("barrier_nospec: using ORI speculation barrier\n");
+		instr = 0x63ff0000; /* ori 31,31,0 speculation barrier */
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.13.6
