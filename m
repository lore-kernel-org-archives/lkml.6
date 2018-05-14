Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoSvRGCjCGHjo7bHa4WTmgz/tLeAf1in5kw1vJRW7UCafoUTDVqeuTsY/+jPsDwlCiJuN+Q
ARC-Seal: i=1; a=rsa-sha256; t=1526280598; cv=none;
        d=google.com; s=arc-20160816;
        b=q+W6gH6IBO7Nsx+9RtT7jPkVg8SMJ/eOoJQFgUMZHDe3lr5EgOxLbPkOwA2ocPjuzm
         hHKdaTbEWWGYd1ZkOFP8V1OOHMLeNcomEmqtCZXp06hZ2T7WgYv6ECusDEdsX4mVBDtB
         E4Y8bh5KXdu1psR1M8Tl0RlsCEfVZny87lL4qtwSdIpAx6JaFORaR34VW7DOlyFinJ+I
         zImjQC3MVWsYNZe0wyRyor0Wm/UA4cqQql/ryGvhKxw7iWf2d+34LSB+WXVWAsqdmoCF
         JdDvCK8M/6ZZujJQYATCXCZmXNspQjI+sHWltu9oxCw63J8ztzgCzcguBry+j6QXppda
         dbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hG4yVooZ5qjJuAhMWOvbL/bQEvJcGn4+nXJcc8wQkp0=;
        b=au0u1dBPWAeFPB/k0Y+7NkrGm1dj+Ww5ti+2GmHA7eejX6MjVTvu3qXsafkFAmDiYV
         vEQuqEPrcLpm5GZcc4z0Q7cLbRjc4irY5ZDHr1LZ4IFmHifjwnLLINso2qT9LGWCXsW0
         yly8KRtzyZaJwMQRAQU55v4RgvPvr08QYDG5RC0jkppB+r/WpgNiOrqFaW28I85FJU8p
         jitH2OrKJ3lj2QHvVJH0SibC1AFLblzc5dbxlMZP28oUBHjrmg6hX9AjUjfFZLon+KhQ
         8OApLV/7GEjmpmvxSjn1HNJ7hti5KX2eq7UlpdIwLtYRWUgcGt61b2RKZU2FAcVk4lwZ
         ydzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oIRatP78;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oIRatP78;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
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
Subject: [PATCH 3.18 02/23] perf/core: Fix the perf_cpu_time_max_percent check
Date: Mon, 14 May 2018 08:48:31 +0200
Message-Id: <20180514064704.147242899@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421204769613896?=
X-GMAIL-MSGID: =?utf-8?q?1600421204769613896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -224,7 +224,7 @@ int perf_cpu_time_max_percent_handler(st
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	int ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (ret || !write)
 		return ret;
