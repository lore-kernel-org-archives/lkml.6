Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeCUWX0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:23:26 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44116 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeCUWXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:23:25 -0400
X-Google-Smtp-Source: AG47ELsLiQDbXYIOYXshAXEIjxC4Mh29KklAw/evyQ3lsvSmEpKJm2ceAOBlBn3KIFzmk+LU11VfEg==
Date: Wed, 21 Mar 2018 15:23:57 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: mm/hmm: a simple question regarding devm_request_mem_region()
Message-ID: <20180321222357.GA31089@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jerome,

I started to looking at the mm/hmm code and having a question at the
devm_request_mem_region() call in the hmm_devmem_add() implementation:

>	addr = min((unsigned long)iomem_resource.end,
>		   (1UL << MAX_PHYSMEM_BITS) - 1);

The main question is here as I am a bit confused by this addr. The code
is trying to get an addr from the end of memory space. However, I have
tried on an ARM64 platform where ioport_resource.end is -1, so it takes
"(1UL << MAX_PHYSMEM_BITS) - 1" as the addr base, while this addr is way
beyond the actual main memory size that's available on my board. Is HMM
supposed to get an memory region like this? Would it be possible for you
to give some hint to help me understand it?

>	addr = addr - size + 1UL;
>
>	/*
>	 * FIXME add a new helper to quickly walk resource tree and find free
>	 * range
>	 *
>	 * FIXME what about ioport_resource resource ?
>	 */
>	for (; addr > size && addr >= iomem_resource.start; addr -= size) {
>		ret = region_intersects(addr, size, 0, IORES_DESC_NONE);
>		if (ret != REGION_DISJOINT)
>			continue;
>
>		devmem->resource = devm_request_mem_region(device, addr, size,

Thanks
Nicolin
