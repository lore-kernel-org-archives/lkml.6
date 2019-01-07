Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865AEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AEA2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546871986;
	bh=15GsfR6Eob14Cf3becR4feX4Sx7fKT01ew1i9LvD6DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ms9PsSBCh+JXrbwccyAVXauzQBMA2K8BcYbpIKmN3kwNdxUXqgAuM9kUOrtAHXbOe
	 tynMq5YvgJwaWYvVCoXAgPnACta2v8Lv9UcHS8hPaFO0Yg4ekPSXW2SV6wLbMFEvgK
	 u3rPK4O9HzG5IgQTFeUvJLcfTq4DIITFvgvihEgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfAGOjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:39:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41927 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfAGOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:39:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so1083913edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFZQrU8fTXYe+4yKyznILHyyYdOjuztNdiLALRdIzAY=;
        b=SB+hGraYS/Buan6+jzxNbmM5tnjf3AjTf3bLI3IznWsbk7BbVxbY3vICpIkrIMSoUq
         UkXOvqTkfF8j+X+V7GdIUaaAP4SaYZEZU9oRw48qS2SFmd+5VC1kX+XiP+CkXqlmIjkq
         VUdQBCgaEr79bzr4Z6E2BF3R2UorS70VpsphGeB8z1jlICDVYMFv5nA8a42wMvVhXYCV
         V9S+4T0DAVnQy2gXOxmTJld1obiqtrZRRYoOfr+bZHHcYdFLdC5NmCkE27T2SL4RQHMA
         YUlUnIe7u4fEFi8DqMvkCaPCVBilNEO7LNxec/S11m14Z5toGgIJybFgK8H5bAGS9kD/
         S4+Q==
X-Gm-Message-State: AA+aEWb0k8A3NDY0eyVc2KwEeKvKSM9Qa1UavAfRHxxURMDoYZ/UjDhX
        e23znOpaCk5V3AIHjrMINM0=
X-Google-Smtp-Source: AFSGD/XDwJtPft+7e+YBwwRMOEFJiiNj0lmF71HskZs7fiZ6HzWFIE7LfZHsN6DrG9+SFqQ6YZXLew==
X-Received: by 2002:a17:906:d191:: with SMTP id c17-v6mr47364442ejz.27.1546871981554;
        Mon, 07 Jan 2019 06:39:41 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l18sm29285813edq.87.2019.01.07.06.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:39:40 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] mm, oom: marks all killed tasks as oom victims
Date:   Mon,  7 Jan 2019 15:38:01 +0100
Message-Id: <20190107143802.16847-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107143802.16847-1-mhocko@kernel.org>
References: <20190107143802.16847-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Historically we have called mark_oom_victim only to the main task
selected as the oom victim because oom victims have access to memory
reserves and granting the access to all killed tasks could deplete
memory reserves very quickly and cause even larger problems.

Since only a partial access to memory reserves is allowed there is no
longer this risk and so all tasks killed along with the oom victim
can be considered as well.

The primary motivation for that is that process groups which do not
shared signals would behave more like standard thread groups wrt oom
handling (aka tsk_is_oom_victim will work the same way for them).

- Use find_lock_task_mm to stabilize mm as suggested by Tetsuo

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f0e8cd9edb1a..0246c7a4e44e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -892,6 +892,7 @@ static void __oom_kill_process(struct task_struct *victim)
 	 */
 	rcu_read_lock();
 	for_each_process(p) {
+		struct task_struct *t;
 		if (!process_shares_mm(p, mm))
 			continue;
 		if (same_thread_group(p, victim))
@@ -911,6 +912,11 @@ static void __oom_kill_process(struct task_struct *victim)
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
+		t = find_lock_task_mm(p);
+		if (!t)
+			continue;
+		mark_oom_victim(t);
+		task_unlock(t);
 	}
 	rcu_read_unlock();
 
-- 
2.20.1

