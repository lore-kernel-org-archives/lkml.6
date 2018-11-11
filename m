Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ADC20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYpmWmsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ADC20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390320AbeKLI7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbeKLIWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22515223C8;
        Sun, 11 Nov 2018 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975526;
        bh=wqxXKzaUJi3VzdDqZLdolrZsfs5QOnqNukBxT1v2KTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYpmWmsGrYxwm/aohOxw4zruLqnSxqR6SjsT4T9TiUc0+wqBfxzFO/vj0Dhz0dTA+
         wXHy18azvK4FWawk59UyoEDTif2+vwcdaYZov3GmjhjzxAmNq0+RIphQDUA4GY+nI0
         KsAw12k8Im5gbHESa57iHkGdFcb/aEMKU0NX7qx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 003/222] bcache: trace missed reading by cache_missed
Date:   Sun, 11 Nov 2018 14:21:40 -0800
Message-Id: <20181111221648.108037012@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -792,7 +792,7 @@ static void cached_dev_read_done_bh(stru
 
 	bch_mark_cache_accounting(s->iop.c, s->d,
 				  !s->cache_missed, s->iop.bypass);
-	trace_bcache_read(s->orig_bio, !s->cache_miss, s->iop.bypass);
+	trace_bcache_read(s->orig_bio, !s->cache_missed, s->iop.bypass);
 
 	if (s->iop.status)
 		continue_at_nobarrier(cl, cached_dev_read_error, bcache_wq);


