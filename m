Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E611FC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200320855
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOJtOOj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeLLAzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:55:53 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38531 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeLLAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:49 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so13449296ioj.5;
        Tue, 11 Dec 2018 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqAI0hgInZRj/HqBspWobjcKVjc1X8/CWrZ8LYW+zYw=;
        b=rOJtOOj1/y0YQUdYJ6Z0+0sKiPNOzB6zvmboZBJGRE2W2t3EWjhe9w/TD5V7rP4n1y
         C+FvH/UmfcZ+FBWdJX2lj9EFh4mSTpFfJ0DEzyrT3LwELXen1MLNLbDmHWV8IKpdhnx8
         kNzLv7z6vnEFNgXiEqHqw8Xj/eRqfI03MN3s7+MOCyhqcYs4zXVpkJXgIYyrydOqxZs6
         HtIKyXG4A7bibmbeQfRYaCPj+k2IsN99SWBZotuE8oH6tv+YGtJdiN9e7PeC122jNk2a
         y9fTMr2ZOu6Td0UJuzzp7beNEWESvLf+1L2kqNTWKLjsux+lhW+8yHUXnNHJ/i4lCqoE
         ebNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqAI0hgInZRj/HqBspWobjcKVjc1X8/CWrZ8LYW+zYw=;
        b=SRxRZTo/wHeA8lbB24jazJFdWGLddOQlEY/YdAPNkXTgHSweNed7CfNahkMRt1xaWn
         ocP21wI4Ui2OGTN41/QnprR24QDXDwyrvHNFmuUvLsoDN65fYgP97t+oZNa9OcSkob0/
         iNrE1dnXgRwJaVMJebFtx99PpoE98wTcP/NNbap0kJlvzOzUsYm0kPXtwY86Y4SSsziZ
         8gRiy8UP9ZqPOQg768UwQRkHqpu+YKP5JWN3KhLeLpzFispH9fRAYZZ1ONflmudOZIqG
         4sa6J+EKHct7RS9VzRYGyxcHCgkisu+YkU2DVHo0f4dBAd9urdVxFfSE/IhYA/Yte2mr
         Hzww==
X-Gm-Message-State: AA+aEWbf75Prs78mij9x5SZaUE5kOH+1Mee9XdQ0W243kFxC8UupYRwC
        SJ+aEz2hzijz4wFNBDhYaHI=
X-Google-Smtp-Source: AFSGD/WObtNO2qHxwlg71Fiw23sLuwOvHNO26nAw9w3l66/EHzGSTgS52c7Iqpgn//u6SlEKq02mTw==
X-Received: by 2002:a6b:b28a:: with SMTP id b132mr15048308iof.256.1544576148191;
        Tue, 11 Dec 2018 16:55:48 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:47 -0800 (PST)
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
Subject: [PATCH 05/11] staging: iio: adt7316: fix the dac read calculation
Date:   Tue, 11 Dec 2018 17:54:57 -0700
Message-Id: <20181212005503.28054-6-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation of the current dac value is using the wrong bits of the
dac lsb register. Create two macros to shift the lsb register value into
lsb position, depending on whether the dac is 10 or 12 bit. Initialize
data to 0 so, with an 8 bit dac, the msb register value can be bitwise
ORed with data.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index eee7c04f93f4..b7d12d003ddc 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -47,6 +47,8 @@
 #define ADT7516_MSB_AIN3		0xA
 #define ADT7516_MSB_AIN4		0xB
 #define ADT7316_DA_DATA_BASE		0x10
+#define ADT7316_DA_10_BIT_LSB_SHIFT	6
+#define ADT7316_DA_12_BIT_LSB_SHIFT	4
 #define ADT7316_DA_MSB_DATA_REGS	4
 #define ADT7316_LSB_DAC_A		0x10
 #define ADT7316_MSB_DAC_A		0x11
@@ -1403,7 +1405,7 @@ static IIO_DEVICE_ATTR(ex_analog_temp_offset, 0644,
 static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 				int channel, char *buf)
 {
-	u16 data;
+	u16 data = 0;
 	u8 msb, lsb, offset;
 	int ret;
 
@@ -1428,7 +1430,11 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 	if (ret)
 		return -EIO;
 
-	data = (msb << offset) + (lsb & ((1 << offset) - 1));
+	if (chip->dac_bits == 12)
+		data = lsb >> ADT7316_DA_12_BIT_LSB_SHIFT;
+	else if (chip->dac_bits == 10)
+		data = lsb >> ADT7316_DA_10_BIT_LSB_SHIFT;
+	data |= msb << offset;
 
 	return sprintf(buf, "%d\n", data);
 }
-- 
2.19.1

