Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92E208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A92E208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933888AbeGFFua (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933849AbeGFFuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:20 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7504FBA2;
        Fri,  6 Jul 2018 05:50:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 19/61] drm/atmel-hlcdc: check stride values in the first plane
Date:   Fri,  6 Jul 2018 07:46:43 +0200
Message-Id: <20180706054713.080218768@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit 9fcf2b3c1c0276650fea537c71b513d27d929b05 upstream.

The statement always evaluates to true since the struct fields
are arrays. This has shown up as a warning when compiling with
clang:
  warning: address of array 'desc->layout.xstride' will always
      evaluate to 'true' [-Wpointer-bool-conversion]

Check for values in the first plane instead.

Fixes: 1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180617084826.31885-1-stefan@agner.ch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -889,7 +889,7 @@ static int atmel_hlcdc_plane_init_proper
 		drm_object_attach_property(&plane->base.base,
 					   props->alpha, 255);
 
-	if (desc->layout.xstride && desc->layout.pstride) {
+	if (desc->layout.xstride[0] && desc->layout.pstride[0]) {
 		int ret;
 
 		ret = drm_plane_create_rotation_property(&plane->base,


