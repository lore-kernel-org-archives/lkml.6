Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="O4P3S1h3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D05B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbeGMJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:03:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34292 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbeGMJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so4786862pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qscSjtWfPmvy70VsJfMVHuNaMHwjwyBh8afKLuAFos=;
        b=O4P3S1h3Gq/yQzKo4gkRYHfCa78VdEQHUljoYpVeyaTLno0vMp+8mYwBOU9y/qlNyg
         T9z/c56L54kfyxuQAnZyc7QmTy2jzizTdXzRDeCNqn0aHz0A5KVk9bOgfOt8zDN0tMxZ
         YuhFghuFDOay3sYu7its1R4Q7BrqzZ+r1jfJBWBF4Hy3eFySqnXDf/iz8fI6Exgk0po2
         coiWdrhHvRMx+NwiD2nuQzH6wmuxzdX6dh5L8Jp/eH9j+XtvnOQyrpSgPIDcG3GhVDvc
         xQN01eA4qM+qBgLZfoVxsxJAqHOzkm92v2XXejw9T+ZwKyQeZZxpx9zUhqbI8G6LvhGf
         deNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qscSjtWfPmvy70VsJfMVHuNaMHwjwyBh8afKLuAFos=;
        b=Hdy4A4DcpflnSLiPIr53j7AFwpp+kabrt3sfi4WjnaCtsynVVW/lIM2UAnAXRG6kuC
         hLQqD/CyMtRqyMnnFW9W1RoJMMj7r0NcEWtTcedliIOI37MjbQOrmPURUzLJ2K/9cjzL
         aXi3QZJHdjWpAwnP41ulpUUUi/DPVyt8wtS+QogZCu2e7whTX9CNYklLK6DPrmpgT7Lj
         +raw/NrvZLKdoAr0OOT18PqlubYSFxvQ4Qi/xLqqUg2mRJTUqAczl9ThhQSp10udUHjF
         IEIv2nZxBxGlYD36mPlJuELmmYP5VQaOcmtv+SLBgGkSb+F19n2s2IvwidQ0LnNNDheb
         ssHw==
X-Gm-Message-State: AOUpUlHQvPI5KZoMW5QNuocVh3us3m47+1L9lQGL+Mr07a5ZHlmaPrRv
        kUb8Td+b8w3IifoZxBU386AtVA==
X-Google-Smtp-Source: AAOMgpeqDNNqVp4eG2Hup4Hg2LwCG/vC+myT8Q08obfMVcLgj7UtX5WuFp3CUj/p1FNkRXfyfz5K3g==
X-Received: by 2002:a63:2a0b:: with SMTP id q11-v6mr5243458pgq.36.1531471791621;
        Fri, 13 Jul 2018 01:49:51 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:50 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/10] lightnvm: pblk: assume that chunks are closed on 1.2 devices
Date:   Fri, 13 Jul 2018 10:48:45 +0200
Message-Id: <20180713084845.19511-11-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

We can't know if a block is closed or not on 1.2 devices, so assume
closed state to make sure that blocks are erased before writing.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index d023ea6116bc..537e98f2b24a 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -719,10 +719,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
 
 		/*
 		 * In 1.2 spec. chunk state is not persisted by the device. Thus
-		 * some of the values are reset each time pblk is instantiated.
+		 * some of the values are reset each time pblk is instantiated,
+		 * so we have to assume that the block is closed.
 		 */
 		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
-			chunk->state =  NVM_CHK_ST_FREE;
+			chunk->state =  NVM_CHK_ST_CLOSED;
 		else
 			chunk->state = NVM_CHK_ST_OFFLINE;
 
-- 
2.11.0

