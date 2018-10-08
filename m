Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9CC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83F120645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYTcYb7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83F120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbeJICDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJICDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB35E20645;
        Mon,  8 Oct 2018 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024614;
        bh=d/ZDRNOj/icCD3qPdOlVQM1xUNNsjlk/BdwdVwPf6kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYTcYb7SJM+CBgvNukqzxCCKilDE64gU9zqOpBI+JcZrVnGJse9vRQlHGmkDUypDz
         N5nHwycbeq5t7VIX1vdG/E8EKCGaQ/KnWXHz2ZVvU+0sMIlzy2JG4ahoLiwttO4xcY
         jSeBcTu0jOEEKIUoZmJoqGoa7qVv40zdDkXYGkOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 097/168] iio: imu: st_lsm6dsx: take into account ts samples in wm configuration
Date:   Mon,  8 Oct 2018 20:31:17 +0200
Message-Id: <20181008175623.750764084@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit a13bf65f3f2e36008ea60b49d3bda2527e09fd9c ]

Take into account hw timer samples in pattern length computation done
in st_lsm6dsx_update_watermark routine for watermark configuration.
Moreover use samples in pattern (sip) already computed in
st_lsm6dsx_update_decimators routine

Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -187,12 +187,15 @@ static int st_lsm6dsx_set_fifo_odr(struc
 
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 {
-	u16 fifo_watermark = ~0, cur_watermark, sip = 0, fifo_th_mask;
+	u16 fifo_watermark = ~0, cur_watermark, fifo_th_mask;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	struct st_lsm6dsx_sensor *cur_sensor;
 	int i, err, data;
 	__le16 wdata;
 
+	if (!hw->sip)
+		return 0;
+
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		cur_sensor = iio_priv(hw->iio_devs[i]);
 
@@ -203,14 +206,10 @@ int st_lsm6dsx_update_watermark(struct s
 						       : cur_sensor->watermark;
 
 		fifo_watermark = min_t(u16, fifo_watermark, cur_watermark);
-		sip += cur_sensor->sip;
 	}
 
-	if (!sip)
-		return 0;
-
-	fifo_watermark = max_t(u16, fifo_watermark, sip);
-	fifo_watermark = (fifo_watermark / sip) * sip;
+	fifo_watermark = max_t(u16, fifo_watermark, hw->sip);
+	fifo_watermark = (fifo_watermark / hw->sip) * hw->sip;
 	fifo_watermark = fifo_watermark * hw->settings->fifo_ops.th_wl;
 
 	err = regmap_read(hw->regmap, hw->settings->fifo_ops.fifo_th.addr + 1,


