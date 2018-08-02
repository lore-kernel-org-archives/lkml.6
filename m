Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E642BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357C5208D8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="R+fFKkXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357C5208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeHBM5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:57:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46233 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbeHBM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:57:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so852027ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9nBkdJmSf7XQB8nBRNFvnUYWQfCUzEb7L5hI7csDiU=;
        b=R+fFKkXDv6DPFEVjT3n/omCqGcfSVtzPOrnvefNHnuBdZL7rH0TaS5yIvgsuZgn17y
         TtnoOP4Eik5s44etD9Eo6hAcUrlckb71lM8i/fBt+Tiy0YI0/x3quT/mTs8xzv61n1H7
         zyc+/u9r/RiepwgBKcFW3T8OsfmvOmkg2fCPC398WVkUr+T9Ebj6r1om70RCcw/5hSLC
         C6/sEuZuU67taTV8Z3vE9+1E1ujo221QinzHj+DB/AmMXphUXgjYkwdIUCiFbw4oKf1h
         902m6NFT/Sof06aDfOdZlPSfCq7F4M0QJGQA9pyh1EN5M6Mc8ZtOlXtyXDX/ISIXURME
         ldIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9nBkdJmSf7XQB8nBRNFvnUYWQfCUzEb7L5hI7csDiU=;
        b=rgztt0mxNr6Xq0Z9k8LVy3uP9OFSEsADz7EimBGe1X9bcpZAjY5GIpz4PgOe0zh803
         CPHv7Y8XKqLdXS7f78nBvoHdB9gn7MIw/sfASYulambe6TSzIn5uvQdodRwV8zg7CbVX
         3mOhtU+zsWP9Nf2DDtCHUHLV1ojrEGepwAyWmSmPQcYlOdHdj+aFvetol4aAFinJrL0U
         K0F0km2PU2dLoV8RugzrZauocfqzMfOr38t4zv7THjlz9n4jkZJbIKNXySjUNjEO6gV6
         UcG4z27k+U/U7U2Spi5x00FhRDZ5f9pn5CCnAZPbKxb5GJ4AvnQkWbALL+BumnGzc7bS
         8/7w==
X-Gm-Message-State: AOUpUlEUWffMaPAQL9gtuvwHf35jjP7FJWaMXu+69phX98lBCUdEDM0V
        VwKk9sBw/gOysLHTSiEhqDgtf5XEM2qaiA==
X-Google-Smtp-Source: AAOMgpd06WwP6OBCarwOZLOEMmd/E3TXdFgV27j55/bzzd7UVMypaBWlbTpHblMp7as/AHDePO8Xgg==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6-v6mr2009872plp.316.1533207997619;
        Thu, 02 Aug 2018 04:06:37 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id o72-v6sm2447084pfk.76.2018.08.02.04.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 04:06:36 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: remove dependencies on BLK_DEV_NVME and PCI
Date:   Thu,  2 Aug 2018 13:06:25 +0200
Message-Id: <20180802110625.12463-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to force NVMe device driver to be compiled in if the
lightnvm subsystem is selected. Also no need for PCI to be selected
as well, as it would be selected by the device driver that hooks into
the subsystem.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 439bf90d084d..a872cd720967 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,8 +4,7 @@
 
 menuconfig NVM
 	bool "Open-Channel SSD target support"
-	depends on BLOCK && PCI
-	select BLK_DEV_NVME
+	depends on BLOCK
 	help
 	  Say Y here to get to enable Open-channel SSDs.
 
-- 
2.11.0

