Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoSAJEEyI3Vjul+W8p65hbpQBKSYN5rGRCUT2R2OSK2CQcnVFsofJxXWZQwplbaG1xMrzVj
ARC-Seal: i=1; a=rsa-sha256; t=1526281789; cv=none;
        d=google.com; s=arc-20160816;
        b=nd08BkHiEceQmu7NjI3A0E5P3vr1hbchKPWoyPshwunNhJHYlt9w9a0XsILyqV/+tC
         ZIXedEZnlpfITNdVHQexYrb/lL0n9HI9cWcdWztNNA4gKQxaBhl/JngSM85iH+0LIaq0
         nFFgReaOhrLxIW0IPE6cmXip+qL5Ze0eKb7w6rOXVC44B/WadDBvU+TU9q2n2KNixzM4
         DouvpwqwSnKDInlyOqEnLHr8KscZ4t/1UFX70rMkSXZDhilMzJEiVdlYPjmDIK0gFuTn
         ty/939MH26W7HuKS+gv2Qqg4g6s1nBdqgB6Tkrg/XZwfk0EQnESPzcSJO6ZdyXDQgUoV
         eyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wQjdLxh5vzNVM8A6Cdw3elGjXn5b+pt57ghHJ/KFsZ8=;
        b=R1lyB4WP27bAGdaY9hVIVhacq4HPolw9GCaugYSnR9E3vqU6j7bsU19fs9b2NA9toy
         By1t4pEjTnAgVaaQm80k/JkbXSaQuxXnGKX5FRN4vbUlJoNQc6L1+MBxYhjMrXPbiNaq
         KPJlMHn9S3GMtpIjfzSvdudusi/1Kr7pxudP/Ns/uHf11hsheg1BVOsqaxmN71f8NA2L
         GQf7nPd2YUKPfluoq93VUB738tsVNDqT/NS8mY+YQIQlWT5UVYDylvgBBnzei273gPaM
         C3r1F0UwAYiBlXi7PDWkh9nvtN3ZytJhWdJJcyKA80pjyCodyRGTDLEBf45Fc2B5tveA
         UjpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eFz9xPoY;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eFz9xPoY;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 52/56] perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*
Date: Mon, 14 May 2018 08:48:57 +0200
Message-Id: <20180514064759.650482524@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422453930408065?=
X-GMAIL-MSGID: =?utf-8?q?1600422453930408065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit ef9ee4ad38445a30909c48998624861716f2a994 upstream.

> arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids[cache_type]' (local cap)
> arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids' (local cap)
> arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs[cache_type]' (local cap)
> arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs' (local cap)

Userspace controls @config which contains 3 (byte) fields used for a 3
dimensional array deref.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/perf_event.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -297,17 +297,20 @@ set_ext_hw_attr(struct hw_perf_event *hw
 
 	config = attr->config;
 
-	cache_type = (config >>  0) & 0xff;
+	cache_type = (config >> 0) & 0xff;
 	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
 		return -EINVAL;
+	cache_type = array_index_nospec(cache_type, PERF_COUNT_HW_CACHE_MAX);
 
 	cache_op = (config >>  8) & 0xff;
 	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
 		return -EINVAL;
+	cache_op = array_index_nospec(cache_op, PERF_COUNT_HW_CACHE_OP_MAX);
 
 	cache_result = (config >> 16) & 0xff;
 	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
+	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
 	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
 
