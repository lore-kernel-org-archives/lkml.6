Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834EDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4895B216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4895B216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeHURle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:41:34 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHURld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:41:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lq1ku-1gN2R31yNM-00dkBQ; Tue, 21 Aug 2018 16:21:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/ucm: fix UCM link error
Date:   Tue, 21 Aug 2018 16:20:44 +0200
Message-Id: <20180821142100.2250647-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:j4Viy4RFwdOUAKBVAHH2hGbQvOXvAIcHCh8CwmLaCDEhaZxApK8
 s3/FdQBdA8eBfMb5eVPHLUN4Zn+5FHpzbtH1AIzMiPERkroyiW7mPZxWt9pjagPqKqBhcPx
 8nJyj1qzptn7Hr/iCxPT9u7WXRwJyrFFMnYscIvO8Tx0Pq6cVfzNPruAadS3qLJ9q+Pzi2n
 Wy/PrQP0eWGn16MMrx4+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vgF9bWMQP40=:8lKmIOFZB6URtfu/5U1CMT
 xDQ/V4ovgm66eMmOJyQv/rlp4Q/13eKZHVxm0fVFGPOWqreFljLvEs30m67+xUExawtylpvd2
 MmQo5T2aO/H1ZaseaBrF+3ylJrKrbwEoXfmgXKzNuDYJ1CToDs4eHIuE1HCRsMJKUohVeVsns
 UyNUD4tOeYrzvwlLu1u97kW/AThV067gFWUMsieosUx25kRpqTuLbU0CvN2HXxveHOuRKys+l
 fzfubfUEgx+IMnIbGflS8+Lw9ulHsnBzliqfUEMX5C6SydIcRXZIsfBkkc495RLb74JWWoQZF
 +/komJA4H7W7Y4uE86JEfp+A3ugp6coeZYuH6W4Ratm68/6nES0/rAJFVTKJLo90jxgU9GLkD
 4QmjCW0Jt8j6GgfVYLv790+dBzQOxLPbmT569rG+I639/5dudJ8xhhR3+QXVtwib9z0/uwyqa
 ae3Ugzg58OGlSftFyp57jM6fVk9f5mI2nXYm73sUZbw7iP0O+xaii/bfQba4UzOMsxYIda04M
 T5p4hL+QTFxjqsZO3r3oL+QiNMVYf/igP/6RlcvJPpZi9MypRtHhWaOQbLlBRjbylNaFds9Q8
 PnEz4hwxwkSWe0yAgV2pFsMAu7wdA+MNZbU83yccPmFWTYeoxFJdxpoC9wrs+lcDK5RLS73i+
 kx1teLfEqlxze3WkHWRgKCQvrW739h2ZCMmaZH+swavrwq/F75Yf6dFog4ex8Y9Gw7f4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building UCM with CONFIG_INFINIBAND_USER_ACCESS=m results in a
set of link errors including:

drivers/infiniband/core/ucm.o: In function `ib_ucm_event_handler':
ucm.c:(.text+0x6dc): undefined reference to `ib_copy_path_rec_to_user'
drivers/infiniband/core/ucma.o: In function `ucma_event_handler':
ucma.c:(.text+0xdc0): undefined reference to `ib_copy_ah_attr_to_user'

To get it to build-test again, this makes the option itself a
tristate, which lets Kconfig figure out the dependency correctly.

Fixes: 486edfb1039d ("IB/ucm: Fix compiling ucm.c")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 1d6f5710d1df..176b943dfec9 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -35,7 +35,7 @@ config INFINIBAND_USER_ACCESS
 	  rdma-core <https://github.com/linux-rdma/rdma-core>.
 
 config INFINIBAND_USER_ACCESS_UCM
-	bool "Userspace CM (UCM, DEPRECATED)"
+	tristate "Userspace CM (UCM, DEPRECATED)"
 	depends on BROKEN || COMPILE_TEST
 	depends on INFINIBAND_USER_ACCESS
 	help
-- 
2.18.0

