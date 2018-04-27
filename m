Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZocU2+kEnkLf9plGUsQmWC9r8gi7by0wglYk4Nez14+BRIgdR590wtgWH2BZ7KY08vPDbYe
ARC-Seal: i=1; a=rsa-sha256; t=1524837853; cv=none;
        d=google.com; s=arc-20160816;
        b=mv3cHv4Bsd9jmN+Cq7YOEgvSVmBUr24fmqgaDm9FxJBb1IXHE2wnLjD1/+8BEg4IWf
         ZTSt+8FIZsqbjeXRNnFHk5FU9VtfyEaEgBeDa2gzsX3LwYEa3V0J4UJvlp+TvDAQvwkz
         K4FR/xvBoRHkBSz1Z6YRf5Sh8S1woL1jgVnzyCi7iTzauDbqftKgJwMxCtlBVUUtCuaE
         14bDZW1IQmyXvs3plgEVVIgwiAQbpzTwrccMRspJCeH8ouNLQrJVtDxLhmtlNGdNHdn8
         XIo3jYZvi0yNQ8wHudB90XVGlmXS4sPv7NJJQoFnMHKVT3RQB/GHpfW70HpcN3oAKHbw
         chFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=eL1HpxQvJOp6Rv4fz49YgPKCj9v4GFcFhNeQmN/nNUg=;
        b=ZEyjmGvLsT/x32fLRnQs7dFkfIVcUgY8bL7yv6bTtl+C/r3GuATDtXRnaU8X4978B2
         6d3zGkeP8fk/gv1pXM52vPQ/xY6zhnmlKJq4VebQkB8b8dSVH8Y0KQj3qOg4NUkMOyIO
         7o8/Lkx0y7Fddu1WEPLisVt4KTscbJCznTw/7S3Y+jNHxTubZ/ub7HrpR6hd9j8vDiQS
         YHIYQwaAJPD0n+yNJfcJSpPf3cXLy+k7gek69lHsoC++vm010SNLFR3daABoleP7lHRZ
         +1IqRJakYGiar4JZOwhqh6hb1trx9+PSccOCBLPthw04f5MWEJnzm54s9ejnxvNYAPd1
         BkTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC46E21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 41/74] s390: move nobp parameter functions to nospec-branch.c
Date: Fri, 27 Apr 2018 15:58:31 +0200
Message-Id: <20180427135711.625886806@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908184297617912?=
X-GMAIL-MSGID: =?utf-8?q?1598908377101783130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -59,11 +59,11 @@ obj-y	+= debug.o irq.o ipl.o dis.o diag.
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o
 obj-y	+= entry.o reipl.o relocate_kernel.o alternative.o
+obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
-obj-$(CONFIG_EXPOLINE)		+= nospec-branch.o
-CFLAGS_REMOVE_expoline.o	+= $(CC_FLAGS_EXPOLINE)
+CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= module.o
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
