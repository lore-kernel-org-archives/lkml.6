Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F55C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D536421841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130330;
	bh=mOMIKj1FE+wkdemgzu7EgP8cuJqv+odtvLUZY3L+J7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S4Mm5cPIAWWDjO6k9AeWZg5mER5wot4Zilx/GngPe3Tj3yzdj9l39CBQKytpM12St
	 5D+h8LYacjAyhnla9DNtH5jG2CN7kc7pglIV/Eg1oVu2affRpiOOFG4OSGSrZcGNll
	 UrUt8xJTzWiFr3RcOqwmWBIiE+Bw40tRJtxaqw04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfBYVcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfBYVcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C40C321848;
        Mon, 25 Feb 2019 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130325;
        bh=mOMIKj1FE+wkdemgzu7EgP8cuJqv+odtvLUZY3L+J7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNCgY/CWgQy1c4DYu+p/wJkCK6OIoLQTigUd363xSK4B5HX05bB9LEGmHuXcSg7M6
         /TwKac7koKT9eSFhKL6BbWYHVz6uoIHvBzGA0BjWVeaOIXBb7wBymtkaRQfgCly9E1
         ZlYfKMkLOx0KZybNVI1aIbVxR4dhUB9+RV/SUjyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 085/183] drm/meson: add missing of_node_put
Date:   Mon, 25 Feb 2019 22:10:58 +0100
Message-Id: <20190225195108.848442384@linuxfoundation.org>
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

[ Upstream commit f672b93e4a0a4947d2e1103ed8780e01e13eadb6 ]

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
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1547372691-28324-4-git-send-email-Julia.Lawall@lip6.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index bf5f294f172fa..611ac340fb289 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -368,8 +368,10 @@ static int meson_probe_remote(struct platform_device *pdev,
 		remote_node = of_graph_get_remote_port_parent(ep);
 		if (!remote_node ||
 		    remote_node == parent || /* Ignore parent endpoint */
-		    !of_device_is_available(remote_node))
+		    !of_device_is_available(remote_node)) {
+			of_node_put(remote_node);
 			continue;
+		}
 
 		count += meson_probe_remote(pdev, match, remote, remote_node);
 
@@ -388,10 +390,13 @@ static int meson_drv_probe(struct platform_device *pdev)
 
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
-- 
2.19.1



