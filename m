Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8630C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962B721852
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129820;
	bh=j+64R+eFmju8WDZnq5chn9ULiGkYwJKE6mtuec+6Gmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAbCYDvWShdnCjRXE+AXgi6wethxr9Zj/+bw698RU0OpoOHYiKTZft6mazNglANd0
	 d9yOiZ0awEA4ICToICIjKTgcn0dqv4zjWq1lQi4pT7v/o3zXJ4P/QUrDyL1+5YUUsx
	 gZBmMKCC6I5os58DEJqECNdwObEiUSH29lydliB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfBYVXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731115AbfBYVXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B65C21841;
        Mon, 25 Feb 2019 21:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129815;
        bh=j+64R+eFmju8WDZnq5chn9ULiGkYwJKE6mtuec+6Gmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqVCjn30/EnhhtnWoxZBFGNYKNepcEpDc7N37PVn3wmcOHNE4wixL3aZhK08srqRC
         SMssSDYCXlu1Rf1mdYARz1OXiL99QhIgQQzC/oqjSoYYr5QHgQfz+m3VHKiWYUgv2W
         nU9ptQ3IEI190ZPPYcBTnMIo2ansechAQgW6ooFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/152] drm/sun4i: backend: add missing of_node_puts
Date:   Mon, 25 Feb 2019 22:11:09 +0100
Message-Id: <20190225195048.446846092@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index d7950b52a1fd9..e30b1f5b9d91a 100644
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



