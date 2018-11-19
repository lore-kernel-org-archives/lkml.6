Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB4CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B915621722
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHreqX2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B915621722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405235AbeKTDYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404390AbeKTDYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF8321508;
        Mon, 19 Nov 2018 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646798;
        bh=7yw9h76s1OhIEOg9Ej+ZcrBUXq0RFIe0RTT8UGZTGu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHreqX2OuIPBwLXwUXXjhofrlWJhuC0h2Iy40A0h5zNDuzCPOXYT6OUGgcZnAX0Fn
         /1qwb+kXZkdFRZ28x6wxOo6aAwEkTfNSr12zWEa1uLZn5JYeD+CZYfRQm2lHW6gkPH
         GeKRBrqa7gH25Uvy3edHB1ym0/y7T/rS00GxP6Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 093/160] Btrfs: fix null pointer dereference on compressed write path error
Date:   Mon, 19 Nov 2018 17:28:52 +0100
Message-Id: <20181119162640.195279590@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -481,6 +481,7 @@ again:
 		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 		if (!pages) {
 			/* just bail out to the uncompressed code */
+			nr_pages = 0;
 			goto cont;
 		}
 


