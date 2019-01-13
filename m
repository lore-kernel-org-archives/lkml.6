Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7FBC43614
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FC120873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfAMJZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:25:02 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60664
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfAMJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:24:52 -0500
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; 
   d="scan'208";a="291725802"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 13 Jan 2019 10:24:47 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/sun4i: backend: add missing of_node_puts
Date:   Sun, 13 Jan 2019 09:47:44 +0100
Message-Id: <1547369264-24831-5-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node iterators perform an of_node_get on each
iteration, so a jump out of the loop requires an of_node_put.

Remote and port also have augmented reference counts, so drop them
on each iteration and at the end of the function, respectively.
Remote is only used for the address it contains, not for the
contents of that address, so the reference count can be dropped
immediately.

The semantic patch that fixes the first part of this problem is
as follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_available_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 drivers/gpu/drm/sun4i/sun4i_backend.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 9e9255e..a021bab 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -786,17 +786,18 @@ static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote)
 			continue;
+		of_node_put(remote);
 
 		/* does this node match any registered engines? */
 		list_for_each_entry(frontend, &drv->frontend_list, list) {
 			if (remote == frontend->node) {
-				of_node_put(remote);
 				of_node_put(port);
+				of_node_put(ep);
 				return frontend;
 			}
 		}
 	}
-
+	of_node_put(port);
 	return ERR_PTR(-EINVAL);
 }
 

