Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C82213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9ZTghbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C82213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJAWyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:54:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37387 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJAWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:54:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so236508pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JhPWD9GmCa144jbwu47jO4XGHQrL4gXGJ7XlYinBJQI=;
        b=l9ZTghbA4NsPDl7HANztX5eg5U8udL8CE5yi/0UxfLpAakMkdRN7ZqtSS1Vytat2i6
         HMyCRoevPNwYNu+kt2J5BI+ebx5P9LUckDZST3RLT7ZvNGfPKmFXIrfXHbcmOoZgbjTI
         LlyYR6qAJkyBQe+4dSZ17cV3zjyIoic6ubByA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JhPWD9GmCa144jbwu47jO4XGHQrL4gXGJ7XlYinBJQI=;
        b=iGLhvEg2a5vNsadqIMgX9aBGQ6gxj4bqH7Gkml33sYWCF/hXivUGwm+SlH0obK/QDq
         jLRVWycXFpL3t7HzaXzBR0aXhJgy0OX3AIM3709Rsn96U7L0i4h0OvJyH2gNivIPLJja
         +ps4o9npHLAiMiJu2sNtie6a7OJYm4nIqZkIDQix8exIYNGtu4aq1JqQvvvxYtw2J7+n
         +TcRccZX78a7IkO9bhP7RYOwUOv4SMpIEnwrI50x+MA3ErB1JdnzrPbwh1vYYWiif+0F
         RQndbK/kjsuiJe3fleSzZtsmFpbH3ITkwLmjT1Y1hfLHIUz97UcF/tujHP6Tcdf/gVzB
         bM4A==
X-Gm-Message-State: ABuFfohwL72AaOuVoHCzNRAzXNESzb0IQcKR7HF7BflU4s7IBoLS+O11
        pC6nz/ZsDcOgTlE7VnB1OFoILQ==
X-Google-Smtp-Source: ACcGV6343XHzISRvJSV9SnoKgUQylTkbzy9IfOpMCuTSllN2bIYTuO+5HNtF1FlUEruThv0H8bj1Bw==
X-Received: by 2002:a63:5d03:: with SMTP id r3-v6mr11016224pgb.445.1538410561460;
        Mon, 01 Oct 2018 09:16:01 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id 72-v6sm14629801pfr.115.2018.10.01.09.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 09:16:00 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robb Glasser <rglasser@google.com>,
        Evan Green <evgreen@chromium.org>, stable@vger.kernel.org
Subject: [PATCH RESEND] scsi: sg: Prevent potential double frees in sg driver
Date:   Mon,  1 Oct 2018 09:15:06 -0700
Message-Id: <20181001161506.100284-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robb Glasser <rglasser@google.com>

sg_ioctl could be spammed by requests, leading to a double free in
__free_pages. This protects the entry points of sg_ioctl where the
memory could be corrupted by a double call to __free_pages if multiple
requests are happening concurrently.

Signed-off-by: Robb Glasser <rglasser@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
Cc: stable@vger.kernel.org

---
Reposting this patch from last summer, as it looks like it fell in between
the cracks.

 drivers/scsi/sg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 8a254bb46a9b..25579d8a16b5 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -924,8 +924,10 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 			return -ENXIO;
 		if (!access_ok(VERIFY_WRITE, p, SZ_SG_IO_HDR))
 			return -EFAULT;
+		mutex_lock(&sfp->parentdp->open_rel_lock);
 		result = sg_new_write(sfp, filp, p, SZ_SG_IO_HDR,
 				 1, read_only, 1, &srp);
+		mutex_unlock(&sfp->parentdp->open_rel_lock);
 		if (result < 0)
 			return result;
 		result = wait_event_interruptible(sfp->read_wait,
-- 
2.19.0.605.g01d371f741-goog

