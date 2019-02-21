Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C03C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A320838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759900;
	bh=+KlOeo7X8g7HG4wIeRYW+rdcLWZwYsjlSTGxC3UYNtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lRTjP5rEZHEKKtHBsxfn4TZKdr8kOREHArIYTfZxY4KVQJoMK5VFZlYe6V1HcIvbv
	 4clAY+EfgfysanV2+Vr7hbO0j8YNUbLLY0UNmK0QkMAOve37DVRShPvV2ZYMWvAZRn
	 tXspQc/VMJ7CluXnqxp9SOwYQ/qFydhiJ82ujVww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfBUOiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfBUOiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7DA920838;
        Thu, 21 Feb 2019 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759895;
        bh=+KlOeo7X8g7HG4wIeRYW+rdcLWZwYsjlSTGxC3UYNtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fysCxfqULL2EqrfzdFF1kzPxsudaJrcqmplJzR8dXdNLS+240wMlPgOQfiQH/imHY
         0RNOM7oUOtA3wvdlYIk/hc8xX+Xhp43OND8/SGGSsW9d6SXqqzuL6ppuAQgPADnhhl
         eTQYjyQQddZ5W42qD3C34sXY517Qkpen4lQSe7Tw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 08/20] net: Do not allocate page fragments that are not skb aligned
Date:   Thu, 21 Feb 2019 15:35:38 +0100
Message-Id: <20190221141947.012165914@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

[ Upstream commit 3bed3cc4156eedf652b4df72bdb35d4f1a2a739d ]

This patch addresses the fact that there are drivers, specifically tun,
that will call into the network page fragment allocators with buffer sizes
that are not cache aligned. Doing this could result in data alignment
and DMA performance issues as these fragment pools are also shared with the
skb allocator and any other devices that will use napi_alloc_frags or
netdev_alloc_frags.

Fixes: ffde7328a36d ("net: Split netdev_alloc_frag into __alloc_page_frag and add __napi_alloc_frag")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -374,6 +374,8 @@ static void *__netdev_alloc_frag(unsigne
  */
 void *netdev_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __netdev_alloc_frag(fragsz, GFP_ATOMIC | __GFP_COLD);
 }
 EXPORT_SYMBOL(netdev_alloc_frag);
@@ -387,6 +389,8 @@ static void *__napi_alloc_frag(unsigned
 
 void *napi_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __napi_alloc_frag(fragsz, GFP_ATOMIC | __GFP_COLD);
 }
 EXPORT_SYMBOL(napi_alloc_frag);


