Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33918C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB092063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218275;
	bh=HlJNIkJsj+Tjt1KPjRMz23Mj7/Mow5idu3p9/a7HBPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o7wHhmuuQJbYv+bTqWtpx39I9FpLxT+dj+zgidrZDDdBPxCAJKDLzQoGO7RMEEcTx
	 VsR6+6uVkssQ0nTWOZez+F4CyQd2PvLBJM6rMLN2c2g5dozjBchKCT+iCAE70jQF8u
	 PDR2IKjCyHyrDiEshh5uySh76gjibOmd332j/hno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbfAKOvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:51:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403829AbfAKOjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B792063F;
        Fri, 11 Jan 2019 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217586;
        bh=HlJNIkJsj+Tjt1KPjRMz23Mj7/Mow5idu3p9/a7HBPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYgqzKsGwKknAmGMYqs0cdk7IepvhD2TUG5UnKZdC2icbvMuMGmhI4tiF7k8a8Ocw
         Dn5ZqwjvdlFMqun8mpQv3DBDWqaLN/otYw/xVUVpaQLRpA3sufKVRHu3h9R3FvbUD2
         ZpYbpaJPg452iV7BD1eUryP8EenPzF0MdM3Szg4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.19 117/148] dlm: memory leaks on error path in dlm_user_request()
Date:   Fri, 11 Jan 2019 15:14:55 +0100
Message-Id: <20190111131118.933028190@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

From: Vasily Averin <vvs@virtuozzo.com>

commit d47b41aceeadc6b58abc9c7c6485bef7cfb75636 upstream.

According to comment in dlm_user_request() ua should be freed
in dlm_free_lkb() after successful attach to lkb.

However ua is attached to lkb not in set_lock_args() but later,
inside request_lock().

Fixes 597d0cae0f99 ("[DLM] dlm: user locks")
Cc: stable@kernel.org # 2.6.19

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lock.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5795,20 +5795,20 @@ int dlm_user_request(struct dlm_ls *ls,
 			goto out;
 		}
 	}
-
-	/* After ua is attached to lkb it will be freed by dlm_free_lkb().
-	   When DLM_IFL_USER is set, the dlm knows that this is a userspace
-	   lock and that lkb_astparam is the dlm_user_args structure. */
-
 	error = set_lock_args(mode, &ua->lksb, flags, namelen, timeout_cs,
 			      fake_astfn, ua, fake_bastfn, &args);
-	lkb->lkb_flags |= DLM_IFL_USER;
-
 	if (error) {
+		kfree(ua->lksb.sb_lvbptr);
+		ua->lksb.sb_lvbptr = NULL;
+		kfree(ua);
 		__put_lkb(ls, lkb);
 		goto out;
 	}
 
+	/* After ua is attached to lkb it will be freed by dlm_free_lkb().
+	   When DLM_IFL_USER is set, the dlm knows that this is a userspace
+	   lock and that lkb_astparam is the dlm_user_args structure. */
+	lkb->lkb_flags |= DLM_IFL_USER;
 	error = request_lock(ls, lkb, name, namelen, &args);
 
 	switch (error) {


