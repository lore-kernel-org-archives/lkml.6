Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F1C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EB9214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="SD3CJNaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EB9214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJISap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42063 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJISap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so646456pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/TVf+su0XnaNLtGwghLacA6h4HeQqhXaBp14oLVNmc=;
        b=SD3CJNaDS2LWRQCfgvm59ZAgJLslYLaOi7H6IM4o84aU6zbvim9JriVThQa+IE3vkq
         p9XtPMVClTNn/Uim15lnG+HvAelrmbzuSex7CpuSz6ELBrnfi1qdcABmIvUWtEGwhRHT
         0364lCTK7ds9xK9yopnTokCfP7re7ndymGtr0C8cY66yywboZNQO3tdNptnq+HCJ1mpO
         64Ipmn4gnd8c3XemgmwlStBTiOBXWWYMumYL6gU3LZvW9ESudB/UwnfjtzxLf0dPsAb7
         JDaODzM+Ele4YUImoGvVZX3gwVweZv05AUQZpmDMWPP95JWPk7zfS1idVEiHx897rEIp
         YPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/TVf+su0XnaNLtGwghLacA6h4HeQqhXaBp14oLVNmc=;
        b=D+DYBPisTMfMQymgEwTK1JRAMLxSCVNw6hlfDRZUSfJGiHahVAM1DpUyIg8PF91b+5
         FQG96xbXzh9fWaK/YrSQocnpy0un8svX8FGJSAAYGJug3byzgHsajPjRzwdtCj7+f1fE
         ThjSCD+3QvmAk55YPRZPK8olHUjq0W9le6WNhZV+d8u4DDWNpTEA+m3DTAlzPhNG3wto
         zkwTe5o6I4r9diW6vMK16zx2bKZc/ZGlS+HUgO2JOyMrTSrrcjTirLXyns+f1htjBPV3
         5KoxEnCsmrIc0Le7EWEWLTDQpaLFXjxGWNhBhqlUUCfX5nC9tFezpEP7iydcpeCajs6O
         NOqQ==
X-Gm-Message-State: ABuFfoi7F/ioFWPqRPI6TQI+fF7LJI1ilAidkJGXmTPUi9jOZzvgAUXt
        tyZbnCtBuVJY8IyhTZc18EgRQDV9dd0JQQ==
X-Google-Smtp-Source: ACcGV63ZBOOkkmzz2yQW7ZwoUkliTO/+UezP4P/eEBxyZ97Ng8ZRKJBgF6kHcpp5yItbDxpG0d6LhQ==
X-Received: by 2002:a63:1f0a:: with SMTP id f10-v6mr25051807pgf.313.1539083658326;
        Tue, 09 Oct 2018 04:14:18 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:17 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 19/45] lightnvm: pblk: fix up prints in pblk_read_check_rand
Date:   Tue,  9 Oct 2018 13:11:49 +0200
Message-Id: <20181009111215.7653-20-mb@lightnvm.io>
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

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The prefix when printing ppas in pblk_read_check_rand should be "rnd"
not "seq", so fix this so we can differentiate between lba missmatches
in random and sequential reads. Also change the print order so
we align with pblk_read_check_seq, printing read lba first.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d3ff8c3e9010..829e92857289 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -149,10 +149,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 #ifdef CONFIG_NVM_PBLK_DEBUG
 			struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-			print_ppa(pblk, &ppa_list[j], "seq", j);
+			print_ppa(pblk, &ppa_list[j], "rnd", j);
 #endif
 			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
-								lba, meta_lba);
+							meta_lba, lba);
 			WARN_ON(1);
 		}
 
-- 
2.17.1

