Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BADC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5682175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5682175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeKOHWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:22:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOHWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:22:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 090A193898;
        Wed, 14 Nov 2018 21:17:21 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-99.ams2.redhat.com [10.36.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E8385F72B;
        Wed, 14 Nov 2018 21:17:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian Hansen <chansen3@cisco.com>,
        Dave Young <dyoung@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>,
        Kairui Song <kasong@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Omar Sandoval <osandov@fb.com>, Pavel Machek <pavel@ucw.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are logically offline
Date:   Wed, 14 Nov 2018 22:16:58 +0100
Message-Id: <20181114211704.6381-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 14 Nov 2018 21:17:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, pages inflated as part of a balloon driver will be dumped
by dump tools like makedumpfile. While XEN is able to check in the
crash kernel whether a certain pfn is actuall backed by memory in the
hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
virtio-balloon and hv-balloon inflated memory will essentially result in
zero pages getting allocated by the hypervisor and the dump getting
filled with this data.

The allocation and reading of zero pages can directly be avoided if a
dumping tool could know which pages only contain stale information not to
be dumped.

Also for XEN, calling into the kernel and asking the hypervisor if a
pfn is backed can be avoided if the duming tool would skip such pages
right from the beginning.

Dumping tools have no idea whether a given page is part of a balloon driver
and shall not be dumped. Esp. PG_reserved cannot be used for that purpose
as all memory allocated during early boot is also PG_reserved, see
discussion at [1]. So some other way of indication is required and a new
page flag is frowned upon.

We have PG_balloon (MAPCOUNT value), which is essentially unused now. I
suggest renaming it to something more generic (PG_offline) to mark pages as
logically offline. This flag can than e.g. also be used by virtio-mem in
the future to mark subsections as offline. Or by other code that wants to
put pages logically offline (e.g. later maybe poisoned pages that shall
no longer be used).

This series converts PG_balloon to PG_offline, allows dumping tools to
query the value to detect such pages and marks pages in the hv-balloon
and XEN balloon properly as PG_offline. Note that virtio-balloon already
set pages to PG_balloon (and now PG_offline).

Please note that this is also helpful for a problem we were seeing under
Hyper-V: Dumping logically offline memory (pages kept fake offline while
onlining a section via online_page_callback) would under some condicions
result in a kernel panic when dumping them.

As I don't have access to neither XEN nor Hyper-V installation, this was
not tested yet (and a makedumpfile change will be required to skip
dumping these pages).

[1] https://lkml.org/lkml/2018/7/20/566

David Hildenbrand (6):
  mm: balloon: update comment about isolation/migration/compaction
  mm: convert PG_balloon to PG_offline
  kexec: export PG_offline to VMCOREINFO
  xen/balloon: mark inflated pages PG_offline
  hv_balloon: mark inflated pages PG_offline
  PM / Hibernate: exclude all PageOffline() pages

 Documentation/admin-guide/mm/pagemap.rst |  6 +++++
 drivers/hv/hv_balloon.c                  | 14 ++++++++--
 drivers/xen/balloon.c                    |  3 +++
 fs/proc/page.c                           |  4 +--
 include/linux/balloon_compaction.h       | 34 +++++++++---------------
 include/linux/page-flags.h               | 11 +++++---
 include/uapi/linux/kernel-page-flags.h   |  1 +
 kernel/crash_core.c                      |  2 ++
 kernel/power/snapshot.c                  |  5 +++-
 tools/vm/page-types.c                    |  1 +
 10 files changed, 51 insertions(+), 30 deletions(-)

-- 
2.17.2

