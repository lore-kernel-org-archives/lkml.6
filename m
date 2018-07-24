Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C2C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAA020880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgtvrewD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAA020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbeGXXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:31:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42964 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388572AbeGXXbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:31:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so5535664wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ui/ENQsK3coGxM9u4SbPNHKRlXUII1ql5vAqIOw34B4=;
        b=bgtvrewD3tirV080j1ZNd/8mh2196u8Cn7BSyRx50FqRcvYGQVPWLfVDMucX5isPKh
         JimBCc5P1LkjqwVS3f0tvhAOdkIbuyGHDoccl0EjW8kr8oyZEiIOj71mpOXwd71FgtdJ
         /UinQA6+YHFEYAuXa7rcriMd+rEpkl3eKY0d8PRKnvrhL9RD4lpI0THOoDrj+tj/Mmty
         34bo7PeAlEQF2gPhIv+ZNfcbVAbTTNbUGUGOd5FrUDDGxsgLoJcUGGZO+Qo/0R9XQRu+
         F29a2/OzH8RvzkdM3tzN9FGpEpFLBkbmDxGD5z4+c1X5rgm8FQLMUvd9fICdq1GYbRZk
         nfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ui/ENQsK3coGxM9u4SbPNHKRlXUII1ql5vAqIOw34B4=;
        b=PRU8CjJg/0xdc0wv/IUIa891SUBfjoXWpQ34w508ARoGnfmX1dmGmbh9TMYiCb1qvT
         CKqJrz9ux1zR7VvHg7liJhSKjCd+mGaxeig1rpuFJH6/hLnttpt4OiMsaWuCg8Pxapur
         Y/WtFZiG/nm89LxWhXNa0Mn4O8JdYxzc57R1drIyV/ChtJ5m/Oxdpt8cdE/Cm8l0995j
         BBBDAs2M86SqHQM1BiHO9/oha8Po6cAhieV92j6RT3qm8MLak/ixd+YSbTHEuXApsnFw
         xxR2VDh3ju1u+2HMFB7Hn/I1IafA8KWyEpuYbnOh6su7MAy2Aa17C2ZZJOMWkWYE7gQe
         IUTA==
X-Gm-Message-State: AOUpUlGH0MvEnH6s+GxTPeWR3/rcw0/1WlV8ZsVeNamIJ82QGaQW8Gfx
        dpmqLiTJcnrnCi0mv3gK0lg=
X-Google-Smtp-Source: AAOMgpfUNn7jCmHGeqvHEesYo4FIAkW7DEPv2xIoo1yEwm3bBREez4CV/gAphFVby5zC3Nvs6Nz7MA==
X-Received: by 2002:a5d:60c5:: with SMTP id x5-v6mr13853404wrt.232.1532470944503;
        Tue, 24 Jul 2018 15:22:24 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id p3-v6sm14792125wrg.47.2018.07.24.15.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:22:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 385FB64081F;
        Wed, 25 Jul 2018 01:22:22 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 37qeFkkaMGba; Wed, 25 Jul 2018 01:22:21 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 5D63E6408C0; Wed, 25 Jul 2018 01:22:21 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Staging: octeon-usb: Applying coding style for column width.
Date:   Wed, 25 Jul 2018 01:22:09 +0300
Message-Id: <20180724222212.8742-3-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724222212.8742-1-tsotsos@gmail.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the warnings as its refereed to TODO list.
There are also a code style issues that could be resolved via breaking
down cvmx_usb_poll_channel().

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..0d3ec12788fc 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2637,12 +2637,14 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 				hcintmsk.u32 = 0;
 				hcintmsk.s.chhltdmsk = 1;
 				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCINTMSKX(channel, usb->index),
-						     hcintmsk.u32);
+						CVMX_USBCX_HCINTMSKX(channel,
+							usb->index),
+							hcintmsk.u32);
 				usbc_hcchar.s.chdis = 1;
 				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCCHARX(channel, usb->index),
-						     usbc_hcchar.u32);
+						CVMX_USBCX_HCCHARX(channel,
+							usb->index),
+							usbc_hcchar.u32);
 				return 0;
 			} else if (usbc_hcint.s.xfercompl) {
 				/*
-- 
2.16.4

