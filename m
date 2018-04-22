Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/SUmoKU4zecmhWwFfDJ/1jnCTl19vgKTYTh/mLxTL8aCaK6qnDF86kGNcj/HC0wGFdNZgH
ARC-Seal: i=1; a=rsa-sha256; t=1524406585; cv=none;
        d=google.com; s=arc-20160816;
        b=qH0BQCsFwwiLQ6f3AvyXDWtPHS+cGTSJW5tdMk33d3EP29z2QvasOhabckhtdWKi44
         FFfxBng0TQOb4G7hc0Opj6ltSOFQmga5e4/ncMIpZ8C1E/xDX0JJavb8Qy+TKGNFhopc
         nuuDB8jeTYrF1k+8kw5moLL1QRF2FmYafSFNH0GQlDsMS0/oxfIUq4SeMNMqNJThFK3A
         55DQEJDhip5zkyCDfYekE0BM8rY0SbhBrAwCyA4rPDpwDuUnVa+9+llXARSbZMGDLXzw
         LPILvOHMZ0pkHG+/lhXb1ks9sXCtNCuYyErcbjeWCkLQ3tRWC/PRVdHDUDWlNe5v6zIe
         skUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RUhLSXNPGIWE3r3p7AHGfz7jzVYaf6qwXWTKMdMgC8w=;
        b=c8ISE1BMrijDdzxCzihS8E2sBNoS7f78G45gFqAx2zLpMZpgYHcQMlQW1x75K6hDJR
         +hqaZOawFjs38Pv7VjcRGS0tjjVLPpsKGu/4xgV8HSvONPzMkLDjlMAf4Eq8H8aQ3ES5
         tjtLFkh6sLQbBvHi7bjBQSKrtUU4Numecoae9TRPasy+R71+WIC91RGx6Hv6SkLdM4iG
         AOZodEK6m8t7V5y1OcHChfDXxAaZ8mnwHwwMM/25dQR3n6mJzPI82F0IJo2/c7UWlwYo
         LfOz23GeQX5IJHsXBXra17hJ8fSrNNg9UN+vEVbGXIvUJuFFSQYaEOSMsuDjkgDEoHEP
         a0ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Pekka Enberg <penberg@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	David Rientjes <rientjes@google.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 29/97] mm, slab: reschedule cache_reap() on the same CPU
Date: Sun, 22 Apr 2018 15:53:07 +0200
Message-Id: <20180422135306.823977541@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454810628611405?=
X-GMAIL-MSGID: =?utf-8?q?1598456160092324740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit a9f2a846f0503e7d729f552e3ccfe2279010fe94 upstream.

cache_reap() is initially scheduled in start_cpu_timer() via
schedule_delayed_work_on(). But then the next iterations are scheduled
via schedule_delayed_work(), i.e. using WORK_CPU_UNBOUND.

Thus since commit ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND
work on wq_unbound_cpumask CPUs") there is no guarantee the future
iterations will run on the originally intended cpu, although it's still
preferred.  I was able to demonstrate this with
/sys/module/workqueue/parameters/debug_force_rr_cpu.  IIUC, it may also
happen due to migrating timers in nohz context.  As a result, some cpu's
would be calling cache_reap() more frequently and others never.

This patch uses schedule_delayed_work_on() with the current cpu when
scheduling the next iteration.

Link: http://lkml.kernel.org/r/20180411070007.32225-1-vbabka@suse.cz
Fixes: ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Pekka Enberg <penberg@kernel.org>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/slab.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3915,7 +3915,8 @@ next:
 	next_reap_node();
 out:
 	/* Set up the next iteration */
-	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
+	schedule_delayed_work_on(smp_processor_id(), work,
+				round_jiffies_relative(REAPTIMEOUT_AC));
 }
 
 #ifdef CONFIG_SLABINFO
