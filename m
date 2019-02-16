Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A32C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB385222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfBPOAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:00:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPOAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:00:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F15051244DF;
        Sat, 16 Feb 2019 14:00:53 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 825BC614C4;
        Sat, 16 Feb 2019 14:00:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, travis@sgi.com, thgarnie@google.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/6] Several patches to fix code bugs, improve documents and clean up
Date:   Sat, 16 Feb 2019 22:00:02 +0800
Message-Id: <20190216140008.28671-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 16 Feb 2019 14:00:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v2 post was here:
https://lkml.org/lkml/2018/9/9/56

During the v2 patch reviewing, Ingo suggested to:
 (1) improve the document in Documentation/x86/x86_64/mm.txt;
 (2) improve the documents about struct kaslr_memory_region;
 (3) open code unnecessary function get_padding();
 (4) improve the memory region randomization to be at 2M granularity;

*** Part (1)
has been done with below commits currently: 
d52888aa2753 x86/mm: Move LDT remap out of KASLR region on 5-level paging
32b89760ddf4 x86/mm/doc: Enhance the x86-64 virtual memory layout descriptions
5b1290406579 x86/mm/doc: Clean up the x86-64 virtual memory layout descriptions

*** Part (4)
has been investigated, the code change can be found here:
https://github.com/baoquan-he/linux/commits/mm-kaslr-2m-aligned

From test resut and Table 4-15 of Intel manual, changing the memory
randomization to be at 2M granularity is not doable.

  Table 4-15. Format of an IA-32e Page-Directory-Pointer-Table Entry (PDPTE) that Maps a 1-GByte Page

The current memory region KASLR is at 1 GB granularity, PUD aligned.
When I tested above patches on kvm guest, system work well with 1 GB
memory deployed. With 4 GB, KVM guest can't boot up. Finally I read
Intel CPU manual and found it's because the 1 GB page mapping need be
mapped at 1 GB aglined physical address. While the 2M granularity
randomization will break that and causes boot failure.

But we stil can improve the granularity in 5-level paging mode from 512
GB to 1 GB, this will be posted soon.

*** This patchset
includes the original three code bug fix patches in v2, and two new
patches to improve code comments about kaslr_memory_region and open
code unnecessary function get_padding(), meanwhile carry the known
SGI UV bug fix.

Note:
SGI UV bug fix is not tested yet, the idea was approved by SGI UV expert
Mike Travis, and the old post as below was tested and has been merged
into our RHEL distros. This new change doesn't change the way to
calculate the size of the direct mapping section, but only wrap the
calculation code into a new function calc_direct_mapping_size()
according to Ingo's suggestion.
https://lkml.org/lkml/2017/5/18/102


Baoquan He (6):
  x86/mm/KASLR: Improve code comments about struct kaslr_memory_region
  x86/mm/KASLR: Open code unnecessary function get_padding
  mm: Add build time sanity check for struct page size
  x86/mm/KASLR: Fix the wrong calculation of memory region initial size
  x86/mm/KASLR: Calculate the actual size of vmemmap region
  x86/mm/KASLR: Do not adapt the size of the direct mapping section for
    SGI UV system

 arch/x86/mm/kaslr.c | 131 +++++++++++++++++++++++++++++++++++---------
 mm/page_alloc.c     |   2 +
 2 files changed, 107 insertions(+), 26 deletions(-)

-- 
2.17.2

