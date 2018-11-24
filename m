Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C98C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445AD20874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LXb84wO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445AD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeKYEVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 23:21:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKYEVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 23:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lJ3kHbsE2hFcf68m/vu/0cee4kk5HDlgXUX+/syPk60=; b=LXb84wO759I7gWO52ZbI3Ks4wW
        HcfBXZ5PoQAbZ14FHGNVMljl0tBD5/UJ5Mm7NeInnHFGXKdEcxNVoaPmU9rJzfB0jMZPOyzS+/rN9
        aUQHmvZg3Fm5S7SKy5iHvmuQqjyH+oyNC4dzLQwetYyJsCfoO293LWqhxf2aYgNh/g0XeZP+ihdKy
        DotBGTdq8Cnc+4d7LL5/oNVQVJmm1oLf1H70P99VJUXogU3q8t7gk4toEQUgRNBa042pjFfnMNGjm
        Yf5DDQV+a3DJovLTX9g5tXz5XqBdgPhDVmjd9yFR1pqK4UxOQDUmPCN01YJgayPD3drZHidPZ/NGw
        Ocja5/rw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQbmr-00040D-VG; Sat, 24 Nov 2018 17:32:09 +0000
Date:   Sat, 24 Nov 2018 09:32:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: [GIT PULL] XArray updates
Message-ID: <20181124173209.GZ3065@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

We found some bugs in the DAX conversion to XArray (and one bug which
predated the XArray conversion).  There were a couple of bugs in some of
the higher-level functions, which aren't actually being called in today's
kernel, but surfaced as a result of converting existing radix tree &
IDR users over to the XArray.  Some of the other changes to how the
higher-level APIs work were also motivated by converting various users;
again, they're not in use in today's kernel, so changing them has a low
probability of introducing a bug.

Dan can still trigger a bug in the DAX code with hot-offline/online,
and we're working on tracking that down.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git xarray

for you to fetch changes up to fffc9a260e38acec3187515738122a3ecb24ac90:

  XArray tests: Add missing locking (2018-11-19 09:41:11 -0500)

----------------------------------------------------------------
Matthew Wilcox (19):
      XArray: Fix xa_for_each with a single element at 0
      XArray: Export __xa_foo to non-GPL modules
      nilfs2: Use xa_erase_irq
      XArray: Regularise xa_reserve
      XArray: Unify xa_cmpxchg and __xa_cmpxchg
      XArray: Turn xa_erase into an exported function
      XArray: Add xa_store_bh() and xa_store_irq()
      XArray: Unify xa_store and __xa_store
      XArray: Handle NULL pointers differently for allocation
      XArray: Fix Documentation
      XArray: Correct xa_store_range
      XArray tests: Correct some 64-bit assumptions
      dax: Remove optimisation from dax_lock_mapping_entry
      dax: Make sure the unlocking entry isn't locked
      dax: Reinstate RCU protection of inode
      dax: Fix dax_unlock_mapping_entry for PMD pages
      dax: Fix huge page faults
      dax: Avoid losing wakeup in dax_lock_mapping_entry
      XArray tests: Add missing locking

 Documentation/core-api/xarray.rst |  52 ++++++--
 fs/dax.c                          |  60 +++++----
 fs/nilfs2/btnode.c                |   4 +-
 include/linux/xarray.h            | 267 +++++++++++++++++++++++++++++---------
 lib/test_xarray.c                 |  50 ++++++-
 lib/xarray.c                      | 139 +++++++++-----------
 6 files changed, 387 insertions(+), 185 deletions(-)


