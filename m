Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq9VLfBk89kfBYNFF9UN6iIBgkE56Dr7A60gB36aHpJulpiPv2IKpHjm5Z6Wb8dPKJzFXie
ARC-Seal: i=1; a=rsa-sha256; t=1524837682; cv=none;
        d=google.com; s=arc-20160816;
        b=MBkmTrHE+E5i0TySVyYnbCuO/y4J/Z0569919VDNzuMfgbWLifO/UKK08CnWVGh4D0
         aXXTXEkx5ikheTms7LiOTkqng5kZnZIpdMmnx9D7nw5ZpvSuQi8AMvdN7biDaus/kHqU
         t1f8lFbj2eurumbygAKFgK5f3jOWB1ilfYIqmKcpZAfLQiIBz1JtdAML95M8APCOhI8O
         ujUoK8+TqRI8UHv2XzID5Q0bVxmj79+uslXoYlbMCuoyjAfOrRNZ/2hAo2nHRefp99zf
         SwOhTr77hP3tnyBNgvzPKp+TsQhGZhUiEtFfCB9Nvd0dKcCvK9GmpN9b+FktgY8XiFyT
         9VRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=MrLN7bby7fDFoz9w67IYj3A63qVd7cqFttfS+IxX3J0=;
        b=df/9MW/+zZ35ZFa0445jDgBs1O79EVR806Fx45BiOjFAuMl9xjdu4hL9tdvxpv7DIC
         5fHT0xWGfBfFgnA9aK3B++TriBY5BecW+6phhjJ3XiS2rvp+MmmRdLBW8UvH+5DTXgIo
         kEYhM0+hWOCnyM/LzZBf9ZJKWBI0n1A/eH0KaGJgDTAsOkCwlAUSufFTOZ+NSBPGkB7A
         0LWsJKf70VPfMajR/UQxBmgmz65Hzu8ITsFLWQWxnMJNtsGUcCDJNZtg66xies4e/gKP
         XiUBfABE6HnTpAeOMXZ2S9aMcCAX7Ojbt3bQcT4zZ6J6j2v+71dQCM02+ltn7BAACGQm
         A2eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A314A2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 26/50] s390: correct nospec auto detection init order
Date: Fri, 27 Apr 2018 15:58:28 +0200
Message-Id: <20180427135657.242749826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908197509621778?=
X-GMAIL-MSGID: =?utf-8?q?1598908197509621778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -846,6 +846,9 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
+	if (IS_ENABLED(CONFIG_EXPOLINE_AUTO))
+		nospec_auto_detect();
+
 	parse_early_param();
 	os_info_init();
 	setup_ipl();
