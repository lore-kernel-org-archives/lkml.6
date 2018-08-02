Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBFBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5D72157F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="fnngLFVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5D72157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeHBWvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:51:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46331 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbeHBWvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:51:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id l16-v6so2516328lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H48CS9aBNqkJwyLfS4hKgdgmNwjZR+U90yZjmrUTGyU=;
        b=fnngLFVmEhhBaQ3hWKVaQc606VTYB1DYfTEv0QgibCi1/LDYOoLVanHOsTQf5WYFn7
         b61oKjap1vmbydn+O7O7cixMgCkoTVXPEKCq2pwp/1v3gtgoSmbJQVihqbY7YZHiUAbF
         xG6e/PlBpyZOs0F2/3WHCRaxtmZXZLbzU57ZYEMUEx4zB7Peaowf/R3/8xZHY579tw3S
         kHXGZSlk5SNdqir2Pb+/hYns/jQfSDgv4HRGiGvuulg1VagS2LJfmXh/94LhVRYoRpyH
         o1pEpNlP/jsh2Hds9/EoKA11p/nHxs9wlG/0HUEtTuSnaU5+x/iX8OD/0XBeHZOc1226
         2epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H48CS9aBNqkJwyLfS4hKgdgmNwjZR+U90yZjmrUTGyU=;
        b=N+yV2cnU8wGIhzB65JPqLjIfVwh07eMIO24PpZygVOi4D8qO9W6uoB6uP9+I8xAhwk
         iRxaPyu827eK4NsBeDheENGcxIMHiUHPx0yZynYWbktGWJtDceUAEIfYqS2CEfx0eEZ0
         tzats5EHQPX8V/Tr3Mdpq5km+4+F9KVkdFq5f0boP87FmFDSHY83WCoJSHoBi+zctV+M
         BCuLPPahsKyJjNWun/Y8XiHO0m3JfRJpGf8RiNKlNpXjAjNxnbKV9cCClEP3a4IdIA/c
         tffjBNa5N38O6+U6sbvcQo/z9Eb84xfAoLTHHMP7kmBfJc6Pxqj/XbSZXF9WR2i7Nd+t
         be7g==
X-Gm-Message-State: AOUpUlEjCuuH9djGHBU57RNzxeaHU372hsT8lJjNHHqmqllXYF/0YgG3
        OCnevQBODaQd5Y1umppZiIy0YQ==
X-Google-Smtp-Source: AAOMgpfZZTIoiIee2KmI451/zDcIoa2pO3qSpYFpSlBa002yxcROaIFDrXlHl52qfvACMvoGnXomUQ==
X-Received: by 2002:a19:ef13:: with SMTP id n19-v6mr2966877lfh.48.1533243539396;
        Thu, 02 Aug 2018 13:58:59 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id r73-v6sm574177ljb.16.2018.08.02.13.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 13:58:58 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Date:   Thu,  2 Aug 2018 22:58:41 +0200
Message-Id: <20180802205841.22039-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme driver checks for 1.2 and 2.0 compatibility. If an unsupported
version is reported, the device will not be initialized.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 537e98f2b24a..e9e2fedff387 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->state = PBLK_STATE_RUNNING;
 	pblk->gc.gc_enabled = 0;
 
-	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
-					geo->version == NVM_OCSSD_SPEC_20)) {
-		pblk_err(pblk, "OCSSD version not supported (%u)\n",
-							geo->version);
-		kfree(pblk);
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
 		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
 							geo->dom);
-- 
2.11.0

