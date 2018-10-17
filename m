Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F151ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1719F2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="izlxtBta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1719F2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJQQHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:07:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38359 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJQQHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:07:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so12156280pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/USgmVy81vs1yDCG0JKx/xH46DxdkkeWmnKpjvt0sw=;
        b=izlxtBtaSMGU43UMOyk/sqsIiSQQ9VFSDtcHWKw1sNCjhPHAt7yOYpJ+TVR2GBzOk4
         DYJdZ5H8y2AhM2+kvuW2lI1YQ5HhVWNYVQ9U4lExn863g/Ze9E+ULBkgY7jUPkJ6bEn6
         S3dkjZ1QHj+d9VJ2T4hb1PP/xw9DHXXj9CL6VCnHtbQeD3mBhHfWzr8OwxY4aGbNgPJx
         pEnQi4tFdX5ManwuDI65p1L9yGFocCXIJNYMjwy12n4XlbRywDyXu8zDJZzs76Qoi6HG
         54jtxsrVuDfagqGKyp92bsOtnBQri6ZdOBrlmzVeI1IDfy3bquKnE/RMRBdpDFF9LOKp
         FPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/USgmVy81vs1yDCG0JKx/xH46DxdkkeWmnKpjvt0sw=;
        b=c6bdztS2sqzv/x4Bt6tWF0hmU32lLCpjx1Bm1oIkYq991q68455/JQTCriKShJP9Aq
         Tf/ts/Ynqf+cpn8Yv/qjJ5Yn3axtiG7DiSRfYoNKMAnXf072/hCmbNrVNOfSY8xDr1uZ
         b0ia9qQplOMNkeGGNzHnWs5l+S3YurXhTUElkDVyLHpyJ2qoVljWhIPOEFXzJGfm2OO5
         xF2UWqSJ3es1AJs9gVQGvcSLDGsm07GoYZzg+sfnpAnfd0yvaHB+EFCDi8Z2yX8oG8P9
         +XEdpdfASZcdTLYbIHaqt5fLaklz7370dFAYgqmk7wKDR6Wm0ecDyxNF9goc005TGZ24
         RD7A==
X-Gm-Message-State: ABuFfohBuHEVVLfkTudprAiq9Uq87kxbvzgMDk87o7DBzMTTrdN6j/yS
        HZml1klXCGiOAQF9eui6wphCcQ==
X-Google-Smtp-Source: ACcGV61KHjTVzAcbJtiXw4B0l/vx+sAjuuCVTA/Oumc92EJSkMJk1p6ltGaWr4WTjTVCf+nj9BIWuA==
X-Received: by 2002:a62:6d04:: with SMTP id i4-v6mr16301637pfc.131.1539763995872;
        Wed, 17 Oct 2018 01:13:15 -0700 (PDT)
Received: from ake-ubuntu.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id k12-v6sm15547018pgo.34.2018.10.17.01.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 01:13:14 -0700 (PDT)
From:   Ake Koomsin <ake@igel.co.jp>
To:     Jason Wang <jasowang@redhat.com>
Cc:     ake@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_net: avoid using netif_tx_disable() for serializing tx routine
Date:   Wed, 17 Oct 2018 16:59:18 +0900
Message-Id: <20181017075918.7043-1-ake@igel.co.jp>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <f04bee7a-3892-102d-2be0-f4fda4048e74@redhat.com>
References: <f04bee7a-3892-102d-2be0-f4fda4048e74@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
introduces netif_tx_disable() after netif_device_detach() in order to
avoid use-after-free of tx queues. However, there are two issues.

1) Its operation is redundant with netif_device_detach() if the interface
   is running.
2) In case of the interface is not running before suspending and
   resuming, the tx does not get resumed by netif_device_attach().
   This results in losing network connectivity.

It is better to use netif_tx_lock()/netif_tx_unlock() instead for
serializing tx routine during reset. This also preserves the symmetry
of netif_device_detach() and netif_device_attach().

Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
Signed-off-by: Ake Koomsin <ake@igel.co.jp>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3f5aa59c37b7..41ccf9c994a4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2267,8 +2267,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 
+	netif_tx_lock(vi->dev);
 	netif_device_detach(vi->dev);
-	netif_tx_disable(vi->dev);
+	netif_tx_unlock(vi->dev);
 	cancel_delayed_work_sync(&vi->refill);
 
 	if (netif_running(vi->dev)) {
@@ -2304,7 +2305,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 		}
 	}
 
+	netif_tx_lock(vi->dev);
 	netif_device_attach(vi->dev);
+	netif_tx_unlock(vi->dev);
 	return err;
 }
 
-- 
2.19.1

