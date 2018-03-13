Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELvRx68Zow3zLvCpuh0S/VWB9wIW8b5QWCoJXBEBLpQag57AHq05xQ5iI9vzNP23l8qOf2z4
ARC-Seal: i=1; a=rsa-sha256; t=1520966034; cv=none;
        d=google.com; s=arc-20160816;
        b=o7Norud8neva+fucnYxvYUck4SaTX9kIh8cESmraEK74VNEQAhVqPpn+YSZS9RUNPj
         tzh+5hTLWRwJjwy20iT2o0ejUXCs20AMFsfRvEAH7wA0J83s8VZdyX6ITuWubn6gAUgK
         qSlksdkUSQfJwnxR5LQa1fkl+LW0AP+kYZHcUYFBV8wDhYdHpwAp3k7Wk4kKtwqMTvx4
         TddZwoUr7HQF0f2ys4RHZNxZ86lbzQDzx5tbcvB3MI8Ccm9O5A5gblNjSySo6sQ1KmkG
         Hs9stR17wYRYeoR8rMgcaZoWrfhAyYYIp4KrmMMWqGyuZfqBcYJOsmWRKVXk9OjDS0/M
         A65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hlOmhYEnn0thJYdWyf2xLM+Uy7Trxi7BtC+lufyHbP8=;
        b=OAM/yK/icAPbNoML1BHVhZ/tyPPfSjEpH9tDXprp+H3mTYMvZw1G1vrT1Hph8lwD4E
         FvbQpSgyN0LWgY0nQheHjtcnbRiuS4C+v0l5MyIRK0p+g0iOsk80jmfvHV2bJlAQpuHz
         fmLSm9KnQC8/8KFoIuB9y+iq2HWnQo40TKO4dskjqFAu0zwiIJ/gRsT4xxiqAUBPS1Vc
         HCebsyJWyphdE/3hy2ObXMXenNZINpEdk5SzG/BZrke0BeDY2Sku/5PCBTdt5tcIu8SJ
         bJyr1Rf6n2xhkl472FMqPFCbuuoj+XdqFUIJqT3w8h1uhHHvPqTf7FYy0zn6m+nl7OSN
         e6rA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Suchanek <msuchanek@suse.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Neuling <mikey@neuling.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Russell Currey <ruscur@russell.cc>,
	Joe Perches <joe@perches.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/8] powerpc/64: Patch barrier_nospec in modules
Date: Tue, 13 Mar 2018 19:33:03 +0100
Message-Id: <7a0d36c27c354f04c803ce5c4ef743e6f753b2d6.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848480929122834?=
X-GMAIL-MSGID: =?utf-8?q?1594848480929122834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copypasta from lwsync patching.

Note that unlike RFI which is patched only in kernel the nospec state
reflects settings at the time the module was loaded.

Iterating all modules and re-patching every time the settings change is
not implemented.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/setup.h  |  5 ++++-
 arch/powerpc/kernel/module.c      |  6 ++++++
 arch/powerpc/kernel/setup_64.c    |  4 ++--
 arch/powerpc/lib/feature-fixups.c | 17 ++++++++++++++---
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 486d02e4a310..7e3a41248810 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -58,7 +58,10 @@ enum spec_barrier_type {
 void __init setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 void __init setup_barrier_nospec(enum spec_barrier_type, bool enable);
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
index 09f21a954bfc..d1d9f047161e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -909,11 +909,11 @@ void barrier_nospec_enable(bool enable)
 
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
index 000e153184ad..b59ebc2215e8 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -156,14 +156,15 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 	printk(KERN_DEBUG "rfi-flush: patched %d locations\n", i);
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
 
@@ -182,6 +183,16 @@ void do_barrier_nospec_fixups(enum spec_barrier_type type)
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
