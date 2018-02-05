Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227IeXSTI2NqkwtptxO2Ggp02GKqSb3ltrFNJ4mrbJXMI774+OexskxbwWl18RoDJ8kOG5ZQ
ARC-Seal: i=1; a=rsa-sha256; t=1517855161; cv=none;
        d=google.com; s=arc-20160816;
        b=bAMt1RlmEf4HMh+Fr9y9afYDnYnNFeF9tCudR4Hhj+oHqr5s1zT3CQZr/q7GGKJ++d
         xFIUVmEQtmwRlst/EPlN0JZk7m+UHOE+fSegK8Ru5yFgtXjX0GzsqukGkUav1QKG9onc
         XBXUVjW15DM+3Bh1fdwKCsnB9khJAr5o8hMoHY750nSmubPvcp3nWxEMgKL+cNPxKj0J
         fEqMYy87p6ZRNTQmaRgNVS3zcSt9PMEOjLJ1o/pahouwoSipPwY/pyC9G3g3mcj8/QIb
         kkxaOs/IgtF2HJWLkVTPcNSTLhbFSIJruc5Tj2nYj7Z9j/xVQxaTorUwqkbSUMsfB4MN
         1MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uIrJrDoQl0SdE60vt6YSRqPxuWWQT7ecOOmVGRWsHLw=;
        b=a6acq0+laRYScCH00xmZ1fBY9V9m2Vv2aFZmJ9U83BMJ5k4kY9f4fUX8yPyhxxPZbO
         Okt4B7rwqPdO12ubOprybzmaaxfNUbEny0sGW4IH2US/Okb+T4LPJzO7g80nITo9CXyF
         C+17+PX6SBfilkSBIX51kxAB6PvBd0/QX9Ire/quLGDNoRoOH0PYmnVoJ/zQdpcvdoJ+
         C+AQG08IEf/6eH3yxLDdPnxfgi/XTXLHDB2O49uKbDYfW3g0/T5Q9d59eqYZ2SeF3Vv2
         32NMktAT28KzI4GV0sJNBQVR28m16e6+gPnLHmarpY8v7OVaJ/zH4KP//Y+blBVRwhCi
         F8IQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andi Kleen <ak@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 4.15 14/60] x86/cpu/bugs: Make retpoline module warning conditional
Date: Mon,  5 Feb 2018 10:22:47 -0800
Message-Id: <20180205182214.511378749@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586341940305144?=
X-GMAIL-MSGID: =?utf-8?q?1591586494569871646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit e383095c7fe8d218e00ec0f83e4b95ed4e627b02

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -94,9 +94,10 @@ static const char *spectre_v2_strings[]
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
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
@@ -300,7 +308,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IPBP" : "",
-		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
+		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IBPB" : "",
+		       spectre_v2_module_string());
 }
 #endif
