Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C870C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DE520C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DE520C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbeGKVDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726611AbeGKVDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:03:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41CA4ADA0;
        Wed, 11 Jul 2018 20:57:07 +0000 (UTC)
Date:   Wed, 11 Jul 2018 13:57:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/hugetlb: remove gigantic page support for HIGHMEM
Message-ID: <20180711205702.d4xeu552xgxjbse3@linux-r8p5>
Mail-Followup-To: Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180711195913.1294-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180711195913.1294-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Mike Kravetz wrote:

>This reverts commit ee8f248d266e ("hugetlb: add phys addr to struct
>huge_bootmem_page")
>
>At one time powerpc used this field and supporting code. However that
>was removed with commit 79cc38ded1e1 ("powerpc/mm/hugetlb: Add support
>for reserving gigantic huge pages via kernel command line").
>
>There are no users of this field and supporting code, so remove it.

Considering the title, don't you wanna also get rid of try_to_free_low()
and something like the following, which I'm sure can be done fancier, and
perhaps also thp?

diff --git a/fs/Kconfig b/fs/Kconfig
index ac474a61be37..849da70e35d6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -192,8 +192,8 @@ config TMPFS_XATTR
 
 config HUGETLBFS
        bool "HugeTLB file system support"
-       depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
-                  SYS_SUPPORTS_HUGETLBFS || BROKEN
+       depends on !HIGHMEM && (X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
+                  SYS_SUPPORTS_HUGETLBFS || BROKEN)
        help
          hugetlbfs is a filesystem backing for HugeTLB pages, based on
          ramfs. For architectures that support it, say Y here and read

Thanks,
Davidlohr
