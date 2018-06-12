Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4053DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76D82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTUxjHPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76D82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934193AbeFLRpO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933574AbeFLRpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:45:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4521F20660;
        Tue, 12 Jun 2018 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528825512;
        bh=X0d/s4r7cZwINA0t1AE4pSdBKw4CfF0hUElmnO6yDl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTUxjHPZd5g4a+w9RphsIJ46bVwniLhh3rozVQ0WkoZ7vNXY7jI4NBredeSsLw5s1
         SC9BSe0/eulswIaIPWXI/R9cllSdJRaEPfDI0ENXi4Qg7uT4ZslBuomqz2F8zV+6G4
         LjFpcMhuBzQbFAH7PxoxTXpDTNKhBPH2/9CgKOZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 07/21] fix io_destroy()/aio_complete() race
Date:   Tue, 12 Jun 2018 18:52:04 +0200
Message-Id: <20180612164825.712821017@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 4faa99965e027cc057c5145ce45fa772caa04e8d upstream.

If io_destroy() gets to cancelling everything that can be cancelled and
gets to kiocb_cancel() calling the function driver has left in ->ki_cancel,
it becomes vulnerable to a race with IO completion.  At that point req
is already taken off the list and aio_complete() does *NOT* spin until
we (in free_ioctx_users()) releases ->ctx_lock.  As the result, it proceeds
to kiocb_free(), freing req just it gets passed to ->ki_cancel().

Fix is simple - remove from the list after the call of kiocb_cancel().  All
instances of ->ki_cancel() already have to cope with the being called with
iocb still on list - that's what happens in io_cancel(2).

Cc: stable@kernel.org
Fixes: 0460fef2a921 "aio: use cancellation list lazily"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -560,9 +560,8 @@ static void free_ioctx_users(struct perc
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct kiocb, ki_list);
-
-		list_del_init(&req->ki_list);
 		kiocb_cancel(req);
+		list_del_init(&req->ki_list);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);


