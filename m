Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E904C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A332084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5nCK+v6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A332084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbeKLIQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729653AbeKLIQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53CBE21780;
        Sun, 11 Nov 2018 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975216;
        bh=i8JBnaJMfH+YgVwo2fWteAMB2oRa1ALZwbXxIuLxhe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5nCK+v6dd9YvCeW0XN+QvTMK8jHmpIuj2dXYozQ+/GfQWniA0087jbEvfFOKNoiG
         VpKyS1Q97xBJf5LwMp7EbEkvjELlg0IqK8w/s3AhNe/G3duEk3TAcZySZy5Y9BuD9e
         41D+/cn59oeUTEQAGsWfFCY41JiKG5sIAWgYK+6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 012/361] bcache: trace missed reading by cache_missed
Date:   Sun, 11 Nov 2018 14:15:59 -0800
Message-Id: <20181111221621.621712332@linuxfoundation.org>
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
@@ -850,7 +850,7 @@ static void cached_dev_read_done_bh(stru
 
 	bch_mark_cache_accounting(s->iop.c, s->d,
 				  !s->cache_missed, s->iop.bypass);
-	trace_bcache_read(s->orig_bio, !s->cache_miss, s->iop.bypass);
+	trace_bcache_read(s->orig_bio, !s->cache_missed, s->iop.bypass);
 
 	if (s->iop.status)
 		continue_at_nobarrier(cl, cached_dev_read_error, bcache_wq);


