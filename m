Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E0C65BB0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EE42081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EE42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeLDV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:26:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:51975 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeLDV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:26:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="96127313"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2018 13:26:01 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 4/4] x86/vdso: Rename "required_syms" to "requested_syms"
Date:   Tue,  4 Dec 2018 13:26:00 -0800
Message-Id: <20181204212600.28090-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204212600.28090-1-sean.j.christopherson@intel.com>
References: <20181204212600.28090-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "required" moniker implies that vdso2c will fail if one of the
defined symbols is not found, which is simply not true, e.g.
VDSO32_NOTE_MASK is quite obviously 32-bit only and not required
for the 64-bit image.

Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/entry/vdso/vdso2c.c |  4 ++--
 arch/x86/entry/vdso/vdso2c.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index a175cd2016c9..b2acdaffc66d 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -85,7 +85,7 @@ const int special_pages[] = {
 	sym_hvclock_page,
 };
 
-const char *required_syms[] = {
+const char *requested_syms[] = {
 	[sym_vvar_start] = "vvar_start",
 	[sym_vvar_page] = "vvar_page",
 	[sym_hpet_page] = "hpet_page",
@@ -139,7 +139,7 @@ extern void bad_put_le(void);
 	PLE(x, val, 64, PLE(x, val, 32, PLE(x, val, 16, LAST_PLE(x, val))))
 
 
-#define NSYMS ARRAY_SIZE(required_syms)
+#define NSYMS ARRAY_SIZE(requested_syms)
 
 #define BITSFUNC3(name, bits, suffix) name##bits##suffix
 #define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 14003d311298..6c5a290ce468 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -97,10 +97,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			GET_LE(&sym->st_name);
 
 		for (k = 0; k < NSYMS; k++) {
-			if (!strcmp(name, required_syms[k])) {
+			if (!strcmp(name, requested_syms[k])) {
 				if (syms[k]) {
 					fail("duplicate symbol %s\n",
-					     required_syms[k]);
+					     requested_syms[k]);
 				}
 
 				/*
@@ -123,12 +123,12 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 
 		if (symval % 4096)
 			fail("%s must be a multiple of 4096\n",
-			     required_syms[i]);
+			     requested_syms[i]);
 		if (symval + 4096 < syms[sym_vvar_start])
-			fail("%s underruns vvar_start\n", required_syms[i]);
+			fail("%s underruns vvar_start\n", requested_syms[i]);
 		if (symval + 4096 > 0)
 			fail("%s is on the wrong side of the vdso text\n",
-			     required_syms[i]);
+			     requested_syms[i]);
 	}
 	if (syms[sym_vvar_start] % 4096)
 		fail("vvar_begin must be a multiple of 4096\n");
@@ -168,7 +168,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	for (i = 0; i < NSYMS; i++) {
 		if (syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
-				required_syms[i], (int64_t)syms[i]);
+				requested_syms[i], (int64_t)syms[i]);
 	}
 	fprintf(outfile, "};\n");
 }
-- 
2.19.2

