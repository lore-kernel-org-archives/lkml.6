Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05713C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C938521841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129615;
	bh=Ls2e7VwASnOWID6D6byRwsIY17IDQgRPMEEYpvbHsDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibgKhbkRAQPcbEHYeLknr7PZEw5y0Z2+iRtzOCxaaW9DxYoKEu+52MX4vsUwkfq2d
	 hkuhyJzN4TLSdusB5xpuL+3PUb+QA509sElUaA9kt4vAf6Vqo8yN/OxtASxc2opoU1
	 +2tg1raUXaGgYeJjdyAf3MAwuh8jJlFQ4UhFQv64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfBYVUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbfBYVUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1DB205C9;
        Mon, 25 Feb 2019 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129602;
        bh=Ls2e7VwASnOWID6D6byRwsIY17IDQgRPMEEYpvbHsDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YD0zFG5oQbWNxMyRLhdWRNfd7fNAxp7faROw47FHITLhhPcP8aU3BM9P1SSil8ZVj
         7Pi3zr4k7nxrkXpQvANEgI7KLQO98xpyLF/gp7DCNvyIMZYqs5hCfVUFYAlPET9lDN
         pV0i+8D1yRfkCIeNXGp07PMGuzH0MMSstQ61YIsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Yong-Taek Lee <ytk.lee@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 012/152] proc, oom: do not report alien mms when setting oom_score_adj
Date:   Mon, 25 Feb 2019 22:10:04 +0100
Message-Id: <20190225195044.487507112@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit b2b469939e93458753cfbf8282ad52636495965e upstream.

Tetsuo has reported that creating a thousands of processes sharing MM
without SIGHAND (aka alien threads) and setting
/proc/<pid>/oom_score_adj will swamp the kernel log and takes ages [1]
to finish.  This is especially worrisome that all that printing is done
under RCU lock and this can potentially trigger RCU stall or softlockup
detector.

The primary reason for the printk was to catch potential users who might
depend on the behavior prior to 44a70adec910 ("mm, oom_adj: make sure
processes sharing mm have same view of oom_score_adj") but after more
than 2 years without a single report I guess it is safe to simply remove
the printk altogether.

The next step should be moving oom_score_adj over to the mm struct and
remove all the tasks crawling as suggested by [2]

[1] http://lkml.kernel.org/r/97fce864-6f75-bca5-14bc-12c9f890e740@i-love.sakura.ne.jp
[2] http://lkml.kernel.org/r/20190117155159.GA4087@dhcp22.suse.cz

Link: http://lkml.kernel.org/r/20190212102129.26288-1-mhocko@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Yong-Taek Lee <ytk.lee@samsung.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/base.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1084,10 +1084,6 @@ static int __set_oom_adj(struct file *fi
 
 			task_lock(p);
 			if (!p->vfork_done && process_shares_mm(p, mm)) {
-				pr_info("updating oom_score_adj for %d (%s) from %d to %d because it shares mm with %d (%s). Report if this is unexpected.\n",
-						task_pid_nr(p), p->comm,
-						p->signal->oom_score_adj, oom_adj,
-						task_pid_nr(task), task->comm);
 				p->signal->oom_score_adj = oom_adj;
 				if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
 					p->signal->oom_score_adj_min = (short)oom_adj;


