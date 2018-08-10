Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B7BC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C98E223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C98E223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeHJR75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:59:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36355 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeHJR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:59:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so2329345wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u8/RQnqvKaB52sUTxj99rxlBwtcgMKNF8ab+i1Lq2fw=;
        b=QmWMdEcdborrgzppakyJnw1mH7x40pJYzVOmktP0VBJGz5HSlZRGDVyXjmDY9VPrL3
         7OHCmmOBMY7XTtBg1JnXIZ7zsufeIhLtSs8nHaKYJY9Fab2fJi3L0Ton8S4x76YATCL1
         fMZa0EkIvi4YGWiyWnK8fRuwrWZFtT3DeyKxjZYYZPouy6ahRvG0apwwyKi2rTCo7Flx
         Ca8LX25dz3MczLe/BAz2gVt7p/gwJJZVE+7DDqkqK9KKGCmyTYI0BjgAnW7jjvBijzQA
         vIab78pavP1WP23C4tLYNyw6wqYqRZ4y26kZ0Vml34kZg/i1N44IW4SEz8HQwTlGhCLM
         XqIQ==
X-Gm-Message-State: AOUpUlEwWvo657AEasC1bE2nyj5kN/47I4xpnxsDA3Cpe18pxvjLBBhh
        ZBwMmyIgeuj9uGkIl6ICWkU=
X-Google-Smtp-Source: AA+uWPw8xquqFk2mp3igFhB3kf6iBPtizGpKmD/cr0FGjeXNESOrUMg8g1YikVGecqhpmi8es9gZXQ==
X-Received: by 2002:a1c:a989:: with SMTP id s131-v6mr2000324wme.136.1533914975948;
        Fri, 10 Aug 2018 08:29:35 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id r12-v6sm1581899wmh.0.2018.08.10.08.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:29:35 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 340B612481D;
        Fri, 10 Aug 2018 17:29:34 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/3] mm/memory_hotplug: Drop unused args from remove_memory_section
Date:   Fri, 10 Aug 2018 17:29:29 +0200
Message-Id: <20180810152931.23004-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180810152931.23004-1-osalvador@techadventures.net>
References: <20180810152931.23004-1-osalvador@techadventures.net>
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

