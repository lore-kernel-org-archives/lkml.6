Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B567C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3291214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="aA2O5Ym4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3291214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeJISa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJISa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so661243pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfEYPVh4rqHS6+QUeAah9CXPO2mj/JAmATW5DSk6e3A=;
        b=aA2O5Ym4Y/iXk8JWL5FotQ8HLg3FHlj9ZN6JRvnl3I/E4K21HzpvrHgcA+/1CnVw1Q
         jPLP8+H20MxCqPt7zhynY7HSHMTdyFuALJTXdFZZqcrjsaXRd34Ae6ALjzDPDzPxluDT
         1Lv9QJwYb7oLTU0ZyhCpFPlFzqzgX2ot7J8NNibPi96//ru0mwIQlF82HtQG4XWCM2BS
         5Bd6wHvaxs5F2vP0rnJ6lhZR2tn4TbtK6zfS3sPiTVkOeeE7b5fVLt/h361FCl6Xj7Cd
         WFhxfjIdbeEh9vvt5a8MAf+/uXZkgJZpJQBP6JZKRIZl6112JX0gnvfAqJemxHrauX4y
         wKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfEYPVh4rqHS6+QUeAah9CXPO2mj/JAmATW5DSk6e3A=;
        b=H1Rvyr1LEEQ8r8C7BhSlsquLiAZzEGSipEqdweWaJWb8hMGaDjjirOgo378ITTe53T
         WKWbM4mGeInSAAOmA6XcCEM4EDaacak8HOzFLLdeTWHgrO28flHP7SXkDiNSw10bxiJ/
         IZatllbmoBpVK2NLiuYodmK5oEwF/xTlxqadqs0q1zFkiciFndoB+Z2eeiayzLw9cG2X
         Nn+TTuL373paPTVnzDCh9kElnOsgGAkQlcaGBqiZuSUUSBS1xkTZeUXxfLioy2EtAWYI
         ob133fTM9EAjkXx3YhF3x83/J7D1ZNjVChJUnk+fDyftOHnq9p9HtFc52WoNP/Y/hWu3
         IzMw==
X-Gm-Message-State: ABuFfojUbpNxt6ePAeoUqcjmAHUAccqc/Pkqgb1GymdebR5LNPqRZPzF
        2N18jEjUbl7nQceJ4qV96MQwVA==
X-Google-Smtp-Source: ACcGV60XGBGU3dNEdeMWIX0PkM6C5PZTT+cCkHapsWT8CDfo5He7geXqgnkS2RBh5SvnYCDJcdsvBA==
X-Received: by 2002:a63:6d83:: with SMTP id i125-v6mr24412670pgc.215.1539083641044;
        Tue, 09 Oct 2018 04:14:01 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:59 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 14/45] lightnvm: pblk: remove unused variable.
Date:   Tue,  9 Oct 2018 13:11:44 +0200
Message-Id: <20181009111215.7653-15-mb@lightnvm.io>
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

From: Javier González <javier@javigon.com>

Removed unused struct ppa_addr variable.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index af9477b7e803..1865ac1560fa 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1373,7 +1373,6 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 	if (rqd->opcode == NVM_OP_PWRITE) {
 		struct pblk_line *line;
-		struct ppa_addr ppa;
 		int i;
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
-- 
2.17.1

