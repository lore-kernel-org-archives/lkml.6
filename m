Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CEBC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB6220874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="GHeQ03pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB6220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeFQIsw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:48:52 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43728 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeFQIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:48:50 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id ABF885C037A;
        Sun, 17 Jun 2018 10:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529225329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=ZjvNVXWFdRVsCVQNAEc1HToxaABQiBl/rg5vop04hj0=;
        b=GHeQ03pvQj+f4rB8Gl6uihwrhOv7wKULqDXY8e1F6j1b5n8WQqiSmyvE3KG+qEU8ROI2lm
        cOgHK9GhglBASoxSEi54ClEH+6DA76Sum6Dv6iADg8dmSpvWGPazsTim8+6TmFDKOMmgkT
        VE8LLRu5pwZ/HMS/gYC14r4uKhrOeCs=
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Stefan Agner <stefan@agner.ch>, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/atmel-hlcdc: check stride values in the first plane
Date:   Sun, 17 Jun 2018 10:48:22 +0200
Message-Id: <20180617084826.31885-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The statement always evaluates to true since the struct fields
are arrays. This has shown up as a warning when compiling with
clang:
  warning: address of array 'desc->layout.xstride' will always
      evaluate to 'true' [-Wpointer-bool-conversion]

Check for values in the first plane instead.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Check for first value instead of dropping if statement
  (subject was: drm/atmel-hlcdc: remove unnecessary if statement)

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 73c875db45f4..47e0992f3908 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -839,7 +839,7 @@ static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
 			return ret;
 	}
 
-	if (desc->layout.xstride && desc->layout.pstride) {
+	if (desc->layout.xstride[0] && desc->layout.pstride[0]) {
 		int ret;
 
 		ret = drm_plane_create_rotation_property(&plane->base,
-- 
2.17.1

