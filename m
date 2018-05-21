Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo4lZNwqds2RHQXGIZmHr5Hb1qA2aK8qzaV8Jdwz4zR44hMOe8xodfAosf+6vSUJIIL3sFV
ARC-Seal: i=1; a=rsa-sha256; t=1526937589; cv=none;
        d=google.com; s=arc-20160816;
        b=bhHayLI/rfrNJkyms8Tf2SdiklgGbW9YtF2Gpu5gCiGTlv0sA6dixqGmrys99+sliM
         4q96Snk6uro7pZbgGZonpQWidHytPZnHHcaWpZON4blztDtfEfI/dbv5BgYLJVZRrTDE
         mc6s/TZ7EY/TpsjwPoS5rXkhoQ9IyryMf53/HZWCrSieDv0UoQW4mzOTr2jXMLDoi37i
         NoAHEBLXEi0ZRvwX/atChfVwlv49VW0yzr1kx9IvJ/Idf2euevNcpTHEaRPXlOB/AuV9
         28c4/1pHhBl7URxiog/7HBaDGod4dQrCAejgF/L56/h5a0okXkeeCe3Nm6iMm9RAf4fj
         a4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DaajS0mELmu0vOGJl7Js1cAsmKvoVaUnUMfofWQBPv0=;
        b=zrSJ1U4gwNT/60bdmL+jkHvyrlIGREyKOhhFZKeizN9XdP3/lUa4xTLTb+BeHzKKes
         fOMlByxyuoMIcqJwNqEMGQEUXAHycPP+SfadvTHLnUpdBrMCcsUWe/ZXTeXJnlX9BqqT
         z2QylyTFsdE40lbDavW8jZPIPzgZW5V8mFvvYW0rkMPi6fNCwPVqQ/HCBuyc2/S8Q7wy
         cm6jhky97K1152OHdQ+tsbjDBDjxnMGiKZfGcWlg2Srgt26KOx9d2Yqk657LlCVBJq+H
         W+Gj0+1sHAACdIUr4jmf/dySdQh36qQ9gX/pueFHcBeEGglABEoa9n6XwzqdmyRFlmUD
         ozAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tI0H3qXL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tI0H3qXL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 50/95] x86/bugs: Concentrate bug reporting into a separate function
Date: Mon, 21 May 2018 23:11:40 +0200
Message-Id: <20180521210457.884316039@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109827159806887?=
X-GMAIL-MSGID: =?utf-8?q?1601110110570084522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
