Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAA3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A9320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A9320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbeGSOLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:11:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36130 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbeGSOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:11:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so6454040wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iR6ap2+iUy62zVMy6aBo5ViVXszWlh4SxTnrrtnI6UU=;
        b=c/S1crlWBfwPuFhnZZ6aT5DwSZwChMiz8LmoZtbGNGbVIW8f/5MlkqJx4E2AzVH1v2
         yRa0BLmWxcO9ua+59h7sBWbTpuWn3lu02qU9hwnWMytnNKFBLeaZz/VoeRA1D/nojfUq
         EYGhyZmMUqI2uL1N2f4Xi+2/wqxjJ8+XqCEtCDeVHjSqtTTPpMyOMeiipgKB/cl2kkQz
         bVcj7Zy10LxCqxhoAmgZeB8KBKcTiPQZP5jLWBvq++p0wRfmzYCKHM19U5GHOSIadTbW
         WFbHQflgsBqhqcXTChzxvm2axebFvpzJi+ZPGSVuNRT9Rv8qb16rWSAgAV8WgFD2xzvY
         VEEg==
X-Gm-Message-State: AOUpUlGx/E8XRiqt7oRCuMq2HtzW3iIaye2fx806XCddvHpUQvBF5wwi
        xHip7JQZowkLg+eAUWbVp84=
X-Google-Smtp-Source: AAOMgpftYRfy5AcQmz/Xk79SbS1/qmSyf+8EbwNQ/C1z3SwS12yErvGTDFwyambro5ndGrGS1BwkMg==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr4454990wmt.94.1532006868813;
        Thu, 19 Jul 2018 06:27:48 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j6-v6sm9373056wrs.91.2018.07.19.06.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:27:47 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 8D671124176;
        Thu, 19 Jul 2018 15:27:45 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 5/5] mm/page_alloc: Only call pgdat_set_deferred_range when the system boots
Date:   Thu, 19 Jul 2018 15:27:40 +0200
Message-Id: <20180719132740.32743-6-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180719132740.32743-1-osalvador@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

We should only care about deferred initialization when booting.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d77bc2a7ec2c..5911b64a88ab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6419,7 +6419,8 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 				  zones_size, zholes_size);
 
 	alloc_node_mem_map(pgdat);
-	pgdat_set_deferred_range(pgdat);
+	if (system_state == SYSTEM_BOOTING)
+		pgdat_set_deferred_range(pgdat);
 
 	free_area_init_core(pgdat);
 }
-- 
2.13.6

