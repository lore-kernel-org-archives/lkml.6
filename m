Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3355DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E9B222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896936;
	bh=iY5M5hu6gCPhds5GjYUofegTk1rdXj3jRGV6zEwR1yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lzhqcV5a/71XTQXIobjR3Hu+1wGPxD1co93tE25egHOO6LYdzg6/sqx0qaYkdLrCo
	 fjuY/pr0X+Z2H06HM5iN+MvU7OdnusSgt2pbiv+Y/Qm6uGjHBwXsPiUKqYBLqTEvJ4
	 1GQIa7lzxzkM4x6EwulLpycckRVQn8J8HX/oM5o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbfBKOze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388982AbfBKOza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D3F2229E;
        Mon, 11 Feb 2019 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896929;
        bh=iY5M5hu6gCPhds5GjYUofegTk1rdXj3jRGV6zEwR1yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsQHFyz5AXqMWfmW3DbLmnpX25ziVe+Zj4Zn1YnPm7Kl7vOvXJSsmHt/YVpA0pGe8
         2C3ckATvgG4l+batpJGd45ghn1212bGsz/XK0iUJEnuIFqGL479ZfkwuWBWLjxSEVD
         1vOPrUlBDKFuYEAwbgd7OUSXLN3sHypWVkYObOl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 035/205] dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_ll
Date:   Mon, 11 Feb 2019 15:17:13 +0100
Message-Id: <20190211141830.140048992@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5cc8ed31f26b..6d86d05e53aa 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -159,7 +159,7 @@ struct zynqmp_dma_desc_ll {
 	u32 ctrl;
 	u64 nxtdscraddr;
 	u64 rsvd;
-}; __aligned(64)
+};
 
 /**
  * struct zynqmp_dma_desc_sw - Per Transaction structure
-- 
2.19.1



