Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFDHIA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752496AbeFDHH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:07:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 46/47] fix io_destroy()/aio_complete() race
Date: Mon,  4 Jun 2018 08:58:58 +0200
Message-Id: <20180604065551.452702810@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -643,9 +643,8 @@ static void free_ioctx_users(struct perc
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-
-		list_del_init(&req->ki_list);
 		kiocb_cancel(req);
+		list_del_init(&req->ki_list);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
