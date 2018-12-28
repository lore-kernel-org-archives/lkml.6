Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EBDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8736214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbeL1Dju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:39:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeL1Djt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:39:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8322A168F;
        Fri, 28 Dec 2018 03:39:48 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C831E5D781;
        Fri, 28 Dec 2018 03:39:42 +0000 (UTC)
Date:   Fri, 28 Dec 2018 11:39:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/2] mm/memblock: reuse memblock bottom-up allocation
 style
Message-ID: <20181228033940.GB1990@MiWiFi-R3L-srv>
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 28 Dec 2018 03:39:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 at 11:00am, Pingfan Liu wrote:
> The bottom-up allocation style is introduced to cope with movable_node,
> where the limit inferior of allocation starts from kernel's end, due to
> lack of knowledge of memory hotplug info at this early time.
> Beside this original aim, 'kexec -c' prefers to reuse this style to alloc mem

Wondering what is 'kexec -c'.

> at lower address, since if the reserved region is beyond 4G, then it requires
> extra mem (default is 16M) for swiotlb. But at this time hotplug info has been

The default is 256M, not sure if we are talking about the same thing.

low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);

> got, the limit inferior can be extend to 0, which is done by this series
> 
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Daniel Vacek <neelx@redhat.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> Cc: linux-kernel@vger.kernel.org
> 
> Pingfan Liu (2):
>   mm/memblock: extend the limit inferior of bottom-up after parsing
>     hotplug attr
>   x86/kdump: bugfix, make the behavior of crashkernel=X consistent with
>     kaslr
> 
>  arch/x86/kernel/setup.c  |  9 +++++---
>  drivers/acpi/numa.c      |  4 ++++
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 58 +++++++++++++++++++++++++++++-------------------
>  4 files changed, 46 insertions(+), 26 deletions(-)
> 
> -- 
> 2.7.4
> 
