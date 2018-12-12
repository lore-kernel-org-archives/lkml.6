Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA6C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4FB20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE9dzQCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4FB20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLLA4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:56:20 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46409 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeLLAzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:52 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so13427388ios.13;
        Tue, 11 Dec 2018 16:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuTVzGlrd5P62PmG1C4j7pV1yedB7ZGV8yxuvoLTCUk=;
        b=nE9dzQCJntmbkZDYcuB0f+5CpI3dPJBVZLHrbsFI98fR9TAsoFsDQCEFQ1B7X4Co8S
         tecCA7jCXf/g7ddZOc+7TINyGNGhadYfqtBSdnYy7yx46RgqSZkdU4h+NUq5TbDvrfOp
         DUHqDMzxmZ/CuxIuynSpPmAB4XauAfGojrWAKcvXUTNUIOrbYb8ix+6rCsK2idISqqmG
         igJnceluGbxVNu4pl+p4x5IVuwWhDcz91DSOR6FKr9E4FrgDwJsW4+xYdR7vwr4hh3yO
         Q2km4flG5IWkAde0zyDZ1udb5qbfcBHlQ1AtXTcyA7NFbEuRgm81DfrFEplqMPw6s4FY
         Gamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuTVzGlrd5P62PmG1C4j7pV1yedB7ZGV8yxuvoLTCUk=;
        b=rutHdwu3r6ujBN85h+U423S3Bj2o4Vh1hZukcczUV2tCbisJRw3BeYHaOKieapK+Vc
         XoOSSxAjV7Fz4vsNx0HmI6qRNAfpzE5dS0O/J7/JEMqCtTL7yp38pPoj2PYJI8NQieIf
         /yltLgKCLeGTodhXFifwcfx+EcCE5PWh+tf8IR3fAM4BYVoUGs2n09964hioxg13F3w2
         kzSNlK6XM39zqLOkgLXywArMxawOQZzffvv/mQN1zkZJcLcb9WiEUewfM+/L9SEADUHF
         vjo7fRWokC2etfS7nutzRAXqVGxa2NMzscPJYJnIClRpyTZg7DE24NlQbYdsmKZlL5t+
         1gUQ==
X-Gm-Message-State: AA+aEWZpQ70VAL/XHlvUP8meOKV6PGs0My4PUWvqiBgKPv0bH8wNkde3
        2DdynD9M/Z7M3PgyaeFFzAM=
X-Google-Smtp-Source: AFSGD/XNg3HpCB72+QnrSv2pJhuwVhhGx9pLoGBz42yt8vFDigh25JESqZx8dWegswa6y605546pTA==
X-Received: by 2002:a5e:8f09:: with SMTP id c9mr2173301iok.241.1544576151886;
        Tue, 11 Dec 2018 16:55:51 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:51 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH 09/11] staging: iio: adt7316: remove dac vref buffer bypass from adt751x
Date:   Tue, 11 Dec 2018 17:55:01 -0700
Message-Id: <20181212005503.28054-10-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option to allow the external vref to bypass the reference buffer is
only available for adt7316/7/8. Remove the attributes for adt751x as
well as the chip->id checks from the show and store functions.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 3348fdf08f2e..bca599d8c51c 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -964,9 +964,6 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-		return -EPERM;
-
 	return sprintf(buf, "%d\n",
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
 }
@@ -981,9 +978,6 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	u8 dac_config;
 	int ret;
 
-	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-		return -EPERM;
-
 	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_AB);
 	if (buf[0] == '1')
 		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
@@ -1009,9 +1003,6 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-		return -EPERM;
-
 	return sprintf(buf, "%d\n",
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
 }
@@ -1026,9 +1017,6 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	u8 dac_config;
 	int ret;
 
-	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-		return -EPERM;
-
 	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_CD);
 	if (buf[0] == '1')
 		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
@@ -1713,8 +1701,6 @@ static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
 	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
 	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
 	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
 	&iio_dev_attr_VDD.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
-- 
2.19.1

