Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2256AU3AnveyISMITmkc8+owFK4roL3sDAouYo6bFtvxfRrub1F6ReUVR6wWOXRUm2ujlyiJ
ARC-Seal: i=1; a=rsa-sha256; t=1519411243; cv=none;
        d=google.com; s=arc-20160816;
        b=c1+3h+GvSnIc+2mjr54r1f8yoWAtIT+EYqpgYnCvbagX/sjMTGzrVbKLqorxpp+D5Y
         7mmJtcjBy81Er5++RUgkNQ0fq3xqHF7bOSNDQnyW5wlK3H+c4AqtL/lOaNqvn88A1wVM
         zupv62aqcpIsZhaO0Wgeti49WOFYx/VbfbVJ94uupCUGPkLHNmLf8QMwC4H+EsfVcy+9
         WLJUkeJGbEBwgr4Kg0t+9msdax8crKPHvUOPZZJedIQfUVNIWXkzUMy7zq7usGP1N9ct
         o0dHcYn8UJ7sTTfqCIcersKd3erGw4YW77+PUyM/XxbeoWuy6p81Nhqx5WXZPlZzGWGV
         1Kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DKjP2sTQT1N5DihJTCiZqLjm/gV0WwLfshl2VNsji8A=;
        b=wDj4kiH24gBd632iU0uB87ZUlPGS+5sZNmyfb4UOPjBxgeBNYV7VTNX9UNDgBw/lPG
         lAwPWAHsxByAR39OUmxfJFzo4KyfAoJyRCsx868LEXb+h5xikGtzgD3Kahdj0WihIzg6
         yFo9wjRmcPF13fsa8qDCQYzXweX3dt41IVTSnWLya1eFFlWe/fExuoC1ZueakuJq5NHG
         r8wFMGPPuCKoiExU+OsgJBAiPLuhnJRwoI22ceL6+8V4xY/A/FAURiSEE/M7N/Q3To1S
         4whNlvdbPNbUEtY99YzxiBfUDqGTB587F4uT43+p9e/0+LTYiqaA2d3VkkhLkebrITWj
         p6Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andi Kleen <ak@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 171/193] x86/cpu/bugs: Make retpoline module warning conditional
Date: Fri, 23 Feb 2018 19:26:44 +0100
Message-Id: <20180223170352.817111766@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218164578725000?=
X-GMAIL-MSGID: =?utf-8?q?1593218164578725000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

(cherry picked from commit e383095c7fe8d218e00ec0f83e4b95ed4e627b02)

If sysfs is disabled and RETPOLINE not defined:

arch/x86/kernel/cpu/bugs.c:97:13: warning: ‘spectre_v2_bad_module’ defined but not used
[-Wunused-variable]
 static bool spectre_v2_bad_module;

Hide it.

Fixes: caf7501a1b4e ("module/retpoline: Warn about missing retpoline in module")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -94,9 +94,10 @@ static const char *spectre_v2_strings[]
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
-static bool spectre_v2_bad_module;
 
 #ifdef RETPOLINE
+static bool spectre_v2_bad_module;
+
 bool retpoline_module_ok(bool has_retpoline)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
@@ -106,6 +107,13 @@ bool retpoline_module_ok(bool has_retpol
 	spectre_v2_bad_module = true;
 	return false;
 }
+
+static inline const char *spectre_v2_module_string(void)
+{
+	return spectre_v2_bad_module ? " - vulnerable module loaded" : "";
+}
+#else
+static inline const char *spectre_v2_module_string(void) { return ""; }
 #endif
 
 static void __init spec2_print_if_insecure(const char *reason)
@@ -293,6 +301,6 @@ ssize_t cpu_show_spectre_v2(struct devic
 		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
+		       spectre_v2_module_string());
 }
 #endif
