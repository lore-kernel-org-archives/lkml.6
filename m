Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7FEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267382150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267382150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeI0PoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbeI0PoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 939AAA6E04;
        Thu, 27 Sep 2018 09:26:43 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-205.ams2.redhat.com [10.36.116.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8C62015AD1;
        Thu, 27 Sep 2018 09:26:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 6/6] memory-hotplug.txt: Add some details about locking internals
Date:   Thu, 27 Sep 2018 11:25:54 +0200
Message-Id: <20180927092554.13567-7-david@redhat.com>
In-Reply-To: <20180927092554.13567-1-david@redhat.com>
References: <20180927092554.13567-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 27 Sep 2018 09:26:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's document the magic a bit, especially why device_hotplug_lock is
required when adding/removing memory and how it all play together with
requests to online/offline memory from user space.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/memory-hotplug.txt | 42 +++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-hotplug.txt b/Documentation/memory-hotplug.txt
index 7f49ebf3ddb2..ce4faa5530fa 100644
--- a/Documentation/memory-hotplug.txt
+++ b/Documentation/memory-hotplug.txt
@@ -3,7 +3,7 @@ Memory Hotplug
 ==============
 
 :Created:							Jul 28 2007
-:Updated: Add description of notifier of memory hotplug:	Oct 11 2007
+:Updated: Add some details about locking internals:		Aug 20 2018
 
 This document is about memory hotplug including how-to-use and current status.
 Because Memory Hotplug is still under development, contents of this text will
@@ -495,6 +495,46 @@ further processing of the notification queue.
 
 NOTIFY_STOP stops further processing of the notification queue.
 
+
+Locking Internals
+=================
+
+When adding/removing memory that uses memory block devices (i.e. ordinary RAM),
+the device_hotplug_lock should be held to:
+
+- synchronize against online/offline requests (e.g. via sysfs). This way, memory
+  block devices can only be accessed (.online/.state attributes) by user
+  space once memory has been fully added. And when removing memory, we
+  know nobody is in critical sections.
+- synchronize against CPU hotplug and similar (e.g. relevant for ACPI and PPC)
+
+Especially, there is a possible lock inversion that is avoided using
+device_hotplug_lock when adding memory and user space tries to online that
+memory faster than expected:
+
+- device_online() will first take the device_lock(), followed by
+  mem_hotplug_lock
+- add_memory_resource() will first take the mem_hotplug_lock, followed by
+  the device_lock() (while creating the devices, during bus_add_device()).
+
+As the device is visible to user space before taking the device_lock(), this
+can result in a lock inversion.
+
+onlining/offlining of memory should be done via device_online()/
+device_offline() - to make sure it is properly synchronized to actions
+via sysfs. Holding device_hotplug_lock is advised (to e.g. protect online_type)
+
+When adding/removing/onlining/offlining memory or adding/removing
+heterogeneous/device memory, we should always hold the mem_hotplug_lock in
+write mode to serialise memory hotplug (e.g. access to global/zone
+variables).
+
+In addition, mem_hotplug_lock (in contrast to device_hotplug_lock) in read
+mode allows for a quite efficient get_online_mems/put_online_mems
+implementation, so code accessing memory can protect from that memory
+vanishing.
+
+
 Future Work
 ===========
 
-- 
2.17.1

