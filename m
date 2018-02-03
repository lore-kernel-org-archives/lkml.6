Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBCBeR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 20:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbeBCBeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 20:34:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4108821785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Fri, 2 Feb 2018 17:34:09 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: jgross@suse.com, boris.ostrovsky@oracle.com
cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        sstabellini@kernel.org
Subject: [PATCH] pvcalls-back: do not return error on inet_accept EAGAIN
Message-ID: <alpine.DEB.2.10.1802021728420.10160@sstabellini-ThinkPad-X260>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the client sends a regular blocking accept request, the backend is
expected to return only when the accept is completed, simulating a
blocking behavior, or return an error.

Specifically, on EAGAIN from inet_accept, the backend shouldn't return
"EAGAIN" to the client. Instead, it should simply continue the wait.
Otherwise, the client will send another accept request, which will cause
another EAGAIN to be sent back, which is a waste of resources and not
conforming to the expected behavior. Change the behavior by turning the
"goto error" into a return.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index c7822d8..156e5ae 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -548,7 +548,7 @@ static void __pvcalls_back_accept(struct work_struct *work)
 	ret = inet_accept(mappass->sock, sock, O_NONBLOCK, true);
 	if (ret == -EAGAIN) {
 		sock_release(sock);
-		goto out_error;
+		return;
 	}
 
 	map = pvcalls_new_active_socket(fedata,
