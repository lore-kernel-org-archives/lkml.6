Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrindpgkjWVhcJS16kAZeSA0FWNO9GSzubaauQdywn8j6k8FV7KBC5pNDz5KxWp07B7AmbU
ARC-Seal: i=1; a=rsa-sha256; t=1524837864; cv=none;
        d=google.com; s=arc-20160816;
        b=Khw5kxXPPstNf4yu1ODZcS6pE2rx1E2hhjfLgTCh0BT2n4cUrgISqubA6o6BzQX/kZ
         RWbK8yFn9nDwmB3xB+9zKS8iAJRTpMmW+0Qkq/nH4i1qg0k8vt88dxudlIOfWOCh7Se0
         hvBX2u/NrH/WAj7lVGG6X3jcFQvsk2ZJBCzFqOTx1KXWcyOvSwsCiui6AsNITDHMaAXb
         mXCBL9k0lgTkx1tx8V6aJteIY1dbIRVMizAH1Cr28sQ10sj7/y0UWB0ywqNjJW0JY1Ws
         g/ihE4J5oErkL1exaxj3LhQzR1Z8cIJ3JOccrS8Ohg5RKsNcADryRKT/ov7FG3q8D4OH
         GS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YWP5TC4hPzNbgvsjUHGz3fZWR9mENsIjRLe1yseZaa0=;
        b=e0eG9EbY+p2Z/LpypfCjW9dn8fQ0e8FmNNkbRw73S1ucNudbAGRgFJ9Z/6+M3vAqqA
         +ztInzP3LexQW+2mG84skFdLAOXvcKYPs/CKJ9iLVAJtGDHbHT5SIL4b0p72vwNEq36x
         ZGU7Of9GV9FaLPooU2LwxRO3bApc1ydZ8qlVEF4dF8VU7iZOVyUNsAAKg+fiOIHGFmSp
         BZVmanCFda/8ymFe9UOPlRZFxts2DN+NrDzU36AiR/b+8fEux54Y4WJFtTNlqYHofDDp
         fZLE9ctq2cUoDh+55l0Laf8xXEI/+N8cSM5gEPSX55cUKO+nPbH1ZjAnBSZtcyix/DFE
         weGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084912189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 44/74] s390: add sysfs attributes for spectre
Date: Fri, 27 Apr 2018 15:58:34 +0200
Message-Id: <20180427135711.750084883@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908192442314071?=
X-GMAIL-MSGID: =?utf-8?q?1598908388134230304?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit d424986f1d6b16079b3231db0314923f4f8deed1 ]

Set CONFIG_GENERIC_CPU_VULNERABILITIES and provide the two functions
cpu_show_spectre_v1 and cpu_show_spectre_v2 to report the spectre
mitigations.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                |    1 +
 arch/s390/kernel/nospec-branch.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -118,6 +118,7 @@ config S390
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES if !SMP
+	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
+#include <linux/device.h>
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 
@@ -43,6 +44,24 @@ static int __init nospec_report(void)
 }
 arch_initcall(nospec_report);
 
+#ifdef CONFIG_SYSFS
+ssize_t cpu_show_spectre_v1(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+		return sprintf(buf, "Mitigation: execute trampolines\n");
+	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
+		return sprintf(buf, "Mitigation: limited branch prediction.\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+#endif
+
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
