Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8652C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A662217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfAWAoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:44:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:13606 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfAWAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:44:22 -0500
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0N0iCG1051637;
        Wed, 23 Jan 2019 09:44:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Wed, 23 Jan 2019 09:44:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0N0iCxF051616;
        Wed, 23 Jan 2019 09:44:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x0N0iCdk051613;
        Wed, 23 Jan 2019 09:44:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201901230044.x0N0iCdk051613@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] workqueue: Try to catch =?ISO-2022-JP?B?Zmx1c2hfd29yaygpIHdp?=
 =?ISO-2022-JP?B?dGhvdXQgSU5JVF9XT1JLKCku?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date:   Wed, 23 Jan 2019 09:44:12 +0900
References: <90c831b3-0d09-3cf7-5a2c-2fa7afaa003e@i-love.sakura.ne.jp> <20190122151819.qjzihyyd4h2ukou2@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20190122151819.qjzihyyd4h2ukou2@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan wrote:
> On Sat, Jan 19, 2019 at 11:41:22AM +0900, Tetsuo Handa wrote:
> > On 2019/01/19 4:48, Daniel Jordan wrote:
> > > On Sat, Jan 19, 2019 at 02:04:58AM +0900, Tetsuo Handa wrote:
> > > __queue_work has a sanity check already for work, but using list_empty.  Seems
> > > slightly better to be consistent?
> > > 
> > 
> > list_empty() won't work, for "struct work_struct" is embedded into a struct
> > which is allocated by kzalloc().
> 
> Please check list_empty's definition again, it compares the address of the node
> to its next pointer, so it should work for a zeroed node.  I'll reiterate that
> it seems slightly better to be consistent in "is work_struct initialized?"
> checks, but it's not a big deal and I'm fine either way.

You are talking about

	if (WARN_ON(!list_empty(&work->entry))) {
		spin_unlock(&pwq->pool->lock);
		return;
	}

part in __queue_work(), aren't you? But since flush_work() is used for waiting for
a work to complete, that work can be either queued state (list_empty() == false) or
not queued state (list_empty() == true). Thus, I don't think that flush_work() can
use list_empty() for checking whether that work was initialized.



[PATCH v2] workqueue: Try to catch flush_work() without INIT_WORK().

syzbot found a flush_work() caller who forgot to call INIT_WORK()
because that work_struct was allocated by kzalloc() [1]. But the message

  INFO: trying to register non-static key.
  the code is fine but needs lockdep annotation.
  turning off the locking correctness validator.

by lock_map_acquire() is failing to tell that INIT_WORK() is missing.

Since flush_work() without INIT_WORK() is a bug, and INIT_WORK() should
set ->func field to non-zero, let's warn if ->func field is zero.

[1] https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 392be4b..a503ad9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2908,6 +2908,9 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!wq_online))
 		return false;
 
+	if (WARN_ON(!work->func))
+		return false;
+
 	if (!from_cancel) {
 		lock_map_acquire(&work->lockdep_map);
 		lock_map_release(&work->lockdep_map);
