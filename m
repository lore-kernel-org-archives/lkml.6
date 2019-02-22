Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD8D20684
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfBVA2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:28:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfBVA2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 349273002DA2;
        Fri, 22 Feb 2019 00:28:01 +0000 (UTC)
Received: from redhat.com (ovpn-120-13.rdu2.redhat.com [10.10.120.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D28760139;
        Fri, 22 Feb 2019 00:27:58 +0000 (UTC)
Date:   Thu, 21 Feb 2019 19:27:55 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Adam Manzanares <Adam.Manzanares@wdc.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "cl@linux.com" <cl@linux.com>, "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jack@suse.cz" <jack@suse.cz>
Subject: Re: [LSF/MM TOPIC] Page Cache Flexibility for NVM
Message-ID: <20190222002754.GA10607@redhat.com>
References: <85ddda85755bf15ed2e56bce21f711ae8154d304.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85ddda85755bf15ed2e56bce21f711ae8154d304.camel@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 22 Feb 2019 00:28:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:11:51PM +0000, Adam Manzanares wrote:
> Hello,
> 
> I would like to attend the LSF/MM Summit 2019. I'm interested in
> several MM topics that are mentioned below as well as Zoned Block
> Devices and any io determinism topics that come up in the storage
> track. 
> 
> I have been working on a caching layer, hmmap (heterogeneous memory
> map) [1], for emerging NVM and it is in spirit close to the page
> cache. The key difference being that the backend device and caching
> layer of hmmap is pluggable. In addition, hmmap supports DAX and write
> protection, which I believe are key features for emerging NVMs that may
> have write/read asymmetry as well as write endurance constraints.
> Lastly we can leverage hardware, such as a DMA engine, when moving
> pages between the cache while also allowing direct access if the device
> is capable.
> 
> I am proposing that as an alternative to using NVMs as a NUMA node
> we expose the NVM through the page cache or a viable alternative and
> have userspace applications mmap the NVM and hand out memory with
> their favorite userspace memory allocator.
> 
> This would isolate the NVMs to only applications that are well aware
> of the performance implications of accessing NVM. I believe that all
> of this work could be solved with the NUMA node approach, but the two
> approaches are seeming to blur together.
> 
> The main points I would like to discuss are:
> 
> * Is the page cache model a viable alternative to NVM as a NUMA NODE?
> * Can we add more flexibility to the page cache?
> * Should we force separation of NVM through an explicit mmap?
> 
> I believe this discussion could be merged with NUMA, memory hierarchy
> and device memory, Use NVDIMM as NUMA node and NUMA API, or memory
> reclaim with NUMA balancing.

What about cache coherency and atomic ? If device block are expose
through PCIE then there is no cache coherency or atomic and thus
direct mmap will not have the expected memory model which would
break program expectation of a mmap.

This is also one of the reasons i do not see a way forward with NUMA
and device memory. It can depart from the usual memory too much to
be drop in like that to unaware application.

In any case yes this kind of memory falls into the device memory i
wish to discuss during LSF/MM.

Cheers,
Jérôme
