Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AACAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FCE20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xdhB+kZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FCE20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbeKLISs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733152AbeKLISr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:47 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7678521508;
        Sun, 11 Nov 2018 22:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975331;
        bh=0dNY8VtQ93xABMPcA7qdOd7s4UrmGZhL70ACCt+J6/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xdhB+kZnZGhoovDOO7U7QUCI7vBm3XpnFy7ExTbPzhiPzFrVhvz32tt9QqtMLLgAX
         o1N7Vq+d51k6wNJuCmFkpFcU/576cAOsDnq/xUCrIzfev3rTe1ZJgHgvXtR16mUu3H
         XFI2nTeXtxX7uonVkov0rkX500E1kc8sMRjIdg64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 345/361] Btrfs: fix null pointer dereference on compressed write path error
Date:   Sun, 11 Nov 2018 14:21:32 -0800
Message-Id: <20181111221701.068568354@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -503,6 +503,7 @@ again:
 		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 		if (!pages) {
 			/* just bail out to the uncompressed code */
+			nr_pages = 0;
 			goto cont;
 		}
 


