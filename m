Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D848620863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVHRgSxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D848620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeLABo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:44:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39678 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeLABo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:44:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so2898006pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 06:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gv09Gf6Oa0dSOhJSitG07t2r4ojslJZfiSgMJC2baW8=;
        b=hVHRgSxtigxjhII0ZO9zM7qGqr7oKw5TiZwbHzXWYKU9PC6hdWtL4k7orQE35FeeGa
         mhdTSpJ9PMnwA3aJKjDdI18NxzLZzc0t2cWWd/kto7zVxCxGSTIMhdNSCHjdeInP5dvE
         SAZOTlMIeKEOUGuqsogAnQFzUrPbA6aIUYSupi8AN6skaUm+pdPkbWdRpiq79DnGY0Y3
         2WTkbWsoPlW6e6QirDVyifa/KDYyuyrVy5mQNj6LdZh6uvNj3ZQu+kimQs/3746hFY3s
         BStBWrOEDmvJOUcp/HkCOC+tALkvKxi5/bEL9z24Y6YYc7sSlaqiXWQdv/NKb7cgF/uv
         kwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gv09Gf6Oa0dSOhJSitG07t2r4ojslJZfiSgMJC2baW8=;
        b=jS7E5FSZCFnN0gjkZc5Uss9guQsicRnbPfVmXL3Q7zn2RQYwJQq6zujqUylzp7/CBO
         4+wV0SslSD3CJMujdD8rawIkUZL90vz+hZ+yroZ1A1LOMWLNzSakYVNj1dBo5eblIZOS
         AeZeh4S5ChgaePFEMPgBjuYRUrOCX4S7M2VL78iZwFCnSg4WQe5pUP3J3FUos4F+1vud
         3Y6ECIG6+al0GHyTzgYPK5UUKayrOGRUY0dsLLVcOyuiz5MELxWsemhye5skSw+e899A
         zkxGrhdvPtTETb2mUe3a8RODifpPiH9Xkqu8eEHXGY866GJzyo2fSuVu97qZ8atqoLfD
         PKxw==
X-Gm-Message-State: AA+aEWbHNI5wCKbWHsMeQ4SfWZcl/Z0H0aRpkTB/RhIZpFH6Osu7rQrU
        SNY/pD+R4tZ/4Sm94FNzW2Y=
X-Google-Smtp-Source: AFSGD/UFPxwEDhJQ3cBJUXKtqd15YRhfSP2OwSo4dn903ZANpviVZdIV+3W9eBZHCpXVZn7zkcIl8Q==
X-Received: by 2002:a17:902:3225:: with SMTP id y34-v6mr5761101plb.227.1543588528751;
        Fri, 30 Nov 2018 06:35:28 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g28sm12680425pfd.100.2018.11.30.06.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 06:35:27 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] irq_remapping: Remove unused header files
Date:   Fri, 30 Nov 2018 09:35:21 -0500
Message-Id: <20181130143521.2763-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file.h does not need to be included,so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/irq_remapping.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 7d0f3074d41d..b94ebd42edd8 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -1,4 +1,3 @@
-#include <linux/seq_file.h>
 #include <linux/cpumask.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-- 
2.17.0

