Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62820C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FDC2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/R3176o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBVMWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:22:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37585 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:22:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so1604393edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=id5OtkvNpj1Whv46MnxA1ePsJutfnd2hePFKSh/MX4U=;
        b=u/R3176ovFteXT4qSQ8WPHAN5WHWP/OhnlKQFVEoxYuBM9eOtrkydI4h7GuFomb3ts
         N+s2UPUNAVrBApv2guUeW1sn9GgDy2IkEGDAcfs9e6i7gDrRYU9bYLh5Z40eq6fRB4Lf
         f7EnNkRXYpFaIq5ShQdq6M3OOrUe/pUa58VGj2vzVGv37MloizSVNL0E4J+AELvV0qhr
         FCB5gecCJHkae3GdJX+hgiUY5s4ju2SXM/Ywgivf6YiH3Sxr5R++Ci2Vd58cTAQqf9MQ
         qHpsBFrBBPYtJ1MbLoQX5Tl5hbC/Mcnx+C5QSVi/LAxJWVJ/7Pelq/fNJEjrpaU5up3w
         TnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=id5OtkvNpj1Whv46MnxA1ePsJutfnd2hePFKSh/MX4U=;
        b=T8UbGsVw3zWWldsE8O1kPDx8W+CSV/hPTSzyZELdWeACUMQSPFRdN8/5qq9mxG03AF
         1t836bfNNPj/MX+sJFPBjyzMgmRFZ6oJr1wLtOTsKXOZrRXQE+g+HonH20s6B2526Emp
         NNBQbLLCFwxGPdENK05iAJHgPrh03Y9kQ3o4GeIVC+ted9fgxPhTuPXd13SeKoqAljYu
         jecCxEACQqSVt6AjWhcpSn9l+sD5cIXpB1I+IvnobfR+uasZ3B70Ck1hVgYY8Wu/H1/O
         INlgY6coSr9gH88ORvMbtmCwK1pEUCXdzpjZqmVKRAQuAizHl9jisrWEZs0KPgGEFjnk
         px0g==
X-Gm-Message-State: AHQUAubiHYiBNelYDDsmw+Uq+F6QZNqkwvFmQD/p3t63z4CVbreCj1kS
        5HykqK4MAZUnzhpNT+KzsUY=
X-Google-Smtp-Source: AHgI3IY48ibg8hHchnGUkIInwejv9AXEd1XLpRp8I1pB9dThBHRYfLE+nIJZfOauE4jVeJkK68tMvQ==
X-Received: by 2002:a50:bdc6:: with SMTP id z6mr3039024edh.64.1550838121588;
        Fri, 22 Feb 2019 04:22:01 -0800 (PST)
Received: from ahersrvbspbld01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id h1sm355537edc.97.2019.02.22.04.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:22:00 -0800 (PST)
From:   Andrey Zhizhikin <andrey.z@gmail.com>
To:     dinguyen@kernel.org
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andrey Zhizhikin <andrey.z@gmail.com>
Subject: [PATCH] ARM: socfpga_defconfig: enable support for large block devices
Date:   Fri, 22 Feb 2019 12:21:47 +0000
Message-Id: <20190222122147.27132-1-andrey.z@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_LBDAF, which is required by ext4 fs. This option could
hanle both ext3 and ext4, and ex4 requires this option to be enabled,
otherwise the filesystem is mounted RO mode.

Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
---
 arch/arm/configs/socfpga_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 08d1b3e11d68..b4b387486cd9 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -21,7 +21,7 @@ CONFIG_NEON=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.17.1

