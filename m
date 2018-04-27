Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoH86sQipIcQxgnHo0D2uFfsOmjgTfz6f4Jb8TNnjJfPOS2Hff8EkZ0MPKTqbLlc5ZJ8Sis
ARC-Seal: i=1; a=rsa-sha256; t=1524837669; cv=none;
        d=google.com; s=arc-20160816;
        b=aZ08cLaOgPvqXe+g77iNpbhdK+wb31aJa4/mGgJKWsct+ImRRHAd/IWgkOWfCtYy4w
         T1mx6Utz772c42sBXu8KAtRH2Pilji7q8ieDavBqXwIYJN2l2U1TmbPl5IjTj7CRiP6b
         l1A8UxfMrVRprVI02xMfZHR+i2+ucowV8URZ7stSUuYW/xSb16jcwDMOXvLg0+jWlCYB
         MmxB33yNOv8tlwV0DvI1SyRy6+QLKceFeO0tiWQsN492IRmjXfP91+uKH4evkVciKKsu
         DLscMnxwnQ4RLJDJqOyJ3qqkRffrRjAIQhmAZKHHglsATLTLAMr4NTZY8dDZXw1fjw8p
         1bcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=tB+XvWL+1u3LxlwLH3h5ZPSodr5CwJiXoyyhRrcIv3M=;
        b=HBFPyuMlq99PuBC7Emx0iCWY+W1ulS3lxkz+vTPc58NuomWIMXDeI/5DakJqXH9Wzm
         a5X0zkiyXrjAuHvkSACb0Ldsy4UMYeKmkF5ta6mNO34JFqyQLRaEjdZnHnd/nZxxSkES
         RMOBqmQea+4S2oeO+1mMrO3sQ/+CfPlgqj01i0h67CardmPqNcXmf9R+BCFOhbnS2Y3P
         hwVvGMJqZq/UirraQC+IBLZCKFXOdMZmy/STjYW+qu8lbzXow6c1TFLO3b+4IVjNPBE7
         IKWYw1+gHOro+3Oc9Kvs2mVJBuAVm8UIvJ2r6PLjBa/X+To8SUl3QFW6Q+mZuFGQmXGD
         XBoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2402185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 22/50] s390: move nobp parameter functions to nospec-branch.c
Date: Fri, 27 Apr 2018 15:58:24 +0200
Message-Id: <20180427135657.034170807@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908184297617912?=
X-GMAIL-MSGID: =?utf-8?q?1598908184297617912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit b2e2f43a01bace1a25bdbae04c9f9846882b727a ]

Keep the code for the nobp parameter handling with the code for
expolines. Both are related to the spectre v2 mitigation.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/Makefile        |    4 ++--
 arch/s390/kernel/alternative.c   |   23 -----------------------
 arch/s390/kernel/nospec-branch.c |   27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 25 deletions(-)

--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -45,11 +45,11 @@ obj-y	+= debug.o irq.o ipl.o dis.o diag.
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o dumpstack.o
 obj-y	+= entry.o reipl.o relocate_kernel.o alternative.o
+obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
-obj-$(CONFIG_EXPOLINE)		+= nospec-branch.o
-CFLAGS_REMOVE_expoline.o	+= $(CC_FLAGS_EXPOLINE)
+CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -14,29 +14,6 @@ static int __init disable_alternative_in
 
 early_param("noaltinstr", disable_alternative_instructions);
 
-static int __init nobp_setup_early(char *str)
-{
-	bool enabled;
-	int rc;
-
-	rc = kstrtobool(str, &enabled);
-	if (rc)
-		return rc;
-	if (enabled && test_facility(82))
-		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
-	else
-		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
-	return 0;
-}
-early_param("nobp", nobp_setup_early);
-
-static int __init nospec_setup_early(char *str)
-{
-	__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
-	return 0;
-}
-early_param("nospec", nospec_setup_early);
-
 struct brcl_insn {
 	u16 opc;
 	s32 disp;
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -3,6 +3,31 @@
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 
+static int __init nobp_setup_early(char *str)
+{
+	bool enabled;
+	int rc;
+
+	rc = kstrtobool(str, &enabled);
+	if (rc)
+		return rc;
+	if (enabled && test_facility(82))
+		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
+	else
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nobp", nobp_setup_early);
+
+static int __init nospec_setup_early(char *str)
+{
+	__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nospec", nospec_setup_early);
+
+#ifdef CONFIG_EXPOLINE
+
 int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
 int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
 
@@ -99,3 +124,5 @@ void __init nospec_init_branches(void)
 	nospec_call_revert(__nospec_call_start, __nospec_call_end);
 	nospec_return_revert(__nospec_return_start, __nospec_return_end);
 }
+
+#endif /* CONFIG_EXPOLINE */
