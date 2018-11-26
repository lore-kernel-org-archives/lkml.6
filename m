Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58164C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFCF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ECCikKGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFCF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeK0DjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:39:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36710 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeK0DjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:39:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so16442434edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8evddiikL3tOqy/f4zVT9/kxTqkXqGrvFI9LY5FHVe0=;
        b=ECCikKGVD+N3PsqCd5E+Pbym0YTKSHWI8O6+I32D0JDezLaJ4vCJszkqzU7KMyjbOk
         FCU5UY9njvUVPdZBctHXYvfBFJlnxFk0DHFTJpXqbLaCETmEwinxulC8Dd8d3VEBDRVW
         mNCdhZ3Y1m7D5ZcmU9zksZdX4zWSrrc+frIeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8evddiikL3tOqy/f4zVT9/kxTqkXqGrvFI9LY5FHVe0=;
        b=ePswq/mXaFEDzEvaKWovDqJgoX8VKDBy/bw5w1Q8EpK8gsDp3IRo6iTHR89gCWFGCF
         kWCJpT84KOd7T/AzUXpLDSVOF66c8aJKcMLuuYT+Q+fzwX1lLGiaZw19ifT1ui5gVJxe
         FfaAOhUBMxX9tyOBxfLLUQYHFX0Fb54MH5MDED5494BhhNqHXU61e60jpl32Mm3ZtPYx
         Lys68Ztax7VBJ3oANy082xjQ7+bkLQRMKAr3OHG1191twSDw7Yoi1lYheYV4CrTcaq+p
         Fmz64xnhyPrWjYeQapEF83ulFdd5m0+mxSDIKlOI7sAT3YlEbjwo9PBLhIXWXZHEV1Ul
         ME1A==
X-Gm-Message-State: AGRZ1gK1H9CLaWs1JO7v+UI16MDuBGgJQ60LpfoHkGVDeCEMagKDhTJw
        hIWHKiZIbZtRHT5TQU16+tS6OA==
X-Google-Smtp-Source: AJdET5fJBjc51Qt6jDVoNLTg/rnEcY8rm9YKRQSYQaQNkGey3+aVCITDtCCVUsD1jwhrI64YMguDiQ==
X-Received: by 2002:a17:906:7a9c:: with SMTP id f28-v6mr20925980ejo.135.1543250665013;
        Mon, 26 Nov 2018 08:44:25 -0800 (PST)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id k32sm297995edb.42.2018.11.26.08.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:44:24 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] afs: Add missing memory barriers in afs_manage_cell()
Date:   Mon, 26 Nov 2018 17:44:12 +0100
Message-Id: <20181126164412.11184-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comments for wake_up_bit() and waitqueue_active() point out,
the barriers are needed to order the clearing of the _FL_NOT_READY
bit and the waitqueue_active() load; match the implicit barrier in
prepare_to_wait().

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 fs/afs/cell.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index cf445dbd5f2e0..a9488abe56029 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -637,6 +637,7 @@ static void afs_manage_cell(struct work_struct *work)
 		cell->state = AFS_CELL_ACTIVE;
 		smp_wmb();
 		clear_bit(AFS_CELL_FL_NOT_READY, &cell->flags);
+		smp_mb__after_atomic(); /* see comment for wake_up_bit() */
 		wake_up_bit(&cell->flags, AFS_CELL_FL_NOT_READY);
 		goto again;
 
@@ -678,6 +679,7 @@ static void afs_manage_cell(struct work_struct *work)
 	cell->state = AFS_CELL_ACTIVE;
 	smp_wmb();
 	clear_bit(AFS_CELL_FL_NOT_READY, &cell->flags);
+	smp_mb__after_atomic(); /* see comment for wake_up_bit() */
 	wake_up_bit(&cell->flags, AFS_CELL_FL_NOT_READY);
 	_leave(" [deact->act]");
 	return;
-- 
2.17.1

