Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F395820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVcxLIqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F395820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeK0KPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:15:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33428 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeK0KPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:15:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so15096673wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4m58yeJ7cdwSGop/2oQTjIHI9CooPl92CFXapzyeCY=;
        b=EVcxLIqo5M3c2rHmKLeaxX8Ey4vPd9888vkjm4MoJ9eyR2cQH3SUVoWo5yPLoJnI/k
         vNZnXHztEgg1G2KUCl+s4bhDAR3FgNxWBNramKjTNMyzXYv/qxtyd6IZy77bn2o8Z98m
         VmrgvWHjsyJLoDMOyLkGyNIcz/ol878fmtU/QtYkaP5Hd0GUJSRaqTL8pdeasxSEmkF9
         X41Dml8vhpoSG6IR4sqlWjIhbIzY55zK7Ynn7lIwF9VzOHIPgiTbpiEg0faVBc61Ro/P
         mq8F3w0wDxQDZutAhhuAvyVsreRDDJNfeb3uOcWPqCrp+w9ObfXee1E8FCxyNBzjlU9c
         o6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4m58yeJ7cdwSGop/2oQTjIHI9CooPl92CFXapzyeCY=;
        b=Y+t+JudiK9Lw6C+gOHwLx31iy/NPTViB6hOOjcapDZUGsg3J8nIFYSklmvzByG+lWj
         m/j+6Qrj8NVA++V6Lbp5va/ZIyAxWwwgvdG++7gfHR2ZVM+CvmYgdjiEfRqL8DGEqUER
         Rn3ityTTGEAWX7YIDb0MuCwgrgcYEy4j0cb/KFkelU3laGAfndKgWi7usB8Tj4lgoIOK
         qyiOCIbGkEi9pLsUV+r4AgM+dbHNnFWEqXO4xZ5+tY5BTOnMjVUjQnNsYTFKkWoQBqgc
         +7uVr1KuT3oqynVC3M+5ppmqybGaq5a00fzN/zzjbJg+1wizUrP7IYHrhj0zWpS8wpT9
         qtnA==
X-Gm-Message-State: AA+aEWbCOnpRtuVazAKFWAanGo7bHozq7NrCoZbznPg2OijROnq65DlN
        8XJOXzv32yLIdTad27//IfE=
X-Google-Smtp-Source: AFSGD/UxFIB2bufyYDgerdcMBAAC+o5lAlFgrO1gh0bcMCrkKC1Mk01n52Ce450DlqiPhoDk70aMNw==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr24899022wrp.198.1543274384325;
        Mon, 26 Nov 2018 15:19:44 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id t69-v6sm2389863wmt.5.2018.11.26.15.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:19:43 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: emxx_udc: Added a temporary variable with address.
Date:   Tue, 27 Nov 2018 00:19:09 +0100
Message-Id: <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
References: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the IO_ADDRESS call with a temporary variable.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index ebc622f..d55cadd 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -108,20 +108,22 @@ static void _nbu2ss_dump_register(struct nbu2ss_udc *udc)
 
 	dev_dbg(&udc->dev, "\n-USB REG-\n");
 	for (i = 0x0 ; i < USB_BASE_SIZE ; i += 16) {
-		reg_data =   _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i));
+		u32 *tmp;
+
+		tmp = (u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i);
+		reg_data = _nbu2ss_readl(tmp);
 		dev_dbg(&udc->dev, "USB%04x =%08x", i, (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 4));
+		tmp = (u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 4);
+		reg_data = _nbu2ss_readl(tmp);
 		dev_dbg(&udc->dev, " %08x", (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 8));
+		tmp = (u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 8);
+		reg_data = _nbu2ss_readl(tmp);
 		dev_dbg(&udc->dev, " %08x", (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 12));
+		tmp = (u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 12);
+		reg_data = _nbu2ss_readl(tmp);
 		dev_dbg(&udc->dev, " %08x\n", (int)reg_data);
 	}
 
-- 
2.7.4

