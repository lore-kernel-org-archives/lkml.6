Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED802146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zAIN2cvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED802146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbeK3BfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732084AbeK3BfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087A521479;
        Thu, 29 Nov 2018 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501786;
        bh=KIxA3Sl8roLGedwVi883FYcBGEtHyGFlIVeFwaZfNhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAIN2cvMLvOqx++dGlsQoYfZvdb6zgD8pGCC/vSacYbXCqyNucJOB6VVVtMUfhpGd
         fWuQACUlCd7rEI2C8RX3hJLLy9P5bRF3jTBbvBt7qgjBuIe+c12+HNxTyQUwsmaZ6o
         jhIsQzKcjINuMnpAjWiu5ToXBlsdsg8Ysj/7l1uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 040/110] drm/fb-helper: Blacklist writeback when adding connectors to fbdev
Date:   Thu, 29 Nov 2018 15:12:11 +0100
Message-Id: <20181129135922.880925714@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

commit 8fd3b90300bec541806dac271de2fd44e2e4e2d2 upstream.

Writeback connectors do not produce any on-screen output and require
special care for use. Such connectors are hidden from enumeration in
DRM resources by default, but they are still picked-up by fbdev.
This makes rather little sense since fbdev is not really adapted for
dealing with writeback.

Moreover, this is also a source of issues when userspace disables the
CRTC (and associated plane) without detaching the CRTC from the
connector (which is hidden by default). In this case, the connector is
still using the CRTC, leading to am "enabled/connectors mismatch" and
eventually the failure of the associated atomic commit. This situation
happens with VC4 testing under IGT GPU Tools.

Filter out writeback connectors in the fbdev helper to solve this.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>
Fixes: 935774cd71fe ("drm: Add writeback connector type")
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181115163248.21168-1-paul.kocialkowski@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fb_helper.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -200,6 +200,9 @@ int drm_fb_helper_single_add_all_connect
 	mutex_lock(&fb_helper->lock);
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		ret = __drm_fb_helper_add_one_connector(fb_helper, connector);
 		if (ret)
 			goto fail;


