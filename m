Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC06C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958BB20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277746;
	bh=t9/RTM1Z4r0vUY0QH0h7lD6+aIxhzc2QPa+Jo/rA47A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aMkq8ZmrabOj4YLCVrjoIwUPqpr4p/zrP9nKlAgIE1I2PciRTJu0uQknhUAqRC+rl
	 BfqNV3q6Fv/5lkmt0A7fDvjftkMdIaqsD9hQ/eYu2R6Ec5PxGmUv7Kp4YEVmYj6vCg
	 ktxYHAcnPQcKQdmfcbXIWRDTYrnF6VQj08OviM40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbfBDKxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732449AbfBDKv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D4C2070C;
        Mon,  4 Feb 2019 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277486;
        bh=t9/RTM1Z4r0vUY0QH0h7lD6+aIxhzc2QPa+Jo/rA47A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JK99FJiHg/y/Ydy2Nr2iWt+jat+UWHasy0DdFolD/aN5YE1nDrfWVP+TNMrH6L6tu
         xBp4Tsoh6PChnbfF0fAseK6MVVt0gcd09s/hdY9tGslf/izrrNx8FkyZ1gjdDforxB
         VSmp0qe7Q8nAyPldZhAeOy0Dlny6nDVNFOQwP3Oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 27/80] virtio_net: Dont enable NAPI when interface is down
Date:   Mon,  4 Feb 2019 11:36:47 +0100
Message-Id: <20190204103623.668010120@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 8be4d9a492f88b96d4d3a06c6cbedbc40ca14c83 ]

Commit 4e09ff536284 ("virtio-net: disable NAPI only when enabled during
XDP set") tried to fix inappropriate NAPI enabling/disabling when
!netif_running(), but was not complete.

On error path virtio_net could enable NAPI even when !netif_running().
This can cause enabling NAPI twice on virtnet_open(), which would
trigger BUG_ON() in napi_enable().

Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2429,8 +2429,10 @@ static int virtnet_xdp_set(struct net_de
 	return 0;
 
 err:
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+	if (netif_running(dev)) {
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
 	return err;


