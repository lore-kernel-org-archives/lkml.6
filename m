Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEE8C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F062184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548839552;
	bh=+aIrxJL1RKHfLeo3Rvwx86tVb+zi2Ftp6I7j2izwwXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iYqPDCl2MbcblNdh8MhdMuSmsS77EZdytyv61bPp6/ZnpHUTJm78/MQ2xjW6Ra1iw
	 xwQJWIHgT0070AihYqpeVMJ8RuPuTzEI12lY+rBZnIh/94bs4PMuBsqmlUykAOjAxR
	 C3XjPbB+qOmiiS2NTwkTVeGAVOzSYcLo8VoowZ5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfA3JMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:12:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37838 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:12:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so25132558wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqcIWXioD2gkdPhR+3oNYtx3Ld3P23Y8DhdWLsl2n/o=;
        b=FevnqoSzorKN33A0/vcjvyQRTXNl/9iEAGHsumR7Y+RgXFitReEMxSBQnouMarbOOk
         yk6YHRYmsf/9itp+dCO3ywJWr9lqTdKdHVTQlmPePfb7j7a/UNdsYd/b2PmJDWW64ijz
         D3DNF9/P0eeV9hx7/AFU6I7qn6juZXrW0+1akeRxXoRw306YNer+EYeF/lsX9OpFtPB5
         /Tp9dFLDOna6A2E7BewBeXMXlG73YbW6Dn/e96lsx8WsLN1U2Y+62KYIJ/JXHgR+9H/m
         Q3onCHcu5xdfv21B9vPwjSPKMgQjFB46AvkXRWdpmDNdWPXM+vHNXkVFf7xoRuxeYYQU
         Sq5g==
X-Gm-Message-State: AJcUukcmV8igz5dsQzNxLxlD6wQ0Y1T4E9mrbLmSmfcKrlSabp4WjF3x
        AJk2h80oGlyLO3Z2ZiTgoqU=
X-Google-Smtp-Source: ALg8bN4OLx4B36rgVZODDcO0K8ixVFRBva3FhUwiy8i7CxdLOfPVVkqSieNV7/xg/er1aWb+g0RmCA==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr30650251wrn.142.1548839548346;
        Wed, 30 Jan 2019 01:12:28 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-142-190.eurotel.cz. [37.188.142.190])
        by smtp.gmail.com with ESMTPSA id l19sm1491875wme.21.2019.01.30.01.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:12:27 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/2] mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone
Date:   Wed, 30 Jan 2019 10:12:16 +0100
Message-Id: <20190130091217.24467-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130091217.24467-1-mhocko@kernel.org>
References: <20190130091217.24467-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Mikhail has reported the following VM_BUG_ON triggered when reading
sysfs removable state of a memory block:
 page:000003d08300c000 is uninitialized and poisoned
 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 Call Trace:
 ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
  [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
  [<00000000003e4194>] seq_read+0x204/0x480
  [<00000000003b53ea>] __vfs_read+0x32/0x178
  [<00000000003b55b2>] vfs_read+0x82/0x138
  [<00000000003b5be2>] ksys_read+0x5a/0xb0
  [<0000000000b86ba0>] system_call+0xdc/0x2d8
 Last Breaking-Event-Address:
  [<000000000038596c>] is_mem_section_removable+0xb4/0x190
 Kernel panic - not syncing: Fatal exception: panic_on_oops

The reason is that the memory block spans the zone boundary and we are
stumbling over an unitialized struct page. Fix this by enforcing zone
range in is_mem_section_removable so that we never run away from a
zone.

Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Debugged-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b9a667d36c55..07872789d778 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1233,7 +1233,8 @@ static bool is_pageblock_removable_nolock(struct page *page)
 bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct page *page = pfn_to_page(start_pfn);
-	struct page *end_page = page + nr_pages;
+	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
+	struct page *end_page = pfn_to_page(end_pfn);
 
 	/* Check the starting page of each pageblock within the range */
 	for (; page < end_page; page = next_active_pageblock(page)) {
-- 
2.20.1

