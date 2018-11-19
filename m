Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE97BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E9214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0/thvLS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705E9214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406750AbeKTD3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405697AbeKTD3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACDA02148E;
        Mon, 19 Nov 2018 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647108;
        bh=Zbt1cVNww8gU5L7Rgg8nAPVP8Fzf1fKdU5OUXiEv2Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0/thvLS3EJ/KcDrzPbOJTiWmN59mGbqzO4yw4EortSz83lB4qUMOBGpO/nTW+dHh3
         JdZSZgqeSp2Cs6Pb+oOD58nMKkb5C8r7GwqlfiZjJqmj9Y2Umrw90u1XFlyZ9p48MW
         LQsW8BfYLi2IgcLGo9kNO6Xrcwlv8bK6Eavvh38o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Corey Wright <undefined@pobox.com>
Subject: [PATCH 3.18 53/90] dm: remove duplicate dm_get_live_table() in __dm_destroy()
Date:   Mon, 19 Nov 2018 17:29:35 +0100
Message-Id: <20181119162629.402065358@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Wright <undefined@pobox.com>

[3.18.y only, to fix a previous patch]

__dm_destroy() takes io_barrier SRCU lock (dm_get_live_table) twice
which leads to a deadlock.  Remove taking lock before holding
suspend_lock to prevent a different potential deadlock.

Signed-off-by: Corey Wright <undefined@pobox.com>
Fixes: e1db66a5fdcc ("dm: fix AB-BA deadlock in __dm_destroy()")
Cc: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2589,7 +2589,6 @@ static void __dm_destroy(struct mapped_d
 	might_sleep();
 
 	spin_lock(&_minor_lock);
-	map = dm_get_live_table(md, &srcu_idx);
 	idr_replace(&_minor_idr, MINOR_ALLOCED, MINOR(disk_devt(dm_disk(md))));
 	set_bit(DMF_FREEING, &md->flags);
 	spin_unlock(&_minor_lock);


