Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4DBC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8132920645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KByBXbZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8132920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIFEmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:42:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44021 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFEmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:42:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so4215202pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OzKPlDZfR8Vr1kKmSH0Nsx1XZridXjep+sI/nooV+yQ=;
        b=KByBXbZffgwesCqwARNqNdFf/pGn3Jl0w4dqoyzGIaf7U7PkGay1LXdPl3ZUged0Jn
         /sSmXDiGPtSWGfMjnPWZHmqLO04RhWT1qznkCEZ8pUB++95RLHuGXmK2Wwen06AhDzhx
         h1H1mQYPuLbgRyG6PXd6IwByCeAr2N6ybLfxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OzKPlDZfR8Vr1kKmSH0Nsx1XZridXjep+sI/nooV+yQ=;
        b=gnJR6eIhToraTrOw1vOGqJ5i5jeQoeFF8cCzwxIu+yS0JXubw8VLkWi3as+VZTUjCz
         NEpsT6QU7Yot4MI8MBTLEoaElfj56ojvt0ABnnQiy3FibK6oBbclOwFJhEkZAfqZUGpF
         IFq7HyykeJ0jFpmQ4acLlbtrGO4FIBCsxfc/g/a+M+KglknjW/5eRVmElQ+Rej1nNgXJ
         vEOdP7QUv5C59LJL3/LOvwuaORiRmKs1xYqtevcQ1RROUv9o1zM3jSohht+KlIy/Dg7a
         rPE10zJW/LGTG8aM83Eqi9UDMEyhIa8qBRvCOltIZFdZMGfBhxCB1amf0NoFG1yofnVz
         6bwg==
X-Gm-Message-State: APzg51CId+5nW8Nw5XnGm0Yv09dCzhmi3DbY+6WSV+kDN9SaeeYNs96R
        lW/hl2mvmkxh5StQ3gaLyv1hVA==
X-Google-Smtp-Source: ANB0VdZtRISAiHpZjLLDY1tVxIvJiU7Ni5b/5qaJIPrTMEWRnCs0B65UNxlW2RExcZ4T6zs3Bn2vPw==
X-Received: by 2002:a63:fd52:: with SMTP id m18-v6mr185998pgj.304.1536192569151;
        Wed, 05 Sep 2018 17:09:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d24-v6sm3541273pgv.23.2018.09.05.17.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 17:09:27 -0700 (PDT)
Date:   Wed, 5 Sep 2018 17:09:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sunvdc: Remove VLA usage
Message-ID: <20180906000926.GA18830@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
moves the math for cookie calculation into macros and allocates a fixed
size array for the maximum number of cookies and adds a runtime sanity check.
(Note that the size was always fixed, but just hidden from the compiler.)

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/sunvdc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 5ca56bfae63c..f68e9baffad7 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -36,6 +36,10 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define VDC_TX_RING_SIZE	512
 #define VDC_DEFAULT_BLK_SIZE	512
 
+#define MAX_XFER_BLKS		(128 * 1024)
+#define MAX_XFER_SIZE		(MAX_XFER_BLKS / VDC_DEFAULT_BLK_SIZE)
+#define MAX_RING_COOKIES	((MAX_XFER_BLKS / PAGE_SIZE) + 2)
+
 #define WAITING_FOR_LINK_UP	0x01
 #define WAITING_FOR_TX_SPACE	0x02
 #define WAITING_FOR_GEN_CMD	0x04
@@ -450,7 +454,7 @@ static int __send_request(struct request *req)
 {
 	struct vdc_port *port = req->rq_disk->private_data;
 	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
-	struct scatterlist sg[port->ring_cookies];
+	struct scatterlist sg[MAX_RING_COOKIES];
 	struct vdc_req_entry *rqe;
 	struct vio_disk_desc *desc;
 	unsigned int map_perm;
@@ -458,6 +462,9 @@ static int __send_request(struct request *req)
 	u64 len;
 	u8 op;
 
+	if (WARN_ON(port->ring_cookies > MAX_RING_COOKIES))
+		return -EINVAL;
+
 	map_perm = LDC_MAP_SHADOW | LDC_MAP_DIRECT | LDC_MAP_IO;
 
 	if (rq_data_dir(req) == READ) {
@@ -984,9 +991,8 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto err_out_free_port;
 
 	port->vdisk_block_size = VDC_DEFAULT_BLK_SIZE;
-	port->max_xfer_size = ((128 * 1024) / port->vdisk_block_size);
-	port->ring_cookies = ((port->max_xfer_size *
-			       port->vdisk_block_size) / PAGE_SIZE) + 2;
+	port->max_xfer_size = MAX_XFER_SIZE;
+	port->ring_cookies = MAX_RING_COOKIES;
 
 	err = vio_ldc_alloc(&port->vio, &vdc_ldc_cfg, port);
 	if (err)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
