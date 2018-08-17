Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BBDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E0921878
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E0921878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeHQLBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:01:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeHQLBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DB2F819703B;
        Fri, 17 Aug 2018 07:59:13 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-9.ams2.redhat.com [10.36.117.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C54C10D18C9;
        Fri, 17 Aug 2018 07:59:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, devel@linuxdriverproject.org,
        linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH RFC 1/2] drivers/base: export lock_device_hotplug/unlock_device_hotplug
Date:   Fri, 17 Aug 2018 09:59:00 +0200
Message-Id: <20180817075901.4608-2-david@redhat.com>
In-Reply-To: <20180817075901.4608-1-david@redhat.com>
References: <20180817075901.4608-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 17 Aug 2018 07:59:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 17 Aug 2018 07:59:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Well require to call add_memory()/add_memory_resource() with
device_hotplug_lock held, to avoid a lock inversion. Allow external modules
(e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
lock device hotplug.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
[modify patch description]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..9010b9e942b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -700,11 +700,13 @@ void lock_device_hotplug(void)
 {
 	mutex_lock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lock_device_hotplug);
 
 void unlock_device_hotplug(void)
 {
 	mutex_unlock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(unlock_device_hotplug);
 
 int lock_device_hotplug_sysfs(void)
 {
-- 
2.17.1

