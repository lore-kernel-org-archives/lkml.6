Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22424cNNl3hZImvFjKj0vd1nM09bWqm5lsNuNPj2xd/IZEa40KJoWm7czxnHdT1j78Ze/JTP
ARC-Seal: i=1; a=rsa-sha256; t=1517855016; cv=none;
        d=google.com; s=arc-20160816;
        b=b2PSRHiftqQG4ywhJiBFD5zyUpohdbCY2WZsP0Hrp/0cyeq3u9E4Pfo9tAzRkINlDA
         QrKK1zOC+jKGe5fEJHh29vyEw6rTVlpNnL8MD3eLALncGzemYgwgEPcb4IIz8RM2C3qA
         lXdSZ4fsrQ/V8eVDbGsXxKrVndBlWumwUExXl9I8FHHJDNk0LWjtR8GlzVwkJwrY6tMY
         u5uaoztYBDyYrtN7XvFmU4rrRKK9ZA1s1KGbPG0AoueWEbB5xFCVcMNHQnJ8s1N5jd5w
         m5T6FvUZzxebsQPS/cPp+Xcj8Q9DpzA1uTawafSpXhBqy692Kyd0guFRiMBuN/byASwN
         NdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DZgHG9AHzSklLQu9yhnWMuvP4o90v7lYl/ljai/ixs0=;
        b=Psr/mKb4EAZ4RVws3a5bcqsvW6+msL/iYlSgEaesR3ytrSwjh3peWzpyqIFb7ZWOUY
         rZlneqk4xx8Q32hlAnAizvP1vsZ+UU6D5TtdECVoWSd4WiIZz2S3Tdm0JkA3uLzRzELy
         LhF9n1A4T5pD7xMNl7GDnFFn+1VsSH8W8F7XGxIldEt1fRCQ+1S8aDTMwJVOx3cLxqo4
         qKDIXKiSUthi4aIy3R+4O4O3KLkFOkY1YZWG2h2g3fd9kjE2Yke4tdNBBzX+slkUCkLS
         20hjVnDd7wBRL+vuN5FM14i+6zZ906+FejkkIFwT2gG5YTRlhMBk0a1QyfFIMVxYseki
         A6dw==
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
Subject: [PATCH 4.14 18/64] x86/cpu/bugs: Make retpoline module warning conditional
Date: Mon,  5 Feb 2018 10:22:37 -0800
Message-Id: <20180205182139.309136422@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586341940305144?=
X-GMAIL-MSGID: =?utf-8?q?1591586341940305144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
