Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE472063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216960;
	bh=Hx2TIM8oGR0qhusTW3FpDQhIFEZKVlS9qulW6/k9n2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYdt21pohWC62aEBTj6j4x0jU6FwAaRVEnT1ywNKNBYNaXGr3zQWvKyqNtRzg6oXw
	 rMOZ3w6qMB1fmRv/Zr2nht65nypBIQA3LAYB/Wq7iFiP2fp7C4dliUhsYrRfI1CI65
	 ZNOD1zzJxUFOLBX2n7me+lQlcAYgqVf+ypnjM08I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbfAKO3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388684AbfAKO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3952133F;
        Fri, 11 Jan 2019 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216955;
        bh=Hx2TIM8oGR0qhusTW3FpDQhIFEZKVlS9qulW6/k9n2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGE1Zre9Nxd86WzLZ9QT/lo4/QFPqkja4R/eRsCkRkC9I2R+22NSujgMr6pO/fv35
         d/+SpMo3CJ/Uj+XXMwCu3BQlwxDabjHgQKvKn6EDpzIYobZqyt9lvTRV1YIg0QTlfN
         pc3c3azxpl1CBmaHSxv5mrBi5nn0wH55iCGh+T30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.9 51/63] dlm: memory leaks on error path in dlm_user_request()
Date:   Fri, 11 Jan 2019 15:14:54 +0100
Message-Id: <20190111131053.772607133@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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


