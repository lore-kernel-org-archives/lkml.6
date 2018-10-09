Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C8C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82287214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Blkhwp1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82287214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJISaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40626 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJISaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so648051pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1p9bXnHXgng+Azijy0DrFN05uFEZCB7dmzLswOYo5Y=;
        b=Blkhwp1xJbWp35U1e6Uu9LYfhiCdE/9ugrt25jlgOs+I4H3cX9UP5a0H84yde+b4ve
         p/gyDKnwI9+gW2RhZtH+DXQV2w+KG987FBoMqy2flrWepV9JxKgftBieBKMZY3JVAHhd
         sQHXdwxbCi0muW5czh75wuRpiJYcZ9GzEuHxtG2pQlOI6bJGsH2PfZTHh12aDwraJNRb
         jeLn7R5r8O5rrTYvdL64ttaVdXYUyTGyoHBichHpeAsESzswnvr8EGluEMPfIwnxip6J
         ndqI2a7hizK3Fk4fTV6yGnHl3jTvxcU00anMVIBQvjVOEQOcljGnK5QG6LnqgFBT/akD
         TzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1p9bXnHXgng+Azijy0DrFN05uFEZCB7dmzLswOYo5Y=;
        b=ncYUOX1ELWNJeGRiDcnWlXgaB0M3tNg5dxswEzJvjf71B0L1UCUb36z91XGCkxrEGF
         n9TIBhyOBvjPBTrwvEm3ynK2aJxxp/+RvMj0nPgl03EOXijIHosG1u2lIuBrdvuYW3Eu
         u7TcNtWguBTj5YjTceN46rabIRbtihpz6k5HMrLc0eBBRfwINlL+o38rdOhr26wHZxXz
         0tr5BWr/T1PffD6X128+36GtwFxYF+gsWghspBSvDq2Jh1FCLugyTl27b5Pr6AnDyYSj
         gSAjzRLA71/hfkEJOFAmZh5zhFq0rCOLGV8Ce0m2jtyqmkMc/L89WCIqUbGe1GTs7SR/
         +Hnw==
X-Gm-Message-State: ABuFfog4Vst5s43sWwux1t+EWUzHfYP5WNLLUJS6msF7ou7lA4+HC2wM
        u+U7tthZLbtW64tdQw8McOgBNQ==
X-Google-Smtp-Source: ACcGV61ZNXTE31soF3gokNKJoRqUisMJt41vRMrSsFQe4+uzPGOO55XmqHeifMVOtrUVDx+semBr0Q==
X-Received: by 2002:a63:194a:: with SMTP id 10-v6mr20928494pgz.192.1539083620362;
        Tue, 09 Oct 2018 04:13:40 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:39 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 08/45] lightnvm: pblk: fix incorrect min_write_pgs
Date:   Tue,  9 Oct 2018 13:11:38 +0200
Message-Id: <20181009111215.7653-9-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation of pblk->min_write_pgs should only use the optimal
write size attribute provided by the drive, it does not correlate to
the memory page size of the system, which can be smaller or larger
than the LBA size reported.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9119c64d6f62..8adc8ac8b03c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -371,7 +371,7 @@ static int pblk_core_init(struct pblk *pblk)
 	atomic64_set(&pblk->nr_flush, 0);
 	pblk->nr_flush_rst = 0;
 
-	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
+	pblk->min_write_pgs = geo->ws_opt;
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
-- 
2.17.1

