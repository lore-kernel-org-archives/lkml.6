Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124AC2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfAMKWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:22:01 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47959
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726665AbfAMKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 05:21:58 -0500
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; 
   d="scan'208";a="291728764"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 13 Jan 2019 11:21:54 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] OF: properties: add missing of_node_put
Date:   Sun, 13 Jan 2019 10:44:50 +0100
Message-Id: <1547372691-28324-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an of_node_put when the result of of_graph_get_remote_port_parent is
not available.

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
 drivers/of/property.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 0843003..8631efa 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -806,6 +806,7 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 
 	if (!of_device_is_available(remote)) {
 		pr_debug("not available for remote node\n");
+		of_node_put(remote);
 		return NULL;
 	}
 

