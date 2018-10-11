Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F80F20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="JEjp9OKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F80F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeJKPTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:19:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40948 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJKPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:19:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so3778204pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3V9hyDWZjdftsthbVpsskbhBuIx6yQZQc2+RBbtRyXA=;
        b=JEjp9OKk1DLPiM7CHtqajCOFgoJUNhLbQHwqdI8ESWqSVGXjbS2uOfdObrJs0TUNBO
         I60PEOHyQYNNj9xzqFHn1K+zSnsEIjNiE/h53BxSor226fNMmSmgEHOVs6cCOU8WbkEd
         8dZAYM+kxm2/Wz+Jg0Gf6DppwQX8LcVY9LPgHmZx/CmPoJmYXhAoPtxLQPQGkKZxT76C
         RTxnAlMEl/fjekYjnLKAqWk6yKn9ye7g3yUf9rUQkk3242CUxXG9eB8mRjwx3BbKHC5X
         BKPGZmiAc4dbd6VqpDtB1B5VZPVnQMRKkKOEAB+IPH126/xTGKYWoisP392l+zw7Cru+
         vsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3V9hyDWZjdftsthbVpsskbhBuIx6yQZQc2+RBbtRyXA=;
        b=tAt4E4/h7jlCYHDSeP/ArB9VnzKdVnWtV/6acgcyQmezDdX990bMlEbHBh4ZKkqhKe
         Z+6a3GANkC8egYAok5XGThzeVE5uyHbgbFWtyKQbUyFODXkWNwMWe16LtaWbRb9FHCIN
         TVy5JUB38XuWbIYSOhj5m8FDrtu67F5jws39djhB9MDjqyg7Yx/SHFzZ6mSmrY1HogfI
         P8ka98OLGAi8WkGelCPJZ5kRXlGzGYP2NQq9jSypqEOmHWz0+8WvFm5TK5V+5nxECOQz
         U8PeuxgjWtIgjHF+76QzpsqqSOPr/5p+gFaaj8DbSaW7m8AzgnhVXY07Rr5GQCIb+KaV
         udzg==
X-Gm-Message-State: ABuFfog3zGem7uruxefBHEkKsnChebBYxPvz3gTHPvuQTqTNwNBjbvlU
        j4EU/gZtpWccbVzrTguzbP5Vi2iouxTNcA==
X-Google-Smtp-Source: ACcGV63oayOIyobGPItcLAhTe7zc9Gvl6sVbe5QlnxaCXt2+VLhPJtgrwwwGwvnTwhwYDZD7bM2Hgw==
X-Received: by 2002:a63:ec4b:: with SMTP id r11-v6mr440781pgj.295.1539244408700;
        Thu, 11 Oct 2018 00:53:28 -0700 (PDT)
Received: from ake-ubuntu.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id u21-v6sm41760586pfa.176.2018.10.11.00.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 00:53:27 -0700 (PDT)
From:   Ake Koomsin <ake@igel.co.jp>
To:     Jason Wang <jasowang@redhat.com>
Cc:     ake@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: enable tx after resuming from suspend
Date:   Thu, 11 Oct 2018 16:51:26 +0900
Message-Id: <20181011075127.2608-1-ake@igel.co.jp>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
disabled the virtio tx before going to suspend to avoid a use after free.
However, after resuming, it causes the virtio_net device to lose its
network connectivity.

To solve the issue, we need to enable tx after resuming.

Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
Signed-off-by: Ake Koomsin <ake@igel.co.jp>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dab504ec5e50..3453d80f5f81 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	}
 
 	netif_device_attach(vi->dev);
+	netif_start_queue(vi->dev);
 	return err;
 }
 
-- 
2.19.1

