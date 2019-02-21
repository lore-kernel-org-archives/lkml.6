Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82552084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760087;
	bh=AwKbozoJIPIjBkCJLJ6IKjNgmk/UDNp78rqv0ofo2Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UyKsV6RaayHJPc97j3dNrHk/GBydFyVjB93y0FIdn9yBRoZCwJPwaIjTAtVwlkInh
	 mjYUvZYu2GilkBEE3nxNReWiMyN+QJQuAMcb32f7joXhvrBxhvvtz3LmBsQEFJspZY
	 Yl67kz+UjS5IWNPygquMSyKjBJ9IwOiB8E42ydN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfBUOl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbfBUOlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:41:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F176D2080D;
        Thu, 21 Feb 2019 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760082;
        bh=AwKbozoJIPIjBkCJLJ6IKjNgmk/UDNp78rqv0ofo2Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCSw+V1QMbBAglWKK6San+owY6386rSi0yPFNNUTsYLFoMqWr6Q3rP39Ikjqqnga0
         wX7xQP3zRwlaFM54XC2nsmrgZqmIpLI03r4vceUs49fR4EU2BwfTad4+O8JAoOCqjb
         Ilkt9KihBuUIvSfp5Jd2q9eqgy7uFK6mvqrmd7Qw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/30] net: Do not allocate page fragments that are not skb aligned
Date:   Thu, 21 Feb 2019 15:36:02 +0100
Message-Id: <20190221125251.668880024@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -353,6 +353,8 @@ static void *__netdev_alloc_frag(unsigne
  */
 void *netdev_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __netdev_alloc_frag(fragsz, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(netdev_alloc_frag);
@@ -366,6 +368,8 @@ static void *__napi_alloc_frag(unsigned
 
 void *napi_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __napi_alloc_frag(fragsz, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(napi_alloc_frag);


