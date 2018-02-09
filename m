Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225aKkop8TDmxA1EHi/t3tqheTeD9KbfvV11yPREh46rWPf1NZop95Cf2js6MzUUoJTRuCn3
ARC-Seal: i=1; a=rsa-sha256; t=1518183828; cv=none;
        d=google.com; s=arc-20160816;
        b=n7DfXzWETQ9aXWOlZiMrv/K2U1TmWVO/Bq7b5MPA81dRXG7hII6xG7Pqfb46hRh+tp
         Zwnox0N+3huBu4x43dIMKJZ+h9T8yMEBTxn/1TnSRaJ+REgnExbQgj4roZJAQOkxUban
         4BjrGoljTxCq/GHXbaGzpXlBGQMnj3FMrcMzt6clfdd5HE3DZTkdi7RjuPurUhLW4heF
         Arfhs8iQnUAsqqTTFfNUI6bLdqDfaI8I64Y9x9KutpWNmhOk2GRSGZMsuJ+lxRIv5RWE
         96gUJsnKiqzHM4QQ1wnBVdi+LxAdRWZsnwigU4HWDQsgisdAAQhpgsZvauFgwNlTdpyZ
         mC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E1PDrRwzAO77256DytmxIX5Xh+RamSyGbenrMg/xDtY=;
        b=WQSqwbuWrh55xUX5NZ4iwC8oFLEUn9t0zkBxS/2iLvFx3j59LJzlTvUnwIq6g+xtU3
         N917HgnFSndd2mAyIh/wbjS9BB3snrBcjoo/2WL3a2lVkhvU8z1QWAlKxkQEh0yXSQ8+
         7OM56PsKMWgcWZJ0FD6EGwIKr29lk0FnfAWisqxYkZuvzvC6uMXC1cdJKbTn3i9VxOvS
         8XX/ilMrOdX6aSzPmhQvhoYp7iTxUVFhE5I8hcA/rH0u51WKHAX1YuQcfsc/zLMKWkZn
         5z7z8gHAk4z/sdFeiprxJqZas1McsVPrwPgmtfVCOMPEzWKXdtvFqM1vtl8ROsSoEne6
         VD8g==
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
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 49/92] x86/cpu/bugs: Make retpoline module warning conditional
Date: Fri,  9 Feb 2018 14:39:18 +0100
Message-Id: <20180209133934.719982801@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931126455801253?=
X-GMAIL-MSGID: =?utf-8?q?1591931126455801253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -93,9 +93,10 @@ static const char *spectre_v2_strings[]
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
-static bool spectre_v2_bad_module;
 
 #ifdef RETPOLINE
+static bool spectre_v2_bad_module;
+
 bool retpoline_module_ok(bool has_retpoline)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
@@ -105,6 +106,13 @@ bool retpoline_module_ok(bool has_retpol
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
@@ -299,7 +307,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IPBP" : "",
-		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
+		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IBPB" : "",
+		       spectre_v2_module_string());
 }
 #endif
