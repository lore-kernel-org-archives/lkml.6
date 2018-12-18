Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54322C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23490218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151324;
	bh=Lq6x0L0WkcgGqIOdHJEOrHl3Q2WAW61f6Ve7U74HCJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FEuGdXNSmlMZTupTEZKC7f6/gLgLJylLLNTrdc1W0DMjCtE6cTHUYrG70/t//ErzK
	 PonKGDYLCJxfXnbLmMnX273jvXq8I5lVWBu90YuNAncta6h2eVbNqp2lys6xG8F4iD
	 eZicAAS/wI3fALdXEILTsRmvaIrlDLv/POWLunNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeLRQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:42:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD4E721873;
        Tue, 18 Dec 2018 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151319;
        bh=Lq6x0L0WkcgGqIOdHJEOrHl3Q2WAW61f6Ve7U74HCJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkIIU9N28j0f5ZIGAaoTwjHtOBrdY2Q8fKfJZ3K1aZRUSS4xsxq4zJPrXaJ93z4Mn
         HpTkRgQ8mfdDtTg//8NZmQM7eVhqUQ4LzQIpHnHgKJEf+wHGJ/kF1A3JEQC+QIR2Ed
         4Aaig26dbC6Xi8GDbwwViljIy5noARxLT1e6u98o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Teigland <teigland@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 25/44] dm cache metadata: verify cache has blocks in blocks_are_clean_separate_dirty()
Date:   Tue, 18 Dec 2018 17:39:37 +0100
Message-Id: <20181218163930.444431564@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit 687cf4412a343a63928a5c9d91bdc0f522939d43 upstream.

Otherwise dm_bitset_cursor_begin() return -ENODATA.  Other calls to
dm_bitset_cursor_begin() have similar negative checks.

Fixes inability to create a cache in passthrough mode (even though doing
so makes no sense).

Fixes: 0d963b6e65 ("dm cache metadata: fix metadata2 format's blocks_are_clean_separate_dirty")
Cc: stable@vger.kernel.org
Reported-by: David Teigland <teigland@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-metadata.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -930,6 +930,10 @@ static int blocks_are_clean_separate_dir
 	bool dirty_flag;
 	*result = true;
 
+	if (from_cblock(cmd->cache_blocks) == 0)
+		/* Nothing to do */
+		return 0;
+
 	r = dm_bitset_cursor_begin(&cmd->dirty_info, cmd->dirty_root,
 				   from_cblock(cmd->cache_blocks), &cmd->dirty_cursor);
 	if (r) {


