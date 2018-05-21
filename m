Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqh6whmpWF7hG74qumqiuqThA2gIxMgfm1fyYxfYU0kiX15ERNp8R5OKMPU1H4wklnXh4re
ARC-Seal: i=1; a=rsa-sha256; t=1526937913; cv=none;
        d=google.com; s=arc-20160816;
        b=BQ6LUXk9ya1cXH2Ry2p674MH8EzDiyv0Z8uFzNB2rXu7UIW71+70G7ScEnBa7w1VTL
         e7jZVWJwPmtMU+w9+QaYCSVevPXKSQeRXtQchfXl89zPcxSLVDLCx8ReeB0u4Fo294wW
         XKKzJlrydM+Yo6mfTPI3Ma1ueg7awquRWyI24LTcCAh+Sc//Oecgs6SYO3Kppo/b42U5
         pLcWaIKwPmLcIINYe2L24cfMUeUl43aVHrWUxcjoUb2Y1naAtLGWs4mqNtrHXBhXpDPE
         xyVLpcpT+8IfQhaPhiOYTHEdN2MEutpXuh7txGz3MjxIrwDEVD5lsPw+wh4D3gW1Phq0
         DaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SFZ72aKgdLEFVjnlEWyx3VYdg9ROgRJOwewNUsZ9u2E=;
        b=Ol7Mfg1GiWr+uxoC6jFQ1NmNZ807PXkhHWOEXLY+6oPVu8lbiqh0DyfQ8H0h0zjK1H
         9RRSQKYOy2lwD6j7/NuT7iJ4hBGeHFmGyAPIPox/hXfZyXC8jjrMMkZmxBiuCSR1Ug3M
         QhRDhVg4jSHaFSG8a47uf6YQL+8/0BSvwhThNZgFWGDVP/QdweyBeIynN/u7o6P6rav/
         Lm9qkGbY6v5ww3jzXiK+aXgQTwoYxtz7UGDxNzbOPFjeamMQFJ56o8eUkQ8VyJaAFKaz
         +juvmnKI0Tzd0utc/GTKKdcxojC+rTaEPJPl4S5ACM1pwN0k26fN5zPmbLBVc2TiRdiG
         yfdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a4ut+8qi;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a4ut+8qi;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 064/110] x86/bugs: Concentrate bug reporting into a separate function
Date: Mon, 21 May 2018 23:12:01 +0200
Message-Id: <20180521210511.863181479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109827159806887?=
X-GMAIL-MSGID: =?utf-8?q?1601110449731597707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   46 +++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -314,30 +314,48 @@ retpoline_auto:
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
-	if (boot_cpu_has(X86_FEATURE_PTI))
-		return sprintf(buf, "Mitigation: PTI\n");
+
+	switch (bug) {
+	case X86_BUG_CPU_MELTDOWN:
+		if (boot_cpu_has(X86_FEATURE_PTI))
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
