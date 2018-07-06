Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835C7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C21822B70
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P/ka28H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21822B70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeGFVo2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:44:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41037 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeGFVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:44:27 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so3407489ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KrIQAzZyjefIKFQ4uitl5ddkRz/kLtCH2yreZba173Y=;
        b=P/ka28H6AF24giTrfYp6TurGv4lxHlj6RxRHbcQcILBUw4McUHRo8WsgZqyOVG2Wrt
         cvE/I5gkiN+os13/GDL8xrlx2BCi4FzuKHxOz/SsL0eBqPArlwrug6Utmir91Ri1/w7h
         XIR+I4YoL0xXTZ6YxcTlPI0SyOJ4rTCzEfU7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KrIQAzZyjefIKFQ4uitl5ddkRz/kLtCH2yreZba173Y=;
        b=WqXklTSN/8V2NpAAG6SLNTKGCBadH1ku6e4xnegEAyHwX5qmBq1j5Sd1s8SzYLwEDl
         RKqDxvN/qaRn1TCllUi1muyplz89R6Z1LDJPeHURXa/av4v5zA73/TZluA7KwAFdenxA
         A+Agvi66T0NHITlVa86jJLw6ra8Gtej5qmuxFUdgifUK1Q/UU6K1EitKsxJd3UYtAup+
         WZ06f6BVRogbBacaUYMzeOpMd4g0oTRIEc0WRnRVrvI7zMExbY6oEauKZ9UfDnWcHXYC
         USFUrALJn/izoQd15ZVlJ+k54zgA7lQrI2+VrNc+cPBzvmadqM1f50T76mq/g3nKhGJ8
         Jg2Q==
X-Gm-Message-State: APt69E0PFO6Mu07xIdiQfVr5e9d3rak//RpnViENV1W+tBr4EG50mwFX
        w4Gyw8syZDMesmnlBZQ5qBjUOFpp9+w=
X-Google-Smtp-Source: AAOMgpc+4uUODTaxkJUJsQo+jWqtlbPk6YZskNRI6F2j7ZPoAij9aAe5Qgs0ziIBsSy292DF8kQv/g==
X-Received: by 2002:a17:902:28ea:: with SMTP id f97-v6mr11357616plb.55.1530913466700;
        Fri, 06 Jul 2018 14:44:26 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id c5-v6sm26967844pfe.169.2018.07.06.14.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 14:44:25 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        Tobias Lindskog <tobias.lindskog@sonymobile.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Arve H" <arve@android.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>
Subject: [PATCH] ashmem: Shrink directly through shmem_fallocate
Date:   Fri,  6 Jul 2018 14:44:16 -0700
Message-Id: <20180706214416.184691-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Lindskog <tobias.lindskog@sonymobile.com>

When ashmem_shrink is called from direct reclaim on a user thread, a
call to do_fallocate will check for permissions against the security
policy of that user thread.  It can thus fail by chance if called on a
thread that isn't permitted to modify the relevant ashmem areas.

Because we know that we have a shmem file underneath, call the shmem
implementation of fallocate directly instead of going through the
user-space interface for fallocate.

Bug: 21951515
Signed-off-by: Tobias Lindskog <tobias.lindskog@sonymobile.com>
Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/staging/android/ashmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index a1a0025b59e0..23ff9ee80386 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -444,9 +444,9 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		loff_t start = range->pgstart * PAGE_SIZE;
 		loff_t end = (range->pgend + 1) * PAGE_SIZE;
 
-		vfs_fallocate(range->asma->file,
-			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-			      start, end - start);
+		range->asma->file->f_op->fallocate(range->asma->file,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				start, end - start);
 		range->purged = ASHMEM_WAS_PURGED;
 		lru_del(range);
 
-- 
2.18.0.203.gfac676dfb9-goog

