Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq6VD7FuTg/cNobiY3PzkGXOjRok+86adJoTrl4tAT6tBzqIfu/FReSaKdDm6mZptDp9kDm
ARC-Seal: i=1; a=rsa-sha256; t=1527156072; cv=none;
        d=google.com; s=arc-20160816;
        b=fpdny4r+s5xociP0r3L7fRZoXgOPBq6g1CNXKI4Wwcvi8A4JjbPJaSNvyxaxFO6F8U
         1chOwCUjiuVwK7eSuO8G08xO2K6i8o1Gmblz/M4ff7nyrd7/UJ0td131YmDx5ThXAa8g
         Bhe2neJgaYYDwbeJaaEc6qmOz5YHB2Mmmu2pgTGNpK1M3Hk0yXIVP+onWz5fgvxtDY8+
         yYdDgtvOKKasf0UGoxAcGJHH0X78sqe8kBJvWPbdADEiaU5WTruLfGtY4g4vN7ZmrI5b
         ExxVHp3tg917Q5E7K6VH8fIaThLoWi+/5EhL33vNjVNfPbK+SH+iyrIR3yRJgStb1Nwl
         S/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=x8g4AXx81xef/7suzxuvRwJjoVYD9/hCKF8YXQ7Fs4M=;
        b=cD5POAWUCNZFOYuPsKecD0yTlLgauQTR4z8vZlkR5UxwQ1BYThDTAo2kf1m1pqW4gE
         Q8lPkEjXQ8bAIKybfMWE3TMMQwGOE4RurBqCOWZBICZnq5dBShJWW4etIuxfY54h2y2D
         sLUuIiXyWjpCdJo4861TKxr0fyFPxQCqdu3YWHwFpkRgbIByJdR/YitfIz+WUhaerGmH
         3ckd5kCDzzKgrpJGXDuDFIrxsEJ+2S8hHMvTvP/OqSuT83LqvCeYzBhiG1+NmyF4d+Xv
         8c55pGt/AH9LfgyGiZFRo/0caHpZmVZ+l4JwSpUG7njX9sgUTYBgB0g5eY+li33M8PNB
         rTyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xoCQHjfH;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xoCQHjfH;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 052/161] s390: add sysfs attributes for spectre
Date: Thu, 24 May 2018 11:37:57 +0200
Message-Id: <20180524093024.685628974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339205287555710?=
X-GMAIL-MSGID: =?utf-8?q?1601339205287555710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -120,6 +120,7 @@ config S390
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
 #include <asm/nospec-branch.h>
 
 static int __init nobp_setup_early(char *str)
@@ -42,6 +43,24 @@ static int __init nospec_report(void)
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
