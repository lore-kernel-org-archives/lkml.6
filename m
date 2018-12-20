Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6363AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B0217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297986;
	bh=Mxsrg5jxB1Y5EARs5rs7k6yTbcurh4dlZH+CTqckDAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rtuvxlao4Rple3XKs2/00xV5fvJwqzn4b4ZrIAYmprT64V2Bc4cQ+ELzMWg7Ahdci
	 AM7xgY88izisY3j/6alWThHNXj418ZIsrh21ZKg5Ha15JGl3NU5LbqANpA/mvGcAfd
	 bxkvvZQnWLW5AmTjSXGgDZGMy9yUOl+kr4uk68CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeLTJ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbeLTJ0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD94217D7;
        Thu, 20 Dec 2018 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297980;
        bh=Mxsrg5jxB1Y5EARs5rs7k6yTbcurh4dlZH+CTqckDAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMcXrFRPV9oTanA+rnMsdjCMqYDIfyoY/gGrDl2lfuO8Y/mk1PG5vo71Jd2SjBHro
         ifS6bk/kuGBq4RXMW7m7pZI3Uz3sW1mguhWQINSv1cnhy/hBXnshRrrfxn3TH0lipx
         MOFSOyYc+K3tpbrdYbHwfuxGCxlPZRYurQpT1HJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 03/72] aio: fix spectre gadget in lookup_ioctx
Date:   Thu, 20 Dec 2018 10:18:02 +0100
Message-Id: <20181220085922.464426676@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -43,6 +43,7 @@
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 
 #include "internal.h"
 
@@ -1084,6 +1085,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
+	id = array_index_nospec(id, table->nr);
 	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		if (percpu_ref_tryget_live(&ctx->users))


