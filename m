Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuS/lUamEu0rZK5R4Nai6adtdA9r+2iJscMzqGI6drN9YgoJksrFEhu4rW5tgau1OWi3F/6
ARC-Seal: i=1; a=rsa-sha256; t=1520824087; cv=none;
        d=google.com; s=arc-20160816;
        b=mNerrXZXgaJM1b3ig4wvnTtRBjTXpdYdDN51DXKMEfZ9foxWa7a6Mtsv/3w6YBc4DY
         vnOKeWkHZeQFDNvYtr6xyB5b2lyCqUkUF9+42TlUnIv802ILoweXV+LsHr+e8tuHU0gD
         KfvmkDXbH7YBLjZRuwdLeVx/jt5g2MmgccHXlN9oCPf+iQRXzHExpd+YWKrCrnztztg5
         iQd4R7e7zgztwpXKHuKdNq67JxIORZ0eEH5tKx7luCxOI5cEW4LruHrxnziNuvtk8vc+
         VCX4hrcvoUoDZE/SBpAYJCrMq6gx/Od/2OWvTA/JUjtIIQlPpNoDAP5mWv8VPu38B6+6
         1+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=WOU2Eu8ThDJSyeLxONYjN+mn7fX5nSQDZraMU8i2Vf8=;
        b=SMKlRohXHqmmY5n0HM9EjhsgtXEL6OtD1CTFF+8Yi6PCbSatlf4WXfmhonLkZAbesQ
         4KUX2U3LR1yo11E/tWYDdhFepFzlmDzZ0+MZNum6WY7lxabcbRkz8t/CwqqqpcNnObY3
         leEMB2bGM4Wysv+U8NAdFjZ9I5Srhl3s3YvAGo7N54lztT0PaO8tIcfWUWsP84zf9p2j
         SLo6rGy60fGS7U8Vvei39HoV0M5jE/vCHXdrr8iKglveAAeLBS0VZtzzBPpLkVKJtE3I
         CZLSQShBzL4/Db8xrVTBVw0lu5mxKhqvQ9IHTPTeZ9Pz8JTAjZB0eAOdL5Yeb5itNZFp
         JO4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, karahmed@amazon.de, ak@linux.intel.com,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 peterz@infradead.org, torvalds@linux-foundation.org, bp@alien8.de,
 dave.hansen@intel.com, tim.c.chen@linux.intel.com, arjan@linux.intel.com,
 pbonzini@redhat.com, gregkh@linux-foundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.529333574@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 096/104] x86/cpufeatures: Clean up Spectre v2 related
 CPUID flags
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699637551098715?=
X-GMAIL-MSGID: =?utf-8?q?1594699638139339506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2 upstream.

We want to expose the hardware features simply in /proc/cpuinfo as "ibrs",
"ibpb" and "stibp". Since AMD has separate CPUID bits for those, use them
as the user-visible bits.

When the Intel SPEC_CTRL bit is set which indicates both IBRS and IBPB
capability, set those (AMD) bits accordingly. Likewise if the Intel STIBP
bit is set, set the AMD STIBP that's used for the generic hardware
capability.

Hide the rest from /proc/cpuinfo by putting "" in the comments. Including
RETPOLINE and RETPOLINE_AMD which shouldn't be visible there. There are
patches to make the sysfs vulnerabilities information non-readable by
non-root, and the same should apply to all information about which
mitigations are actually in use. Those *shouldn't* appear in /proc/cpuinfo.

The feature bit for whether IBPB is actually used, which is needed for
ALTERNATIVEs, is renamed to X86_FEATURE_USE_IBPB.

Originally-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517070274-12128-2-git-send-email-dwmw@amazon.co.uk
[bwh: For 3.2, just apply the part that hides fake CPU feature bits]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -178,10 +178,10 @@
 #define X86_FEATURE_PTS		(7*32+ 6) /* Intel Package Thermal Status */
 #define X86_FEATURE_DTHERM	(7*32+ 7) /* Digital Thermal Sensor */
 #define X86_FEATURE_INVPCID_SINGLE (7*32+ 8) /* Effectively INVPCID && CR4.PCIDE=1 */
-#define X86_FEATURE_RSB_CTXSW	(7*32+9) /* Fill RSB on context switches */
+#define X86_FEATURE_RSB_CTXSW	(7*32+9) /* "" Fill RSB on context switches */
 
-#define X86_FEATURE_RETPOLINE	(7*32+29) /* Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* AMD Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
 #define X86_FEATURE_KAISER	( 7*32+31) /* "" CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
 
