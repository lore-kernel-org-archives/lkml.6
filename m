Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF67C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3E52073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XqmdXUOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3E52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIFCgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:36:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIFCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:36:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so4174876pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tFRHIkGo5gdqZRGre9WKjmW/hmEpMWKXjCP24e69K6g=;
        b=XqmdXUOhw9gx6Hb8SegHc0YHQJfhzDqzWz4JlIPKieCfKNIm606s5O6uF323GDf8uo
         T4zyKyPBc9X9mHqvU/i7SFktdJ/nVoTsXfDRHRUYAGOcgaNdXZ+dqbxo4VTpufWG+lg+
         udB+Qw+5TQkzAasO68k/hRbpAQ1/uD9rrzXzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tFRHIkGo5gdqZRGre9WKjmW/hmEpMWKXjCP24e69K6g=;
        b=R4i3ml6qTrNIr6hXuNqVMXkBYrTwZcKISPztOAgCPoPPPutkwtLUUkhYe+w3riLbFJ
         LHBXSVli7V9HshTSvOYdVw3qiv5vRINt+aq8Uq5rMRU34T7mOOLLnTKRh10t1azukAhc
         Z7KfSWcFEXFAVYwypxT/mgcYYj/34pLFLWShSHX3BTQp59XwHSdGY8Bt7hCkfKOCfDJf
         DE1kvPWPPGbxQEBqk92Z2gWxYL69zyqxHA9YQdK4xAs1dY8XXlqrZb1wHLQ2ys0RzkSk
         UjkRxnr0qtifG1ofMqzfDxLZ/LoS1OkVGRx9I4TwIGyPLD41j+11eNuTe173hXU5yG9O
         h67A==
X-Gm-Message-State: APzg51D3/xdD/282biaVyJbPI70K1m5cN3sfeagOf8v50fOQMqldHsI8
        GtpHn4PuxycD2QpfLWFQZ0gzNpec0as=
X-Google-Smtp-Source: ANB0VdYAasW3bHx6d1UT6wq7zycbA+Cj18v7b1ZeIn7kRh1YdaxyiWnf2IgBZ/VoMCUY+CBwWb1/rA==
X-Received: by 2002:a62:990f:: with SMTP id d15-v6mr42818379pfe.162.1536185033917;
        Wed, 05 Sep 2018 15:03:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g21-v6sm8272096pfe.41.2018.09.05.15.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 15:03:52 -0700 (PDT)
Date:   Wed, 5 Sep 2018 15:03:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Allen Pais <allen.pais@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64: viohs: Remove VLA usage
Message-ID: <20180905220351.GA48213@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
allocates a fixed size array for the maximum number of cookies and
adds a runtime sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1
RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/kernel/viohs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index 635d67ffc9a3..7db5aabe9708 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -180,11 +180,17 @@ static int send_dreg(struct vio_driver_state *vio)
 		struct vio_dring_register pkt;
 		char all[sizeof(struct vio_dring_register) +
 			 (sizeof(struct ldc_trans_cookie) *
-			  dr->ncookies)];
+			  VIO_MAX_RING_COOKIES)];
 	} u;
+	size_t bytes = sizeof(struct vio_dring_register) +
+		       (sizeof(struct ldc_trans_cookie) *
+			dr->ncookies);
 	int i;
 
-	memset(&u, 0, sizeof(u));
+	if (WARN_ON(bytes > sizeof(u)))
+		return -EINVAL;
+
+	memset(&u, 0, bytes);
 	init_tag(&u.pkt.tag, VIO_TYPE_CTRL, VIO_SUBTYPE_INFO, VIO_DRING_REG);
 	u.pkt.dring_ident = 0;
 	u.pkt.num_descr = dr->num_entries;
@@ -206,7 +212,7 @@ static int send_dreg(struct vio_driver_state *vio)
 		       (unsigned long long) u.pkt.cookies[i].cookie_size);
 	}
 
-	return send_ctrl(vio, &u.pkt.tag, sizeof(u));
+	return send_ctrl(vio, &u.pkt.tag, bytes);
 }
 
 static int send_rdx(struct vio_driver_state *vio)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
