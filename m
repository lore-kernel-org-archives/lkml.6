Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD19C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FF620651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865587;
	bh=Nr+tUIyGCTHbFkOO7/q43tLrM3AV+MKjyR/s6CdMDq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LCOfYWqvsKXn5x9QEzv9ypK3JNqm42TCJujQH0bSslVtmE2ued440fyizZYB3dUoU
	 lVY6b3qrxdOtfsQSHE+QtLX6Cs4pZD+9WU4s1MvCgTkpsyO3vE3aAh3Vz+FccOQg2/
	 KcWUmkLBHYVHypzxYBTvTrmw5OUdL8tK/ume0S14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfAGMxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbfAGMxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:53:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9019D20651;
        Mon,  7 Jan 2019 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865584;
        bh=Nr+tUIyGCTHbFkOO7/q43tLrM3AV+MKjyR/s6CdMDq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vv6WY7KLi6M3dY/nvecLoU0DkO/0mzptnkYzlo6WB91vfiyncuVzYjQK1nyIsMDfb
         tk4lInZm3jIsqVa83i03NneDkbvTNHaApg4q6eyn6ESP/Czk7ZLs/O2QNutigcV0TG
         ERC8auLwRp11dBPVxZZmDQ2kuiaNHPS6gr/zvV10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 097/170] DRM: UDL: get rid of useless vblank initialization
Date:   Mon,  7 Jan 2019 13:32:04 +0100
Message-Id: <20190107104504.480211734@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit 32e932e37e6b6e13b66add307192c7ddd40a781d upstream.

UDL doesn't support vblank functionality so we don't need to
initialize vblank here (we are able to send page flip
completion events even without vblank initialization)

Moreover current drm_vblank_init call with num_crtcs > 0 causes
sending DRM_EVENT_FLIP_COMPLETE event with zero timestamp every
time. This breaks userspace apps (for example weston) which
relies on timestamp value.

Cc: stable@vger.kernel.org
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180928144126.21598-1-Eugeniy.Paltsev@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_main.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -350,15 +350,10 @@ int udl_driver_load(struct drm_device *d
 	if (ret)
 		goto err;
 
-	ret = drm_vblank_init(dev, 1);
-	if (ret)
-		goto err_fb;
-
 	drm_kms_helper_poll_init(dev);
 
 	return 0;
-err_fb:
-	udl_fbdev_cleanup(dev);
+
 err:
 	if (udl->urbs.count)
 		udl_free_urb_list(dev);


