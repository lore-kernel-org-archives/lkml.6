Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3232184B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277272;
	bh=uByxaDiA5OnrKgs4KTNeR9/BMjNiqZ79yJSxIeiMLz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BPYdLYCp1Gp3IIZ4PoQtFfRa0rUevKrII2WRH4hiTi28SWOcE35+vmix5nUSQUeOw
	 LPoQCfUEW7BWYOa8IFMbDwhQ0YwuugM24rFbsSlWtEdpz75w+ucssMKUj+nqOtGDPf
	 6Y0GlODT+l9rS6hG5JIfz42vryCZp22lUCIrhIxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfBDKrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbfBDKru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B702070C;
        Mon,  4 Feb 2019 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277269;
        bh=uByxaDiA5OnrKgs4KTNeR9/BMjNiqZ79yJSxIeiMLz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdxDAbUAcBuwAxEXVCe9VPJeD1a4NLLWaP5qGto3s2g2DZw+4mjKOVNMZkbP3KBcn
         eqTfxrAKWipmjFRd5e796CGn7hLYcuyCrwiy7x83s5G9X6RZNA0Qe7eWtz8txFUykZ
         UuPHyl1m2TxqBaUgy0NdX02lXSXBXZrgh2VrQ520=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 31/74] virtio_net: Use xdp_return_frame to free xdp_frames on destroying vqs
Date:   Mon,  4 Feb 2019 11:36:44 +0100
Message-Id: <20190204103623.456363993@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 07b344f494ddda9f061b396407c96df8c46c82b5 ]

put_page() can work as a fallback for freeing xdp_frames, but the
appropriate way is to use xdp_return_frame().

Fixes: cac320c850ef ("virtio_net: convert to use generic xdp_frame and xdp_return_frame API")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2593,7 +2593,7 @@ static void free_unused_bufs(struct virt
 			if (!is_xdp_raw_buffer_queue(vi, i))
 				dev_kfree_skb(buf);
 			else
-				put_page(virt_to_head_page(buf));
+				xdp_return_frame(buf);
 		}
 	}
 


