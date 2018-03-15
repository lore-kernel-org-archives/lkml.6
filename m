Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELsj6IQDpkMNCkAOF7vz60hRVzXpdiAOVcZlQmmj5j1SFiagoi/JDFGwvaTa9hWy1r6dnXq1
ARC-Seal: i=1; a=rsa-sha256; t=1521141385; cv=none;
        d=google.com; s=arc-20160816;
        b=XRMcG4MQf58onjBN0zmznw0uR6k29d0Sk9db9FVMr3XB24g7zSfpcr8lhH40k9AgGV
         exRXz1PbaX5TpKvF9pj2WHDP99cJW2JXFkIaxGLDbJvRWfh6NPJUNGvZbB0T8+RyOYbj
         Oi6c/yAxFSDpCCuPLt9pz6XWjkKPUGU2u2TpD0vEF4f6pFtfnbZbH2h2dFotHoFcQgq9
         3csZF1mktknaqP84psKGXjZ4G21hXSOWkIyVP8n8kDr03rlehcXaTfLwPTTkPEHSWVTF
         FiAAHKpZRtxDMS7wusPglF0O3wYsfLAgpJvJQKDJ/SLqBnquc7L6ONKOTXKWJjnXDkZ8
         +J6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f0oJX08xvTlOZXN3ZHyjot5a06v+pVzuUmqtq6DCrzI=;
        b=hpduEkuRWoUhsoXc9EQQbSfWnCrRzbekuIqV8fceevcKsBLFGyDlNDwdamA1Zm3EpG
         p0eCeZ25uBCt/Q0CiazYHGAdFoNzDwu23Ro+wXOdZVWlYpc4Ah/rROTTfZk++8nNh6qt
         PImofAI+qK35Zp4q5aTGkqAR6V4/X2hy+0rKhSk48pF5tHYzm7k5gISLAOTfX1VYpaMD
         rKU2TPuU0d/S/THuOLOld//AQcQWvY0tN77AshFeXjaJtcARnhfcGQMLfSQRdvXB/kO+
         NWfMzWsfAzaCcPoZZh+Sh/AVeQjJm5DyPCgwB47DD8HFs8Vio6rRvsJjrGdF67IGU/tT
         NVRw==
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
Subject: [PATCH RFC rebase 6/9] powerpc/64: Patch barrier_nospec in modules
Date: Thu, 15 Mar 2018 20:15:55 +0100
Message-Id: <c776f744a0623ae6ebc24411677ec477abfae48b.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032349384465370?=
X-GMAIL-MSGID: =?utf-8?q?1595032349384465370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note that unlike RFI which is patched only in kernel the nospec state
reflects settings at the time the module was loaded.

Iterating all modules and re-patching every time the settings change is
not implemented.

Based on lwsync patching.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/setup.h  |  5 ++++-
 arch/powerpc/kernel/module.c      |  6 ++++++
 arch/powerpc/kernel/setup_64.c    |  4 ++--
 arch/powerpc/lib/feature-fixups.c | 17 ++++++++++++++---
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index c7e9e66c2a38..92520d2483b8 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -58,7 +58,10 @@ enum spec_barrier_type {
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 void setup_barrier_nospec(enum spec_barrier_type, bool enable);
-void do_barrier_nospec_fixups(enum spec_barrier_type type);
+void do_barrier_nospec_fixups_kernel(enum spec_barrier_type type);
+void do_barrier_nospec_fixups(enum spec_barrier_type type,
+			      void *start, void *end);
+extern enum spec_barrier_type powerpc_barrier_nospec;
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 3f7ba0f5bf29..7b6d0ec06a21 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,6 +72,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+
+	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
+	if (sect != NULL)
+		do_barrier_nospec_fixups(powerpc_barrier_nospec,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
 #endif
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 767240074cad..f60e0e3b5ad2 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -910,11 +910,11 @@ void barrier_nospec_enable(bool enable)
 
 	if (enable) {
 		powerpc_barrier_nospec = barrier_nospec_type;
-		do_barrier_nospec_fixups(powerpc_barrier_nospec);
+		do_barrier_nospec_fixups_kernel(powerpc_barrier_nospec);
 		on_each_cpu(do_nothing, NULL, 1);
 	} else {
 		powerpc_barrier_nospec = SPEC_BARRIER_NONE;
-		do_barrier_nospec_fixups(powerpc_barrier_nospec);
+		do_barrier_nospec_fixups_kernel(powerpc_barrier_nospec);
 	}
 }
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index dfeb7feeccef..a529ac6b2a5d 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -160,14 +160,15 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 						: "unknown");
 }
 
-void do_barrier_nospec_fixups(enum spec_barrier_type type)
+void do_barrier_nospec_fixups(enum spec_barrier_type type,
+			      void *fixup_start, void *fixup_end)
 {
 	unsigned int instr, *dest;
 	long *start, *end;
 	int i;
 
-	start = PTRRELOC(&__start___spec_barrier_fixup),
-	end = PTRRELOC(&__stop___spec_barrier_fixup);
+	start = fixup_start;
+	end = fixup_end;
 
 	instr = 0x60000000; /* nop */
 
@@ -186,6 +187,16 @@ void do_barrier_nospec_fixups(enum spec_barrier_type type)
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+void do_barrier_nospec_fixups_kernel(enum spec_barrier_type type)
+{
+	void *start, *end;
+
+	start = PTRRELOC(&__start___spec_barrier_fixup),
+	end = PTRRELOC(&__stop___spec_barrier_fixup);
+
+	do_barrier_nospec_fixups(type, start, end);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.13.6
