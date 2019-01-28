Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9070C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47522171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548686726;
	bh=R4LUADSyGzbKRrmHJJdrrtmnh1hqwyHHtyZMh/+etHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HaRKGY/9PNnpQCWBxTrnNjAbdiAa1eWZdhDeqtDiyNtvM4fDnf5kYtt7jakEXF06B
	 GTiEq9Ehi1FgjGvXYiu+c2AjOBoLyEpM9HECl8dWotCsHco0DWEfANapShoIY2iyLu
	 JLVzT5f7nuprldE3L5LjH3CjoSFooYJRsSk2DXJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfA1OpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:45:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40952 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfA1OpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:45:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so13190509edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTySQcXDgbgWvZzIuOomkfESKJ+ZiRRspPXpQ++HP0Y=;
        b=dctjK6wIV7a7Oc7qU/081YuM6vdYgnoOE/5cF/uDSIzLcXQYHWtsgybP1JsxJJ47ER
         en26HEgmSeYGvdlgNGHsNDh8+6ualSavZFfXFF3UQyNuaT/CBjvdB1bvgS6yB3uSkRIh
         M8LteJpYH/AdGQjwSadXFohld79HAq82fabWUdrGD7kUax/q+iHMlR/cvZSfhZ8ViDtU
         zT5f7FE4WeYP3Iyp5d11laTGWE6UClmSq38ki2S3ibj/Et4j6oNS5AMMF8X9ZoGIcMB+
         zlFawrVlqSkCXQX83ddI3REThmQy9xycXbXRsNIiwGvEgNnjlW9ypv5M9lUqp+Rzdoeo
         hCzA==
X-Gm-Message-State: AJcUukctZAoEWsweKcvPrzNHez3AdoZoYJIuJCWepxEsVm3DC88XPjhx
        BhCeMhtQcGXCEj0Q/O7Jnqs=
X-Google-Smtp-Source: ALg8bN4SDZcBeV3rbkI2gxNZ8px9xHNMo/kDxk2X/qizXtVKHesg5Jmhm964+1jN/CWGYVmWZahd/Q==
X-Received: by 2002:a50:b3b8:: with SMTP id s53mr22208336edd.122.1548686717177;
        Mon, 28 Jan 2019 06:45:17 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j8sm2919064ejr.17.2019.01.28.06.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:45:16 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone
Date:   Mon, 28 Jan 2019 15:45:06 +0100
Message-Id: <20190128144506.15603-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128144506.15603-1-mhocko@kernel.org>
References: <20190128144506.15603-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Zaslonko <zaslonko@linux.ibm.com>

If memory end is not aligned with the sparse memory section boundary, the
mapping of such a section is only partly initialized. This may lead to
VM_BUG_ON due to uninitialized struct pages access from test_pages_in_a_zone()
function triggered by memory_hotplug sysfs handlers.

Here are the the panic examples:
 CONFIG_DEBUG_VM_PGFLAGS=y
 kernel parameter mem=2050M
 --------------------------
 page:000003d082008000 is uninitialized and poisoned
 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 Call Trace:
 ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
  [<00000000008f15c4>] show_valid_zones+0x5c/0x190
  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
  [<00000000003e4194>] seq_read+0x204/0x480
  [<00000000003b53ea>] __vfs_read+0x32/0x178
  [<00000000003b55b2>] vfs_read+0x82/0x138
  [<00000000003b5be2>] ksys_read+0x5a/0xb0
  [<0000000000b86ba0>] system_call+0xdc/0x2d8
 Last Breaking-Event-Address:
  [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
 Kernel panic - not syncing: Fatal exception: panic_on_oops

Fix this by checking whether the pfn to check is within the zone.

[mhocko@suse.com: separated this change from
http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com]
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 07872789d778..7711d0e327b6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1274,6 +1274,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 				i++;
 			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
 				continue;
+			/* Check if we got outside of the zone */
+			if (zone && !zone_spans_pfn(zone, pfn + i))
+				return 0;
 			page = pfn_to_page(pfn + i);
 			if (zone && page_zone(page) != zone)
 				return 0;
-- 
2.20.1

