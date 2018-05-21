Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpHmDaTJLn4sgZCUrh4NyH+IhF1lyfx1vDkxwhI2XjWZkuxbv9BdnT3KtvnD0CX1PeQHLGY
ARC-Seal: i=1; a=rsa-sha256; t=1526937319; cv=none;
        d=google.com; s=arc-20160816;
        b=n3ICz2jcvhRck1SCPYnsFe1yobZRv4/hmJAscWehQjV2tamJRA+6hVk17eMdSi/Qrc
         uEVPYxBSWLXuADS5zSQ0N+8DdanLvop796YxPN1CinHvQEf8QJ8RsY7s78+WJ8CHNzsW
         cm/GChS+AMoZ8KjwezCfftiefMlwIuW3lCDosUJ0qXvlbXG1qXg3FeGM6skPEqwchGtp
         dwZ0pgsaRjDsD9T58i8ew0BklJDWG+Ql7xaK21B4TReo8HYkSKVrd+6Ocnd48jVLcULC
         nRlm6oPChoa6jbIlOOn4hAFEmHuRO4UT0cgW7UDmfzJc0DjSQrBOQ7BLPX5SDbFzufiK
         CpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iaYfZ/cN4Hku5ZBNV407tojDshTRTZIqLqYMaGFmCoQ=;
        b=lSuR/GjVGVIKylWV2HR9VMnv+pogE/rfFDNvn4MifU333vZXUGPfuDZf7F+952ucNL
         9mk+sgSZ6Us3bBfYGbF1th25yTtwomB7K1TzDyJojqp0YYxsaLcWURRcfe/z0Cfd+o/r
         CmMoiq3EZ4q8GFicN/uopf8U3uTgeDSIBvTiYZw11IOunTx/ABhRnlIt1oi/RNmhB8h0
         MddNhH+5uhgxpy9ac8UCfTKAIEgq35aW+ODbBbZpMtitYmP0u52AKTwqNx7eZNaxxptA
         n/bjEb5as4VxKKIZGOZhzfZzlNYUm1BxQvY4lKQ2xMTL4EC6k6obF9lEuUk7jLiCD5VP
         86+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=y+nkWHl5;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=y+nkWHl5;
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
Subject: [PATCH 4.9 38/87] x86/bugs: Concentrate bug reporting into a separate function
Date: Mon, 21 May 2018 23:11:14 +0200
Message-Id: <20180521210424.062581092@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109827159806887?=
X-GMAIL-MSGID: =?utf-8?q?1601109827159806887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit d1059518b4789cabe34bb4b714d07e6089c82ca1 upstream

Those SysFS functions have a similar preamble, as such make common
code to handle them.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   46 +++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -313,30 +313,48 @@ retpoline_auto:
 #undef pr_fmt
 
 #ifdef CONFIG_SYSFS
-ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+
+ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
+			char *buf, unsigned int bug)
 {
-	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+	if (!boot_cpu_has_bug(bug))
 		return sprintf(buf, "Not affected\n");
-	if (boot_cpu_has(X86_FEATURE_KAISER))
-		return sprintf(buf, "Mitigation: PTI\n");
+
+	switch (bug) {
+	case X86_BUG_CPU_MELTDOWN:
+		if (boot_cpu_has(X86_FEATURE_KAISER))
+			return sprintf(buf, "Mitigation: PTI\n");
+
+		break;
+
+	case X86_BUG_SPECTRE_V1:
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+
+	case X86_BUG_SPECTRE_V2:
+		return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+			       spectre_v2_module_string());
+
+	default:
+		break;
+	}
+
 	return sprintf(buf, "Vulnerable\n");
 }
 
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_CPU_MELTDOWN);
+}
+
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
-		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+	return cpu_show_common(dev, attr, buf, X86_BUG_SPECTRE_V1);
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		return sprintf(buf, "Not affected\n");
-
-	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
-		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
-		       spectre_v2_module_string());
+	return cpu_show_common(dev, attr, buf, X86_BUG_SPECTRE_V2);
 }
 #endif
