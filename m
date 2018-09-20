Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D521525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex4nqgXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7D521525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbeIUBC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44648 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so4867801pgp.11;
        Thu, 20 Sep 2018 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQe8dWaIWFtV1ZNvAEkJWOMwhon4VpCEGr9xrv2EmUc=;
        b=ex4nqgXf/iI06i8uU2fw4bsYXqYZrm9Z5zhO18h4tYfAtTEe6P9UupMimAnjdcJ/sR
         bkUu0JusAxKaC/FQgdODP8KSsg83CN2LMOoZ6b7/sxEJXIHITppu5SQes9jXpR3al7U4
         SguKsEMR5m5c+9GL9mo0hwBaJMPEJrA4kDTFVVGo1K2ewGF3BtCy7qibDJfF15NPCFML
         yENobKV3KyTZXyrkCf02btd4QSVuNg9EwuNOKsDtLkLqWndw1Va8SW7vHElZ0oIA/Ftm
         PtQtUN82MQwLNTikCWrXiA6UReB3HTVW+BAW23dCZHgfRdJsmEICUXUTIGCd8rubZghu
         aqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GQe8dWaIWFtV1ZNvAEkJWOMwhon4VpCEGr9xrv2EmUc=;
        b=DKuX3uKfSPstpiEDjIqz2Km8ekaY6UogMCZ30gMgWyKN8cxMaLDgGZK5HNA1pRrzof
         WTtX5oU6xFC6EXu1KLShq2mkf1kWRawWNzZIH205IreCa6Xnr5+s3mVRiOlEzHwl0bGo
         x8RJo3ivbcffXOnIOdC3QThzCqOUNL2lGTMmHo48lS7EYEZitbiu2sHH/0sRKv15opLR
         sCm7BuCjIEz9Oyisnd8IT4ubuW43TUV9EXh73Zod7DeUeNuBlC+bkZ1fsDfVnEnlAdnZ
         arW3UsuI0OtK41iCaJshWJbbFpztZODCQ4OT15dyhRmG3aw9zhS/V6h26uJAAPGeZvUo
         dU+A==
X-Gm-Message-State: APzg51DniiKTmihki5qKrdiODqnc7enpWwl7N9jfPnWzuKtUJqY17kgo
        nqlt5DbVGiNLsuX9x3MMprCjrxmR
X-Google-Smtp-Source: ANB0VdbdH/o985ceDzsPLDud++0tWcqCqUqEU378lfIBReKLiTZQVRRtoZf1D/HF/6J//DOfcrXxkg==
X-Received: by 2002:a63:d34f:: with SMTP id u15-v6mr8696031pgi.325.1537471049509;
        Thu, 20 Sep 2018 12:17:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 6/9] ata: ahci_brcm: Match BCM63138 compatible strings
Date:   Thu, 20 Sep 2018 12:16:42 -0700
Message-Id: <20180920191646.18198-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the "brcm,bcm63138-ahci" compatible string in order to allow this
driver to probe on such platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index d535e87151dc..43f4e4fe4742 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -383,6 +383,7 @@ static struct scsi_host_template ahci_platform_sht = {
 static const struct of_device_id ahci_of_match[] = {
 	{.compatible = "brcm,bcm7425-ahci", .data = (void *)BRCM_SATA_BCM7425},
 	{.compatible = "brcm,bcm7445-ahci", .data = (void *)BRCM_SATA_BCM7445},
+	{.compatible = "brcm,bcm63138-ahci", .data = (void *)BRCM_SATA_BCM7445},
 	{.compatible = "brcm,bcm-nsp-ahci", .data = (void *)BRCM_SATA_NSP},
 	{},
 };
-- 
2.17.1

