Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD61DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC6820869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898718;
	bh=64LskGI5elZW7rrrJKV14uZZxUScz8ySNl6vTLM4Eto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R9waudPYQjaUHY0D9j8HwJUPYj80KgoDHIqiLJvBk2/Jpi/nTBTd9wUlsr9xGsZrz
	 8/mVBCGMEhu7dz/+e64mFuCeNiUT5QVc5Wd+Eg0ckLV9DIpXyIga4ckSAnAERIalrS
	 Vp7N9Fc6dfUFcCFG9Nh5paRVscPKp/FwfY/QunoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbfBKPB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390165AbfBKPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:01:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4685222A6;
        Mon, 11 Feb 2019 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897283;
        bh=64LskGI5elZW7rrrJKV14uZZxUScz8ySNl6vTLM4Eto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mU7BrmfH4UU1mwNrsGBEBbS/dLZ/JCszuIDA95nlZvHTwpzLQVts0PamsYz0L467m
         bFiGn3OytZoU+dVSNcFgLYIHWkBfwP0r03uSxMtg7YtED57OOdW3U/q8sSIquLuamZ
         WlWrYHGIz4R7HKljIhq7wbY4gDsZgxVN0vLW9InE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 119/205] drbd: disconnect, if the wrong UUIDs are attached on a connected peer
Date:   Mon, 11 Feb 2019 15:18:37 +0100
Message-Id: <20190211141836.245486770@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

[ Upstream commit b17b59602b6dcf8f97a7dc7bc489a48388d7063a ]

With "on-no-data-accessible suspend-io", DRBD requires the next attach
or connect to be to the very same data generation uuid tag it lost last.

If we first lost connection to the peer,
then later lost connection to our own disk,
we would usually refuse to re-connect to the peer,
because it presents the wrong data set.

However, if the peer first connects without a disk,
and then attached its disk, we accepted that same wrong data set,
which would be "unexpected" by any user of that DRBD
and cause "undefined results" (read: very likely data corruption).

The fix is to forcefully disconnect as soon as we notice that the peer
attached to the "wrong" dataset.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 143c5a666e25..1aad373da50e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4139,7 +4139,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 	kfree(device->p_uuid);
 	device->p_uuid = p_uuid;
 
-	if (device->state.conn < C_CONNECTED &&
+	if ((device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS) &&
 	    device->state.disk < D_INCONSISTENT &&
 	    device->state.role == R_PRIMARY &&
 	    (device->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] & ~((u64)1))) {
-- 
2.19.1



