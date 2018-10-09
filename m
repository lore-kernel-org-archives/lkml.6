Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B68BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114EE214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="LsDMiSGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114EE214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeJIScE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:32:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42600 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeJIScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:32:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so668420pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ld8Cyo7wvWWxWUMW/IaZbWJk35j/A2DpbxU/gAK4BFI=;
        b=LsDMiSGpQovtR3pFkJ9NfMvz6PevcXtAu6sb5cZtNjHBWL5NkE2LTbmZR8fLgzVuAN
         rUwvEmYHAIOlSloJttNirKZsulPZLo5oi4ygNTLToSHK1rRMu7IMQsbDayp7Cvns2UIT
         /3Doz8PSTFLOZiLrKryI/9hiBawW+ZnpPLpZcRVim83o9Eb4j5x8yDsYh2Z3RRC2b1AA
         Xs3TyeHIy3OHBYJbTpoOQxis4BkRdUqXm2QUa14Gao4SkuHp6c29TYtcY60uF4LUxqng
         nYCx4rayVITsgbt7rbCtsxNVblkCzdL6Rf7iJ7p/W5R4uFDcukOi3nu+p9fxaCRvshGj
         0tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ld8Cyo7wvWWxWUMW/IaZbWJk35j/A2DpbxU/gAK4BFI=;
        b=icFGNTI24XEAvMskQRFyJxSRjwKP+V0En08Y2mLyjz4mc17b8dj/TGmlvHJW7QzCoR
         j5O5gr6EqAsiLwDFTQVjtruOS0DGMgIjwT6Q67TrYAd6bYuucVrJFnDDVkpvyb94cjzG
         Ab7IQFtFjXBlSZKtvn3dvaTa5Nrjzd114dEcejgzjU2vbYClXsFA8K9RBmClCwqZ5ScG
         ufSMdJA6X3Psp1hGn84ik5sFmB/RDTp86tYUjU84NQnUWBUWkbBrx31jVukZtL72GNLy
         tHiupF445v/RzrFWMy5kzX9r3UCNnH0gJTji6I2K25FmUs7taK6RdhnSuHwtgQzPQu8E
         fSdw==
X-Gm-Message-State: ABuFfogu8F2J//oxZtzf7aoPPOG2nSErDeoMoM8IIQVr627FYTnxKf+6
        ckPr7LwailCuI2WfXqQ5FjOolQ==
X-Google-Smtp-Source: ACcGV60n9/zfBBlUl7/Oh+31D9tQdbvGJY7HjFCd9pU1TxtkIpl0Aspet4IwJoXEArXaGLBnWY989Q==
X-Received: by 2002:a63:cb51:: with SMTP id m17-v6mr24570149pgi.105.1539083736602;
        Tue, 09 Oct 2018 04:15:36 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:35 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 42/45] lightnvm: do no update csecs and sos on 1.2
Date:   Tue,  9 Oct 2018 13:12:12 +0200
Message-Id: <20181009111215.7653-43-mb@lightnvm.io>
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

1.2 devices exposes their data and metadata size through the separate
identify command. Make sure that the NVMe LBA format does not override
these values.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 7d0a4d3b0a48..a4f3b263cd6c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -977,6 +977,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
+	if (geo->version == NVM_OCSSD_SPEC_12)
+		return;
+
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
 }
-- 
2.17.1

