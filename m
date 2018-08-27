Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BECC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C196B208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QXwCd4Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C196B208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeH1BDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:03:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeH1BDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:03:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4-v6so142130pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oK18RL5nMDdxorNofXFtMAgaKE7Iu1U3uDnzVrof+e0=;
        b=QXwCd4Ut2GosyYWwdhvRl/9M4f+jxjyZUvIZ56CDrdyFDZSHXtxBJyn0AKHVfW3xiZ
         +ZW3FJVHzdmbe62mK2E9x2Runw3U5VLzsLok+pfB19TZFbpu4+oZ28LayYvfVR8nLtjR
         3ehg1Man356QdWA5otgoKyH5OeQ0l0noJUyoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oK18RL5nMDdxorNofXFtMAgaKE7Iu1U3uDnzVrof+e0=;
        b=dKExmwFB+/sWN9yIo3nlZK7OuQa3Gmk9/TRtDJ3DxeVq0PNoZ8IULqlvW8sy0sg7+V
         T8zlk1IsHdAcHZClNM7H0I2v61VaHisWPeeeL8Ew3efkn4C5Q7xRgTgr+/DujyLtLKDz
         isSo+ALDrDrcpsdc4LQxjl1xLWpHJreGRU/3Y2IKmKtQ+LnETSxie80LYmG9KIspXJbo
         xyd93VyxMhHAB/WUoJ8PEOePI8UNywpCLOdkYbWL8Lvza8sKBGLAcf+3L+kye7SDhNYj
         w8bwxdsCPG1Sb+ZFcX9KeB74YYdtzwK3M4rz7QQWQD7KKIMopMLfXDokEBgYTYU/Y+27
         sAFg==
X-Gm-Message-State: APzg51AVVPEdYCklopkt4e143tCjJj30xy2lnVfI2C76Q9qawW00/i62
        Hg7pEsR8zgg7DxvVAxUUCMnoFA==
X-Google-Smtp-Source: ANB0VdYKYNPGrzyuCLp64Y/niVzrlow2jKvBG9OzDVvarL5vcb4ogGAESp1HJ/fkFxXvx6K4uhf+9g==
X-Received: by 2002:a63:c50c:: with SMTP id f12-v6mr13904679pgd.113.1535404500894;
        Mon, 27 Aug 2018 14:15:00 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id h132-v6sm238699pfc.100.2018.08.27.14.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 14:15:00 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] iio: adc: qcom-spmi-adc5: Verify channel numbers from DT
Date:   Mon, 27 Aug 2018 14:14:53 -0700
Message-Id: <20180827211453.213061-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only defines a subset of all possible ADC channels. Channel
numbers read from the device tree are accepted as long as they don't
exceed a max value, even when no channel definition exists. Add a
check to abort initialization in this case.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 9c8e6f9e8248..ab5bec917c0a 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -519,7 +519,8 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		return ret;
 	}
 
-	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA) {
+	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA ||
+	    !data->adc_chans[chan].datasheet_name) {
 		dev_err(dev, "%s invalid channel number %d\n", name, chan);
 		return -EINVAL;
 	}
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

