Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317A8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E639D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E639D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeIRRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeIRRVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5749286669;
        Tue, 18 Sep 2018 11:49:04 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-248.ams2.redhat.com [10.36.116.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 082DA5C1B2;
        Tue, 18 Sep 2018 11:48:58 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Michael Neuling <mikey@neuling.org>
Subject: [PATCH v1 5/6] powerpc/powernv: hold device_hotplug_lock in memtrace_offline_pages()
Date:   Tue, 18 Sep 2018 13:48:21 +0200
Message-Id: <20180918114822.21926-6-david@redhat.com>
In-Reply-To: <20180918114822.21926-1-david@redhat.com>
References: <20180918114822.21926-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 18 Sep 2018 11:49:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's perform all checking + offlining + removing under
device_hotplug_lock, so nobody can mess with these devices via
sysfs concurrently.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index ef7181d4fe68..473e59842ec5 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -74,9 +74,13 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
 {
 	u64 end_pfn = start_pfn + nr_pages - 1;
 
+	lock_device_hotplug();
+
 	if (walk_memory_range(start_pfn, end_pfn, NULL,
-	    check_memblock_online))
+	    check_memblock_online)) {
+		unlock_device_hotplug();
 		return false;
+	}
 
 	walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
 			  change_memblock_state);
@@ -84,14 +88,16 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
 	if (offline_pages(start_pfn, nr_pages)) {
 		walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
 				  change_memblock_state);
+		unlock_device_hotplug();
 		return false;
 	}
 
 	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
 			  change_memblock_state);
 
-	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
+	__remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
 
+	unlock_device_hotplug();
 	return true;
 }
 
-- 
2.17.1

