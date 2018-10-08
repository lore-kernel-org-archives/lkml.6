Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F6C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA5B214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8jgRO+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA5B214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbeJICB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4692087D;
        Mon,  8 Oct 2018 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024530;
        bh=P9bCwj0AUdJgfJbCGqRhOZOVXFbnv4oBEVlz9EGlmFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8jgRO+LZ2kbwPqoFNS1mgDDAhXSGP5vVfzu8sNkuA+9BspseoPyCWDjmaZp1n0dJ
         Vb7qCN5j9o24kZLe/SQl7Dkx2V9nGJgBW5ebGbg2v5GiY1y53CT1zFhKqPZwEzhmaS
         /sy7vFNS2Nyghvn9lDFGTC0UP579dtmuPVee7L44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 071/168] tools/vm/slabinfo.c: fix sign-compare warning
Date:   Mon,  8 Oct 2018 20:30:51 +0200
Message-Id: <20181008175622.765732078@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit 904506562e0856f2535d876407d087c9459d345b ]

Currently we get the following compiler warning:

    slabinfo.c:854:22: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
       if (s->object_size < min_objsize)
                          ^

due to the mismatch of signed/unsigned comparison.  ->object_size and
->slab_size are never expected to be negative, so let's define them as
unsigned int.

[n-horiguchi@ah.jp.nec.com: convert everything - none of these can be negative]
  Link: http://lkml.kernel.org/r/20180826234947.GA9787@hori1.linux.bs1.fc.nec.co.jp
Link: http://lkml.kernel.org/r/1535103134-20239-1-git-send-email-n-horiguchi@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/vm/slabinfo.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -30,8 +30,8 @@ struct slabinfo {
 	int alias;
 	int refs;
 	int aliases, align, cache_dma, cpu_slabs, destroy_by_rcu;
-	int hwcache_align, object_size, objs_per_slab;
-	int sanity_checks, slab_size, store_user, trace;
+	unsigned int hwcache_align, object_size, objs_per_slab;
+	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;


