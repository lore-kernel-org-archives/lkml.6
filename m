Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqXY2j5HHQoSziOw0QfPotK7wnVrZsyOy68qNDLtirImg5STaFuy0j2HcMjVfiyX6fK2Mth
ARC-Seal: i=1; a=rsa-sha256; t=1526280657; cv=none;
        d=google.com; s=arc-20160816;
        b=tClKXAPV0pF5xzv8Ht+xQ/aUiV7h3+3zfvG+GL5aY15NvY/0tk32WJeWRyX3tvZlO7
         0ZxvrIzGrfhCVELQIn3vAbVrzsV4U8KRBLvvtJaVsAUzMs6zfLnfGFSmPg0v+IHzeLKX
         BsjWxZ0BP7+Y8MXF38eqn0ZY29LjXE2TcZa1BskK625tN5lKV028sS1ETXbDdrncMleP
         MbwkYF5gs1O66WYKWIlnvMDFS6QkBsK726koe4FA8THtOpsZg5VdzkT4abmJx0gj3C9N
         q8rD5VYh8IWZLuXA6JpClGITZ4mz12cbHB+zu+C8YuId126/grUVkb5imxov+bkDW4+8
         /btA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=83Y9ydHjnxKB9iBC8QmQvIARedJJeo/+yFLH2kVbKvU=;
        b=XIgvo4+1X9r/4aFdW13xobETZ/XQsoLZubaFLyIN1Qs/R+Y/Fgc8ONx4GWQ/wC6uIw
         VJ1a7TuCjDUrVRJRKSlMWD0NLwIPEfrN5tM3KlfFXP5Tlr8p3SJ7rl8VsoXahh3n1Y8R
         yald1MkO8OCeM34cz8f/T0l967Kt1nOniWCGxodSBg+cZI8jZ8EMCZ/y1cZeaOpCiSe/
         ZribJeoueBvHGZJy5ysQZJFPM2DELqLn45S1YObpikBVxO8KCp6lA4ol6jGt2kSLXyQi
         ztXKPzybyvIHVdcvB6QOCO2zrCyXrRkUXjq/8ChOdrCuHOpEAUuJWmdSgm9Xnnej36pd
         0Xrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BIJtmDa7;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BIJtmDa7;
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
Subject: [PATCH 4.4 01/56] perf/core: Fix the perf_cpu_time_max_percent check
Date: Mon, 14 May 2018 08:48:06 +0200
Message-Id: <20180514064755.005449700@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421204769613896?=
X-GMAIL-MSGID: =?utf-8?q?1600421267060338515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -229,7 +229,7 @@ int perf_cpu_time_max_percent_handler(st
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	int ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (ret || !write)
 		return ret;
