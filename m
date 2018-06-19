Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91119C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BE620661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967410AbeFSVsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:48:37 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44162 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967231AbeFSVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:47:15 -0400
Received: by mail-yb0-f193.google.com with SMTP id w74-v6so471341ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LT9TrtiRXCl2nVaT1mJwH3wuwflNX6wnuE0hTLu4Q3Y=;
        b=dUlpCQuxHXFjZcsDu8/cag3/erz5FrWeDeFV/tlaSFcHIoLqnuv+/3o6oGaq0cJ5AS
         HQhUcrae+pTmCH5OiFfC67//a2a1Xd7CN8uu0KjBHlXTfRkKdg+nLr/GzDzESS+9cazA
         duOIDxKYQvw2AYtT69hCmvPPp+KFV62rRfRiN0gTbU+DlvimpCadziuGPv74cJzA2YoL
         2MmRFVr2/AzqLeRre7q/8p8TPa0UTX/M8QzjPkms3/qTRrMP+2Xyp4MHX8/KxS/0zfKX
         OBhdoPKV4Zj67DBGHf3TEvsHxT4VaHh7RWt/5Oa98oCY1l0Gp0WDgMGXePYO2zdDpZcK
         Hy8w==
X-Gm-Message-State: APt69E0TNQLqwr5cCXFVflFPzMtYHap7VAbfQ4FMJiuChyUqmb3Q5pDB
        peN9gxRDGpwaDOdf1f9EZw==
X-Google-Smtp-Source: ADUXVKL1K/JDgTy1ecJl2I9TQj2Zcm6uezU6HIHNQ4R7oP1fBUt5mz28PxPUTK7kt88DxVPNfypN/w==
X-Received: by 2002:a25:b10d:: with SMTP id g13-v6mr7125131ybj.169.1529444834496;
        Tue, 19 Jun 2018 14:47:14 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 1/5] MIPS: octeon: use of_platform_populate to probe devices
Date:   Tue, 19 Jun 2018 15:47:06 -0600
Message-Id: <20180619214710.22066-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_platform_bus_probe is deprecated in favor of of_platform_populate.
of_platform_populate is stricter requiring compatible properties for
matching rather than name or type. Octeon uses compatible strings for
matching, so convert it to of_platform_populate.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db478904..2940e9cc3a04 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -1067,6 +1067,6 @@ int __init octeon_prune_device_tree(void)
 
 static int __init octeon_publish_devices(void)
 {
-	return of_platform_bus_probe(NULL, octeon_ids, NULL);
+	return of_platform_populate(NULL, octeon_ids, NULL, NULL);
 }
 arch_initcall(octeon_publish_devices);
-- 
2.17.1

