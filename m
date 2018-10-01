Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46340C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7C12082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by7WXh6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7C12082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJBAMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:12:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54822 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:12:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so5624797wma.4;
        Mon, 01 Oct 2018 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SYGS1sO45oTnl/Q5rUo6wcZ37D2M/AQANkRaLyz2Pkk=;
        b=by7WXh6eApumJVFOhahxmywLot6MkUu8CcVZErZisOIb24X6ADNZKgN4IR9Wd+gtjX
         T+GMJzP+jIMMBtKllmeVnaIAUVt4Uv9DqtNPhQNC2igGAULfrQt/y5gfa8lR+ImbUi4S
         miwbKKkFo6lzJNj1hZlrBabxPwadEFjph8h9hFIw8CeFltMHyZ40di76dsGNXa1Aihe3
         hs7atpjISJT3HIZBdznoflz4fEtXs6Wla6dB50xbG3di9+RqW5bfKE6dzcUUj3X9I/Ch
         zFB90i4EkyMdBw5/gr/NUiT0GEWTw8pRxcN0WCht3UvlEdSpc3u3CTcsoS7dg03qg9X+
         yFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SYGS1sO45oTnl/Q5rUo6wcZ37D2M/AQANkRaLyz2Pkk=;
        b=mZFFp3WwEMdFUL98x0xOfsAcmxsByLKubHqkojNtDX7JKXt+k8fLUmXokkawuLGwal
         1D5SDXSy0wnnMufM1PA9nb/SRRV8vlNcO/417hfWdekxE9kqX5Mnh4SLBWzh62nj5RiK
         PxWDaEtbFFlMpUFyY7KMtmF3pyXNTmTfL6Nxn+bg3Oq0a1eonRdOtgucw/5MyA/T+Q4U
         cOzQf2buoExTdIxdRWDtfOqoyCjRWkrsNA77CDmW9GNU4X98laWv/bU9lR6KvHBTvVUv
         Fi1MdmqtPzTa0HtS8MRbkTE7m+MsRbxA+yYNqW0Kg5O5vjjTgbgemMXf4DpV0Fc59GEW
         uorQ==
X-Gm-Message-State: ABuFfoiUlQ0pihGfun9q4XKsYKREZWyRHQnyjqC8/Apb7zQPWLyF8PhA
        a9c53Pe0kwfOmiUAIFQgIktXsFv4
X-Google-Smtp-Source: ACcGV604leOI4ku6jgh/lqSyUP3OSFVjtKqSMjitdBSiOjsN52Asm043q3MKytjraRDmXOySX+NSyw==
X-Received: by 2002:a1c:ac82:: with SMTP id v124-v6mr9842742wme.10.1538415204942;
        Mon, 01 Oct 2018 10:33:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v16-v6sm7840651wru.31.2018.10.01.10.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:33:24 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 4/4] ata: ahci_brcm: Allow using driver or DSL SoCs
Date:   Mon,  1 Oct 2018 10:33:02 -0700
Message-Id: <20181001173302.25398-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom STB AHCI controller is the same as the one found on DSL
SoCs, so we will utilize the same driver on these systems as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 39b181d6bd0d..99698d7fe585 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -121,7 +121,8 @@ config SATA_AHCI_PLATFORM
 
 config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
+		   ARCH_BCM_63XX
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  Broadcom SoC's.
-- 
2.17.1

