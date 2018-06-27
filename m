Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3DCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF2A256C4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF2A256C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeF0Xjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:39:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752210AbeF0Xjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:39:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D4A1BF566;
        Wed, 27 Jun 2018 23:39:41 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6F32156880;
        Wed, 27 Jun 2018 23:39:39 +0000 (UTC)
Date:   Thu, 28 Jun 2018 07:39:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 0/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-ID: <20180627233936.GE8970@localhost.localdomain>
References: <20180627013116.12411-1-bhe@redhat.com>
 <CAGM2reYKn80fn8Nb_AT4ybVih4c7cd8+U1nDfJ-C0fwM+DB4jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYKn80fn8Nb_AT4ybVih4c7cd8+U1nDfJ-C0fwM+DB4jw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 23:39:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 23:39:41 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 06/27/18 at 01:47pm, Pavel Tatashin wrote:
> This work made me think why do we even have
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER ? This really should be the
> default behavior for all systems. Yet, it is enabled only on x86_64.
> We could clean up an already messy sparse.c if we removed this config,
> and enabled its path for all arches. We would not break anything
> because if we cannot allocate one large mmap_map we still fallback to
> allocating a page at a time the same as what happens when
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=n.

Thanks for your idea.

Seems the common ARCHes all have ARCH_SPARSEMEM_ENABLE, such as x86,
arm/64, power, s390, mips, others don't have. For them, removing
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER makes sense. 

I will make a clean up patch to do this, but I can only test it on x86.
If test robot or other issues report issue on this clean up patch,
Andrew can help only pick the current 4 patches after updating, then
we can continue discussing the clean up patch. From the current code, it
should be OK to all ARCHes.

Thanks
Baoquan
