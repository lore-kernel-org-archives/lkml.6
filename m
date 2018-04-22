Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+x8saDx+9almTWdLF3YP2HN8cFU0OYphZ+u1kgF+MDJaY3eAsnHVcVa4YfYBLZ5gzUQRl8
ARC-Seal: i=1; a=rsa-sha256; t=1524405299; cv=none;
        d=google.com; s=arc-20160816;
        b=q6ELLqDHDr64rQYyZW4i3oPtu3ZtR1Jsl4tEhYK65CzaD4vsJsLNxnNyaCjsjoq/ic
         wj8fTimyVVqYCyS3EN77KPKWqfSFz+CAZtJg9B9vH7HbUboosaJJ1cnO1IHsHZlk1P/H
         4+7sssV1XFPRTfd5rn/W7OFQBwY9uCp37IghID0odw8G5sdKcsvhifch84cBm6nFaL3C
         mEKXnPCaXW4mX6RkUrXAK/ISZkMGfTIOim/X//UP91k48keQQYrIwFG+1qqx158E7Xmb
         TQa/ead5AaYEyNDOpsux728zK33ajE6IehjA6eJEZGR+UYqmXmO6yTxOO3oU3S8XMOQu
         py5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bU4tYXSm6u8Ne9RauScgllt9NDI81SzM7+iL1iHZq3Q=;
        b=0vTjUw0OaFvSrs0xl7y+WCery7yS7mM/w8NjRm7xucznmFbv7DSz89GmkOP01+gDTm
         Q4FPlfHilDnSNeeXZx99FtCc758F5t5TQg59CGep9M8fUUNKNdLAXdw2uB8GSWEOLcfV
         3WNVKxoiPAtgpZOzABAeSaaaLVuvVbV6aIZSdPuhOUJ6AJk+Q87VBvfov1o04JfubJ/Y
         GmXfWEKH5gk8ZHpUkTWWMgmZOtXAjdZcgKeOBI+VCwpnexoB4K+t+KCi4v8C3tVTAKZ9
         dAyslNCa0CGcMnQ+NU3yJZDxS7LxPiinytwZdVdWEBTr5sqVGcXZrGSkvSoeBTNLd260
         y8aQ==
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
Subject: [PATCH 4.16 016/196] mm, slab: reschedule cache_reap() on the same CPU
Date: Sun, 22 Apr 2018 15:50:36 +0200
Message-Id: <20180422135104.957692051@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454810628611405?=
X-GMAIL-MSGID: =?utf-8?q?1598454810628611405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4074,7 +4074,8 @@ next:
 	next_reap_node();
 out:
 	/* Set up the next iteration */
-	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
+	schedule_delayed_work_on(smp_processor_id(), work,
+				round_jiffies_relative(REAPTIMEOUT_AC));
 }
 
 void get_slabinfo(struct kmem_cache *cachep, struct slabinfo *sinfo)
