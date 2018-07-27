Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC37C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E49208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Cxm+AzeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E49208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeG0Pq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:46:57 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:16752 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbeG0Pq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1532701483;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=YYMZK4ZnMv/M+G6EFea+OYpX2GDfqLagilnIZ9Orguk=;
        b=Cxm+AzeWR0dgIukU4gQUN8fnTu1g604DY3kzgnKCoVN3QSXnFRf4TcRLEB4B8jRHpM
        iF2R+qkh+I2zdDN8Nfi1Yd64+C9SN33CYTbEO042W9dMWefcL/8+uZCFka39/BGx5SLf
        jCkBHcpg1Iam0puwVAI2UEHYV/fFwfBpjFUJc+pRdNiFi21p1Hx5E1M0qNEw5YYwu+dW
        6F/CMv/1g0o6GxBoVWl4EZiJqPzF7Bl3nc1mSlhm0xT5PpFyLuyEhyk8Y4uA/cs1Pubi
        hp6dfCpwI6W+EVdd+bzTlxoXHXUqAY2/cxAMOZA7cmujsE0SJcpyBoNpxBmtJ0HKRDrB
        n/YA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZeJAL4="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6REOZnfw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 27 Jul 2018 16:24:35 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sebastian Reichel <sre@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Andrew F. Davis" <afd@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org
Subject: [PATCH] drm: omapdrm: displays: fix port_num for opa362 output
Date:   Fri, 27 Jul 2018 16:24:32 +0200
Message-Id: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opa362 amplifier has two ports, an input (usually connected
to the OMAP3 VENC) and an output port connected to the external
connector.

These are usually defined as input port@0 and outpt port@1 in
the DT and really distinguished by the reg = <port_num> property
of these nodes.

But we are missing to define the output port as number 1 so
it does not match the DT entry.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
index afee1b8b457a..296d46f060b2 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
@@ -208,6 +208,7 @@ static int opa362_probe(struct platform_device *pdev)
 	dssdev->type = OMAP_DISPLAY_TYPE_VENC;
 	dssdev->output_type = OMAP_DISPLAY_TYPE_VENC;
 	dssdev->owner = THIS_MODULE;
+	dssdev->port_num = 1;	/* second port */
 
 	r = omapdss_register_output(dssdev);
 	if (r) {
-- 
2.12.2

