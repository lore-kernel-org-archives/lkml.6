Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EB0C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7794720671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mh/R5xay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7794720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeGSKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:53:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41036 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbeGSKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:53:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id c21-v6so3680366pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=s229wFo0iFjGxgmGWbb8urNjBWHmv1KXXXpm5jMzXfU=;
        b=mh/R5xaysa6eyf1wncVP61oacQjCQJaz+1skC3qm2Sc+nS2Vhr+k7rYYduwLGtcGzR
         wt7te/v+tK2YV+lwTY+sy7Hkk4gAaQ6lY07mmoQ9vXkUGuRTS77HiSiCuG1ztAkSxQc2
         lme88ozEyxJBrDvdFI8BMaLJ0KBTsPHSrZQT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s229wFo0iFjGxgmGWbb8urNjBWHmv1KXXXpm5jMzXfU=;
        b=VXTRnrt6cw+DbaZsmPhmpvxwkmh8jP6C7V4EeKXP5auFy/BN5+XdQlea6RiW91/WQm
         TUdYPvE86k8E2FtXd6kupkX12ZdyMpcumDEfX2J/Vs0w8xpV04KMG13Lbdi2W5sXeuNh
         us9Wzhv4aK/2UFQdODwmqBihcwuvp5H4NeH/GNtoi+ZPJtQrlXcE6FIEgHEXu1QWZqyk
         RzzT8RXFoRvvfnMcJaG3/ahka3TOqiHuYwfss6ZhfD5nRAmUl4sfUwVo/S3QHqHhWFWz
         o76HeQ0vujXqR6PhxIXE6UKiQLBFUagD+19EJg17VYhu5AVhd5Tqmk/jksGeePMiFooo
         G2Jg==
X-Gm-Message-State: AOUpUlFFrtqLmeN4d69V/9YEpMRZaKvtNetJ4DBYiuj7+Qwo+WJ643ZH
        UxmpQuO33o0hx//YkMsBwJmTLw==
X-Google-Smtp-Source: AAOMgpfSbF2Ay+5KwrtvzvK2TnY0VyTOqoMTgGyPJit1VAiVxLgujn5rPvqE6IGo7BywlwJ8awB1yA==
X-Received: by 2002:a62:998:: with SMTP id 24-v6mr8792525pfj.99.1531995054785;
        Thu, 19 Jul 2018 03:10:54 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id n80-v6sm10444838pfb.95.2018.07.19.03.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:10:54 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] usb: musb: Call musb_platform_exit from musb_stop
Date:   Thu, 19 Jul 2018 15:40:38 +0530
Message-Id: <20180719101038.9465-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

musb stop is musb core call during unregister or shutting down
gadget or host musb. For graceful exit add musb_platform_exit
on musb_stop so-that it can exit the musb platform driver as well.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/usb/musb/musb_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b7d56272f9d1..0b93b6384eda 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1110,6 +1110,7 @@ void musb_stop(struct musb *musb)
 	 *  - ...
 	 */
 	musb_platform_try_idle(musb, 0);
+	musb_platform_exit(musb);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.17.1

