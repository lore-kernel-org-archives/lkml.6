Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp0JpW0YiFCyXyS6Lh+/ffVyyQbpM9Oe3HOou85UNP4Bh4x/OWiKX5+En7cAwnRIYn9DqiH
ARC-Seal: i=1; a=rsa-sha256; t=1525767389; cv=none;
        d=google.com; s=arc-20160816;
        b=HYVKDWJvW567Sgl40FYOtGIWcN46IlEoA38F1cU1R3kLM9i+96i8S1PsWNpFTCiQr0
         2yFc2sIqLPWcmU4Jn/bJd1v8kx70QBTX285XQcZhn4I9UkefSuq4ThKBXZFguca71fIp
         v1ciJnscETWoC8F+9173d087e0ZmpyVsN1CCjlR0RO3Dvxpmv9rMtrglXf+dwcxwwrIV
         nd0TfyyvQ6BLUSZl7f9vXDGDudxSUZGrGfakGAmHkV4PktCq7SuV2SVyOt+VlOyAmdyv
         X87u3zHkoeU7GRYGiJ9kdcPUu6hXvYtXq0tIvb807Vi0YVmwQ6RF6uAH/6p5hE2CaTT3
         kRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Zye6yCXVYjKL2rKkiNon37tj4I9TtkLuiJTRA/Txo88=;
        b=nhF5eSu4csjBT+7sh8fw3jshvAL3IQBBIVQLjH2BPPmhVM58grZWdPmCTifnQ6FJ9Q
         qf1GBSDqztyZYVBt9bU5J+p++3sXeMFTf2Es2l/FOtI2X8ZSvr3776yD11Sm9akGlAlD
         /lxP/j9HEqiOUzMVQ1mmzO+0xcFsMQlsgHN6ZMo3u4UccfZa49WNG5ENpIgm2ETbwJqx
         DMS6J5eseOvKTSjZc3yqqcvjgL6m5HLEJTLt9q1PwOcL/werO6FDMHFLbL9wLOxAGH+h
         pzwRCSDlhJ0rHIMEmBgYk0WOXP0XOPMbpV9Cc8N+7PeC4E+HVH9oDZveQdSLQMOzzhLD
         RLzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Y3ZzoRAa;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Y3ZzoRAa;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tan Xiaojun <tanxiaojun@huawei.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 01/32] perf/core: Fix the perf_cpu_time_max_percent check
Date: Tue,  8 May 2018 10:10:41 +0200
Message-Id: <20180508074008.969914166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599883065708177813?=
X-GMAIL-MSGID: =?utf-8?q?1599883065708177813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tan Xiaojun <tanxiaojun@huawei.com>

commit 1572e45a924f254d9570093abde46430c3172e3d upstream.

Use "proc_dointvec_minmax" instead of "proc_dointvec" to check the input
value from user-space.

If not, we can set a big value and some vars will overflow like
"sysctl_perf_event_sample_rate" which will cause a lot of unexpected
problems.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <acme@kernel.org>
Cc: <alexander.shishkin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/1487829879-56237-1-git-send-email-tanxiaojun@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -453,7 +453,7 @@ int perf_cpu_time_max_percent_handler(st
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	int ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (ret || !write)
 		return ret;
