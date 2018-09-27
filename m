Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF95ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A022150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A022150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeI0Pn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:43:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbeI0Pn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:43:26 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A8BE30820D8;
        Thu, 27 Sep 2018 09:26:04 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-205.ams2.redhat.com [10.36.116.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D57820154E7;
        Thu, 27 Sep 2018 09:25:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <lenb@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: [PATCH v3 0/6] mm: online/offline_pages called w.o. mem_hotplug_lock
Date:   Thu, 27 Sep 2018 11:25:48 +0200
Message-Id: <20180927092554.13567-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 27 Sep 2018 09:26:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andrew, Only patch #5 changed (see change notes below). Thanks!


Reading through the code and studying how mem_hotplug_lock is to be used,
I noticed that there are two places where we can end up calling
device_online()/device_offline() - online_pages()/offline_pages() without
the mem_hotplug_lock. And there are other places where we call
device_online()/device_offline() without the device_hotplug_lock.

While e.g.
	echo "online" > /sys/devices/system/memory/memory9/state
is fine, e.g.
	echo 1 > /sys/devices/system/memory/memory9/online
Will not take the mem_hotplug_lock. However the device_lock() and
device_hotplug_lock.

E.g. via memory_probe_store(), we can end up calling
add_memory()->online_pages() without the device_hotplug_lock. So we can
have concurrent callers in online_pages(). We e.g. touch in online_pages()
basically unprotected zone->present_pages then.

Looks like there is a longer history to that (see Patch #2 for details),
and fixing it to work the way it was intended is not really possible. We
would e.g. have to take the mem_hotplug_lock in device/base/core.c, which
sounds wrong.

Summary: We had a lock inversion on mem_hotplug_lock and device_lock().
More details can be found in patch 3 and patch 6.

I propose the general rules (documentation added in patch 6):

1. add_memory/add_memory_resource() must only be called with
   device_hotplug_lock.
2. remove_memory() must only be called with device_hotplug_lock. This is
   already documented and holds for all callers.
3. device_online()/device_offline() must only be called with
   device_hotplug_lock. This is already documented and true for now in core
   code. Other callers (related to memory hotplug) have to be fixed up.
4. mem_hotplug_lock is taken inside of add_memory/remove_memory/
   online_pages/offline_pages.

To me, this looks way cleaner than what we have right now (and easier to
verify). And looking at the documentation of remove_memory, using
lock_device_hotplug also for add_memory() feels natural.


v2 -> v3:
- Take device_hotplug_lock outside of loop in patch #5
- Added Ack to patch #5

v1 -> v2:
- Upstream changes in powerpc/powernv code required modifications to
  patch #1, #4 and #5.
- Minor patch description changes.
- Added more locking details in patch #6.
- Added rb's

RFCv2 -> v1:
- Dropped an unnecessary _ref from remove_memory() in patch #1
- Minor patch description fixes.
- Added rb's

RFC -> RFCv2:
- Don't export device_hotplug_lock, provide proper remove_memory/add_memory
  wrappers.
- Split up the patches a bit.
- Try to improve powernv memtrace locking
- Add some documentation for locking that matches my knowledg

David Hildenbrand (6):
  mm/memory_hotplug: make remove_memory() take the device_hotplug_lock
  mm/memory_hotplug: make add_memory() take the device_hotplug_lock
  mm/memory_hotplug: fix online/offline_pages called w.o.
    mem_hotplug_lock
  powerpc/powernv: hold device_hotplug_lock when calling device_online()
  powerpc/powernv: hold device_hotplug_lock when calling
    memtrace_offline_pages()
  memory-hotplug.txt: Add some details about locking internals

 Documentation/memory-hotplug.txt              | 42 ++++++++++++-
 arch/powerpc/platforms/powernv/memtrace.c     |  8 ++-
 .../platforms/pseries/hotplug-memory.c        |  8 +--
 drivers/acpi/acpi_memhotplug.c                |  4 +-
 drivers/base/memory.c                         | 22 +++----
 drivers/xen/balloon.c                         |  3 +
 include/linux/memory_hotplug.h                |  4 +-
 mm/memory_hotplug.c                           | 59 +++++++++++++++----
 8 files changed, 114 insertions(+), 36 deletions(-)

-- 
2.17.1

