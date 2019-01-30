Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BB2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C7D218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfA3Uan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:30:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfA3Uam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:30:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CD84A0C27;
        Wed, 30 Jan 2019 20:30:42 +0000 (UTC)
Received: from max.home.com (ovpn-117-201.ams2.redhat.com [10.36.117.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07ADC608C8;
        Wed, 30 Jan 2019 20:30:38 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] gfs2: Revert "Fix loop in gfs2_rbm_find"
Date:   Wed, 30 Jan 2019 21:30:36 +0100
Message-Id: <20190130203036.11220-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 30 Jan 2019 20:30:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2d29f6b96d8f80322ed2dd895bca590491c38d34.

It turns out that the fix can lead to a ~20 percent performance regression
in initial writes to the page cache according to iozone.  Let's revert this
for now to have more time for a proper fix.

Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>

---
 fs/gfs2/rgrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 831d7cb5a49c4..17a8d3b439905 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1780,9 +1780,9 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 state, u32 *minext,
 			goto next_iter;
 		}
 		if (ret == -E2BIG) {
-			n += rbm->bii - initial_bii;
 			rbm->bii = 0;
 			rbm->offset = 0;
+			n += (rbm->bii - initial_bii);
 			goto res_covered_end_of_rgrp;
 		}
 		return ret;
-- 
2.20.1

