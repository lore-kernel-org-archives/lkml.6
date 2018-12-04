Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA18BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896DF2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896DF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeLDV0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:26:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:51967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeLDV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:26:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="96127312"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2018 13:26:01 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 3/4] x86/vdso: Remove struct vdso_sym and its associated export option
Date:   Tue,  4 Dec 2018 13:25:59 -0800
Message-Id: <20181204212600.28090-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204212600.28090-1-sean.j.christopherson@intel.com>
References: <20181204212600.28090-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...now that all required symbols are exported by vdso2c.

Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

Regarding Andy's concern that we might want the exported flag in the
future for exception fixup, I prototyped a few approaches and in the
end we always need to know at least the base of the original extable
so that we have an anchor point for the relative IPs.  Technically
it's possible to omit the length/end, but doing so requires making
either vdso2c or the kernel code more complex than it needs to be.
So, regardless of whether we use symbols or sections for extable, I'm
fairly confident we'll want to export the result to the .c file.

 arch/x86/entry/vdso/vdso2c.c | 27 +++++++++++----------------
 arch/x86/entry/vdso/vdso2c.h | 15 +++++++--------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 8e470b018512..a175cd2016c9 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -85,22 +85,17 @@ const int special_pages[] = {
 	sym_hvclock_page,
 };
 
-struct vdso_sym {
-	const char *name;
-	bool export;
-};
-
-struct vdso_sym required_syms[] = {
-	[sym_vvar_start] = {"vvar_start", true},
-	[sym_vvar_page] = {"vvar_page", true},
-	[sym_hpet_page] = {"hpet_page", true},
-	[sym_pvclock_page] = {"pvclock_page", true},
-	[sym_hvclock_page] = {"hvclock_page", true},
-	{"VDSO32_NOTE_MASK", true},
-	{"__kernel_vsyscall", true},
-	{"__kernel_sigreturn", true},
-	{"__kernel_rt_sigreturn", true},
-	{"int80_landing_pad", true},
+const char *required_syms[] = {
+	[sym_vvar_start] = "vvar_start",
+	[sym_vvar_page] = "vvar_page",
+	[sym_hpet_page] = "hpet_page",
+	[sym_pvclock_page] = "pvclock_page",
+	[sym_hvclock_page] = "hvclock_page",
+	"VDSO32_NOTE_MASK",
+	"__kernel_vsyscall",
+	"__kernel_sigreturn",
+	"__kernel_rt_sigreturn",
+	"int80_landing_pad",
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index fa847a620f40..14003d311298 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -97,10 +97,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			GET_LE(&sym->st_name);
 
 		for (k = 0; k < NSYMS; k++) {
-			if (!strcmp(name, required_syms[k].name)) {
+			if (!strcmp(name, required_syms[k])) {
 				if (syms[k]) {
 					fail("duplicate symbol %s\n",
-					     required_syms[k].name);
+					     required_syms[k]);
 				}
 
 				/*
@@ -123,13 +123,12 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 
 		if (symval % 4096)
 			fail("%s must be a multiple of 4096\n",
-			     required_syms[i].name);
+			     required_syms[i]);
 		if (symval + 4096 < syms[sym_vvar_start])
-			fail("%s underruns vvar_start\n",
-			     required_syms[i].name);
+			fail("%s underruns vvar_start\n", required_syms[i]);
 		if (symval + 4096 > 0)
 			fail("%s is on the wrong side of the vdso text\n",
-			     required_syms[i].name);
+			     required_syms[i]);
 	}
 	if (syms[sym_vvar_start] % 4096)
 		fail("vvar_begin must be a multiple of 4096\n");
@@ -167,9 +166,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			(unsigned long)GET_LE(&alt_sec->sh_size));
 	}
 	for (i = 0; i < NSYMS; i++) {
-		if (required_syms[i].export && syms[i])
+		if (syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
-				required_syms[i].name, (int64_t)syms[i]);
+				required_syms[i], (int64_t)syms[i]);
 	}
 	fprintf(outfile, "};\n");
 }
-- 
2.19.2

