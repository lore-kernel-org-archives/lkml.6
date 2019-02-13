Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9C6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB0721934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026333;
	bh=QWysNWTr6IRbzkiUuI+dLByNhfTvNgLMdVvF4P/w5dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iRy36oo/W28l5DxVm+fwEa63vcN62UhVXzo4GkRnJHkcDe28OfSj0EIyqKWPMIyME
	 KMOnVPUvVXe4F3NjSrum7bflYRvJPS0w4QrNDDwysEvl2Fh+fkjMCyFDxBPDrjtmK4
	 mn1fWMKcc9rmCcpG2x8RlCeoPoCh7DcrP0oDED/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbfBMCwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388574AbfBMCij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60744222C7;
        Wed, 13 Feb 2019 02:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025519;
        bh=QWysNWTr6IRbzkiUuI+dLByNhfTvNgLMdVvF4P/w5dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYXMyZXJFdhkp4xPlv9iByIuZtKoXpRjVjD+Mik4scYdau7b3WxTB54/WIEqEgFQt
         IwuEGpzGMFKyVXLAtynP99tRYxMCFcYBAaZfI+rY3yKMJSsfGGkMc/QrWPjU06ayxU
         mvQpj7VDDMMj1vodVJXF+bdC6ieofKe9MEyElKb8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 58/83] drm/meson: add missing of_node_put
Date:   Tue, 12 Feb 2019 21:36:36 -0500
Message-Id: <20190213023701.20286-58-sashal@kernel.org>
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
index bf5f294f172f..611ac340fb28 100644
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

