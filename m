Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD76E217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276906;
	bh=6YfeyxPOEttu6NQ4oYC3CUofeVyWaW7lgMpLwQdn6Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JktFitJgTU4OqmjC9vdmJCnWWMeNMH52LjXEN+S2qRtQifRG5/72FSWFvCUbn4A7y
	 VBsU2aVnuWC02LRkvwnrvz0VZNNWS+Y0Qv5yCjq/zAAYA0jtWckQU9am5S3qZXQOF3
	 KhD0IVV9Bz3K2dlkZeVLVYFnUbVngmKduw3JasGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfBDKlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730315AbfBDKlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B342075B;
        Mon,  4 Feb 2019 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276896;
        bh=6YfeyxPOEttu6NQ4oYC3CUofeVyWaW7lgMpLwQdn6Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1dBC+VCtll3kysAI//rpmjmOHp9gc77q/5XHjKvrUgmfi0wHiCcsOAIzAjEf6Iv/
         cyqOQapHE+fFTfYi09Ld45uTw2pjJIJ7uZcM6Xr0I+BIJdHdS+e3vqX65UvJlTPzkz
         /2913FPeBoHPSliX+UusnalFS8oV/jHF97+opyhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7fbbfa368521945f0e3d@syzkaller.appspotmail.com,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 51/65] mm, oom: fix use-after-free in oom_kill_process
Date:   Mon,  4 Feb 2019 11:36:44 +0100
Message-Id: <20190204103619.095754304@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shakeel Butt <shakeelb@google.com>

commit cefc7ef3c87d02fc9307835868ff721ea12cc597 upstream.

Syzbot instance running on upstream kernel found a use-after-free bug in
oom_kill_process.  On further inspection it seems like the process
selected to be oom-killed has exited even before reaching
read_lock(&tasklist_lock) in oom_kill_process().  More specifically the
tsk->usage is 1 which is due to get_task_struct() in oom_evaluate_task()
and the put_task_struct within for_each_thread() frees the tsk and
for_each_thread() tries to access the tsk.  The easiest fix is to do
get/put across the for_each_thread() on the selected task.

Now the next question is should we continue with the oom-kill as the
previously selected task has exited? However before adding more
complexity and heuristics, let's answer why we even look at the children
of oom-kill selected task? The select_bad_process() has already selected
the worst process in the system/memcg.  Due to race, the selected
process might not be the worst at the kill time but does that matter?
The userspace can use the oom_score_adj interface to prefer children to
be killed before the parent.  I looked at the history but it seems like
this is there before git history.

Link: http://lkml.kernel.org/r/20190121215850.221745-1-shakeelb@google.com
Reported-by: syzbot+7fbbfa368521945f0e3d@syzkaller.appspotmail.com
Fixes: 6b0c81b3be11 ("mm, oom: reduce dependency on tasklist_lock")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/oom_kill.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -544,6 +544,13 @@ void oom_kill_process(struct oom_control
 	 * still freeing memory.
 	 */
 	read_lock(&tasklist_lock);
+
+	/*
+	 * The task 'p' might have already exited before reaching here. The
+	 * put_task_struct() will free task_struct 'p' while the loop still try
+	 * to access the field of 'p', so, get an extra reference.
+	 */
+	get_task_struct(p);
 	for_each_thread(p, t) {
 		list_for_each_entry(child, &t->children, sibling) {
 			unsigned int child_points;
@@ -563,6 +570,7 @@ void oom_kill_process(struct oom_control
 			}
 		}
 	}
+	put_task_struct(p);
 	read_unlock(&tasklist_lock);
 
 	p = find_lock_task_mm(victim);


