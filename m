Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F86C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A45721903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497557;
	bh=3e7k32H93rj1vnnGn+9CDzlmrZJrR89JAdnSeVNCHvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PpkF9B2EyErApXWgJnm7WFxlFjEJbe61ZtyA6+GgmogJjfLUhKMpw9WOg4THjsmil
	 MRCMo4eXhpZXsq+GQOh9Di8jd6jfLR3Bd0IzjsQqqVceLi3JiJorOHSzTMF1ZqRMlN
	 ETXDsjmP7D6uTZNgoJQigjN4uRrYTjlW9KhJvOOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfBRNpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbfBRNpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77109218FC;
        Mon, 18 Feb 2019 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497552;
        bh=3e7k32H93rj1vnnGn+9CDzlmrZJrR89JAdnSeVNCHvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjY8iRJwStsP7oaHNyD1A2ByP0hVIPdPCAdfXHX+6ORDjQ0q8/zqM3IKGqVwP5piT
         9brYLPaKU2CFxqYU/21zWrEyZlCQvaytAy9cKNvUOFXZSXcxpWHgDeORBjHg22KtmC
         s/4RdUK8RvanaJABI+mAylb5MhrbF6ClBFP/XE4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 27/92] nvme: pad fake subsys NQN vid and ssvid with zeros
Date:   Mon, 18 Feb 2019 14:42:30 +0100
Message-Id: <20190218133457.258789956@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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
index 962012135b62..971ca6754959 100644
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



