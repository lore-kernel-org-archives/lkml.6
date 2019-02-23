Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45586C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128CB2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzOGJp96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfBWLLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 06:11:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33967 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBWLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 06:11:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so5038426wrg.1;
        Sat, 23 Feb 2019 03:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dtKJgSm47uLAMGcWp0iCU0yCDNLGMuI36OMyEl1aiU=;
        b=bzOGJp96A+AHxUcbO7dpZkYYcoaOcfD/NqEgiZRxBEgc861jMQ/CCavyiTToYfWlX1
         d7AaRROr5/Ptn8S+qecpbEwGSsIS1t6EdndlvsEFJhi5c4hIeUpsoIB/VfrKK58Um7Mq
         tHqqr5+5Z+FUam8bcbxkB4TvRiZl6R66n0WRrD1r9wl4TQlFTT2+5vmNCz2w5UBZ9Tof
         B0dmXeLUIkymkfatVIZlmDoE+QesutwmpOS2MGBzhBuD/sNZLYEGSiez9lnAoMmK3oj1
         GlC/EnBLhr+zoNtcZ7suMDZfjt1TF5bVthXsK4H+6bB7qWIXuRKSDH6NK50PRM9VPZwn
         KSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dtKJgSm47uLAMGcWp0iCU0yCDNLGMuI36OMyEl1aiU=;
        b=shespx+SxgkMQUuIAjhDh1h0g9hxkAU9rligDxgsLwU4D5/pcHrGXec+aQD861FJOY
         7m/2SCZNQz1JAnzpp+VOuC30tLE/83g7IzhCg8I+rnjkmlweo+EIeNZ7vKBwTv5ymomn
         8NN7gsOq+eVmGG4sJwso8z93utZocjtWOioodTOYdZq7+HWDDpR2aOqTPNqiJ7vlZ6BR
         8t02jK9vYIE3v/rEBlyAXkrB20HaPaVgZ1YgmU6xmAH8GkGtmM618/u4Wj89L5cM6BbK
         C9WrybiTk83FDzO+wFbdK/YVDIm+TnO31ktMEof04KJuP21WEHa3Vwtbr/CXhOPHKGXm
         a6xg==
X-Gm-Message-State: AHQUAuZtaoStshfZToih2yZss4yKaH0XHndN1uLb7ap3Cq18CmLpFBLR
        OntiYxVESNNpkPMZtZIWWhg0jTAdFA==
X-Google-Smtp-Source: AHgI3IYEUxlB0EZR2GD3If8/zQKnIPC0ulYVJvT7ySaBiy4vBiRym7WORRRFc56HqUh3ZKYAO9rFTg==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr6021689wrn.268.1550920271953;
        Sat, 23 Feb 2019 03:11:11 -0800 (PST)
Received: from localhost.localdomain ([185.61.164.85])
        by smtp.gmail.com with ESMTPSA id w4sm6595853wrk.85.2019.02.23.03.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 03:11:11 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     jreuter@yaina.de
Cc:     linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, ralf@linux-mips.org, netdev@vger.kernel.org,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        jbi.octave@gmail.com
Subject: [PATCH] net: ax25: Add SPDX License to fix missing License warning
Date:   Sat, 23 Feb 2019 11:11:00 +0000
Message-Id: <20190223111100.13983-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/ax25/af_ax25.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 5d01edf8d819..5048790a75f6 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
-- 
2.20.1

