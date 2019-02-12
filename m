Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A26EC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5858D21934
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549966900;
	bh=ORhuxTaoIUkyNe8Y6kDEe6TmE+fFBtsWxGy7SvJQlTo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HHxooFALK+fyaOLGnmniD9KRUA11Fa64u0YJRQZo2PHg0r+2d29fmRK9ztUZsMCxC
	 QtW8BNIof9nFrjdcvQUNcR1oOH37LN53wrPATIFfhi6sTWFzHUo4ftsmlnMhPfSOdU
	 I3f155SYYkECxxIOgfxifaA7gOPiinL1b/rfH7jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfBLKVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:21:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41702 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:21:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id x7so1693315eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zo9+FKt51sWjrcVWjLOayf+02nh5kJtN90CHM7zOA8o=;
        b=LwvbvKfUwU8qce3zpmFn/Y54J4mETcXmZmYcTZzndd918DD/bXFgYBRS3ytUKtgsAe
         WsKlGFMy7AJ54HImpFlKXTrBm3dPspeFyK+4YKe/YDVGxZNr1XxrGYVKRWsojJFVQyL9
         tNfdLtQBC8exooj8FcDsv/rCMatm9SspgvUZrZu8/KuzlX+h0tE8T2E6joctgfJmfOTu
         uJXJoPc4UDiWJagLBTdPJXoTcViIGdg3Ebks6UJJThnL6uPNi/uXZjXC7HrDhEPYBNPI
         NXjd++1ytJpDm865+OBTrsc/7PLrba+ubTKjsruJmG1YLavRVn3U5gGOKbMUMAlYeLBF
         1OkQ==
X-Gm-Message-State: AHQUAubUHLbrkxNmGJbaXQFxhqjVELoj5XSItW6dpqu3Yaiyw0gJ2F7v
        t+cGvp84aaXJ9h7Bi+rZmM0=
X-Google-Smtp-Source: AHgI3IaOi1HojbWicHleY82Zg6LAsGM4FuUjqN46BBHOFYVqeRQyxeQeOnBqVNBTOEU0Xku63geUCQ==
X-Received: by 2002:aa7:cb5a:: with SMTP id w26mr2430908edt.261.1549966896510;
        Tue, 12 Feb 2019 02:21:36 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w56sm3753105edb.72.2019.02.12.02.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:21:35 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] proc, oom: do not report alien mms when setting oom_score_adj
Date:   Tue, 12 Feb 2019 11:21:29 +0100
Message-Id: <20190212102129.26288-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Tetsuo has reported that creating a thousands of processes sharing MM
without SIGHAND (aka alien threads) and setting
/proc/<pid>/oom_score_adj will swamp the kernel log and takes ages [1]
to finish. This is especially worrisome that all that printing is done
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
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 fs/proc/base.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 633a63462573..f5ed9512d193 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1086,10 +1086,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 
 			task_lock(p);
 			if (!p->vfork_done && process_shares_mm(p, mm)) {
-				pr_info("updating oom_score_adj for %d (%s) from %d to %d because it shares mm with %d (%s). Report if this is unexpected.\n",
-						task_pid_nr(p), p->comm,
-						p->signal->oom_score_adj, oom_adj,
-						task_pid_nr(task), task->comm);
 				p->signal->oom_score_adj = oom_adj;
 				if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
 					p->signal->oom_score_adj_min = (short)oom_adj;
-- 
2.20.1

