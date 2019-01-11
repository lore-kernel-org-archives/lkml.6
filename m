Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA30C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63C72133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217220;
	bh=JTfwFTQ7jx2eJFXxQ6+XI5BcCDZxYcDRqLy7o8JIYD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfpg+nDpNg462uzOX3WMjlnHgvbVAqwnTitqHd19EEJ4i2cDBrjHjqQfXRmm2AuJ2
	 5W+2mKY68VpqHxU3wSHhpSbX3UhXA0kifqvRQVGWUzmCin8sOS+t9GIyVtqdwSBNhA
	 5Zu2yOu+dJgS2v9wnR4qIW2UwUriRX5JWDyi64LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389702AbfAKOdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389683AbfAKOdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F59204EC;
        Fri, 11 Jan 2019 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217216;
        bh=JTfwFTQ7jx2eJFXxQ6+XI5BcCDZxYcDRqLy7o8JIYD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwbgLK6kZty8uaG6fdceS4ycfq5SxNcLuNN1Rad+DwX+6P/pAA6MQjqkeXvwQdy5n
         ktCX9AnnkOXSmYwg6RjtHfoZnQFhvE3FF4wOkPvB4fWoEPoYtXPX9iLhMrZodT5cbU
         SOxrR/YJlkwjtU4BFVcIZsB+gQkz1z6ZaUwtZ65I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.14 085/105] dlm: possible memory leak on error path in create_lkb()
Date:   Fri, 11 Jan 2019 15:14:56 +0100
Message-Id: <20190111131110.110293347@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit 23851e978f31eda8b2d01bd410d3026659ca06c7 upstream.

Fixes 3d6aa675fff9 ("dlm: keep lkbs in idr")
Cc: stable@kernel.org # 3.1

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1210,6 +1210,7 @@ static int create_lkb(struct dlm_ls *ls,
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
+		dlm_free_lkb(lkb);
 		return rv;
 	}
 


