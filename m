Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8B1214DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2SUEwzkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8B1214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeLDLDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbeLDLDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA3B214DA;
        Tue,  4 Dec 2018 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921416;
        bh=V/uc3oedLBbIgliwfsTlM7aJ0pmMuPUMQBEHIXtwdCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SUEwzkHQB2Kr6G0EVyLy8ojYYqNuXh51G7J/Famg7RnrBhFo96zxY1B4JSsj6cck
         4iit8ONH2hwjHZ4Z1dAtMBrU1K0PSQ63T8I8nrrI1DM6W6pFHTVuDLFBdk7pofqaa0
         +F2m1rX7lkN/fgIW8+jvRFrZ2oqPvWAwqVsRDL3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Pavel Popa <pashinho1990@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 061/146] virtio-net: disable guest csum during XDP set
Date:   Tue,  4 Dec 2018 11:49:07 +0100
Message-Id: <20181204103729.293745783@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit e59ff2c49ae16e1d179de679aca81405829aee6c ]

We don't disable VIRTIO_NET_F_GUEST_CSUM if XDP was set. This means we
can receive partial csumed packets with metadata kept in the
vnet_hdr. This may have several side effects:

- It could be overridden by header adjustment, thus is might be not
  correct after XDP processing.
- There's no way to pass such metadata information through
  XDP_REDIRECT to another driver.
- XDP does not support checksum offload right now.

So simply disable guest csum if possible in this the case of XDP.

Fixes: 3f93522ffab2d ("virtio-net: switch off offloads on demand if possible on XDP set")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Pavel Popa <pashinho1990@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -61,7 +61,8 @@ static const unsigned long guest_offload
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
-	VIRTIO_NET_F_GUEST_UFO
+	VIRTIO_NET_F_GUEST_UFO,
+	VIRTIO_NET_F_GUEST_CSUM
 };
 
 struct virtnet_stats {
@@ -1939,9 +1940,6 @@ static int virtnet_clear_guest_offloads(
 	if (!vi->guest_offloads)
 		return 0;
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads = 1ULL << VIRTIO_NET_F_GUEST_CSUM;
-
 	return virtnet_set_guest_offloads(vi, offloads);
 }
 
@@ -1951,8 +1949,6 @@ static int virtnet_restore_guest_offload
 
 	if (!vi->guest_offloads)
 		return 0;
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads |= 1ULL << VIRTIO_NET_F_GUEST_CSUM;
 
 	return virtnet_set_guest_offloads(vi, offloads);
 }


