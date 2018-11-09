Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB1C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C646520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8tzDep5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C646520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeKJJGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:06:35 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:46203 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeKJJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:06:35 -0500
Received: by mail-pl1-f169.google.com with SMTP id c13-v6so1582710plz.13;
        Fri, 09 Nov 2018 15:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UG4oJyMT4/UdjlqVJhMyxpFsHlnbWcM5m+fV2EGq+nQ=;
        b=I8tzDep5BpnbXdWHuvJQCJHVaSIRRzebXBXz8ZXzvyrAuOvHzqB1k76XdhkpRb7oMO
         jHGYBGRWlefs3ew0MdZ86Og3KkYAeNgIHESXD8a8S/yJnDzkBkPqKTCM5i1sAYKSP3Ep
         z5I5o5MBX0s/ZrLdOhoLIgXGNEPmG+st3fYKCuiP5cxiaYyIgcPLrXQeiQMV0hUJ8v64
         Eyg59lqthnyfBvj/KutbnAmpD3MpO6olVwd/wHlzUO1wUaEPbL5QGl6KZ6kbZOHJXR1D
         crU3wgyUSsYMVpIrLz5rLerXKwG1qouw6wcAcketN+0LYgP9MzzwCubz/b67I9dpqp8S
         ri2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UG4oJyMT4/UdjlqVJhMyxpFsHlnbWcM5m+fV2EGq+nQ=;
        b=JF4LzhXusdI2ngAoz2Dq9ZIFNOpeAviGrfX1mCb4xoBX11/H03xFot0zdg6JwUT4J8
         rl+z/4T60v/TNZ5grs5d0mMX87spsf+n0jtVd+mELk4QlPXu+OpRn5QhBrtSPor3Uzdv
         TJmp/UnAMdvsg5iPkYSD07dOBe5klSQxXhdd2lYcN+HFIHe8Y+cffrpqQYNLna1ptzYc
         6hjnVxDvNX1zL0hNYbZ29qa1N/odGYHpRUslBbT6opHY4i6z1GM8FhHRYrMFdqx+h9/u
         zuqQWtCuY/og1I2gX4s91BiIy4EIA++3A3sxMqdqlf72nMPIioVV1s982mFCe5604vAT
         5prA==
X-Gm-Message-State: AGRZ1gLEVbGHWVZboxkWfCkOp/mM/rihptlkigYXEipVf7ST75vXe8Cu
        q9uSbV9lbflepLT3fN1pOpQ=
X-Google-Smtp-Source: AJdET5dp6k83d8DTmLTQdPky/R/L/9u2+O2Z/uejopgjK0FZZA1gdb7GqAiSL56L6r1CmTe6+9gZmg==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4-v6mr3765929pll.60.1541805829048;
        Fri, 09 Nov 2018 15:23:49 -0800 (PST)
Received: from localhost.localdomain ([104.238.62.13])
        by smtp.gmail.com with ESMTPSA id s4-v6sm8487287pfh.168.2018.11.09.15.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 15:23:48 -0800 (PST)
From:   hmsjwzb <weizhefix@gmail.com>
Cc:     darrick.wong@oracle.com, hmsjwzb <weizhefix@gmail.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix misspelling issue in fs/xfs/kmem.c
Date:   Sat, 10 Nov 2018 07:23:01 +0800
Message-Id: <20181109232301.19977-1-weizhefix@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 fs/xfs/kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
index fdd9d6ede25c..73ec1f84e591 100644
--- a/fs/xfs/kmem.c
+++ b/fs/xfs/kmem.c
@@ -45,7 +45,7 @@ kmem_alloc_large(size_t size, xfs_km_flags_t flags)
 		return ptr;
 
 	/*
-	 * __vmalloc() will allocate data pages and auxillary structures (e.g.
+	 * __vmalloc() will allocate data pages and auxiliary structures (e.g.
 	 * pagetables) with GFP_KERNEL, yet we may be under GFP_NOFS context
 	 * here. Hence we need to tell memory reclaim that we are in such a
 	 * context via PF_MEMALLOC_NOFS to prevent memory reclaim re-entering
-- 
2.17.1

