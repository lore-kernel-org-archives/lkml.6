Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4962C20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="thWwudPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4962C20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeKGHqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:46:33 -0500
Received: from imap.thunk.org ([74.207.234.97]:46204 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeKGHqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fJrIqHkC9A2YKvga1stdgo7VXOejR7UQozFrZWblXuU=; b=thWwudPEZoiWTejvvxr2+DTtyP
        meMnCq5eU7dU2yDWgJFs3nibpicow7Q/TXJziCh0GGKU6uz6A5iKeDGuiSBCMOlNqXYoZhs7uHNal
        NEkceeAs/Zz/gOnadhnhhy9sPGJtmLzlyd/eUgKbqMXt0jwMPxuE50Ul0M03fLy2X0kg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gK9gh-0006CQ-A4; Tue, 06 Nov 2018 22:19:07 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1CF457A7C2F; Tue,  6 Nov 2018 17:19:06 -0500 (EST)
Date:   Tue, 6 Nov 2018 17:19:05 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] ext4: iloc.bh cleanup in add_new_gdb()
Message-ID: <20181106221905.GH2570@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <eb58c8ca-8456-7b5f-9c12-99f03e3057af@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb58c8ca-8456-7b5f-9c12-99f03e3057af@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:58:38AM +0300, Vasily Averin wrote:
> iloc.bh was taken in ext4_reserve_inode_write() and released
> in ext4_mark_iloc_dirty(). It should not be released 2nd time
> in rollback after failed ext4_handle_dirty_metadata(gdb_bh)
> 
> Fixes b40971426a83 ("ext4: add error checking to calls to ...") # 2.6.38
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

I fixed this in a simpler way:

From 6a91a2eb1c5af1381caebfb4c1c91dc175351f6f Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 6 Nov 2018 17:18:17 -0500
Subject: [PATCH] ext4: avoid possible double brelse() in add_new_gdb() on
 error path

Fixes: b40971426a83 ("ext4: add error checking to calls to ...")
Reported-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org # 2.6.38
---
 fs/ext4/resize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 85158e9de7c2..a5efee34415f 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -871,6 +871,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	err = ext4_handle_dirty_metadata(handle, NULL, gdb_bh);
 	if (unlikely(err)) {
 		ext4_std_error(sb, err);
+		iloc.bh = NULL;
 		goto exit_inode;
 	}
 	brelse(dind);
-- 
2.18.0.rc0

