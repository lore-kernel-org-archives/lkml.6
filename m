Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCFFC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5D62175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697614;
	bh=uOFtN1pOPfF8tsDpVxzyAfV8QFr9IK5zn8EI/buEzow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CZjTpwjdU1zlZed/+clHJRysrUvSOoFG2UOeoLT1+I0mucCMY2MsBYIschib4WC5z
	 BXpvcqKI7ADEFGUniHYHRluwRIaCtr8BYmzxFNTpjImp1ELcP9vUHnN2prHj9tZGyL
	 n1j01GKGRIJtuTFNojDw0b7nEX3+A35blUpdxiG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfA1Rqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfA1Pqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E41521741;
        Mon, 28 Jan 2019 15:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690411;
        bh=uOFtN1pOPfF8tsDpVxzyAfV8QFr9IK5zn8EI/buEzow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mniENjyXf7W2D6vIdgGq21X8390leMuC82KXu7BbfI9tdwocXTyyc+2+hrq/7BRck
         tv9HKDP6vT8EusHsB9Uciq27+MsDsC2WxmGX9iGOChzh5Cp9P1fjN/TsNH0mw+2PLz
         9QYrFv//zR1cwZEDROVO2rC4w6DBkLboCpC7wtk0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 077/304] dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_ll
Date:   Mon, 28 Jan 2019 10:39:54 -0500
Message-Id: <20190128154341.47195-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit aeaebcc17cdf37065d2693865eeb1ff1c7dc5bf3 ]

Clang warns:

drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
ignored, place it after "struct" to apply attribute to type declaration
[-Wignored-attributes]
}; __aligned(64)
   ^
./include/linux/compiler_types.h:200:38: note: expanded from macro
'__aligned'
                                               ^
1 warning generated.

As Nick pointed out in the previous version of this patch, the author
likely intended for this struct to be 8-byte (64-bit) aligned, not
64-byte, which is the default. Remove the hanging __aligned attribute.

Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index c74a88b65039..73de6a6179fc 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
 	u32 ctrl;
 	u64 nxtdscraddr;
 	u64 rsvd;
-}; __aligned(64)
+};
 
 /**
  * struct zynqmp_dma_desc_sw - Per Transaction structure
-- 
2.19.1

