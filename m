Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9008AC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B94B21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026309;
	bh=auGgXHbjXrRvxQnGp7euDhrpMalhxDYBK82cR69gHpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=raLa3n24s57F8C5BbyLELXcRfL/is8F/FuCLpeBDh8C5sdPel/6hih+KE+f33HMZR
	 7PBpge6q7Em0QmRWKXueJXG0HbIBYbP9n3FFlAXns+uJPrNt2P/Uf6rHRXGnTwQ9Rw
	 v+M7F7a+eWS60D2sATj3XPNuTQDxIy+rftXl+HaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbfBMCvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388600AbfBMCiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F414206B6;
        Wed, 13 Feb 2019 02:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025525;
        bh=auGgXHbjXrRvxQnGp7euDhrpMalhxDYBK82cR69gHpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWAIZCT90pnSAoJVoFGGWiqDjzRPOJfRs0NS1tZO9Bz62lE/Mo96yt2tZ9yAnVUmf
         qLK5vGjNIp5IiQ2NrThjISHchMdpcowmytRFISkovcETP145LHiKYWXm5QhUEzZPTH
         UIXlfOohY8e+UButF0oyXBjrZ/nBrnALF4+tfYVY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 62/83] drm/sun4i: backend: add missing of_node_puts
Date:   Tue, 12 Feb 2019 21:36:40 -0500
Message-Id: <20190213023701.20286-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit 4bb0e6d7258213d4893c2c876712fbba40e712fe ]

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
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1547369264-24831-5-git-send-email-Julia.Lawall@lip6.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index d7950b52a1fd..e30b1f5b9d91 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -717,17 +717,18 @@ static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
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
 
-- 
2.19.1

