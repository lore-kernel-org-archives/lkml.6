Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+MErVWWWhMfL5+lptPe/S/WPw45H4oHnoBxxKOrFE1qEM6w5Y3yJSKLfOXf/2Qjd+ZDuBX
ARC-Seal: i=1; a=rsa-sha256; t=1522168224; cv=none;
        d=google.com; s=arc-20160816;
        b=GxEZAIQAO36aGTntzD+0GwQxM1VDS+qio1qTN+/QYlXuXszlhaL+dqtHtZ0mJYreyu
         HwVwqib64Hcbw6MUMqoZJ2NrevA3X448UqcPN8ggjmrmK5v+LdYMlPdsGyVPBAnOIuVE
         bZ3KaU+WxnAI4aGYkLbB2OhMyde8PXR8For5ddatjReyztOU5WyDehIxrmoc3GhA0skH
         RjZLqiIZNsM+MZ2VrRkWuMYLRuThIV/9ffVkSscypXb8CNoqO0NO4Q6FRkU7i5ztmZ0S
         qDXkOuzWG1f1kCXAL8wdBysb/K26lomjNwBgx/UmNZO8ixRhTjM7Jjy1NHG0kg6RBzYA
         44ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KcOw9m5Avfm7oj9UDcWave/xWNSpUpqrOy+VekaR7BM=;
        b=pzmhK/87vutMAnqbNlrE3VchxgDuW7EhdtbNTrN0Ky9BsmaoyrCwpDJ5kqhv1dBLmv
         4W9B3EPrBBiNuCutKtVj01Ss1d4IPoRu99NiReu2UOadXSpJoVcHV91Zh9FY0AC1jPc5
         5RHGhpwyr3DKlrsw+rw69k15LXHx0cw/k3terfjFLeToTS01/ql3PcjwayeSSRBjvldn
         BEbdZqdZ1pe6KQDbBVcg79b0BPshega/dDhbcpEGcXFBb7mJzlmrFPXKSQCwxdVjzKBL
         1ecgbALUrVgeus4QL6iRX9I73agWoNy98YoiPgdhbJ3ZEDG/KsqVYNtB+BrHGkrYl8Ub
         71bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 39/43] perf/x86/intel: Dont accidentally clear high bits in bdw_limit_period()
Date: Tue, 27 Mar 2018 18:27:43 +0200
Message-Id: <20180327162718.599122498@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109068654036273?=
X-GMAIL-MSGID: =?utf-8?q?1596109068654036273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit e5ea9b54a055619160bbfe527ebb7d7191823d66 upstream.

We intended to clear the lowest 6 bits but because of a type bug we
clear the high 32 bits as well.  Andi says that periods are rarely more
than U32_MAX so this bug probably doesn't have a huge runtime impact.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 294fe0f52a44 ("perf/x86/intel: Add INST_RETIRED.ALL workarounds")
Link: http://lkml.kernel.org/r/20180317115216.GB4035@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/perf_event_intel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/perf_event_intel.c
+++ b/arch/x86/kernel/cpu/perf_event_intel.c
@@ -2716,7 +2716,7 @@ static unsigned bdw_limit_period(struct
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
 		if (left < 128)
 			left = 128;
-		left &= ~0x3fu;
+		left &= ~0x3fULL;
 	}
 	return left;
 }
