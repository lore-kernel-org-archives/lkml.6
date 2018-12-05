Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C837A2087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGTW8VOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C837A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeLEJs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeLEJsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:48:54 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AB32087F;
        Wed,  5 Dec 2018 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003333;
        bh=vZPSzNYPMiOhOKC4E6xYUZ0lqyp+YSxDWyBqB4W23Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGTW8VOYAtDSfExYklj3+NbuzrKL1kC7qKRheCisJQvvh5ysPGV5elIE7s6SnK6ns
         QAxngEbXw82KeCzZYTcS5knJPHEr1a6I5CP5OsxLcRIQvT+PjlBV7jluZtnBnIOqrq
         NqCjIM76pUEn7v/GxFv2c1U5pknm6XGVrgLhh86c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Kelly <martin@martingkelly.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/45] iio:st_magn: Fix enable device after trigger
Date:   Wed,  5 Dec 2018 04:46:23 -0500
Message-Id: <20181205094706.7225-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

[ Upstream commit fe5192ac81ad0d4dfe1395d11f393f0513c15f7f ]

Currently, we enable the device before we enable the device trigger. At
high frequencies, this can cause interrupts that don't yet have a poll
function associated with them and are thus treated as spurious. At high
frequencies with level interrupts, this can even cause an interrupt storm
of repeated spurious interrupts (~100,000 on my Beagleboard with the
LSM9DS1 magnetometer). If these repeat too much, the interrupt will get
disabled and the device will stop functioning.

To prevent these problems, enable the device prior to enabling the device
trigger, and disable the divec prior to disabling the trigger. This means
there's no window of time during which the device creates interrupts but we
have no trigger to answer them.

Fixes: 90efe055629 ("iio: st_sensors: harden interrupt handling")
Signed-off-by: Martin Kelly <martin@martingkelly.com>
Tested-by: Denis Ciocca <denis.ciocca@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/magnetometer/st_magn_buffer.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 0a9e8fadfa9d..37ab30566464 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }
 
-static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
-{
-	return st_sensors_set_enable(indio_dev, true);
-}
-
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int err;
@@ -50,7 +45,7 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_magn_buffer_postenable_error;
 
-	return err;
+	return st_sensors_set_enable(indio_dev, true);
 
 st_magn_buffer_postenable_error:
 	kfree(mdata->buffer_data);
@@ -63,11 +58,11 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
+	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
 		goto st_magn_buffer_predisable_error;
 
-	err = st_sensors_set_enable(indio_dev, false);
+	err = iio_triggered_buffer_predisable(indio_dev);
 
 st_magn_buffer_predisable_error:
 	kfree(mdata->buffer_data);
@@ -75,7 +70,6 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
-	.preenable = &st_magn_buffer_preenable,
 	.postenable = &st_magn_buffer_postenable,
 	.predisable = &st_magn_buffer_predisable,
 };
-- 
2.17.1

