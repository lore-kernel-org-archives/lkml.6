Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D083C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8762064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8762064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbeJBUR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbeJBUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:28 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 623DC5AA;
        Tue,  2 Oct 2018 13:34:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 060/137] drm/sun4i: Fix releasing node when enumerating enpoints
Date:   Tue,  2 Oct 2018 06:24:21 -0700
Message-Id: <20181002132502.720598530@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit 367c359aa8637b15ee8df6335c5a29b7623966ec ]

sun4i_drv_add_endpoints() has a memory leak since it uses of_node_put()
when remote is equal to NULL and does nothing when remote has a valid
pointer.

Invert the logic to fix memory leak.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180625120304.7543-7-jernej.skrabec@siol.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -241,7 +241,6 @@ static int sun4i_drv_add_endpoints(struc
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote) {
 			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
-			of_node_put(remote);
 			continue;
 		}
 
@@ -255,11 +254,13 @@ static int sun4i_drv_add_endpoints(struc
 
 			if (of_graph_parse_endpoint(ep, &endpoint)) {
 				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				of_node_put(remote);
 				continue;
 			}
 
 			if (!endpoint.id) {
 				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
+				of_node_put(remote);
 				continue;
 			}
 		}


