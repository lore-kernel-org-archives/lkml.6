Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449A21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NBfmFR7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2449A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeJSVxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:53:25 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33296 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:53:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 0039DD0B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DMIA55incBgg for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 08:47:11 -0500 (CDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id C9A32D00
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:47:11 -0500 (CDT)
Received: by mail-ot1-f69.google.com with SMTP id j47so24577267ota.16
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8Zv4rM0IDAQMH6W4AX5bAjSa1qfI0Q6lKVETucG8J98=;
        b=NBfmFR7aP/pl2L1KUTnvbg1rmmmal3rXAIuOG66As/XkPZuXtLDB4qcKLixKG7S6kw
         G2JB4a70411Y5mn8QnASH/cpgnyKayy/rLTub8eiu/lSr6jOrjwV/bT3odtTr4EsoBdd
         Cst6i5e/+c7BFvt98yxBJgck2vRhxrvFORSbs4N3TzE1jNLULCjUv+gxzZTUi1EZyesk
         JSOdh1ceQZ//h78Q8ERX/IvFidV+cbzw/2jurXAt07itXIh4YHZu3rWg9r4MEHArsxjf
         bxaGszNxP5G0xsLYJpG4wPIhGPZnsmRsDDraOME/RrtAb5QNMTOL5pM6dtFlZYVeBGob
         ooMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Zv4rM0IDAQMH6W4AX5bAjSa1qfI0Q6lKVETucG8J98=;
        b=Y56GWPkODliQyIvdj87Uepz2/OCVN6D+DpforQI3kyplu4ZdneSZ0xmw8dg4Z7uDSu
         UChb40JOjo9fvUksoSQc2BVgibXB16ATLbyxU5Mm8tA5ZijQa71v14aGwKnvljAGiTAz
         GuTprfpE3QePOVh4GsMoVpzo10vJq6vKRuSCiKsXbbZSD9MwEIiQf9CuXolYF1VQStHP
         Kw4vvS2ZCWXaqJpmPMs8hvhAIN8AP7QNstEz3Hu4juFQKWV6rEhPbXce42r7Z7eYHHIF
         VKh1fwNvKTpCgUBOO9X46CLZrY/Q/t1ra98owd4emtqngM6pDm0AcCgYaotkqlZoV20+
         BNhg==
X-Gm-Message-State: ABuFfogmugzFMZxZtNmajCRhNwiP2+XSycZVA3P+1wY2wHRnC92BiBPi
        LkIcHMaQO1DyzfJd+/GV0UooHflvKHx2eiurN3Rx/ze1Gg4LievTSZabmpsK++os7n9vCRi6EdB
        oRjg3b0uEUxPB3osRkxRfdmrLHKhN
X-Received: by 2002:aca:5c85:: with SMTP id q127-v6mr17761598oib.301.1539956831059;
        Fri, 19 Oct 2018 06:47:11 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62nb7Bjxfsip/54qZLyxdZnlBVmka/gQnvpQiMCPTFuKHB3bfmTU0bog7UaB62L7WlDjSVMjQ==
X-Received: by 2002:aca:5c85:: with SMTP id q127-v6mr17761585oib.301.1539956830638;
        Fri, 19 Oct 2018 06:47:10 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id n65-v6sm7428519oib.40.2018.10.19.06.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 06:47:09 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] intel_th: Fix a missing-check bug
Date:   Fri, 19 Oct 2018 08:46:52 -0500
Message-Id: <1539956812-11300-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In msc_data_sz(), the 'valid_dw' field of the msc block descriptor 'bdesc'
is firstly checked to see whether the descriptor has a valid data width. If
yes, i.e., 'bdesc->valid_dw' is not 0, the data size of this descriptor
will be returned. It is worth noting that the data size is calculated from
'bdesc->valid_dw'. The problem here is that 'bdesc' actually points to a
consistent DMA region, which is allocated through dma_alloc_coherent() in
msc_buffer_win_alloc(). Given that the device also has the permission to
access this DMA region, it is possible that a malicious device controlled
by an attacker can modify the 'valid_dw' field after the if statement but
before the return statement in msc_data_sz(). Through this way, the device
can bypass the check and supply unexpected data width.

This patch copies the 'valid_dw' field to a local variable and then
performs the check and the calculation on the local variable to avoid the
above issue.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/hwtracing/intel_th/msu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
index 9cc8ace..b7d846e 100644
--- a/drivers/hwtracing/intel_th/msu.h
+++ b/drivers/hwtracing/intel_th/msu.h
@@ -79,10 +79,12 @@ struct msc_block_desc {
 
 static inline unsigned long msc_data_sz(struct msc_block_desc *bdesc)
 {
-	if (!bdesc->valid_dw)
+	u32 valid_dw = bdesc->valid_dw;
+
+	if (!valid_dw)
 		return 0;
 
-	return bdesc->valid_dw * 4 - MSC_BDESC;
+	return valid_dw * 4 - MSC_BDESC;
 }
 
 static inline bool msc_block_wrapped(struct msc_block_desc *bdesc)
-- 
2.7.4

