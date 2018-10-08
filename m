Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A51CC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03502077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QYh2fW2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03502077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJHW7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:59:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45662 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJHW7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:59:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so5428876pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WRZ8SH/7z5C8CRFIKCnyZ1/qs++nuKhiuRUjQlZnizY=;
        b=QYh2fW2wt8GMVWiZvBLz2mrdmS3vXYJAvzvu6xzxLR+PtARvTDUAUU1IKDSp0fi8S0
         Kq7qOt9l2wzafL0okYkptMAhFL3q6MQUVAl7LfGWmAyjK+cFG3F094hxfK/d3IafVMIW
         PEX/2my/kX4uQ7iUqivYztRfP5GowRGQmBRrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WRZ8SH/7z5C8CRFIKCnyZ1/qs++nuKhiuRUjQlZnizY=;
        b=XN9wkoRR+65VA9W/DDjp70fhp+uat0Y1xmeOLJ9wDWWCKvTQsEIxIJN5C2IsasEPKa
         pY152W8GkxAj/VIHjRa61DQgfMYIcKfE7G0lEJi4IT1pFWTBCm2cuJIsTnGw6PeaJap0
         M0vvMCt8RaQc0u3YD3GMFo6zlBrO1vOzTTJb8VqTvCM+7kYwMdUckdS72X0/XMk53ftr
         KBhFPsNgefY1Ro4zchFRFvZUQu5oE3kdYAN5fDd8JWcapGzheU4TAiz7NZkt+IkUtk+d
         WItBo9ZWMOzHknBwA0Fx0wOWWGgEHO4LKTKIxeFtHZojp35dIBEOBLoHEltyBOacb1Fh
         QJdA==
X-Gm-Message-State: ABuFfohQ0nMsVkVOmb+tohhEivnr7vuNnLdUM6SMsZX7bQJ1wErki7+O
        UnR+6djI3/XNE9jYZ5CXRuqIsw==
X-Google-Smtp-Source: ACcGV63WVuzlqLnPatw7ZsQaDWN1KzXUgQ4Dn5Yr4v+BpioG7ZsIzQ7/Z5Q0MVWo6pIcFk5WScXZ+A==
X-Received: by 2002:a63:ea43:: with SMTP id l3-v6mr21864410pgk.427.1539013614706;
        Mon, 08 Oct 2018 08:46:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s2-v6sm31551807pfk.133.2018.10.08.08.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 08:46:53 -0700 (PDT)
Date:   Mon, 8 Oct 2018 08:46:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Miller <davem@davemloft.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH sparc-next] sunvdc: Remove VLA usage
Message-ID: <20181008154651.GA36881@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this moves
the math for cookies calculation into macros and allocates a fixed size
array for the maximum number of cookies and adds a runtime sanity check.
(Note that the size was always fixed, but just hidden from the compiler.)

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
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
