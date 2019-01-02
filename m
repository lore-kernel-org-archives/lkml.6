Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C132C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FF021479
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfABU5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:57:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfABU5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:57:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 421F2B0826;
        Wed,  2 Jan 2019 20:57:49 +0000 (UTC)
Received: from redhat.com (ovpn-120-148.rdu2.redhat.com [10.10.120.148])
        by smtp.corp.redhat.com (Postfix) with SMTP id 362085C1A1;
        Wed,  2 Jan 2019 20:57:46 +0000 (UTC)
Date:   Wed, 2 Jan 2019 15:57:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 0/4] barriers using data dependency
Message-ID: <20190102205715.14054-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 02 Jan 2019 20:57:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So as explained in Documentation/memory-barriers.txt e.g.
a load followed by a store require a full memory barrier,
to avoid store being ordered before the load.
Similarly load-load requires a read memory barrier.

Thinking about it, we can actually create a data dependency
by mixing the first loaded value into the pointer being
accessed.

This adds an API for this and uses it in virtio.

Written over the holiday and build tested only so far.

This patchset is also suboptimal on e.g. x86 where e.g. smp_rmb is a nop.

Sending out for early feedback/flames.

Michael S. Tsirkin (4):
  include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
  include/linux/compiler.h: allow memory operands
  barriers: convert a control to a data dependency
  virtio: use dependent_ptr_mb

 Documentation/memory-barriers.txt | 20 ++++++++++++++++++++
 arch/alpha/include/asm/barrier.h  |  1 +
 drivers/virtio/virtio_ring.c      |  6 ++++--
 include/asm-generic/barrier.h     | 18 ++++++++++++++++++
 include/linux/compiler-clang.h    |  5 ++---
 include/linux/compiler-gcc.h      |  4 ----
 include/linux/compiler-intel.h    |  4 +---
 include/linux/compiler.h          |  8 +++++++-
 8 files changed, 53 insertions(+), 13 deletions(-)

-- 
MST

