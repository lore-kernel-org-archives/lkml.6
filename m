Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934404AbeEIKWH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:22:07 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:16799 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934288AbeEIKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:21:47 -0400
X-IronPort-AV: E=Sophos;i="5.49,381,1520899200";
   d="scan'208";a="54081120"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>
Subject: [PATCH v2 2/3] xen/store: do not store local values in xen_start_info
Date: Wed, 9 May 2018 11:21:28 +0100
Message-ID: <20180509102129.14832-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509102129.14832-1-roger.pau@citrix.com>
References: <20180509102129.14832-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to store the xenstore page or event channel in
xen_start_info if they are locally initialized.

This also fixes PVH local xenstore initialization due to the lack of
xen_start_info in that case.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/xenbus/xenbus_probe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index ec9eb4fba59c..f2088838f690 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -710,7 +710,7 @@ static int __init xenstored_local_init(void)
 	if (!page)
 		goto out_err;
 
-	xen_store_gfn = xen_start_info->store_mfn = virt_to_gfn((void *)page);
+	xen_store_gfn = virt_to_gfn((void *)page);
 
 	/* Next allocate a local port which xenstored can bind to */
 	alloc_unbound.dom        = DOMID_SELF;
@@ -722,8 +722,7 @@ static int __init xenstored_local_init(void)
 		goto out_err;
 
 	BUG_ON(err);
-	xen_store_evtchn = xen_start_info->store_evtchn =
-		alloc_unbound.port;
+	xen_store_evtchn = alloc_unbound.port;
 
 	return 0;
 
-- 
2.17.0
