Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeC2MGU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:06:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752300AbeC2MGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:06:18 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cluster-devel@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
Date: Thu, 29 Mar 2018 14:06:10 +0200
Message-Id: <20180329120612.6104-1-agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a second version of the patch (now a patch set) to eliminate
rhashtable_walk_peek in gfs2.

The first patch introduces lockref_put_not_zero, the inverse of
lockref_get_not_zero.

The second patch eliminates rhashtable_walk_peek in gfs2.  In
gfs2_glock_iter_next, the new lockref function from patch one is used to
drop a lockref count as long as the count doesn't drop to zero.  This is
almost always the case; if there is a risk of dropping the last
reference, we must defer that to a work queue because dropping the last
reference may sleep.

Thanks,
Andreas

Andreas Gruenbacher (2):
  lockref: Add lockref_put_not_zero
  gfs2: Stop using rhashtable_walk_peek

 fs/gfs2/glock.c         | 47 ++++++++++++++++++++++++++++-------------------
 include/linux/lockref.h |  1 +
 lib/lockref.c           | 28 ++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.14.3
