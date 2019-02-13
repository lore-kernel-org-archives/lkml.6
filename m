Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A71C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922DD222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025637;
	bh=i0Gho9LR7kLGRs0OK5eAqk15IXsGCyyoqPzUUEUFq3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U4t6Rbt/ZMmVJgqLC9tHgngGGkvfYm7QMllGckZH+5NzWkKN087isbK69jZc4UKfM
	 hubwkTDDZ0GYWTbJQibqqAqrSP5VL5nHnUIfSWYEMoYaxQhqFAuQPRYyMb59UJo1D3
	 jeiRAfeFie8QgjkbKEtFYEvvGu5CszRXEpdURdLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbfBMCkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389010AbfBMCkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F902222C2;
        Wed, 13 Feb 2019 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025630;
        bh=i0Gho9LR7kLGRs0OK5eAqk15IXsGCyyoqPzUUEUFq3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQINJi8rO5vVqx9YAOwd9pKRCaKpS8yKNE37U9KmTUfRsdQE242bWGay3M46gcStq
         TBUuoeKqVYOcW5I2cPbXETOZ9Dc9F1L5u8gUO9GCfphUq/hi6s0f/47j89FCuHz7ZZ
         hzaRlslN5mc+3XRbhBw071yz6n7Fhpk/Bo4NGcAg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 27/34] drm/meson: add missing of_node_put
Date:   Tue, 12 Feb 2019 21:39:45 -0500
Message-Id: <20190213023952.21311-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

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
index 4ad8223c60ea..5deb44ac6791 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -345,8 +345,10 @@ static int meson_probe_remote(struct platform_device *pdev,
 		remote_node = of_graph_get_remote_port_parent(ep);
 		if (!remote_node ||
 		    remote_node == parent || /* Ignore parent endpoint */
-		    !of_device_is_available(remote_node))
+		    !of_device_is_available(remote_node)) {
+			of_node_put(remote_node);
 			continue;
+		}
 
 		count += meson_probe_remote(pdev, match, remote, remote_node);
 
@@ -365,10 +367,13 @@ static int meson_drv_probe(struct platform_device *pdev)
 
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

