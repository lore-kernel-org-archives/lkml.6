Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0477218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151230;
	bh=9c14AYJdjLcH7d77BvzmIm6mP/FPLsE8YODdxHxWdoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PDJ6Net49c7cvWHyfsvw7HZuZn2G5nQq/pZdD08ZYtT/+cEGHsW/kyi1wafMfM6ro
	 EamJRphW4xcQWP0aGzICNI2aN/e+UR28aj+mHxUQjoqIrzQ5GKpyVvc52L8dsmJhTZ
	 odf0gOzO5u6lJGKDBh/wkUIpp54otcSVKDrttSqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeLRQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeLRQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981FE218A2;
        Tue, 18 Dec 2018 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151226;
        bh=9c14AYJdjLcH7d77BvzmIm6mP/FPLsE8YODdxHxWdoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsgFMUVmQxVD6LiPe8Qd4ofEc9lo6k6puq7TPT9k1W7274mChs6dcQP32DgmC5FjQ
         WdFlNfjY+r/PIhN4EzX4akPoTZ00ZM9fKnUxsYZaCHVDjAm8ulN1BsNt879HGAsvlt
         vDCraK0RRc5akpOu0Y/wH780tVEncsGSLQe3TKo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 09/44] aio: fix spectre gadget in lookup_ioctx
Date:   Tue, 18 Dec 2018 17:39:21 +0100
Message-Id: <20181218163928.602814529@linuxfoundation.org>
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
@@ -45,6 +45,7 @@
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 
 #include "internal.h"
 
@@ -1038,6 +1039,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
+	id = array_index_nospec(id, table->nr);
 	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		if (percpu_ref_tryget_live(&ctx->users))


