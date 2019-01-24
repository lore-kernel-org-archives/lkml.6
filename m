Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C918DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9792184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWptCaMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfAXO2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:28:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43765 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfAXO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:28:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so3052408pfk.10;
        Thu, 24 Jan 2019 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ISfaXsr2H24qrZQzKQBAmGRhlucCPOZ3M80vrtSDgLY=;
        b=mWptCaMCN7bd8aR6Hwbj9k8Ot4wLMsQQRTtZnQFmunq+TaS6LbT2kuexHlxbhLTewz
         FlC7tJ7/Klj0q7Bq7X6hrbgm0gKeL5nGh5ovSsXg441qmJOgvFBsKHOVy2ULAO+XxV/Q
         v/WpOHQS/bY/F73PFLtCuR3+PDFIAyQqyGP/yGeUgUVqdMyE67sPY699sYYB6LiZ8iQ/
         /5JMurrqK2IOEF1I21pR6zm9sjddCK02MBAFvrEhX/dVJGP7atnSIcOJajLoJoc1ujdj
         9LSFwNUQaFX2OWXQI/wWkiZCEqXloPRefUdZIWPeBR+HaDcUlfWc2K1lVFGyjjw1wmtN
         rMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ISfaXsr2H24qrZQzKQBAmGRhlucCPOZ3M80vrtSDgLY=;
        b=CKkHbZcFOkAhHba67MrWA5GK/VvvZ6oU0un8ncYA2ZXn/9aMwTz/wAFMTOtmhE20t8
         /I1hjhsjRNbZmC69oSAv5/ai+eAsOV4sO2sxAM6o8TUoLg+hzWU3GHZbhVmy50Yr+CPV
         QmAwAHdhnEhLUQ2/3VUPsHKP7gGp93kWHsxHe25q9Y4b5PiCsaaZgKli2y6XCCe1/AG9
         dcFD0MdzqzUfnXRU9ImIEyOECSFs8A21bo5p1DpE5zjVhRuUneoGHJXCKK1dsDOfN/sl
         hoQD+wUb1gsWg+NTNefVFz5HqnZT4CEEjohwCVkvsVVJmz8zsESHcllQ6pwFVJFsg5TD
         zfFg==
X-Gm-Message-State: AJcUukcfz0bdO9m1X5tzgKEvM6eOQ7Yec7oP18BiU9KZMKQglZyjuxs7
        fvQQ/QtUVZ/bsFCo6vEM1U2PNTyF
X-Google-Smtp-Source: ALg8bN7/6q3RmJ7eQcrEWoU43XoPDofZ25C2M1aQCdRWyM5UBkKQ6hAZufqoOVIVRjaNLhx87DaCcQ==
X-Received: by 2002:a62:d148:: with SMTP id t8mr6859659pfl.52.1548340085746;
        Thu, 24 Jan 2019 06:28:05 -0800 (PST)
Received: from bhar12345-VirtualBox ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id o66sm37705825pgo.75.2019.01.24.06.28.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 06:28:05 -0800 (PST)
Date:   Thu, 24 Jan 2019 19:58:00 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: iio: industrialio-core: add check when kzalloc fails
Message-ID: <20190124142755.GA31059@bhar.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add code to handle the case when kzalloc fails to allocate memory to dev

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/iio/industrialio-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4f5cd9f..93caa6b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1475,6 +1475,8 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 		}
 		dev_set_name(&dev->dev, "iio:device%d", dev->id);
 		INIT_LIST_HEAD(&dev->buffer_list);
+	} else {
+		return NULL;
 	}
 
 	return dev;
-- 
2.7.4

