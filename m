Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A902FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6356620821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zvACQV4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfBEIc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:32:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfBEIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:32:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2574362wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=e6lcaxh2LseJ2DfuTNTpcEmkO9JO0IMXBWms8bzgAcY=;
        b=zvACQV4cTgawp1TpJkPJyu/lYbHOdY/F4BYGy9TgzSdEp16jh78ztfAQlZ6hSh6XS2
         0bEjVhLTHIk+seW9v5FlXKQDPKoRbAkziXxbW7B/f3b+zpSvve/VozvKFbKMyZxkQwpc
         RMM2XProkeDrv213SlSUJKUuGWl/VdIGdc4HBiuDemtUSIwLAopjCOpC8AgR0iZoiWwJ
         8uRlGz9UtCZ4B9dogwOCpVx/bys7NTX1uL3eoNGYXOurgHyZ/7JlonBCQGFljYhxQdi6
         It1iosUzbGJ3X/saRgRp2nJFh9meTmHVJM7q+2kyOejflZecA6V0px42+yLvqmnSI1O3
         /kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e6lcaxh2LseJ2DfuTNTpcEmkO9JO0IMXBWms8bzgAcY=;
        b=CaNFL8Ki4M5ul+QaUoSbn8791O9Uq/+8lgQy7r2B+TOL/MNADiSdOUn1TjEUcvV5Bk
         yMtMLtW9Eiwj7xlMb16oqQf5ofnXHhyF1TqkeiAbeVIKUyFoORaXRY9FixDS+8oOvoKq
         7N08UTDaa2sdHYd1Ik9Mj+2HA6TOG2pIvYLbThzju0D9hw8Mims0Px8sP8JipbZy4mA7
         t6zuvdQ7T9uDjDGNAJu50wuuFOMu0N435i9gBTjKZf7N/yfFPCfmz+mJJE9F2y/QDzeW
         mtir2HfaWfHRUU6Vlo3ykt6a0U89GpzlmpX6kGAqAWD1KMJU7n8nzQuugrK5ZC9H6sei
         Fm5Q==
X-Gm-Message-State: AHQUAuYAnar8LpczkT7uucRstsitwsT6c3u0VnfoVktUhbx0Ic5Z+Nfh
        ZVuXZ+dJYnstwKQsUofQypaJ7Q==
X-Google-Smtp-Source: AHgI3IYfjaz6WsGwHhDF/zaU0K1nBS/na0bEmPFSePT3xipJumOlbPFsU+/+L0j6wZWp15CBtt3+1w==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr2539235wme.28.1549355547461;
        Tue, 05 Feb 2019 00:32:27 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id g3sm3118596wmh.20.2019.02.05.00.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 00:32:26 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     vgupta@synopsys.com, abrodkin@synopsys.com
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-snps-arc@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/2] arc: hsdk_defconfig: permit kernelci jobs
Date:   Tue,  5 Feb 2019 08:32:13 +0000
Message-Id: <1549355535-22052-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

In our kernelci lab, we have one hsdk device and since it is the only
ARC device at our disposal, it is important to made it availlable for
kernelci boot jobs.

Since kernelci build only defconfig without hacking it, it is important
that defconfig are bootable by default.
And so for hsdk_defconfig, it miss two CONFIGs for let hsdk boot.

Thanks
Regards

Corentin Labbe (2):
  arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM
  arc: hsdk_defconfig: enable CONFIG_ARC_UBOOT_SUPPORT

 arch/arc/configs/hsdk_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.19.2

