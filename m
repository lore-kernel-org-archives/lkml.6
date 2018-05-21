Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoOfo6JimQ486V7Ax2aun798Q+MgvkwzWqpi4hPI0DKPgBgrZpUM4D1vw2AWWB9rR5n3T+P
ARC-Seal: i=1; a=rsa-sha256; t=1526938002; cv=none;
        d=google.com; s=arc-20160816;
        b=XNYaZ+4ztbHbYpmNQ+OTij1g6mmGYi3blE/5TT1Ue/qlum2nQR6QgfM9d76BxcNc8F
         d6HRf0ElCCaOlt5uE+69GNFTwoTNRVoMCkD8mPigLH+Q1m83RNT/BoyvFVLdV1fovNOF
         oPmIVjvgKaCCHU6+z6swphQnqH7mLTBVNNtmo0nnv0aMkAJp0+1AdvGOqH/lzRrVf3dT
         7diyjAeGLu27OwYQIhQrmgJ+e+iPDvXqVu1bAWZ69YqnSxY1K7KOkw7oapG31Aw0yMnE
         wqrvuy0M8I/GpUkvqymNY0zMXISX/bl3B0KcUm9w6oievkgrGsiHaLgvjaFVuAfUcOVq
         HCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=f1BmWWNjW2o4U1Q9qnFDy0cdd+rRJFl0/qBN+8DIUm0=;
        b=WXvgNRBci/OL3/jYzU5LP44JzSS60PVyTbzI9m0vNqvNVtwDpf5rZQxF+/Bzjh2JMa
         Mfzh4gzQ6HLx6ixh+EZg9Etvdnh2yidJwUZJBIjbnx/TuX1DjRaV4ZHTLOrHggn08PAX
         h5pUv8Ssu6MGYLnolpXAr7vpMN0eN9Wsi4Yy7N3dIxWKOz/akzGXrJsIAACa5p7g1GWG
         3p9hB5TPh5cPbsbz6QKYficRo7xWVlpc2vfowUy4nUeeUvL3t6YAg5EU7onw5R1qTmfW
         271Qw1oLttlPtUaIog0zry0YAQsZaDrRHKiWMgaaDzbmFfol8rc/pyiW7NJSE3YAK0LL
         AZAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zluYKIvb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zluYKIvb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 063/110] x86/bugs: Concentrate bug detection into a separate function
Date: Mon, 21 May 2018 23:12:00 +0200
Message-Id: <20180521210511.777972902@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109824365345903?=
X-GMAIL-MSGID: =?utf-8?q?1601110542947927223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 4a28bfe3267b68e22c663ac26185aa16c9b879ef upstream

Combine the various logic which goes through all those
x86_cpu_id matching structures in one function.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -918,21 +918,27 @@ static const __initconst struct x86_cpu_
 	{}
 };
 
-static bool __init cpu_vulnerable_to_meltdown(struct cpuinfo_x86 *c)
+static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = 0;
 
+	if (x86_match_cpu(cpu_no_speculation))
+		return;
+
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+
 	if (x86_match_cpu(cpu_no_meltdown))
-		return false;
+		return;
 
 	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	/* Rogue Data Cache Load? No! */
 	if (ia32_cap & ARCH_CAP_RDCL_NO)
-		return false;
+		return;
 
-	return true;
+	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
 }
 
 /*
@@ -982,12 +988,7 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
-	if (!x86_match_cpu(cpu_no_speculation)) {
-		if (cpu_vulnerable_to_meltdown(c))
-			setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
-	}
+	cpu_set_bug_bits(c);
 
 	fpu__init_system(c);
 
