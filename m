Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr8IllQyAz/xK8PznHb1HadZS43Zr4Iz0pR5G7OnBroMUT5WQ4TFAjlCqFxoRNU056ccdjX
ARC-Seal: i=1; a=rsa-sha256; t=1524837866; cv=none;
        d=google.com; s=arc-20160816;
        b=lr9WZQ619ayDBzVDtS7ueKfTfTfpAM+ZyLiocvsG6RHwpCJ8RBdFSTHy+UJlgQtN/H
         FM3p75+rxznMoB4gx9F/ynL7iZJcZeq6KJpqYWn10+I3RNRIM++nLQ1CD7p95u63Af4N
         cfHraVHBpmVTJn/orSIcxZiHJEpoUF1YNdTOtTa1r44hlq4WjYnmeAEv7uEQ375/SjAP
         CrmAiTfbLhasFmYJY44kjj2Om5Hqk6m7ADCuOo5b9vficPv3YHNyyRVYgyPVKZFnmPca
         +b6Y4Uuavl99PpVWDQ+CjkNmPwz9z0zwY2yEeJfgm8eAXK9eefuaawqSzAxlcKS+7XFy
         oXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=q/nYsGOMfLFgm7rTQJtt7RHsHcVwkhXqpskm6dYpYGQ=;
        b=AxmmCohE4seg92J05dkeAMLdbXX7wsDIvb3pzOH3VbsvZaJswQdTWRInQr1N6YMV3n
         jl2V8aCjrmH88vfTmFIm0UlmsGtXtMko0z09tDJhEbnBQ5N/TCGBWCU2q37FrbmAz9s5
         uZemIN+rQL4xrrJRcF7p4eQ6xT0upNWE7MBuWasXQr9vWvnVsT5qqrDfnCm2E7bPpk4l
         VeJWOJ+B4aFKV3cADIvlskfBQGeaGPTAJfO1ZL20KBiGiG/PueVpjg0fAHIWA8hZUOfN
         VPJWqVBAlu6zNtn8AtG2Gy1OVpMO+QPI2WJIvERqgV+PzxhoDA+BQST6iQMcZ2U5t/cw
         WdMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE7821890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 45/74] s390: correct nospec auto detection init order
Date: Fri, 27 Apr 2018 15:58:35 +0200
Message-Id: <20180427135711.789179250@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908197509621778?=
X-GMAIL-MSGID: =?utf-8?q?1598908390905697532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit 6a3d1e81a434fc311f224b8be77258bafc18ccc6 ]

With CONFIG_EXPOLINE_AUTO=y the call of spectre_v2_auto_early() via
early_initcall is done *after* the early_param functions. This
overwrites any settings done with the nobp/no_spectre_v2/spectre_v2
parameters. The code patching for the kernel is done after the
evaluation of the early parameters but before the early_initcall
is done. The end result is a kernel image that is patched correctly
but the kernel modules are not.

Make sure that the nospec auto detection function is called before the
early parameters are evaluated and before the code patching is done.

Fixes: 6e179d64126b ("s390: add automatic detection of the spectre defense")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/nospec-branch.h |    1 +
 arch/s390/kernel/nospec-branch.c      |    8 ++------
 arch/s390/kernel/setup.c              |    3 +++
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/s390/include/asm/nospec-branch.h
+++ b/arch/s390/include/asm/nospec-branch.h
@@ -9,6 +9,7 @@
 extern int nospec_disable;
 
 void nospec_init_branches(void);
+void nospec_auto_detect(void);
 void nospec_revert(s32 *start, s32 *end);
 
 #endif /* __ASSEMBLY__ */
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -73,7 +73,7 @@ static int __init nospectre_v2_setup_ear
 }
 early_param("nospectre_v2", nospectre_v2_setup_early);
 
-static int __init spectre_v2_auto_early(void)
+void __init nospec_auto_detect(void)
 {
 	if (IS_ENABLED(CC_USING_EXPOLINE)) {
 		/*
@@ -88,11 +88,7 @@ static int __init spectre_v2_auto_early(
 	 * nobp setting decides what is done, this depends on the
 	 * CONFIG_KERNEL_NP option and the nobp/nospec parameters.
 	 */
-	return 0;
 }
-#ifdef CONFIG_EXPOLINE_AUTO
-early_initcall(spectre_v2_auto_early);
-#endif
 
 static int __init spectre_v2_setup_early(char *str)
 {
@@ -103,7 +99,7 @@ static int __init spectre_v2_setup_early
 	if (str && !strncmp(str, "off", 3))
 		nospec_disable = 1;
 	if (str && !strncmp(str, "auto", 4))
-		spectre_v2_auto_early();
+		nospec_auto_detect();
 	return 0;
 }
 early_param("spectre_v2", spectre_v2_setup_early);
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -876,6 +876,9 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
+	if (IS_ENABLED(CONFIG_EXPOLINE_AUTO))
+		nospec_auto_detect();
+
 	parse_early_param();
 #ifdef CONFIG_CRASH_DUMP
 	/* Deactivate elfcorehdr= kernel parameter */
