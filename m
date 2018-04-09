Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeDIObz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:31:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45557 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeDIOby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:31:54 -0400
X-Google-Smtp-Source: AIpwx48yeL8gg2aTAacbk/V7GNoc/7Eh2luIlRf9tr5JFp4UunLGSBKWWZCqPIU7dzUBWS/n3hg2sw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: ccaulfie@redhat.com, teigland@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: dls: lowcomms: Replace GFP_ATOMIC with GFP_KERNEL in receive_from_sock
Date: Mon,  9 Apr 2018 22:31:43 +0800
Message-Id: <1523284303-25996-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

receive_from_sock() is never called in atomic context.

The call chain ending up at receive_from_sock() is:
[1] receive_from_sock() <- process_recv_sockets()
process_recv_sockets() is only set as a parameter of INIT_WORK()
And receive_from_sock() also calls mutex_lock(), which indicates
this function is not called in atomic context.

Despite never getting called from atomic context,
receive_from_sock() calls alloc_page() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 4813d0e..2d4e230 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -633,7 +633,7 @@ static int receive_from_sock(struct connection *con)
 		 * This doesn't need to be atomic, but I think it should
 		 * improve performance if it is.
 		 */
-		con->rx_page = alloc_page(GFP_ATOMIC);
+		con->rx_page = alloc_page(GFP_KERNEL);
 		if (con->rx_page == NULL)
 			goto out_resched;
 		cbuf_init(&con->cb, PAGE_SIZE);
-- 
1.9.1
