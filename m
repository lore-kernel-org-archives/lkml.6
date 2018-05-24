Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo1/AKTT0BSQH0RH2L/otjzrL+RgUmICi4XmfD3J3fyTj6QSe23wgwSSAro5PqfwblrwXu/
ARC-Seal: i=1; a=rsa-sha256; t=1527156061; cv=none;
        d=google.com; s=arc-20160816;
        b=MyjWilRmhgXVnJDLfOjy33dBn8Z/qfb7tbw8VjA0cGPMv9sCs4rDRlNqxoPq6FrBnE
         NMvS5vbefsFi1CGMCN3vzU/sr6KutxiNlDAu6nldRHnhKR6+TzTngxfqi8Ae+tc51Ktf
         JHURqTLhnE9MVD2JX3yxHvhXXyVIt/nxqWTbYUwp6Wn8pf/NP3wr+1/XUX1mITaFRn7m
         clSBUJE0rFWsNrIV7pgWL92eD6BYk9srjWNCLmls14MqO+OTvLyZ1kojOsrZC4HdK5oH
         x61jsbfGrTOPXlcd99dMkUb2z8lbNkDuFplSB9A3/16EuTu0d4bpIzv8klDuE2CoF4LP
         p/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NZItv4NQK09Zc+1uiP0zSaCDf5uRfp9jNgP/OGhiC4M=;
        b=tRT61AhaNueKSh+DNAo+Po0aH6eSE0kAiPBI610WZOBTOCM0agPYc/yG4Yfxh1xE/0
         hqw/HVn6U7CvsEN+xXh2iEbhlF2F8QEK6msXulzt2a15YQkMmUgh/wEnaArltstgaSXs
         +5wYN5GjSLwlBHb6iFCe8C4d+3r+w+xq4WCsSzhiiSQhCULDJOEbDXgN3c1xhBID64lv
         CybghWDdDxs3mVZrlX7EqjDrLyfBoBGbNDNZKBb54V2Yx2cGDzK/Maea+fVStht6V+sz
         6jmzwTY681vwkav2ypZTtXdzi/xZRPif+eobgZHLQnRRWc81NrD/QYrFjPx/MzmyOPIQ
         fJ7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fdQjYXQl;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fdQjYXQl;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 049/161] s390: move nobp parameter functions to nospec-branch.c
Date: Thu, 24 May 2018 11:37:54 +0200
Message-Id: <20180524093024.328567832@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339194308829906?=
X-GMAIL-MSGID: =?utf-8?q?1601339194308829906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -61,11 +61,11 @@ obj-y	+= debug.o irq.o ipl.o dis.o diag.
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
+obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
-obj-$(CONFIG_EXPOLINE)		+= nospec-branch.o
-CFLAGS_REMOVE_expoline.o	+= $(CC_FLAGS_EXPOLINE)
+CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_SMP)		+= smp.o
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -15,29 +15,6 @@ static int __init disable_alternative_in
 
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
@@ -2,6 +2,31 @@
 #include <linux/module.h>
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
 
@@ -98,3 +123,5 @@ void __init nospec_init_branches(void)
 	nospec_call_revert(__nospec_call_start, __nospec_call_end);
 	nospec_return_revert(__nospec_return_start, __nospec_return_end);
 }
+
+#endif /* CONFIG_EXPOLINE */
