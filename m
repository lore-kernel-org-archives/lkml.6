Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA57C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC612064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfAMKWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:22:11 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47959
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfAMKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 05:22:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; 
   d="scan'208";a="291728765"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 13 Jan 2019 11:21:54 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/meson: add missing of_node_put
Date:   Sun, 13 Jan 2019 10:44:51 +0100
Message-Id: <1547372691-28324-4-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an of_node_put when the result of of_graph_get_remote_port_parent is
not available.

An of_node_put is also needed when meson_probe_remote completes.  This was
present at the recursive call, but not in the call from meson_drv_probe.

The semantic match that finds this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@r exists@
local idexpression e;
expression x;
@@
e = of_graph_get_remote_port_parent(...);
... when != x = e
    when != true e == NULL
    when != of_node_put(e)
    when != of_fwnode_handle(e)
(
return e;
|
*return ...;
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpu/drm/meson/meson_drv.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 3ee4d4a4e..b59c757 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -388,8 +388,10 @@ static int meson_probe_remote(struct platform_device *pdev,
 		remote_node = of_graph_get_remote_port_parent(ep);
 		if (!remote_node ||
 		    remote_node == parent || /* Ignore parent endpoint */
-		    !of_device_is_available(remote_node))
+		    !of_device_is_available(remote_node)) {
+			of_node_put(remote_node);
 			continue;
+		}
 
 		count += meson_probe_remote(pdev, match, remote, remote_node);
 
@@ -408,10 +410,13 @@ static int meson_drv_probe(struct platform_device *pdev)
 
 	for_each_endpoint_of_node(np, ep) {
 		remote = of_graph_get_remote_port_parent(ep);
-		if (!remote || !of_device_is_available(remote))
+		if (!remote || !of_device_is_available(remote)) {
+			of_node_put(remote);
 			continue;
+		}
 
 		count += meson_probe_remote(pdev, &match, np, remote);
+		of_node_put(remote);
 	}
 
 	if (count && !match)

