Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0069D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130024;
	bh=AObp+viB7EJvyl2NGJssAxzY/JeXL8jblEiq1J0XCXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KeFpJyM8d3dGyyJIFC2dIZby2nY7Hg0rmO89/EYi3RCHuklsfwJp95TUMuXfViBmz
	 KNJXBWL0oTnec7shltTRDGHlxjl07uRCIFBD0ve2qyWEB36YxpBXN/X4jSIdu0K1dQ
	 dw0OaQtj4s7VK90hbLtcZBl4ox17tfnt4LBSV45A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfBYV1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731609AbfBYV0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABAA20C01;
        Mon, 25 Feb 2019 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130013;
        bh=AObp+viB7EJvyl2NGJssAxzY/JeXL8jblEiq1J0XCXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdfFsrfLguRVgV9BdpyzbigWxTJJzfbmDGdFVwHg2zEZYkLtrCwPAjsPyilm3sinT
         +0/OnDH7UDp6d8rVLQshVoSHbGteC6dD3SUOWWNacU665XMZpqI4jpXrVghl0whobA
         T8734m9baO6PTAMb43YnDhihJeSjc1vE4pGYOX8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kal Conley <kal.conley@dectris.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 104/152] net/packet: fix 4gb buffer limit due to overflow check
Date:   Mon, 25 Feb 2019 22:11:36 +0100
Message-Id: <20190225195050.091512882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
@@ -4275,7 +4275,7 @@ static int packet_set_ring(struct sock *
 		rb->frames_per_block = req->tp_block_size / req->tp_frame_size;
 		if (unlikely(rb->frames_per_block == 0))
 			goto out;
-		if (unlikely(req->tp_block_size > UINT_MAX / req->tp_block_nr))
+		if (unlikely(rb->frames_per_block > UINT_MAX / req->tp_block_nr))
 			goto out;
 		if (unlikely((rb->frames_per_block * req->tp_block_nr) !=
 					req->tp_frame_nr))


