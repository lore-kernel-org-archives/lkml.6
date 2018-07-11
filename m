Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F747C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA68020C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdRps9w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA68020C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbeGKVJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:09:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390327AbeGKVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YUN1/u4lJ/8FdhEItiqcfT4HKIyIzKw9h6/5wCIO96I=; b=QdRps9w/4ShEKb2ApQ8VibE0v
        dvNiiFvDm07ePBLMMyvPi5a30iZnSjRsqPr1oaPtUMR9jrOckzcXwCEtJgZxEPOZUJ8Eswk7X/ghO
        k9NfDMvdVlWuMXNDuYbgsbed3FJ5NYKZi/vf/nKQ0e4WBLlGmkynNzux0umOwcTpdFwAd+WX7vsJ+
        MSclznIHmNzjHsz5Mdcs7jTgP/fzQ+JPH91ocVqNWgudLaIFGC9xHIKDK4OC0ubflQ4naeL8cSM1T
        4pKvv3gauZ3o+xaaYqDawg63EpxwsvCeUdC83XzjNDA4uw0iTVKwU2ujb9mTwA0YDN6oimmXSnmyI
        XQuSXj9BQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdMFp-00059t-HP; Wed, 11 Jul 2018 21:02:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/6] 9p: Use IDRs more effectively
Date:   Wed, 11 Jul 2018 14:02:19 -0700
Message-Id: <20180711210225.19730-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 9p code doesn't take advantage of the IDR's ability to store
a pointer.  We can actually get rid of the p9_idpool abstraction
and the multi-dimensional array of requests.

v2: Address feedback from Dominique.

Matthew Wilcox (6):
  9p: Fix comment on smp_wmb
  9p: Change p9_fid_create calling convention
  9p: Replace the fidlist with an IDR
  9p: Embed wait_queue_head into p9_req_t
  9p: Use a slab for allocating requests
  9p: Remove p9_idpool

 include/net/9p/9p.h     |   8 -
 include/net/9p/client.h |  62 ++------
 net/9p/Makefile         |   1 -
 net/9p/client.c         | 319 ++++++++++++++--------------------------
 net/9p/mod.c            |   7 +-
 net/9p/trans_virtio.c   |   2 +-
 net/9p/util.c           | 141 ------------------
 7 files changed, 133 insertions(+), 407 deletions(-)
 delete mode 100644 net/9p/util.c

-- 
2.18.0

