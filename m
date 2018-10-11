Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE4CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BC621476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwcAPa9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BC621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeJKXEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeJKXEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:49 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4998420652;
        Thu, 11 Oct 2018 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272226;
        bh=r8k6geZFxQRskhmBxXdlOXCfoNAuhxcq2dmLNxtlljQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwcAPa9D6KfbLgA0VVZOxlnh2k1fWtOhs9gjqUDv3zjmTLyp4tneXhdweePErMBfB
         3ifm9qjdaFVYyanIeV9WF4jo8UdX4gu6zIIMkiYZckJOQchAnqpXyfXwGwQiH4Ilou
         wLTpDNU7kJdEodF8ndCagMc2iec+j4xzQ+8HzJos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 034/120] media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_power
Date:   Thu, 11 Oct 2018 17:33:35 +0200
Message-Id: <20181011152551.115629062@linuxfoundation.org>
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

[ Upstream commit 30ed2b83343bd1e07884ca7355dac70d25ffc158 ]

When the subdevice doesn't provide s_power core ops callback, the
v4l2_subdev_call for s_power returns -ENOIOCTLCMD.  If the subdevice
doesn't have the special handling for its power saving mode, the s_power
isn't required.  So -ENOIOCTLCMD from the v4l2_subdev_call should be
ignored.

Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/s3c-camif/camif-capture.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -117,6 +117,8 @@ static int sensor_set_power(struct camif
 
 	if (camif->sensor.power_count == !on)
 		err = v4l2_subdev_call(sensor->sd, core, s_power, on);
+	if (err == -ENOIOCTLCMD)
+		err = 0;
 	if (!err)
 		sensor->power_count += on ? 1 : -1;
 


