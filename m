Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F06C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EF32063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078609;
	bh=goEdTK1jOzgAjU86lNPAZ90KzQkMKGm9/vkyCm+5YNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wzPD55GjLwlHfkGAKPcDbfqn9IOKqb7prcb0HVc0fdClMsZsA6mhtfsup9lNojoI4
	 aJRYPDr5Rwsc2hImVE/SYpOFA2tySLwvGr0I/7LKXnk7KLpKO0P/Yn+GMULy2lVDne
	 yeCAHvGoibVWqDye07/obT8RtcvdbjAZZ954zPsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfAUNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfAUNuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FE62063F;
        Mon, 21 Jan 2019 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078605;
        bh=goEdTK1jOzgAjU86lNPAZ90KzQkMKGm9/vkyCm+5YNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuFJfvU3kvY3oAvBRlRS2RkmsDUnQA+qqTi9aSOgybB4wRyyHj82fwyP0hJZ9Izyh
         NqRM8k1SU1uWRWWLvPV3x7zwD27tyO8qUbbn8kk8paOfD2BHpd0DR8Fl01bqGbujGK
         1actNrerYLgH/QC0PK3W5Je+/U1Lg2/6oIUE7d44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.20 053/111] drm/rockchip: add missing of_node_put
Date:   Mon, 21 Jan 2019 14:42:47 +0100
Message-Id: <20190121122501.753575312@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit a17ce9960b3628b9f546c454741a1cad551d5695 upstream.

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Fixes: 1f0f01515172 ("drm/rockchip: Add support for Rockchip Soc RGB output interface")
Cc: stable@vger.kernel.org
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
[added fixes and cc-stable]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/1547369264-24831-4-git-send-email-Julia.Lawall@lip6.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_rgb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -113,8 +113,10 @@ struct rockchip_rgb *rockchip_rgb_init(s
 		child_count++;
 		ret = drm_of_find_panel_or_bridge(dev->of_node, 0, endpoint_id,
 						  &panel, &bridge);
-		if (!ret)
+		if (!ret) {
+			of_node_put(endpoint);
 			break;
+		}
 	}
 
 	of_node_put(port);


