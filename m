Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5972BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2866A2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216390;
	bh=Nsj4WsgmuFbUff+dLgSZBFI2B9hInFRM5kilMs/p65E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jlbTl5WoXyXj3KbqIyOK3F1UB6jJ9NQlC52oifxJR8LoVr5qEeWI22wZXg/un+dhZ
	 +ErDqHEAHCNDbhCOfxtCL3hGlEelVIGunjCb7n0pjbxQuUlAzjBPv/OCc2oKuy79bt
	 kWGxfJ4Y4jUyE3S8muPR+fUrIUIBvFAmeQhkCRT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfAKOTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbfAKOTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8496A2177B;
        Fri, 11 Jan 2019 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216384;
        bh=Nsj4WsgmuFbUff+dLgSZBFI2B9hInFRM5kilMs/p65E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSQHgOv4eH87q/msgKpNQK5Z1YuAqHMZ47hbkNYNKzCdumCTNnYlYKA/YsqLweti5
         qpwBQKv0wsj7gv47hrMUwOMRi007IpLYsTRe4XmW900n8WxDWYgn/Rlh/yNgWJ7fmw
         HHnlWzci6JscrIpY40yVGwygR/731Dh4on7XD/nI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.4 79/88] dlm: memory leaks on error path in dlm_user_request()
Date:   Fri, 11 Jan 2019 15:08:48 +0100
Message-Id: <20190111131059.067864644@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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


