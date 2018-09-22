Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59235C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112AC21476
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VArYk0Zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112AC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeIWDAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 23:00:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36006 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIWDAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 23:00:50 -0400
Received: by mail-io1-f68.google.com with SMTP id q5-v6so15001388iop.3;
        Sat, 22 Sep 2018 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHsv1kVPjHiFN5CDlRUXNfvFEO14wRvjZvBGLfsjNrM=;
        b=VArYk0ZwKqfpsu23LJuTDU/QXaSYybhX7viKFjGC0ehAhGUHMXvkco/e9X+s1PaYnh
         LG5X1EvwDsvlndjAOFEOwzNllAdpE5/gill6AZ1beu4WLyxgfQo5bL8rPSGTlp6QmI3F
         gl2vsdjvIkRKkjenLFS0gZfL3gB2+Jd/9dezchLyrfkdRnni5WAUN4wq9VFNwNfih809
         luKAL8PjqOiCacAKNDC73kQoaSpLjzluP+N6GlkAPJZET+i2CCzu8EN7GynnPBg7nCm/
         i3s6tDP+X78u7Dj9LTPJvRRwXrW0ncc5rGMzYEiqhJaNSqyGw4Gm+ejNYJ0xY1N0i7ui
         KaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHsv1kVPjHiFN5CDlRUXNfvFEO14wRvjZvBGLfsjNrM=;
        b=LE6wEcitc+xB0De01Bj4q1KWZssyI0zY+YU8fq2utnqUcjhsDYht1MWDgt5yPedIOs
         iehTQf8s03i2aBXJmf9Ypem5BfPq151TaYnrQLRePynfzyuD9GUPgssc1Gl9Zhp+EjMy
         irWAlnMyrVMwcIBOcrO085kQ2n4SPi0+9cDQGDWATAYQhofBY1fsw+vObmOe3ZqxQQ6F
         uUd7I1Kj5sXLS8IAmaBN7GNjSJ8vp/fUsd1uFSctiL/cVvHq+/72wgcPQTSdIbZlY+X+
         R5nkcSXT5l9LNMkyHTyoNNBwxo15e/9fA34UVbqmz0K9bPJSwoj73qY3uDaP15WwH/7i
         9XXA==
X-Gm-Message-State: ABuFfojtvOaCsAILtzrf79qFVKJ8WzGp90pJiDlrGMOywFKBSnt0R0Ni
        85ETeJN8pJZOHFVax0b3K8CPA+0=
X-Google-Smtp-Source: ACcGV62YtLsrDAoH/94g4LL+VX7tiOGbBk3M3U//7DKR05phQR63172XE89p+1Y6MeJcBAG4OLQz3A==
X-Received: by 2002:a6b:9704:: with SMTP id z4-v6mr3035101iod.110.1537650353284;
        Sat, 22 Sep 2018 14:05:53 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id t24-v6sm4206532ite.12.2018.09.22.14.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 14:05:52 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v3 2/2] iio: light: bh1750: Add device tree support
Date:   Sat, 22 Sep 2018 17:05:39 -0400
Message-Id: <20180922210539.6670-2-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922210539.6670-1-decatf@gmail.com>
References: <20180922210539.6670-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for ROHM BH1750 series ambient light sensors.

Signed-off-by: ryang <decatf@gmail.com>
---
Changes in v2:
     - Export module device table
Changes in v3:
     - Remove of_match_ptr so that bh1750_of_match is available
       without CONFIG_OF.

 drivers/iio/light/bh1750.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index c3a481452b67..28347df78cff 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -307,9 +307,20 @@ static const struct i2c_device_id bh1750_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bh1750_id);
 
+static const struct of_device_id bh1750_of_match[] = {
+	{ .compatible = "rohm,bh1710", },
+	{ .compatible = "rohm,bh1715", },
+	{ .compatible = "rohm,bh1721", },
+	{ .compatible = "rohm,bh1750", },
+	{ .compatible = "rohm,bh1751", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bh1750_of_match);
+
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
+		.of_match_table = bh1750_of_match,
 		.pm = &bh1750_pm_ops,
 	},
 	.probe = bh1750_probe,
-- 
2.17.1

