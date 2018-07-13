Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994F0208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="gbZPjthJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994F0208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGMJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:03:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39411 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbeGMJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:14 -0400
Received: by mail-pl0-f65.google.com with SMTP id p23-v6so660512plo.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guX+AAdmqPGxri1WBU30oxOqHrngNhPRqJoTW9aS5Js=;
        b=gbZPjthJ6U9lgH7uR3vWu0E4z7au8/BkEireWOTWBo82tdzxlrbbBC+hvgLO+cQbxv
         VMg7LQjjIeFFyvglQTr/HvBxk9wlXfe8cLMa5v9v2RmjVRUEmYlYdRsV0xbjKiSbgqhe
         /Zj6yDWRZJX/11777L2c6iJfDuLtGUDVV64PS4Ou2hndiDIXLuM9cTViJLe9gp7aTcAm
         KTYNXL2qhxCjtvcXb+R1LfbCxZybla2cIpWiAS1w7Qwch0YeHQ1nAmFzzWncMw9JyFgJ
         A6l6NS6fjSfJkwdaeaXPicd2cy+mJo/f+cQKI7M/kIRR5LxDB91+XDqc3csCSKZQqC6C
         8PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guX+AAdmqPGxri1WBU30oxOqHrngNhPRqJoTW9aS5Js=;
        b=KZfxOMwBpjOQRJVITzEnkfahUl54VEx3EkixltyYET+fL9JPqTeJQtXKqQ57aGaWzc
         vtVkfAI+bJgSf4QcKKB7jrr9ScXP6U99b5YwMe6+uv7IS2v5v7aZvuXpjQW1hol3uGjs
         eFEePAdDR5xFAma0O4gE4wKslUn5GQgSExWAJAhcJoBsrN3h7/lGTup03CBU3iLesgZF
         4RB2H6mOH1rtEOAa7h1CT2ssVZykvLLDMtQU0kEFilv0VVBkHdPE3RAHp1Ax1p37b9IV
         pp+mT7alAcmJEV1yAPj3NB9lQvlbJHULhVYjHMkGkhio95970hc36LamsstjOwjjPBDc
         wq3A==
X-Gm-Message-State: AOUpUlFr7HlQkh/00/DFPqChPATMpuwDhjvRAWvieegpZd+YEygLJapg
        AWZA764JhEeBrD3osKrGjbhYmA==
X-Google-Smtp-Source: AAOMgpdSfmSOSlG9/akLgD9qRtcP6bk08Jj9A3n5zaY3yr1q3ccltWtSHmo2LhrtFlryX5f7bq4wEA==
X-Received: by 2002:a17:902:8347:: with SMTP id z7-v6mr5624375pln.290.1531471773962;
        Fri, 13 Jul 2018 01:49:33 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:32 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/10] lightnvm: limit get chunk meta request size
Date:   Fri, 13 Jul 2018 10:48:41 +0200
Message-Id: <20180713084845.19511-7-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices that does not specify a limit on its transfer size, the
get_chk_meta command may send down a single I/O retrieving the full
chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
split up the I/Os to a maximum of 256KB and issue them separately to
reduce memory requirements.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a76db8820f1c..d9e4cccd5b66 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i;
+	int ret, i, max_len;
+
+	/*
+	 * limit requests to maximum 256K to avoid issuing arbitrary large
+	 * requests when the device does not specific a maximum transfer size.
+	 */
+	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
 
 	/* Normalize lba address space to obtain log offset */
 	ppa.ppa = slba;
@@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	offset = log_pos * sizeof(struct nvme_nvm_chk_meta);
 
 	while (left) {
-		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
+		len = min_t(unsigned int, left, max_len);
 
 		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
 				dev_meta, len, offset);
-- 
2.11.0

