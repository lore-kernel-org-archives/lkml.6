Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270BE2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132300;
	bh=w+rdutqVNT2lwyr56WmxWk2+ZVNHxUVyjgBeYEVLMcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlkS/g1kSg+g+7pYlHToTmS+PCFJqz3Y7SvblLMQhzahWuvZ15YL5TOQhpGpkaBaE
	 waDC3BsezBQSoY0du/HXzC94XnIZYxjTrdVaqd+h2gfL32rvDvSBnY2laIzUl7YWCZ
	 cn8y1nSgJfDfkFpUOGjho8DlQlj6hNQMWHNEL3oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfBYWE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbfBYVNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:13:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 978272084D;
        Mon, 25 Feb 2019 21:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129180;
        bh=w+rdutqVNT2lwyr56WmxWk2+ZVNHxUVyjgBeYEVLMcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1Rfmb76z8S4cNI3qhoYkeexW92Or/udG+SsSlmUaoy4MNdgqN5mTfrW4e9bogAN7
         gycuo//FwklbJcxREafqUncx+9V5nrQCss1S5rugDG1BO5xy+94gXMMmoJGQNnpiDn
         BQ3XSlGP7ioPVyt+khGfIefVWwXlS7No6SEilLH8=
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
Subject: [PATCH 4.9 05/63] proc, oom: do not report alien mms when setting oom_score_adj
Date:   Mon, 25 Feb 2019 22:11:05 +0100
Message-Id: <20190225195036.127240355@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1134,10 +1134,6 @@ static int __set_oom_adj(struct file *fi
 
 			task_lock(p);
 			if (!p->vfork_done && process_shares_mm(p, mm)) {
-				pr_info("updating oom_score_adj for %d (%s) from %d to %d because it shares mm with %d (%s). Report if this is unexpected.\n",
-						task_pid_nr(p), p->comm,
-						p->signal->oom_score_adj, oom_adj,
-						task_pid_nr(task), task->comm);
 				p->signal->oom_score_adj = oom_adj;
 				if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
 					p->signal->oom_score_adj_min = (short)oom_adj;


