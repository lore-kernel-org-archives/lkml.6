Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074AEC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DF5218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfBCNuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52988 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727984AbfBCNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0003wD-3H; Sun, 03 Feb 2019 13:49:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0006xc-4a; Sun, 03 Feb 2019 14:49:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Filipe Manana" <fdmanana@suse.com>,
        "Liu Bo" <bo.liu@linux.alibaba.com>,
        "David Sterba" <dsterba@suse.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.692656480@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 097/305] Btrfs: fix null pointer dereference on
 compressed write path error
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 3527a018c00e5dbada2f9d7ed5576437b6dd5cfb upstream.

At inode.c:compress_file_range(), under the "free_pages_out" label, we can
end up dereferencing the "pages" pointer when it has a NULL value. This
case happens when "start" has a value of 0 and we fail to allocate memory
for the "pages" pointer. When that happens we jump to the "cont" label and
then enter the "if (start == 0)" branch where we immediately call the
cow_file_range_inline() function. If that function returns 0 (success
creating an inline extent) or an error (like -ENOMEM for example) we jump
to the "free_pages_out" label and then access "pages[i]" leading to a NULL
pointer dereference, since "nr_pages" has a value greater than zero at
that point.

Fix this by setting "nr_pages" to 0 when we fail to allocate memory for
the "pages" pointer.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201119
Fixes: 771ed689d2cd ("Btrfs: Optimize compressed writeback and reads")
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -452,6 +452,7 @@ again:
 		pages = kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
 		if (!pages) {
 			/* just bail out to the uncompressed code */
+			nr_pages = 0;
 			goto cont;
 		}
 

