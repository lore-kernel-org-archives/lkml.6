Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ED621522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ED621522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeHORe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:34:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55758 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeHORe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:34:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so1602559wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BdZLNw52aqmLAxMqJGxlH9ECMAhyOUNtYTzW93zUZJ4=;
        b=pAb7f/C92GRhTwdPRsdqK17qj1QKmRVuYPbX69NDWrMlgt/yWPvupLgYQfWqF20sSG
         HPWl7TC+ch6mwYkf5cgQJGKDxrI04IMyOR/KKrWEcLVLPGQx+VqgL00unrQhvmn1dR+M
         xNgtVzr6AwoH+CGTVkriSByhjhuIsq2Rm4UAAsQmpxpfu7CMAsE+R9UXhJlR4RvoCukm
         NwDwdc0IV84EM+fCWZcbHaKKYgqiqjGtTGD7pgVXv1LBrM6TkA2HpkFRzjLzzwBvBnb8
         F7oKTThC8GnYDlAE87ZhWSjjkVj8I55GHe57Rz4klRj6frbEVJzFW8nYN3d2qDgVr0kK
         dbRQ==
X-Gm-Message-State: AOUpUlHqeP4pSnfHd5v9Wp4c6tNgkGQxngVX1SFWrar1INVnKULpQlYz
        mcX4eGTCKj6JKfcn1PlRcTg=
X-Google-Smtp-Source: AA+uWPx9ixWGPbeEHyin7m7JcOEBDGAlima7k0RWmR3Rh+WlJhrZpRgeGVDdayuKkTnw1auJGx6RFQ==
X-Received: by 2002:a1c:b609:: with SMTP id g9-v6mr12788596wmf.73.1534344150025;
        Wed, 15 Aug 2018 07:42:30 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h7-v6sm22889162wrs.8.2018.08.15.07.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:42:29 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id E90C112489E;
        Wed, 15 Aug 2018 16:42:27 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 1/4] mm/memory-hotplug: Drop unused args from remove_memory_section
Date:   Wed, 15 Aug 2018 16:42:16 +0200
Message-Id: <20180815144219.6014-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180815144219.6014-1-osalvador@techadventures.net>
References: <20180815144219.6014-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

unregister_memory_section() calls remove_memory_section()
with three arguments:

* node_id
* section
* phys_device

Neither node_id nor phys_device are used.
Let us drop them from the function.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/base/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c8a1cb0b6136..2c622a9a7490 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -752,8 +752,7 @@ unregister_memory(struct memory_block *memory)
 	device_unregister(&memory->dev);
 }
 
-static int remove_memory_section(unsigned long node_id,
-			       struct mem_section *section, int phys_device)
+static int remove_memory_section(struct mem_section *section)
 {
 	struct memory_block *mem;
 
@@ -785,7 +784,7 @@ int unregister_memory_section(struct mem_section *section)
 	if (!present_section(section))
 		return -EINVAL;
 
-	return remove_memory_section(0, section, 0);
+	return remove_memory_section(section);
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
2.13.6

