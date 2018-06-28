Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74E9C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F932743F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="spEHN0Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F932743F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966067AbeF1N1C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:27:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753775AbeF1N07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9SIUR4/h7N88Ft/710EC07pnGoLnH5vY9wBLhMHhm4M=; b=spEHN0AuDLR1Eu/j97KgVaeTr
        LZzf7AaYvp0ORitJ1xxl9nYBokCvM6S8zxWu0NCx+oEHhWQ8GPmbMpYA9h+lHU0BhPbr6Wf/9EFV5
        wdGjcyMn/ILAfdFi5KBwFsvePuC72ZKy/80udyTZLkzdKroFyf7tmwfuZ1KOxnk2kETt5THGvJf6c
        +JIddpqrTNZbE1AlDpzTFUUj+2shF9IOcwN0rSaT9VSAoihgRdbefjrgd9Mhl+A98uohCc/jnytqW
        aWLdZpsyqvEw05jp4W8sbQ9wz6AopgLu4tKFPUZkAWpd1rt2xH0He+YqITXAOYiaXvRjsTIP318KZ
        +KVfL7jWQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYWwr-0000rV-TX; Thu, 28 Jun 2018 13:26:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/6] 9p: Use IDRs more effectively
Date:   Thu, 28 Jun 2018 06:26:23 -0700
Message-Id: <20180628132629.3148-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 9p code doesn't take advantage of the IDR's ability to store
a pointer.  We can actually get rid of the p9_idpool abstraction
and the multi-dimensional array of requests.

I haven't tested these patches, so caveat maintainer.

Matthew Wilcox (6):
  9p: Change p9_fid_create calling convention
  9p: Replace the fidlist with an IDR
  9p: Embed wait_queue_head into p9_req_t
  9p: Remove an unnecessary memory barrier
  9p: Use a slab for allocating requests
  9p: Remove p9_idpool

 include/net/9p/9p.h     |   8 -
 include/net/9p/client.h |  62 ++------
 net/9p/Makefile         |   1 -
 net/9p/client.c         | 322 ++++++++++++++--------------------------
 net/9p/mod.c            |   7 +-
 net/9p/trans_virtio.c   |   2 +-
 net/9p/util.c           | 141 ------------------
 7 files changed, 132 insertions(+), 411 deletions(-)
 delete mode 100644 net/9p/util.c

-- 
2.18.0

