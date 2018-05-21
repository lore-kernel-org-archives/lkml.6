Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrPp5wMVKmQlZ/iuYJJwbm8gt0WJiX53NPEaVBdUoK4302wU9dESo/XzDnY/FNtmRff+gHd
ARC-Seal: i=1; a=rsa-sha256; t=1526937316; cv=none;
        d=google.com; s=arc-20160816;
        b=JmMP+3bzd2X80iRw/O7INeWW9MkJdFSVrBS5XbQwQXPrSliCr5DEjbxf6R+RVDMW2Y
         uemQOmL9unVEBys81gUWivebTr4L6I6lQWYz5EGE4UCP3DwC9pRwtmp/D4JxPam3G7Sd
         IFJNptjNwZxqupcGYVJmOCVM7uAWqm1rXd8wE/uMYBxl0Nnq/t/LAnHRAjbhnB7mscX8
         KNIgoPATXJNklg8b4OeSfud+vLSA7ICYrCuvL9baXXf+MdPiRtxNspw3Qii3kZjbXJ8H
         xAsSCEeR6WGPJVvOTagI+o4g++2mKE8IRRmu0QRx+d7lHWIuevCQPDfCAO6FmeZ9bYxp
         EqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zYXpW0BlO7E337mMMZum10Fgd3tqL4XVfKkn3FhRLno=;
        b=t+5II5rEa+JiZmW84xxynEFRlL5y9u3hcJ5bexwHzp00NkRKG+vmXUOAIj1bvUOgiu
         4zn0wtkQbOxO7staRsvZ7Dia7tBdR3zYydGW8lC3XqGmwET+iAmMDgx4/ktyWkfCRVuS
         95WZru1K8eyTOUR8IP99d1WIMCvEvMZ/KJXKHJ/hJFymUDEOz48oBuLYi+7jmrOjNGTH
         HZhqRlf8DapQkLqtWFv9jAKbHyvpJyQ6ByYJaSWFbMyg4yEIQLVdnW+KPxcCRcjCbmBN
         62cxrYuHr2tShP750v/3gvodYcxKFvCHB2qN5wKkZk3pvq/cD5FKbfA9Mu1NFLLQtEZD
         fxzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=aPJMdrxS;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=aPJMdrxS;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 37/87] x86/bugs: Concentrate bug detection into a separate function
Date: Mon, 21 May 2018 23:11:13 +0200
Message-Id: <20180521210423.990303652@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109824365345903?=
X-GMAIL-MSGID: =?utf-8?q?1601109824365345903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -879,21 +879,27 @@ static const __initconst struct x86_cpu_
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
@@ -942,12 +948,7 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
-	if (!x86_match_cpu(cpu_no_speculation)) {
-		if (cpu_vulnerable_to_meltdown(c))
-			setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
-	}
+	cpu_set_bug_bits(c);
 
 	fpu__init_system(c);
 
