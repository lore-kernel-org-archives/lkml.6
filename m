Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFC620844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895294;
	bh=quk47f2brUt6xwGxlZ0z5GgqdUyoaBNQAFQ9yMo+4es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mF/rMDQUoe7vpI1Bg4/bXHwng9DXhhZSMjt/WJYJETGKrhJQaCNoW2nOhlBNffiKE
	 BVmtYr9VGGh4yof5h0Dl58PmGq2xoX5eSflgEBuDakpGzBJSTBuJtlDXnRXBkHK0r3
	 LBvWb4HRcpXDCe1PcGViw18jI/BVbM3c1Ewxlh5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfBKO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfBKO2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E9620838;
        Mon, 11 Feb 2019 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895288;
        bh=quk47f2brUt6xwGxlZ0z5GgqdUyoaBNQAFQ9yMo+4es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fx8Gnx3IqgZvoOyoKk3vA7Y9vNQR1VMn9sfotF4kR/DwovN9P2trWa6rBlh0wXKNg
         Aw5tQtb4Cz+hm62RQYEq5jhea0OAcegW83wdg5tfqFptBWgJE7wbzn9YIeKH+iSjF+
         ibgoy4HPawizk02RaQJGbUDiZagl/C+V445OAdCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 156/352] lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()
Date:   Mon, 11 Feb 2019 15:16:23 +0100
Message-Id: <20190211141856.685540887@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 55e58c5e78aad9d3246f57e7718cf5ee7adde9e3 ]

With gcc 4.1:

    drivers/lightnvm/core.c: In function ‘nvm_get_bb_meta’:
    drivers/lightnvm/core.c:977: warning: ‘ret’ may be used uninitialized in this function

and

    drivers/nvme/host/lightnvm.c: In function ‘nvme_nvm_get_chk_meta’:
    drivers/nvme/host/lightnvm.c:580: warning: ‘ret’ may be used uninitialized in this function

Indeed, if (for the former) the number of channels or LUNs is zero, or
(for both) the passed number of chunks is zero, ret will be returned
uninitialized.

Fix this by preinitializing ret to zero.

Fixes: aff3fb18f957de93 ("lightnvm: move bad block and chunk state logic to core")
Fixes: a294c199455187d1 ("lightnvm: implement get log report chunk helpers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/core.c      | 2 +-
 drivers/nvme/host/lightnvm.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2..73ab3cf26868 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -974,7 +974,7 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
 	struct ppa_addr ppa;
 	u8 *blks;
 	int ch, lun, nr_blks;
-	int ret;
+	int ret = 0;
 
 	ppa.ppa = slba;
 	ppa = dev_to_generic_addr(dev, ppa);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a4f3b263cd6c..d64805dc8efb 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -577,7 +577,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i, max_len;
+	int i, max_len;
+	int ret = 0;
 
 	/*
 	 * limit requests to maximum 256K to avoid issuing arbitrary large
-- 
2.19.1



