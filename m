Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4723FC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F331F21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iivOfjtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F331F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeJKXEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeJKXEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066FA2098A;
        Thu, 11 Oct 2018 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272229;
        bh=B6lPUngRzaN1gWWxeO8Hd1PwbGwYK/NrnN2JJK1/Xs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iivOfjtjpUMdhNpYy8gAkWanq9UYnL7HR0UqG1LsYv6LZ3VZJNYpsjW8GuDfCWAo7
         wT4fY34tn7FtF1lxOAwtMdJKwUK177VRUJArJ1Wj2xlekAjrflBUhDypElgelqrfw/
         4YtwRK1az/oJVug1UW6/pgsgoOdwEVWBp/KMSBQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 035/120] media: soc_camera: ov772x: correct setting of banding filter
Date:   Thu, 11 Oct 2018 17:33:36 +0200
Message-Id: <20181011152551.171892742@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 22216ec41e919682c15345e95928f266e8ba6f9e ]

The banding filter ON/OFF is controlled via bit 5 of COM8 register.  It
is attempted to be enabled in ov772x_set_params() by the following line.

	ret = ov772x_mask_set(client, COM8, BNDF_ON_OFF, 1);

But this unexpectedly results disabling the banding filter, because the
mask and set bits are exclusive.

On the other hand, ov772x_s_ctrl() correctly sets the bit by:

	ret = ov772x_mask_set(client, COM8, BNDF_ON_OFF, BNDF_ON_OFF);

The same fix was already applied to non-soc_camera version of ov772x
driver in the commit commit a024ee14cd36 ("media: ov772x: correct setting
of banding filter")

Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/soc_camera/ov772x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/soc_camera/ov772x.c
+++ b/drivers/media/i2c/soc_camera/ov772x.c
@@ -834,7 +834,7 @@ static int ov772x_set_params(struct ov77
 	 * set COM8
 	 */
 	if (priv->band_filter) {
-		ret = ov772x_mask_set(client, COM8, BNDF_ON_OFF, 1);
+		ret = ov772x_mask_set(client, COM8, BNDF_ON_OFF, BNDF_ON_OFF);
 		if (!ret)
 			ret = ov772x_mask_set(client, BDBASE,
 					      0xff, 256 - priv->band_filter);


