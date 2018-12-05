Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B067D2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKCYG3gY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B067D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeLEBtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:49:32 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:32851 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLEBtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:49:32 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so12884244itk.0;
        Tue, 04 Dec 2018 17:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2lh/8f/pnGj9DsItEKtdeExqEW4yKIG/NAVPJWqQXwo=;
        b=JKCYG3gY0+bgAkBaxd8v/5YlWd4nxjjXTrhsOcopfqcDX8bRT65vYWWVbrC1RfykPe
         Y1y35SP2y7zyIbwaH/k1JsmyQ924MwJRRiPCwfz0il18suFiZd+Zke3HcPZnoANrz9ud
         nVmEozSupCiVM5nqw2bQ51uLMfGRClmSjlwQXdu9A8dA25FZILtszsaSO+XJ1OBMZNBk
         TAYFrlKaU+k5ZWV8megIHgzDymKtJqOpVqWrN9k98DKuLGDnRsQBGjaPp13J7FHNJm7i
         RdI6/oJg9njFcHmWiPV0vrEZ6uhhEDVSfIvN5R8u34qyBuQicDu+bVouacNd2bX5YZKp
         te3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2lh/8f/pnGj9DsItEKtdeExqEW4yKIG/NAVPJWqQXwo=;
        b=Ciu1uHq/SvOPbVhSOiUAho+IcJ+DinhT9zuvNmTBq96M3IWRkxGvy5gZPocEab8FFK
         XjDxb9IaSkuC3ZalxLQtCmcIUP+7xGCQolt1vjGGOGSThELtqJPl1dCz43Dh8cUPlDSi
         EPgxmF6g1hbSRT9LO5FwK/2OSNwGnuFjJ27Z+ng3lnENu6QtqAvThb3Q9PePxEoXgCLv
         2NywtR9iEWVEu6nRyzc7MXZ6HnfQc/kD+rWD4pzjhFNyOyPjedezCfBUDw8Fendl/nuJ
         Fe6D0CkdApgeqGr5pPCPVikYDR/PGe85hD++0r42zJA+g+rFSI0C+hSim1kpXt3tx8M4
         MkdA==
X-Gm-Message-State: AA+aEWb7U9bhIU1Rlbygs68MtH1jykC3/fnlaGUroPx9lQf/b9tj7FPK
        eTHcIl69JIJOes2FztiPaV0=
X-Google-Smtp-Source: AFSGD/VFLK0I8bxpxQ6RZbJsMjFOcfclt/Sf4j9cypAJzgoM902vkfZPJEtgQjtHMCrZ1UYaIJFCtg==
X-Received: by 2002:a02:bb9a:: with SMTP id g26mr20338004jan.44.1543974571181;
        Tue, 04 Dec 2018 17:49:31 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l11sm7552412iob.24.2018.12.04.17.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 17:49:30 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH] Revert "Staging: iio: adt7316: Add an extra check for 'ret' equals to 0"
Date:   Tue,  4 Dec 2018 18:49:00 -0700
Message-Id: <20181205014900.4827-1-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 00426e99789357dbff7e719a092ce36a3ce49d94.

i2c_smbus_read_byte() returns 0 when a byte with the value 0 is read from
the device. This is a valid read so revert the check for 0.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index ac91163656b5..2d51bd425662 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -30,10 +30,6 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
 	}
 
 	ret = i2c_smbus_read_byte(client);
-
-	if (!ret)
-		return -EIO;
-
 	if (ret < 0) {
 		dev_err(&cl->dev, "I2C read error\n");
 		return ret;
-- 
2.19.1

