Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C4C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7D821734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129386;
	bh=uiZoywbyMSmXn73r7S87TT2xRBYzRgwJbCvvZv0cZ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZR6aJQOM6pLkKPOMPp8KhK6NQnd7x7InOaOd64jbbu4L5trkMR1ey0CC+013yiyCo
	 uT5t2JcdhRkxF2oJMvzWJ7VWzScTZuL7apRrDSfKvt5AALmoukJsi3DOG3asanvR2m
	 ECo1bxEEJHTUFH0LFi9gTZTx0aTJH/Mk3LMYyorI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfBYVQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:16:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbfBYVQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:16:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E828F21734;
        Mon, 25 Feb 2019 21:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129377;
        bh=uiZoywbyMSmXn73r7S87TT2xRBYzRgwJbCvvZv0cZ4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcKDipftxsLtsvCRTKPj7VHm3OOkzh8b1CxoVkc7WBmwC7lv+3S2j4eEH1rF5xaG2
         N2TwDU4lkxZQ9/6EXIn9+d4tQrdMmyOf+IFEBKzbjsvB7wHdBtZovx8yiYtd5AYWBa
         VNdboohAkQ1nRtNIJi08pSKc480HOIPthV5lhKjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/71] pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read
Date:   Mon, 25 Feb 2019 22:11:14 +0100
Message-Id: <20190225195035.461641362@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

[ Upstream commit e6587cdbd732eacb4c7ce592ed46f7bbcefb655f ]

When a connection is closing we receive on pvcalls_sk_state_change
notification. Instead of setting the connection as closed immediately
(-ENOTCONN), let's read one more time from it: pvcalls_conn_back_read
will set the connection as closed when necessary.

That way, we avoid races between pvcalls_sk_state_change and
pvcalls_back_ioworker.

Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-back.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 169293c25a915..7185ebb63bd53 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -164,9 +164,10 @@ static void pvcalls_conn_back_read(void *opaque)
 
 	/* write the data, then modify the indexes */
 	virt_wmb();
-	if (ret < 0)
+	if (ret < 0) {
+		atomic_set(&map->read, 0);
 		intf->in_error = ret;
-	else
+	} else
 		intf->in_prod = prod + ret;
 	/* update the indexes, then notify the other end */
 	virt_wmb();
@@ -296,7 +297,7 @@ static void pvcalls_sk_state_change(struct sock *sock)
 		return;
 
 	intf = map->ring;
-	intf->in_error = -ENOTCONN;
+	atomic_inc(&map->read);
 	notify_remote_via_irq(map->irq);
 }
 
-- 
2.19.1



