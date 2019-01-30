Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A2C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A811F2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548839554;
	bh=WEQYKvlM9DQ3+KYvqEPufJmsaqepqeJOo+JV8/0aU2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLnS5cmMpBZ78+wvO39JHM4XxUYxeohXLG9rPThnmwz+1Ywr8T7KLlNEyh1yvq1dN
	 XDJ6PtIe8Y/yIshh21Giv+msaefQNM0lFEEZHZvbrRs37HG5CzlOe8KEUvgaZqmJuD
	 9OKYnIqM/OE+YUpjO3bWMmjZW+USWGgYioe7Jjas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfA3JMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:12:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39118 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbfA3JMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:12:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so20682878wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFyaSZDvG5tAIyjheJu+7MuaC7bK/awFyWok5SF8UwQ=;
        b=gUCiIt3VUZS4tDf+t6lHZ87/EuQdEbLQTG6AZUGbGkhG8pad0bAzsOfBwawDuZVfRR
         Az9vceHAAu28f/q93qC5XD7Je5TTaqtCabCyibDwE84L83n0vXk3EdwB2/P35yj9ceAu
         YiBjgyALqCOpKIZu7P68yuUXb6f01+Timy8H5SyPNkhGO0xIdTa8QB6KryVprJ6KM2uK
         ETG1gkFO/FsvppwQy2TUgCJri4FBBFUAWxOrMZdu/xjoRxjK1kniFR2yYOx+P0omkmSN
         nBhHD7MBgUKOj+JXg+gU1ms82Rx4ZK+muqswenHNieF/zOlWKaLeB4bIbBlugbMXvEXl
         npBQ==
X-Gm-Message-State: AJcUukehpqst2RJHLVp63Us09o3aGTDxGSauG0nG0kHVybV8raCy4GI4
        4WLGEL9vA9t4M14h0HRxBt8=
X-Google-Smtp-Source: AHgI3Iaq8fWIDq9I86+HaQ9zHJ55J5mjfGRbhPSWjN7j9DPfqEzANX5rnBt5mnJftfFn161SONvHRQ==
X-Received: by 2002:a1c:c1c9:: with SMTP id r192mr13492549wmf.146.1548839550147;
        Wed, 30 Jan 2019 01:12:30 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-142-190.eurotel.cz. [37.188.142.190])
        by smtp.gmail.com with ESMTPSA id l19sm1491875wme.21.2019.01.30.01.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:12:29 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 2/2] mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone
Date:   Wed, 30 Jan 2019 10:12:17 +0100
Message-Id: <20190130091217.24467-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130091217.24467-1-mhocko@kernel.org>
References: <20190130091217.24467-1-mhocko@kernel.org>
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
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
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

