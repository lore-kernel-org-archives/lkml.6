Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F286C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F992146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wHmuXPun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F992146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeLDLJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbeLDLJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA437214F1;
        Tue,  4 Dec 2018 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921754;
        bh=FnTNQ7yGqM0FCbmxrzJlbyoZSRG1bUnf4not8H9g2nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHmuXPuneUvon2JGlrZqh3RnJjS/IncJ4AmiXPetzrD4R0njNGQ5YIQ4l7fcP3DFR
         dZJ9rN2h1v/e4VRyIF956agy1Ip0dLBSpo7AH9MFAxvjPAwp42CchvJL3brMmpSGW4
         i8sV2J0/5u6TCkwqWajpiYRkBErSDh+M1w2tSbdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kelly <martin@martingkelly.com>,
        Denis Ciocca <denis.ciocca@st.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 39/50] iio:st_magn: Fix enable device after trigger
Date:   Tue,  4 Dec 2018 11:50:34 +0100
Message-Id: <20181204103716.461659198@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <martin@martingkelly.com>

commit fe5192ac81ad0d4dfe1395d11f393f0513c15f7f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/magnetometer/st_magn_buffer.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_tr
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
@@ -50,7 +45,7 @@ static int st_magn_buffer_postenable(str
 	if (err < 0)
 		goto st_magn_buffer_postenable_error;
 
-	return err;
+	return st_sensors_set_enable(indio_dev, true);
 
 st_magn_buffer_postenable_error:
 	kfree(mdata->buffer_data);
@@ -63,11 +58,11 @@ static int st_magn_buffer_predisable(str
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
@@ -75,7 +70,6 @@ st_magn_buffer_predisable_error:
 }
 
 static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
-	.preenable = &st_magn_buffer_preenable,
 	.postenable = &st_magn_buffer_postenable,
 	.predisable = &st_magn_buffer_predisable,
 };


