Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1980C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6530C21B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899209;
	bh=kOOuDYxLlLuHkGpwAxNoAzS/LbcpM4yvs8HpCFSIufQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Jh0UU07vWkszd9RZUTY8jk/C7HzISFhgeyGG+YOWzSiUkRh5m8qd80yQgErX6V4N
	 gfaqeplIz5Cgr71kMOPw9Se2YTy2+RurmndASZJntOOl/eX5xBCZvSnV7fYI9twd2B
	 yoxk0yBCbdpmNWGKmtj1DQyTYQ09Z2kvY5ju4Oa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbfBKOxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387780AbfBKOxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:53:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C2220700;
        Mon, 11 Feb 2019 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896816;
        bh=kOOuDYxLlLuHkGpwAxNoAzS/LbcpM4yvs8HpCFSIufQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XahRh13aqdJcp13ZRjGVzqKr8K0d2QD4IXzqPW74lscjsaBzYtTOb6pcK4ADJSfJf
         yRi8pb0RX9JDEqWEgX35aziXJezJaZNle8BYtIjqpHptZ9bmfjhjyhqUJ3ry7WzgmZ
         m6aZ7QlgMnDru3OI1kS4GgK9Rh37XHYSNS2BKuf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 4.19 311/313] cacheinfo: Keep the old value if of_property_read_u32 fails
Date:   Mon, 11 Feb 2019 15:19:51 +0100
Message-Id: <20190211141913.562283614@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Huacai Chen <chenhc@lemote.com>

commit 3a34c986324c07dde32903f7bb262e6138e77c2a upstream.

Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
property_read_u32 instead of get_property,read_number") makes cache
size and number_of_sets be 0 if DT doesn't provide there values. I
think this is unreasonable so make them keep the old values, which is
the same as old kernels.

Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/cacheinfo.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -79,8 +79,7 @@ static void cache_size(struct cacheinfo
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->size))
-		this_leaf->size = 0;
+	of_property_read_u32(np, propname, &this_leaf->size);
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
@@ -114,8 +113,7 @@ static void cache_nr_sets(struct cachein
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
-		this_leaf->number_of_sets = 0;
+	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
 }
 
 static void cache_associativity(struct cacheinfo *this_leaf)


