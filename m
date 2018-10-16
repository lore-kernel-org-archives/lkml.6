Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21140C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA79D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lylDilyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA79D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeJPMRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbeJPMCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C50E21477;
        Tue, 16 Oct 2018 04:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663232;
        bh=uXzBaHbNhaAUhSIBUQf7BZrbigfY4sD6WEAZKjEa0YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lylDilyQI6IZgHTIxK1dfeYac8RAs+WAwwB4GUKc9/V2M3r4aE5bc0+dVjiyxzIL6
         qFogl+9VQnLbAwmfYrkdBc4z2n11yw/Mz1u8jeoTDEuLfXneOYoYyJTYyqbbBRsvwC
         xedJy3tg+UYXSZ2mRahdxEWN7ORcYI7hQk2dJ14k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 096/100] mm/gup_benchmark: fix unsigned comparison to zero in __gup_benchmark_ioctl
Date:   Tue, 16 Oct 2018 00:12:17 -0400
Message-Id: <20181016041221.135528-96-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 51896864579d5a3349740847083f4db5c6487164 ]

get_user_pages_fast() will return negative value if no pages were pinned,
then be converted to a unsigned, which is compared to zero, giving the
wrong result.

Link: http://lkml.kernel.org/r/20180921095015.26088-1-yuehaibing@huawei.com
Fixes: 09e35a4a1ca8 ("mm/gup_benchmark: handle gup failures")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup_benchmark.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 6a473709e9b6..7405c9d89d65 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -19,7 +19,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 		struct gup_benchmark *gup)
 {
 	ktime_t start_time, end_time;
-	unsigned long i, nr, nr_pages, addr, next;
+	unsigned long i, nr_pages, addr, next;
+	int nr;
 	struct page **pages;
 
 	nr_pages = gup->size / PAGE_SIZE;
-- 
2.17.1

