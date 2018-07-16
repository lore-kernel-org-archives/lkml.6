Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BA5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75466208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75466208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeGPHGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:06:31 -0400
Received: from ozlabs.org ([203.11.71.1]:49615 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeGPHGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:06:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TYh51l4gz9ryt;
        Mon, 16 Jul 2018 16:40:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        osalvador@techadventures.net
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com
Subject: Re: [PATCH v5 0/5] sparse_init rewrite
In-Reply-To: <CAGM2reavPdp48_=cw1g3Jmz2+ZLU9DkOQbdwAu17v39OCkjVPg@mail.gmail.com>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com> <20180713095934.GB15039@techadventures.net> <CAGM2reavPdp48_=cw1g3Jmz2+ZLU9DkOQbdwAu17v39OCkjVPg@mail.gmail.com>
Date:   Mon, 16 Jul 2018 16:40:34 +1000
Message-ID: <87bmb7znrx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Tatashin <pasha.tatashin@oracle.com> writes:

>> About PPC64, your patchset fixes the issue as the population gets followed by a
>> sparse_init_one_section().
>>
>> It can be seen here:
>>
>> Before:
>>
>> kernel: vmemmap_populate f000000000000000..f000000000004000, node 0
>> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
>> kernel: vmemmap_populate f000000000000000..f000000000008000, node 0
>> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
>> kernel: vmemmap_populate f000000000000000..f00000000000c000, node 0
>> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
>>
>>
>> After:
>>
>> kernel: vmemmap_populate f000000000000000..f000000000004000, node 0
>> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
>> kernel: vmemmap_populate f000000000000000..f000000000008000, node 0
>> kernel: vmemmap_populate f000000000000000..f00000000000c000, node 0
>> kernel: vmemmap_populate f000000000000000..f000000000010000, node 0
>> kernel: vmemmap_populate f000000000010000..f000000000014000, node 0
>> kernel:       * f000000000010000..f000000000020000 allocated at (____ptrval____)
>>
>>
>> As can be seen, before the patchset, we keep calling vmemmap_create_mapping() even if we
>> populated that section already, because of vmemmap_populated() checking for SECTION_HAS_MEM_MAP.
>>
>> After the patchset, since each population is being followed by a call to sparse_init_one_section(),
>> when vmemmap_populated() gets called, we have SECTION_HAS_MEM_MAP already in case the section
>> was populated.
>
> Hi Oscar,
>
> Right, I also like that this solution removes one extra loop, thus
> reduces the code size. We were populating pages in one place, and then
> loop again to set sections, now we do both in one place, but still
> allow preallocation of memory to reduces fragmentation on all
> platforms. However, I still wanted to see if someone could test on
> real hardware.

I booted it on a small VM and a 160 CPU 4 node machine, both booted
fine.

If you want:
  Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


Thanks for fixing it up for us.

cheers
