Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49MVhtzBQMZgWvJCJNQGAZTk6UbifNaZrZNC6cnKATwtl4K5aAWMXzheYgUML9x9R9YdMHb
ARC-Seal: i=1; a=rsa-sha256; t=1524405846; cv=none;
        d=google.com; s=arc-20160816;
        b=yme2s5RN5f/lm+Zq+diM3plcHBpk70c8zzqZpxwQJNbeGx+003tybeiKG1Vn9wfUGV
         RbI2ZyrfzHv7Cv6Z9xejnW/IRk0lrmLC9WBuM+2rWVqMytwNfQfqinbJ7zg9ODDUMxqC
         n2UhNvHqqaSh+pvhAWEZ3zCqEJf4O+ItYeYbLpuk73YNqILWnwaAtTzK9gMqGqV1CIq0
         rb2DPMSY4BCoNgdaaL++6OyJCVCi2yJ4whMFvkWCcZOgtKR/7Bmcp5MEfe9ohiHsqa+d
         7Qpj5RCVP/WwHV9O+8Pw18BYcePiq/A8d2DAKPDVdmyXuIxr0CnhpoOqG2CdRYbtQnIH
         Js8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=miGI1P0kMCv650DXD4+8BN0CrbGTA1f0Or0vT4U+9g0=;
        b=jCMtXRPYeRhM80Om1juLD7/kksnOAhJJ3yWKTDDy31HRu872d0c+G1X92SzrWJ7Rsr
         9C/Np8xzT+rVD0eu3n+EMWcFQpfe9+p/WrjU54WJi7OxezgN2VvCNd8q1ntHEhklESkQ
         ChhB1Mk7s1hwYr+Wj9cN1d+aZmXjMpzQ4M2uXg5gqfNJ5Y5KGFbcR2KdQm8WzFY5CSJf
         1uUBI37xI58b11Ua/lx9S35CK4jjHyDxx3kpHJj6a917QaHj9rq7MXqlZMggVvg8gqiX
         SOb+xntsFnx9kB6bq35tFr+zjTh7xAXA6H/DkHKiC7AUXjI2suZGiB0M7JymbtSHGWOn
         pCbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	George Cherian <george.cherian@cavium.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 002/164] cpufreq: CPPC: Use transition_delay_us depending transition_latency
Date: Sun, 22 Apr 2018 15:51:09 +0200
Message-Id: <20180422135135.501274430@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454793510382547?=
X-GMAIL-MSGID: =?utf-8?q?1598455384852053712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Cherian <george.cherian@cavium.com>

commit 3d41386d556db9f720e00de3e11e45f39cb5071c upstream.

With commit e948bc8fbee0 (cpufreq: Cap the default transition delay
value to 10 ms)  the cpufreq was not honouring the delay passed via
ACPI (PCCT). Due to which on ARM based platforms using CPPC the
cpufreq governor tries to change the frequency of CPUs faster than
expected.

This leads to continuous error messages like the following.
" ACPI CPPC: PCC check channel failed. Status=0 "

Earlier (without above commit) the default transition delay was
taken form the value passed from PCCT. Use the same value provided
by PCCT to set the transition_delay_us.

Fixes: e948bc8fbee0 (cpufreq: Cap the default transition delay value to 10 ms)
Signed-off-by: George Cherian <george.cherian@cavium.com>
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cppc_cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -20,6 +20,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
+#include <linux/time.h>
 #include <linux/vmalloc.h>
 
 #include <asm/unaligned.h>
@@ -162,6 +163,8 @@ static int cppc_cpufreq_cpu_init(struct
 	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
 
 	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
+	policy->transition_delay_us = cppc_get_transition_latency(cpu_num) /
+		NSEC_PER_USEC;
 	policy->shared_type = cpu->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
