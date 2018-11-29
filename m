Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60649C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201072145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmeaFmrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201072145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbeK3BiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732444AbeK3BiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792B821479;
        Thu, 29 Nov 2018 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501952;
        bh=4xgbVYKVSXzc2Up8aVF55027pFoTGepbOlp7WWB/Ve0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmeaFmrwIKcXnnMlh57TwEVR/N0g/Q3Q/eoVLpJPxi1XH03DyjAsczJSlPL7Ok0CZ
         4QqdiAQwoQLCVT7AL8AmgbFNq/2RWtM2o4PZoQjmlnPCM8bI/EY3JGg+PASvRBt0Q/
         3XjWMoIBggMJ9T8CbRsrR823OtlrH2/b8VLdaEqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.19 109/110] media: ov5640: fix wrong binning value in exposure calculation
Date:   Thu, 29 Nov 2018 15:13:20 +0100
Message-Id: <20181129135925.683018052@linuxfoundation.org>
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

From: Hugues Fruchet <hugues.fruchet@st.com>

commit c2c3f42df4dd9bb231d756bacb0c897f662c6d3c upstream.

ov5640_set_mode_exposure_calc() is checking binning value but
binning value read is buggy, fix this.
Rename ov5640_binning_on() to ov5640_get_binning() as per other
similar functions.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov5640.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1384,7 +1384,7 @@ static int ov5640_set_ae_target(struct o
 	return ov5640_write_reg(sensor, OV5640_REG_AEC_CTRL1F, fast_low);
 }
 
-static int ov5640_binning_on(struct ov5640_dev *sensor)
+static int ov5640_get_binning(struct ov5640_dev *sensor)
 {
 	u8 temp;
 	int ret;
@@ -1392,8 +1392,8 @@ static int ov5640_binning_on(struct ov56
 	ret = ov5640_read_reg(sensor, OV5640_REG_TIMING_TC_REG21, &temp);
 	if (ret)
 		return ret;
-	temp &= 0xfe;
-	return temp ? 1 : 0;
+
+	return temp & BIT(0);
 }
 
 static int ov5640_set_binning(struct ov5640_dev *sensor, bool enable)
@@ -1479,7 +1479,7 @@ static int ov5640_set_mode_exposure_calc
 	if (ret < 0)
 		return ret;
 	prev_shutter = ret;
-	ret = ov5640_binning_on(sensor);
+	ret = ov5640_get_binning(sensor);
 	if (ret < 0)
 		return ret;
 	if (ret && mode->id != OV5640_MODE_720P_1280_720 &&


