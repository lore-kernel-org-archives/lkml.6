Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB17DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D7221841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130364;
	bh=1usEiyhDJE4Xg84lPkEz5PNMUE8G7mQ7/trWkhlNOMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dJ3M6Tm8LLD61RY8fHuYqOk2tcbf/Y0F/2nQfzD7hKWaBTVYYKaJAhBEU/10JKllD
	 MypZtnXAD3dshbgb0ZMum17RoMe9bGyeelkS3e5I1ksafmCU5Yvyhx0AuBzbpVlfsF
	 yjhx+D+ZBopyY7r2jspiQnHhtEe3zhASLeA+OG/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbfBYVcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732521AbfBYVck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152E821850;
        Mon, 25 Feb 2019 21:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130359;
        bh=1usEiyhDJE4Xg84lPkEz5PNMUE8G7mQ7/trWkhlNOMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8RCgg5x50Gfdd1/U1OfQX84P2JOaulP34AF/HbHCIMc8evbvAH0DwHHGaTsR8qwT
         yXoFyVA6OIMChyclVqdZY/lViwiHl6V3HH8P0OHrzJsPveZse5aYycWymhgqjd9xM8
         n77zwnf/Xp913a44PdESU647deS82xQErKl6wUIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 095/183] drm/sun4i: backend: add missing of_node_puts
Date:   Mon, 25 Feb 2019 22:11:08 +0100
Message-Id: <20190225195110.696644933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bf49c55b0f2c7..9f27d5464804b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -704,17 +704,18 @@ static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
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



