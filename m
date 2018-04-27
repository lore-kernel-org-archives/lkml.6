Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrae5iMTkSNG6c5T1kHZWVSzEtZEeZ4ce6bunCGR2BvF9gnJUsIyTslCW32zMC3radG/iaD
ARC-Seal: i=1; a=rsa-sha256; t=1524837677; cv=none;
        d=google.com; s=arc-20160816;
        b=VVzTK2ot4NoEW48sXkF9XvrfQJgUDTzvjDGP6xYAJMMa+1EJkPN0tDTDKQ2Jmygf98
         5RMT1Xkj2y9pyWg/gLHMs8wJy1MFBJ7inCXlneTmH15lRGO+S36Pcy8sosmFhIegznMo
         Q1Br+4m3ZCHWZcDV+AzqSBAIWjuAnrX5nclwGPGBihsI/dJfaodroeHTAT9PVHfKH3ZG
         vPV75pCNN/rynaF8sIxY9Y0HPDBkCEoN+v0v7zCIlUbLZOTjdKLeC3b9bbth7C1Wx+iH
         5gc1F3jsFI85G6UNB+7e9mVj0PaxAFrqU5piDsP3FFfUWypOJMDuz850XgyMRQfgJhZX
         kreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=nmw+1LB6lUVxdhEvHUHuwAWWEcU1+nskEvEc95nYkks=;
        b=YkzKUpFnGGmazuu+6vtqtDe0NnxE5BFQJ103rpu1+CJa5v9wfolHX4y8dn7vvQjI5Q
         nqi2rn6t6BAUPsUZ9TZDjANi05iVKkFFPrJ/aP2mz+5RbBHmhvB9dKMycAQLHykdMAPA
         AgD6d38YYR3+qxiBpLdiLiw/rOcK8LX68osfSokLUZh6s6c5PvnoxtBHR+2RSbaY6G6R
         +gKZotZupfU6GfLUbZUXhOhWQFCwMGbNBrePyF0V53uccZ3qL1ffvKOQLDYH20j3UIk+
         daNIG2tcFEiR56iIJzd0E1DUmL8vDjKbsIGpR1rd6RtdVoKuirLxyFDIgtMUMbCkJzOV
         TkKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F1A2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 25/50] s390: add sysfs attributes for spectre
Date: Fri, 27 Apr 2018 15:58:27 +0200
Message-Id: <20180427135657.196294626@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908192442314071?=
X-GMAIL-MSGID: =?utf-8?q?1598908192442314071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -111,6 +111,7 @@ config S390
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
