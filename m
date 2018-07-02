Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF36C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD95324AC6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3n7EdR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD95324AC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeGBQnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:43:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36384 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752554AbeGBQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:43:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id m19-v6so3853772pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JHaC/LEh/IfYRgZCgUTt5b1x7bVSE3+8ymM3PQz3bv8=;
        b=a3n7EdR72H1WcwK2KxpXswhlCj/LTLmVmYivRlzsq3rkbF5pa/RIjnGDs3Rzm4jbrd
         HAW19rDg5vKF62UGNU4tn+guG+IET6F458qi1d0vVadtZNNZuNXwTUPN/IH37OGtvnIx
         M+dXLJomxFJ1uX/VLAkhRrfQEvyNxzXHKp4rzO4fkMZcO2vIWzLLG31K0Z3i9Svrvltx
         iH6GpJkjBZtcJtvtTjxbRLWi7HGCubos6kN1IJR+DPaU9eOxTCPgA92eXRrDjlU0DTBu
         gxAHyftxlgZMVfLBIrvG4oMOL6aXNEQ404qOixu8T+3RcwN6UH+pH1+/zeuu4zhJ4WZo
         /9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JHaC/LEh/IfYRgZCgUTt5b1x7bVSE3+8ymM3PQz3bv8=;
        b=gwnOwVPdMUW1beY24wVirEvz1nK/FUCTVR1v7LyQ1DWLRZ5j6lh4LOQKbbYs85xgdT
         7XklP7g/be8qdWKkaeuVcNSnUzNSQtr+iEOCkI8DGfetytfquJ2I83fJvsEdTUppy21u
         qLoAerSJazY0syQsiguvsA6Fjqhf+pusVfiKa0dWxjtlFhstTqMEbWp/Jl7/YosKWNrE
         SypIhZPheXyzVYLDSZe52NONT7xjRMNCdOdGmpbx7jigzgtR80seePkZGBkyJ8OTCF6j
         G2xIr2j/QzSQ8bHG4TllSz1mM87Y2lBy8/Dh0A1mvN61y2O25/RURdgSAB94CQJgfC2R
         nJYA==
X-Gm-Message-State: APt69E064cl2ZUaah9zphzV5CfBxKtjMYG8CPwful3oO9TimOHhUXkRR
        HLp1PgZUnKIP7SD0JtCEVvA=
X-Google-Smtp-Source: AAOMgpfbwf6EEJLAYnL22tBL3gVOfB78dbiFEaiexoZCaGPubeviFvN2/cqprQSvAqTwRhw2FkfIeA==
X-Received: by 2002:a65:4a49:: with SMTP id a9-v6mr20671166pgu.267.1530549824402;
        Mon, 02 Jul 2018 09:43:44 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id k13-v6sm47788864pfg.130.2018.07.02.09.43.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 09:43:42 -0700 (PDT)
Date:   Mon, 2 Jul 2018 22:16:13 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] fs: gfs2: Adding new return type vm_fault_t
Message-ID: <20180702164613.GA4829@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for gfs2_page_mkwrite
handler.

see commit 1c8f422059ae ("mm: change return type to
vm_fault_t") for reference.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/gfs2/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 4f88e20..2c471d6 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -387,7 +387,7 @@ static int gfs2_allocate_page_backing(struct page *page)
  * blocks allocated on disk to back that page.
  */
 
-static int gfs2_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-- 
1.9.1

