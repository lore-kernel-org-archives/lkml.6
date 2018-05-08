Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeEHDei (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:34:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42409 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEHDeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:34:37 -0400
X-Google-Smtp-Source: AB8JxZphflkY/MBgANqzzsU/EuJLDg9Gu3EKq6tV3jvHEmO/KZ7fWk3hT686EZf2d1RMQDCPln7IzQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: boris.ostrovsky@oracle.com, jgross@suse.com,
        simon@invisiblethingslab.com, joao.m.martins@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] xen: xenbus: Fix a possible data race in xs_request_enter
Date: Tue,  8 May 2018 11:34:29 +0800
Message-Id: <20180508033429.12749-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read operation to "req->type" is protected by
the lock on line 128, but the write operation to
this data on line 118 is not protected by the lock.
Thus, there may exist a data race for "req->type".

To fix this data race, the write operation to "req->type" 
should be also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 49a3874ae6bb..274cdfee08b1 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -115,10 +115,10 @@ static uint32_t xs_request_enter(struct xb_req_data *req)
 {
 	uint32_t rq_id;
 
-	req->type = req->msg.type;
-
 	spin_lock(&xs_state_lock);
 
+	req->type = req->msg.type;
+
 	while (!xs_state_users && xs_suspend_active) {
 		spin_unlock(&xs_state_lock);
 		wait_event(xs_state_enter_wq, xs_suspend_active == 0);
-- 
2.17.0
