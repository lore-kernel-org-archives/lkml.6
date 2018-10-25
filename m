Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D033ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B1D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2ialOtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B1D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbeJYWxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbeJYWxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:14 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D4A20848;
        Thu, 25 Oct 2018 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477216;
        bh=obwSeL9KLSb/aZ1pAn2xfX7P/admnp3R8DC3BmlYf3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2ialOtG/85YJOkcaLWbioR9FroBY4QRu8jLbzXrN/AVPTxscfyjlTaSp/IXGFxUD
         YVriL/sokm6SVsGQMornjyiheyKTxorzdHz5/6OhWmB9IQ2qESXviiIidgrJaUZxWu
         K/44nMZ8xKTwpxSdrgPNlIqf65qKqkJNbKDl/ym8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Jeff Layton <jeff.layton@primarydata.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 54/98] nfs: fix high load average due to callback thread sleeping
Date:   Thu, 25 Oct 2018 10:18:09 -0400
Message-Id: <20181025141853.214051-54-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@poochiereds.net>

[ Upstream commit 5d05e54af3cdbb13cf19c557ff2184781b91a22c ]

Chuck pointed out a problem that crept in with commit 6ffa30d3f734 (nfs:
don't call blocking operations while !TASK_RUNNING). Linux counts tasks
in uninterruptible sleep against the load average, so this caused the
system's load average to be pinned at at least 1 when there was a
NFSv4.1+ mount active.

Not a huge problem, but it's probably worth fixing before we get too
many complaints about it. This patch converts the code back to use
TASK_INTERRUPTIBLE sleep, simply has it flush any signals on each loop
iteration. In practice no one should really be signalling this thread at
all, so I think this is reasonably safe.

With this change, there's also no need to game the hung task watchdog so
we can also convert the schedule_timeout call back to a normal schedule.

Cc: <stable@vger.kernel.org>
Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Tested-by: Chuck Lever <chuck.lever@oracle.com>
Fixes: commit 6ffa30d3f734 (“nfs: don't call blocking . . .”)
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 3b8cdb8298c4..a78558a25035 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -128,7 +128,7 @@ nfs41_callback_svc(void *vrqstp)
 		if (try_to_freeze())
 			continue;
 
-		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_INTERRUPTIBLE);
 		spin_lock_bh(&serv->sv_cb_lock);
 		if (!list_empty(&serv->sv_cb_list)) {
 			req = list_first_entry(&serv->sv_cb_list,
@@ -142,10 +142,10 @@ nfs41_callback_svc(void *vrqstp)
 				error);
 		} else {
 			spin_unlock_bh(&serv->sv_cb_lock);
-			/* schedule_timeout to game the hung task watchdog */
-			schedule_timeout(60 * HZ);
+			schedule();
 			finish_wait(&serv->sv_cb_waitq, &wq);
 		}
+		flush_signals(current);
 	}
 	return 0;
 }
-- 
2.17.1

