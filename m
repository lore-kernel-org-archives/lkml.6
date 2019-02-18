Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB55C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A6620838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500887;
	bh=XCPVG2pFbaEK++Ip3/WoppNKvpfcZiknQ5/EMX0cfbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nhFZ0+E9mxnsZ3lSi1XLKfy6c6EjpbNjXXIuw1G3cuDrdiGJZWD7UdbKP6oiHAo0k
	 u/5X3CaCwMWJG9baE9Ef3rP9ezYWUrKoiuCmh7d1pFpZQ5oOGyMK4Iu2FRqXLg0GJx
	 KR1uIawBrnWuCV0ifrmvBKgj9xqALOXjEYDQrPLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfBROl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731314AbfBRNvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06AC220449;
        Mon, 18 Feb 2019 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497872;
        bh=XCPVG2pFbaEK++Ip3/WoppNKvpfcZiknQ5/EMX0cfbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGmLlAI6+NnLDrckIl4yGcaPXWmVmZ0V+5dxmzlwynSe5lJA/9Pn4OWs/3+jO7ht6
         1Leae8MN3IkhgnWvL/LdKiNgVsmZ+ilTLNXMeTQyO6T/qBD42HqHVvLV33cIxGp8+O
         BAaw3+4/LzeScdjPcCu6UZztp81QrTU5ywLwDXbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/85] nvme: pad fake subsys NQN vid and ssvid with zeros
Date:   Mon, 18 Feb 2019 14:43:03 +0100
Message-Id: <20190218133503.850447547@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3da584f57133e51aeb84aaefae5e3d69531a1e4f ]

We need to preserve the leading zeros in the vid and ssvid when generating
a unique NQN. Truncating these may lead to naming collisions.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e5bddae16ed4..e0d2b7473901 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2095,7 +2095,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
-			"nqn.2014.08.org.nvmexpress:%4x%4x",
+			"nqn.2014.08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
 	memcpy(subsys->subnqn + off, id->sn, sizeof(id->sn));
 	off += sizeof(id->sn);
-- 
2.19.1



