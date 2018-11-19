Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D93C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D78E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1z15sTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D78E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbeKTDPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbeKTDPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 111B7214C4;
        Mon, 19 Nov 2018 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646292;
        bh=jeRzmLgxtG6+Sc/qz0UbWCiiDV+iV99FvfwJUzIL3mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1z15sTvx6eRxMppt0fM3swKeTsVbhq00Ar3v53lzYeclZvlDdj5lx9el2Lnco52c
         abv88rZSSB/4hE1kDyrKT2gfsJ2t6N09FxAfd6wa120Y+PMNZXc14vzqqmjIkG9Bnt
         Z5EGjtBAVIQEyh+A+7v3YZR50aR+fNvUOw510ugc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.14 109/124] drm/nouveau: Check backlight IDs are >= 0, not > 0
Date:   Mon, 19 Nov 2018 17:29:23 +0100
Message-Id: <20181119162632.432140889@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit dc854914999d5d52ac1b31740cb0ea8d89d0372e upstream.

Remember, ida IDs start at 0, not 1!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_backlight.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -116,7 +116,7 @@ nv40_backlight_init(struct drm_connector
 				       &nv40_bl_ops, &props);
 
 	if (IS_ERR(bd)) {
-		if (bl_connector.id > 0)
+		if (bl_connector.id >= 0)
 			ida_simple_remove(&bl_ida, bl_connector.id);
 		return PTR_ERR(bd);
 	}
@@ -249,7 +249,7 @@ nv50_backlight_init(struct drm_connector
 				       nv_encoder, ops, &props);
 
 	if (IS_ERR(bd)) {
-		if (bl_connector.id > 0)
+		if (bl_connector.id >= 0)
 			ida_simple_remove(&bl_ida, bl_connector.id);
 		return PTR_ERR(bd);
 	}


