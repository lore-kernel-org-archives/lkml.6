Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDJMXU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752428AbeDJMXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:23:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85F020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 10 Apr 2018 08:23:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410082316.263d34ec@gandalf.local.home>
In-Reply-To: <20180410104902.GC21835@dhcp22.suse.cz>
References: <20180409231230.1ab99e85@vmware.local.home>
        <CAGWkznG8-zmfE5iqPUVP+sztasa1zLPWE28qBiZ_tq524JznPw@mail.gmail.com>
        <20180410061447.GQ21835@dhcp22.suse.cz>
        <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
        <20180410074921.GU21835@dhcp22.suse.cz>
        <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
        <20180410081231.GV21835@dhcp22.suse.cz>
        <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
        <20180410090128.GY21835@dhcp22.suse.cz>
        <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
        <20180410104902.GC21835@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 12:49:02 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> But you do realize that what you are proposing is by no means any safer,
> don't you? The memory allocated for the ring buffer is _not_ accounted
> to any process and as such it is not considered by the oom killer when
> picking up an oom victim so you are quite likely to pick up an innocent
> process to be killed. So basically you are risking an allocation runaway
> completely hidden from the OOM killer. Now, the downside of the patch is
> that the OOM_SCORE_ADJ_MIN task might get killed which is something that
> shouldn't happen because it is a contract. I would call this an
> unsolvable problem and a inherent broken design of the oom disabled
> task. So far I haven't heard a single _argument_ why supporting such a
> weird cornercase is desirable when your application can trivial do
> 
> fork(); set_oom_score_adj(); exec("echo $VAR > $RINGBUFFER_FILE")

We could do this as a compromise:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c9cb9767d49b..40c2e0a56c51 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1185,6 +1185,12 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 	 */
 	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
 
+	/* If we can't OOM this task, then only allocate without reclaim */
+	if (unlikely(current->signal->oom_score_adj == OOM_SCORE_ADJ_MIN)) {
+		mflags = GFP_KERNEL | __GFP_NORETRY;
+		user_thread = false; /* do not set oom_origin */
+	}
+
 	/*
 	 * If a user thread allocates too much, and si_mem_available()
 	 * reports there's enough memory, even though there is not.

This way, if one sets OOM_SCORE_ADJ_MIN, then we wont set oom_origin
for the task, but we also wont try hard to allocate memory if there is
nothing immediately available.

-- Steve
