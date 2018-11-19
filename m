Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C0A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0OFsKbYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C0A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeKTDCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbeKTDB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:01:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7543F2147D;
        Mon, 19 Nov 2018 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645470;
        bh=2+nvyawONrROMz4zJNn3TyuLcKqtJftwv5R+3XhNQdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0OFsKbYTqMACVgV19HTpPv+tReb2Yj+rqgBBk6x9e8VdqTK4wt2vsbvzlNtbnMPts
         ervAsheT56vvH8kiZr8dm7rjhmNtwdyuB99RufevLQfCDmhoX8o1QAChGoIB8vShyy
         qB9B295BsnVq4JQjbnvXiEFAhBxOeYuWIkiddjWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 173/205] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Date:   Mon, 19 Nov 2018 17:28:00 +0100
Message-Id: <20181119162640.634190091@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit 7f3ef5dedb146e3d5063b6845781ad1bb59b92b5 upstream.

Leaving the DRM driver enabled on reboot or kexec has the annoying
effect of leaving the display generating transactions whilst the
IOMMU has been shut down.

In turn, the IOMMU driver (which shares its interrupt line with
the VOP) starts warning either on shutdown or when entering the
secondary kernel in the kexec case (nothing is expected on that
front).

A cheap way of ensuring that things are nicely shut down is to
register a shutdown callback in the platform driver.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20180805124807.18169-1-marc.zyngier@arm.com
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -442,6 +442,11 @@ static int rockchip_drm_platform_remove(
 	return 0;
 }
 
+static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
+{
+	rockchip_drm_platform_remove(pdev);
+}
+
 static const struct of_device_id rockchip_drm_dt_ids[] = {
 	{ .compatible = "rockchip,display-subsystem", },
 	{ /* sentinel */ },
@@ -451,6 +456,7 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_
 static struct platform_driver rockchip_drm_platform_driver = {
 	.probe = rockchip_drm_platform_probe,
 	.remove = rockchip_drm_platform_remove,
+	.shutdown = rockchip_drm_platform_shutdown,
 	.driver = {
 		.name = "rockchip-drm",
 		.of_match_table = rockchip_drm_dt_ids,


