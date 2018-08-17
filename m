Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD01EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A114208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A114208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHQSp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:45:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53084 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeHQSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:45:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so7937022wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rRaWYUc/JL7rh/xe14mXGjzAypZ5GcE+mqKHpK3280M=;
        b=HY63/9cQKRVvcqvbNrS60WIv6/v1Z4mpohRpzUn1SX8nTVJ3w4sffvHOHzDGlSAE9U
         RsYpti159HBvwpkFmivvixtZedY1gLZiNAZp77Hs60FIz/9fz+lpjC5YZvCObYa5z2RR
         jzLDZaKDSE8teRMH2uc30vAzoXq083sLERoPC27gP7IFlk/KPQ/Vv/xvopBfvh/nILJt
         RV1WFw2TMj3NcjQXABlT2PUjKOCsqfHe1HEzsRJ3QOkOMFs2b3ibFgYFFOaduNWbdhBh
         18zsnUWrNksW7NaUeXH2wKriY2mxhDHbqmS4dM3eIUqmnp1TkQUWCIrv+kPYCdK9g2We
         vEKg==
X-Gm-Message-State: AOUpUlGQJLadXYgXtnGeNfTquTEFlBIHzGDCMTka9PaSltXDHRJRbem8
        GQ/t4KTKNTgt5YQ42jdaQTs=
X-Google-Smtp-Source: AA+uWPxN0CBCYcg5r7zXdpVAJ/biB3a2iZ7W1CHpldg3w5oe9w0IYJ1cm/us37aF1m5/vcsSze5wiA==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr17774997wme.15.1534520495769;
        Fri, 17 Aug 2018 08:41:35 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u9-v6sm2218107wrc.43.2018.08.17.08.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 08:41:34 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id DACFB12492D;
        Fri, 17 Aug 2018 17:41:33 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        david@redhat.com, jonathan.cameron@huawei.com,
        Pavel.Tatashin@microsoft.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC v2 0/2] Do not touch pages in remove_memory path
Date:   Fri, 17 Aug 2018 17:41:25 +0200
Message-Id: <20180817154127.28602-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset moves all zone/page handling from the remove_memory
path back to the offline_pages stage.
This has be done for two reasons:

1) We can access steal pages if we remove memory that was never online [1]
2) Code consistency

Currently, when we online memory, online_pages() takes care to initialize
the pages and put the memory range into its corresponding zone.
So, zone/pgdat's spanned/present pages get resized.

But the opposite does not happen when we offline memory.
Only present pages is decremented, and we wait to shrink zone/node's
spanned_pages until we remove that memory.
But as explained above, this is wrong.

So this patchset tries to cover this by moving this handling to the place 
it should be.

The main difficulty I faced here was in regard of HMM/devm, as it really handles
the hot-add/remove memory particulary, and what is more important,
also the resources.

I really scratched my head for ideas about how to handle this case, and
after some fails I came up with the idea that we could check for the
res->flags.

Memory resources that goes through the "official" memory-hotplug channels
have the IORESOURCE_SYSTEM_RAM flag.
This flag is made of (IORESOURCE_MEM|IORESOURCE_SYSRAM).

HMM/devm, on the other hand, request and release the resources
through devm_request_mem_region/devm_release_mem_region, and 
these resources do not contain the IORESOURCE_SYSRAM flag.

So what I ended up doing is to check for IORESOURCE_SYSRAM
in release_mem_region_adjustable.
If we see that a resource does not have such a flag, we know that
we are dealing with a resource coming from HMM/devm, and so,
we do not need to do anything as HMM/dev will take care of that part.

I online compiled the code, but I did not test it (I will do next week),
but I sent this RFCv2 mainly because I would like to get feedback,
and see if the direction I took is the right one.

This time I left out [2] because I am working on this in a separate patch,
and does not really belong to this patchset.

[1] https://patchwork.kernel.org/patch/10547445/ (Reported by David)
[2] https://patchwork.kernel.org/patch/10558723/

Oscar Salvador (2):
  mm/memory_hotplug: Add nid parameter to arch_remove_memory
  mm/memory_hotplug: Shrink spanned pages when offlining memory

 arch/ia64/mm/init.c            |   6 +-
 arch/powerpc/mm/mem.c          |  12 +---
 arch/s390/mm/init.c            |   2 +-
 arch/sh/mm/init.c              |   6 +-
 arch/x86/mm/init_32.c          |   6 +-
 arch/x86/mm/init_64.c          |  10 +--
 include/linux/memory_hotplug.h |  11 +++-
 kernel/memremap.c              |  16 ++---
 kernel/resource.c              |  16 +++++
 mm/hmm.c                       |  34 +++++-----
 mm/memory_hotplug.c            | 145 ++++++++++++++++++++++++++---------------
 mm/sparse.c                    |   4 +-
 12 files changed, 157 insertions(+), 111 deletions(-)

-- 
2.13.6

