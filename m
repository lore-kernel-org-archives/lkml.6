Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46BAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63AC20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299004;
	bh=3sVxfO8x4h/M9vZTZSPH1ntpEbGnrUiEVIyC/rnwFZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g28x5QNnDkwuT8MpsuD1tatJSdecsvji2ThOVoB4y4nlM0nQRtgNofWvjJwpVoy2a
	 FuWhxp4b0Dd3hh9Yh0gznAM0pgohBTEBMSLQjvFHu8d026Q5M4xtIK67gPI1e/8LXo
	 L72edGdTnfmpNAlbNiDNLPe5O0+5aRSWD29LFerg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeLTJWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeLTJWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E6AD217D7;
        Thu, 20 Dec 2018 09:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297752;
        bh=3sVxfO8x4h/M9vZTZSPH1ntpEbGnrUiEVIyC/rnwFZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/z+XV3KOX7C8G/9UZnEzDBHbNyVlTeZrjxaC62Qu9DBCKwv9H9tksAlUIRCXa0yb
         XZsw6wdpzM71Im01E70opnss9hlDw4y6ykyysM6zo84k/fI92wbFoDu6KOIBKgTkIY
         ZLLgm2EB0CDbiUDak4oOcwhIqk1Lk1FxWYhtqftQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 09/40] aio: fix spectre gadget in lookup_ioctx
Date:   Thu, 20 Dec 2018 10:18:21 +0100
Message-Id: <20181220085826.856372548@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Moyer <jmoyer@redhat.com>

commit a538e3ff9dabcdf6c3f477a373c629213d1c3066 upstream.

Matthew pointed out that the ioctx_table is susceptible to spectre v1,
because the index can be controlled by an attacker.  The below patch
should mitigate the attack for all of the aio system calls.

Cc: stable@vger.kernel.org
Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -40,6 +40,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/nospec.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -1063,6 +1064,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
+	id = array_index_nospec(id, table->nr);
 	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		if (percpu_ref_tryget_live(&ctx->users))


