Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B46C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3F520896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="A4BIMjPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3F520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932757AbeFQIbt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:31:49 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34268 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932557AbeFQIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:31:47 -0400
Received: by mail-wr0-f180.google.com with SMTP id a12-v6so13751174wro.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qbVFzHi6wmBLzOp1euCgs3b+X8+XmARsxoSNjosO82Y=;
        b=A4BIMjPkLTOVmwOnG9FvF2NTNCXZ0KdPo5zS3ZUzQV3hdYgTsoBuypIxe+rHXrSvyx
         y/wxZMsL1SYBTjm5vER6PZnPpTdWJfW/YsdjuYDOCDlm3QR9tjYIlhL46D34USeyM8U+
         jWDL9VP1tYILa33FbdGKXWpfLQ/QINEQIRrrX4OCLGrvN2iORHA9fv3SsEs1JtuRAG3h
         SwBKuvVyCMk9kt0kkNmcbbtxkSSsan3eXpEGs2QXLOH7ue5rdHl4eJNZekczzxqBKLp1
         ABsLVlCGOuMcINy5LRVnRRSQKeboMHMP2IFMQTQuj1g+bO35tePzZHzqwPx7NonoYrZ8
         fN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qbVFzHi6wmBLzOp1euCgs3b+X8+XmARsxoSNjosO82Y=;
        b=larLNisrS9zdTMO/H6VyZ5Edhy0GYp3ZYWneEqK9TeWdZCkyDxTPxQD1mpKa8THb2S
         bov62va1I3z2ewfNbU4Y4g0atQ14/jiDDfvr08XmluOsSOJzAh8kSwoEWv5YVOFS9prn
         bKEugYMX1bY4opFkSl0vWrsc40tFNemDtyUNuP6VddoFnQpZPNVVVaOJ4bsVWipCo4FK
         y/rwblv1ZxOWLAZ/Cg9S91RIJqi0gmJNDzy61rc7snT12DsWpdyGEEHNBennHHX7ftqN
         akx8TYBWVjsn47iDvAO7YHiL3fWnR9ezGD3jJ31bc6GxDb3FVYB2US6Vj2gxDqN2/U01
         O9YA==
X-Gm-Message-State: APt69E0JKPir7c6gZMSOjCHDb5JaXjB7uwcHhRTLgBgmmtRTrlWfT/y9
        KJOKLkXWG1/8RZBKFtq50CEOv+AW9sM=
X-Google-Smtp-Source: ADUXVKLV3VuG6m1H1r8g5wmcS4Z0M1DAnocAtV9n5Z3ox7R8oD1HPM+Jj+7/lkDv7sJ3WoXbBXIxpA==
X-Received: by 2002:adf:a851:: with SMTP id l75-v6mr6514598wrc.140.1529224305621;
        Sun, 17 Jun 2018 01:31:45 -0700 (PDT)
Received: from avi.cloudius-systems.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id c11-v6sm12335454wri.49.2018.06.17.01.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 01:31:44 -0700 (PDT)
From:   Avi Kivity <avi@scylladb.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] Revert "eventfd: only return events requested in poll_mask()"
Date:   Sun, 17 Jun 2018 11:31:41 +0300
Message-Id: <20180617083141.26543-1-avi@scylladb.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4d572d9f46507be8cfe326aa5bc3698babcbdfa7. It is
superceded by the more general
2739b807b0885a09996659be82f813af219c7360 ("aio: only return events
requested in poll_mask() for IOCB_CMD_POLL"). Unfortunately, hch
nacked it on the bug report rather than on the patch itself, so it
was picked up.
---
 fs/eventfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index ceb1031f1cac..61c9514da5e9 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -154,15 +154,15 @@ static __poll_t eventfd_poll_mask(struct file *file, __poll_t eventmask)
 	 *     eventfd_poll returns 0
 	 */
 	count = READ_ONCE(ctx->count);
 
 	if (count > 0)
-		events |= (EPOLLIN & eventmask);
+		events |= EPOLLIN;
 	if (count == ULLONG_MAX)
 		events |= EPOLLERR;
 	if (ULLONG_MAX - 1 > count)
-		events |= (EPOLLOUT & eventmask);
+		events |= EPOLLOUT;
 
 	return events;
 }
 
 static void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
-- 
2.14.4

