Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDABC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C8C208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="iNS4O6M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C8C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeHTO64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:58:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36064 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeHTO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:58:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id c21-v6so860414lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 04:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iun9iKLkriRSJZS1TokO8ENAazUqaQVi8hlmEjAFGIo=;
        b=iNS4O6M//MTbaQ9boaKAHC5eJnKyB2aTT+13OsfNNoJDPxSRh3vfewZGc5f65f1LZC
         p79/fQi/5C0fxggN5KC4tmaYOaBjhSK4e1ze/1nlunpte5+h8eIvLWo2dwr+J7fBGpRr
         lnCwh5w9VzTQdK6lkYcZImcxEUiv39Pnsu/L9RMv4bX0flPWDh+mW04aQ+v1nUVoMpH0
         HBPIDYJKHPFLeh391OZV6xH6JtaEvG02R0B5IJISypg7OTNF0zhib4dpu8tMv5NG52dW
         sQF6sSHPXVACOTAWJ3XAdY43D578/YUcKw/6nDTWzFB/WGlmlBidg01jUVFBPw6s92pv
         thlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iun9iKLkriRSJZS1TokO8ENAazUqaQVi8hlmEjAFGIo=;
        b=bCuGwSuhtrp0vxllo2N2mrDnrti9ZcuV12uChGmvqfGaNiaqk0JrZvOTajgsGrOaug
         v5wLFLkRjPrnIo5uYybJJ+hGFidwboYKHmNn5mNtMB3i/d5fxhFCsq25Z/VPxnfolKF9
         W9ZsyRbRPpjKYJJiTXWqCGZci7MUPcd/1IRMZskpT9Q/h0A/lwqNWAYq6vwlc9IH5ap4
         716K6MsEbqoN4WB/gWaECk02gAJ6kLdjophtYi6wTVfir4Y1hpQWadlmIK0+2CwHkIg0
         SKqxVkJTk6yPGgYE+0Yd0nLtPqkrxQrHFJxrnoxt+2V8yScPxxAoefcaTl1iMGlzLXcm
         5bdg==
X-Gm-Message-State: AOUpUlGZ2DjbEIg14IYDCGu72n2NmtVY4XbiuWVDylBFPVuSeUsL7vei
        e+SmoFkNgmiHPVHUOoRa4P+4YA==
X-Google-Smtp-Source: AA+uWPwuMS24IDIKS6cxzXATmVmxpeBs2l9yAJUb0XtC6YvP3oOatawUZx+TM5nL59vmFqge9bANDQ==
X-Received: by 2002:a19:7d84:: with SMTP id y126-v6mr4663685lfc.94.1534765417449;
        Mon, 20 Aug 2018 04:43:37 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id q73-v6sm1759529lfi.86.2018.08.20.04.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 04:43:36 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: refactor put line fn on read completion
Date:   Mon, 20 Aug 2018 13:43:20 +0200
Message-Id: <20180820114320.3764-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read completion path uses the put_line variable to decide whether
the reference on a line should be released. The function name used for
that is pblk_read_put_rqd_kref, which could lead one to believe that it
is the rqd that is releasing the reference, while it is the line
reference that is put.

Rename and also split the function in two to account for either rqd or
single ppa callers.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index cd2f61eed6a0..16858eaf694a 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -165,20 +165,23 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
 }
 
-static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
+static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr ppa)
 {
-	struct ppa_addr *ppa_list;
-	int i;
-
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
-	for (i = 0; i < rqd->nr_ppas; i++) {
-		struct ppa_addr ppa = ppa_list[i];
 		struct pblk_line *line;
 
 		line = &pblk->lines[pblk_ppa_to_line(ppa)];
 		kref_put(&line->ref, pblk_line_put_wq);
-	}
+}
+
+static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int i;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	for (i = 0; i < rqd->nr_ppas; i++)
+		__pblk_read_put_line(pblk, ppa_list[i]);
 }
 
 static void pblk_end_user_read(struct bio *bio)
@@ -208,7 +211,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 		bio_put(int_bio);
 
 	if (put_line)
-		pblk_read_put_rqd_kref(pblk, rqd);
+		pblk_read_put_line(pblk, rqd);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
-- 
2.11.0

