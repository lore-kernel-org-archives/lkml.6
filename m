Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D457C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349DE20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYNlSkNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349DE20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbeKLJfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbeKLITK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:10 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAE82175B;
        Sun, 11 Nov 2018 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975354;
        bh=824WFgU1ZbaCfdXr8AyqbNII37Ffx/PPrL8X8gF8Jro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYNlSkNoYg0o3tuYkAtfGKXpyGAqz6p7/YX1mbgAhgTBvjnrZSVShtfpFIVx7aCGp
         5Q99iCGd8a/wsoNuU8TN3hGzSAdJnlaFMhqjnKr3mVGCziHCkG16KOdD3pi//IGVgB
         LiAoWBEEsmUjmmTC2OtaYlPB7qdxwoCYNKlUSsDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 008/350] bcache: trace missed reading by cache_missed
Date:   Sun, 11 Nov 2018 14:17:52 -0800
Message-Id: <20181111221707.472502352@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui.linux@gmail.com>

commit 502b291568fc7faf1ebdb2c2590f12851db0ff76 upstream.

Missed reading IOs are identified by s->cache_missed, not the
s->cache_miss, so in trace_bcache_read() using trace_bcache_read
to identify whether the IO is missed or not.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/request.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -843,7 +843,7 @@ static void cached_dev_read_done_bh(stru
 
 	bch_mark_cache_accounting(s->iop.c, s->d,
 				  !s->cache_missed, s->iop.bypass);
-	trace_bcache_read(s->orig_bio, !s->cache_miss, s->iop.bypass);
+	trace_bcache_read(s->orig_bio, !s->cache_missed, s->iop.bypass);
 
 	if (s->iop.status)
 		continue_at_nobarrier(cl, cached_dev_read_error, bcache_wq);


