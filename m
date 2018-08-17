Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93837C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E59A2154F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="CmZwhwaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E59A2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeHQRkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:40:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42045 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:40:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so6530586ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCDE1ZF45ByvaJtahq21Emr53yAzkpYEpRNwVGdLgZ0=;
        b=CmZwhwaA5y2FQ4x6XrWG031v7CE7l9hbM61vACly9YNSKeVEhbuvhib9QjiaHjPCEg
         MCLdzwjenLxLz+vg7dj6ivUt8hmyhWs8w/w/etgQ0Aj049SwTjCCAOuxOvJ6uJbPLChD
         C1qJSWTicv67YGmEbEqqI1PLjpn/J4ZQ7B2tL49GdYUtenUXV1jcVZmwGkj/nInTF9Sp
         bofPGTxLt9v7DUNZ2Cn6sIQZhP1fL6ubnZ0lpJpjlX0iW/VHFiR/xWLUBesSlMBUP0D8
         vWk+sH9VUVvUA8NLMKs4CB0H07nBJ/A0wdL4eFSNat8DxHmT272ZxotgGtWKOZ6mqIWW
         2dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCDE1ZF45ByvaJtahq21Emr53yAzkpYEpRNwVGdLgZ0=;
        b=f57Uxr/mQ14zNanDYId/mRtxC9R/Iq0te1+acBPpV4cW/kGlAfG2m85s1KLJHub3nf
         bG/LMdZh0YtkgEArq4VwANtrkkX85fEQrxl0NjKoEtMe8KzNewXQK1URayBsQSauUA34
         JBDaWSALtscTOiJOSbxXKZeXYxHEptimganJzxpoAzoql5jxEx38bUgObfs0AHXXv/RQ
         jn0g4wYnQ0NiyZHs8nFVxnSVDYvS45ISTK2tlBWzsnzkvxmoloNIN8Ow38Lks++cVMGb
         5Hy9322wDNeauZWFLalsdHfCmnaB0UZVf6MO4zrLZzkYmaGgX0+bP8wHSDLK0zS/tB36
         vbIg==
X-Gm-Message-State: AOUpUlFC0e9N6/QxNAhUwFj8pkNKU++ySagQZ1u8+IJgYh1BzPM8F3Uf
        w0Nk/IZhbf5CukjYzlu5pXVQKQ==
X-Google-Smtp-Source: AA+uWPx/mLuiCom3FG9qcCvx+Fw6zTwYITKDWTmqzMHZaD35vNviLjm6GojzwNpB6AvIbqvC3xNbRQ==
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr20287729ljk.111.1534516606243;
        Fri, 17 Aug 2018 07:36:46 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id i1-v6sm337375ljg.43.2018.08.17.07.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 07:36:45 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: fix incorrect min_write_pgs
Date:   Fri, 17 Aug 2018 16:36:37 +0200
Message-Id: <20180817143637.15943-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
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
2.11.0

