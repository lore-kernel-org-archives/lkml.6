Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeBEWwF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbeBEWvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:51:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF1D217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
From: Stefano Stabellini <sstabellini@kernel.org>
To: boris.ostrovsky@oracle.com, jgross@suse.com
Cc: sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Stefano Stabellini <stefano@aporeto.com>
Subject: [PATCH 2/2] pvcalls-front: wait for other operations to return when release passive sockets
Date: Mon,  5 Feb 2018 14:51:47 -0800
Message-Id: <1517871107-15349-2-git-send-email-sstabellini@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517871107-15349-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1802051448460.10160@sstabellini-ThinkPad-X260>
 <1517871107-15349-1-git-send-email-sstabellini@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passive sockets can have ongoing operations on them, specifically, we
have two wait_event_interruptable calls in pvcalls_front_accept.

Add two wake_up calls in pvcalls_front_release, then wait for the
potential waiters to return and release the sock_mapping refcount.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
---
 drivers/xen/pvcalls-front.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 164d3ad..d32cac5 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -1017,6 +1017,12 @@ int pvcalls_front_release(struct socket *sock)
 
 		pvcalls_front_free_map(bedata, map);
 	} else {
+		wake_up(&bedata->inflight_req);
+		wake_up(&map->passive.inflight_accept_req);
+
+		while (atomic_read(&map->refcount) > 1)
+			cpu_relax();
+
 		spin_lock(&bedata->socket_lock);
 		list_del(&map->list);
 		spin_unlock(&bedata->socket_lock);
-- 
1.9.1
