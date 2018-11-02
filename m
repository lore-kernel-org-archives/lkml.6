Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE74AC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08262084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqMaofK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08262084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeKCDtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeKCDtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:25 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD1020847;
        Fri,  2 Nov 2018 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184073;
        bh=HlGfJHA08drQlx9ec41V3BVJRhnx61AOqUN3tZqd/aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqMaofK4xf19iPtRjjkuoXSYPrkRUN1fjVlbyC6/TR5tIAX14YCPUQHD3vkIe2lD7
         VXS1omvmZfo3OjY4GquTtoRwwsqBIsCCFu+fzPibCFpXqQPkrT0LPJ1LJ3NBpkL34I
         szm2T/5vho2amOSBiaHFzmuM9hsqpzz8r8So/P5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 071/150] mm/gup_benchmark: fix unsigned comparison to zero in __gup_benchmark_ioctl
Date:   Fri,  2 Nov 2018 19:33:53 +0100
Message-Id: <20181102182908.542632717@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



