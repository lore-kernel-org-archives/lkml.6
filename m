Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226vnY0e9TvcTHLquKmQT+V6Zut6p6PbzDIWEEEjp26uWeT241Aa9x67egI0MA/1vbfCXALk
ARC-Seal: i=1; a=rsa-sha256; t=1517855146; cv=none;
        d=google.com; s=arc-20160816;
        b=Rvsn0TPjVlcoo5O7OWxS+/Yqb2ib1OCI8cG+tpMMTLPdne5MGQNdL/BBgN+hy504qa
         YDZ+gpWyWMV3ug5SxPP3BfOqQOkgdTB8H2sCqU/4P5V8boS9SL7eY1JXP5NUU/8yqpK0
         R/lW8kTymWkHW5jxxExr5XTzT4DA/K/jcBJJ33/9Pa60+J/4skeTCYSgMPBjwQnbSXHT
         gkUGCOOafyTiyPk/MSTdrLHXqssrF7mwcJ4ISuFs8Q/8CjisUMs1xvQrQe6ymviieHSS
         b6yyI6lOXADSDndI8FdO4Gc8TlG339ECSJptZDGpXjoxbjXceNGB+4eFUQ8yH8gfu9YQ
         HrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8uGjGHnBcU6zMqDg8spWzadbsir+dDDwE3ORpkj3JR4=;
        b=ZyfEUlbGPPIwHhRDPpgLOkjHP/u1RAttKSSb9d4TlkjlnehMwjz8w+/zsRqdze+5/1
         XLmlSs0YeyEupjPx/LJrB47DU8EktfzI1s2jM/jxr1CFEnt8i+HRYOEWMsCT0rHry0Sq
         +bShA1d/ThQT3CQ7yoOIS11j6fV5FJ1G+XEpgt9DcNIuC6P77IUSjJ7d3oPUpXnXoVCD
         U8sFKMq0mYChRFUKQsn5R/gilbiuxKVDODpO/hmuzEk3oGBWDSShikHiFcaPW4pwIftE
         xu690jgrJkRc7pzCFqEJq1sfz9erQpf+XUH5W+ymqZUcHcOB/Fe1fVmRZd6LsKn/h+X0
         EW+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	torvalds@linux-foundation.org,
	alan@linux.intel.com
Subject: [PATCH 4.15 43/60] x86/spectre: Report get_user mitigation for spectre_v1
Date: Mon,  5 Feb 2018 10:23:16 -0800
Message-Id: <20180205182215.744093198@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586389420695022?=
X-GMAIL-MSGID: =?utf-8?q?1591586478239782838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit edfbae53dab8348fca778531be9f4855d2ca0360

Reflect the presence of get_user(), __get_user(), and 'syscall' protections
in sysfs. The expectation is that new and better tooling will allow the
kernel to grow more usages of array_index_nospec(), for now, only claim
mitigation for __user pointer de-references.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727420158.33451.11658324346540434635.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -297,7 +297,7 @@ ssize_t cpu_show_spectre_v1(struct devic
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Vulnerable\n");
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev,
