Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49durea8hGFixiXS3NPDT1Es/M7IAIyT11y2lckqZ3WDKSekvbcmemZC6Q7g2pyqNLWp1ee
ARC-Seal: i=1; a=rsa-sha256; t=1523473488; cv=none;
        d=google.com; s=arc-20160816;
        b=F+CV4yqaIx61KxZ9FN0D6EKNvSfbFcQZsGRiEs7r5dAHvZeeOp3xRtmLOQ0M38OBh/
         j7PbJtKfa23N/5nA/h/hPSIKpa13t7LW6sJ36Gts/KPu3I5Li8zi6gV/+tnR5M0mFDIg
         Avn6YREGxydbvy1beTby1Y1aAVbwLBXrkfQwYZtEqhcIz3FE+OwgjUsowdxD7zwDXig3
         U4RRFHtpvyyHkY5vRQcFLggtuyIQjvfaGgSKwvzegGtZLc0rc0ROILr3SrkMo8dnFcEI
         9vFOhzzgkN4kigSagCOaFPJeKE42qr2fjl4B7IKji9vCxsMh58UqUhrmYaD55QIKWHRj
         1rHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=POKcc4qeYNfBSH0DwfKJaxkMjhXJfbO6CMJI0oHMoks=;
        b=1I+f5uZ5Vuh95U8FoAkEExUsSA5cjHmSwrJpIjvyXSTWAte+LvXotdsJO3XjcNHyZI
         QObv/s4r/+CgScv+evLCgJaVfK78uA6bxoLUL9T7FOqNqOIwB6orN4V4zk+5fdN9znJy
         KAerkxNDG2fAdAEKLxshuLx+bxKIOQ0mVWp9qusFUyQcQZWoiwi8gI2yXVbseGOVoFn6
         tV6IouMjEflRHjA/kieh3nigGcL3a+XndmdTTyOOl9EgZ+xOYooOBY2/7KFX/2JDSOHu
         n1cQ1i1RAW+sZdo9tRc+F7cwBuj6koNMl6/OEtQ7IekgSOOUFuyfulwDjovyD14e3AM7
         HAMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dana Myers <dana.myers@oracle.com>,
	Lv Zheng <lv.zheng@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 249/310] ACPICA: OSL: Add support to exclude stdarg.h
Date: Wed, 11 Apr 2018 20:36:28 +0200
Message-Id: <20180411183633.163823212@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477736655936100?=
X-GMAIL-MSGID: =?utf-8?q?1597477736655936100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lv Zheng <lv.zheng@intel.com>


[ Upstream commit 84676b87b27d8aefafb9f712a5b444938f284513 ]

ACPICA commit e2df7455a9a4301b03668e4c9c02c7a564cc841c

Some hosts may choose not to include stdarg.h, implementing a
configurability in acgcc.h, allowing OSen like Solaris to exclude stdarg.h.
This patch also fixes acintel.h accordingly without providing builtin
support as Intel compiler is similar as GCC. Reported by Dana Myers, fixed
by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/e2df7455
Reported-by: Dana Myers <dana.myers@oracle.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/acpi/platform/acgcc.h   |   10 ++++++++++
 include/acpi/platform/acintel.h |    2 ++
 2 files changed, 12 insertions(+)

--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -48,7 +48,17 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
+#ifdef ACPI_USE_BUILTIN_STDARG
+typedef __builtin_va_list va_list;
+#define va_start(v, l)          __builtin_va_start(v, l)
+#define va_end(v)               __builtin_va_end(v)
+#define va_arg(v, l)            __builtin_va_arg(v, l)
+#define va_copy(d, s)           __builtin_va_copy(d, s)
+#else
 #include <stdarg.h>
+#endif
+#endif
 
 #define ACPI_INLINE             __inline__
 
--- a/include/acpi/platform/acintel.h
+++ b/include/acpi/platform/acintel.h
@@ -48,7 +48,9 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
 #include <stdarg.h>
+#endif
 
 /* Configuration specific to Intel 64-bit C compiler */
 
