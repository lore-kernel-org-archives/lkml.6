Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AD12184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132239;
	bh=Qu6YXJD6UIdwP4te3YzhXYblvnfuFnM+RFGEI1hhFoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioWwCRjaZOx0d9jYRSJs1RrORtj41IlSr7g70zKbSh9Z4Y+S8dWZCpMo24f+Hc2NH
	 h8RH1GYMODvk3+1trcvtEiQJjjoq7dp0VQ+X5zcKYZ2XcMJCD4LZbL1Un2HqLjo+NL
	 xaXiusfWIYcorfbgql07U2W++i0Z/fA9Uapk8tw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfBYVOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbfBYVOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B492146F;
        Mon, 25 Feb 2019 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129246;
        bh=Qu6YXJD6UIdwP4te3YzhXYblvnfuFnM+RFGEI1hhFoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ni61VmNSfQMowReZiQpM7lr7xm5mBVM3VQd4IObvT+osflJBMN6nRxGw9d7gnQKhM
         disJOVmiWEa6NdYTJ/ZBcVR/y39nxDuMz7g8YpvUwydBSEF4SSUDWtojqOjUjiFTMC
         nw4gGyeRjE/ETPlCV7/GVSPshiZZ4s3qsZEMns40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kal Conley <kal.conley@dectris.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 33/63] net/packet: fix 4gb buffer limit due to overflow check
Date:   Mon, 25 Feb 2019 22:11:33 +0100
Message-Id: <20190225195038.354634062@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kal Conley <kal.conley@dectris.com>

[ Upstream commit fc62814d690cf62189854464f4bd07457d5e9e50 ]

When calculating rb->frames_per_block * req->tp_block_nr the result
can overflow. Check it for overflow without limiting the total buffer
size to UINT_MAX.

This change fixes support for packet ring buffers >= UINT_MAX.

Fixes: 8f8d28e4d6d8 ("net/packet: fix overflow in check for tp_frame_nr")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4316,7 +4316,7 @@ static int packet_set_ring(struct sock *
 		rb->frames_per_block = req->tp_block_size / req->tp_frame_size;
 		if (unlikely(rb->frames_per_block == 0))
 			goto out;
-		if (unlikely(req->tp_block_size > UINT_MAX / req->tp_block_nr))
+		if (unlikely(rb->frames_per_block > UINT_MAX / req->tp_block_nr))
 			goto out;
 		if (unlikely((rb->frames_per_block * req->tp_block_nr) !=
 					req->tp_frame_nr))


