Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C5FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896CF2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfAHKGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:06:41 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7407 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728209AbfAHKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:06:40 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="51550536"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Jan 2019 18:06:38 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 641B74BAC81A;
        Tue,  8 Jan 2019 18:06:38 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 8 Jan 2019 18:06:44 +0800
Date:   Tue, 8 Jan 2019 18:05:42 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <x86@kernel.org>, <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by
 pushing forward the parsing of mem hotplug info
Message-ID: <20190108100542.GA2216@localhost.localdomain>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 641B74BAC81A.ADC45
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:24:41PM +0800, Pingfan Liu wrote:
>Background about the defect of the current bottom-up allocation style, take
>the following scenario:
>  |  unmovable node |     movable node                           |
>     | kaslr-kernel |subtree of pgtable for phy<->virt |
>
>Although kaslr-kernel can avoid to stain the movable node. But the
>pgtable can still stain the movable node. That is a probability problem,
>with low probability, but still exist. This patch tries to eliminate the
>probability. With the previous patch, at the point of init_mem_mapping(),
>memblock allocator can work with the knowledge of acpi memory hotmovable
>info, and avoid to stain the movable node. As a result,
>memory_map_bottom_up() is not needed any more.
>

Hi Pingfan,

Tang Chen ever tried to do this before adding 'movable_node':
commit e8d1955258091e4c92d5a975ebd7fd8a98f5d30f
Author: Tang Chen <tangchen@cn.fujitsu.com>
Date:   Fri Feb 22 16:33:44 2013 -0800

    acpi, memory-hotplug: parse SRAT before memblock is ready

Then, Lu Yinghai tried to do the similar job, you can see:
https://lwn.net/Articles/554854/
for more information. Hope that can help you.

Thanks,
Chao Fan

>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: "H. Peter Anvin" <hpa@zytor.com>
>Cc: Dave Hansen <dave.hansen@linux.intel.com>
>Cc: Andy Lutomirski <luto@kernel.org>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>Cc: Len Brown <lenb@kernel.org>
>Cc: linux-kernel@vger.kernel.org
>
>Pingfan Liu (4):
>  acpi: change the topo of acpi_table_upgrade()
>  x86/setup: parse acpi to get hotplug info before init_mem_mapping()
>  x86/mm: set allowed range for memblock allocator
>  x86/mm: remove bottom-up allocation style for x86_64
>
> arch/arm64/kernel/setup.c |   2 +-
> arch/x86/kernel/setup.c   |  17 ++++-
> arch/x86/mm/init.c        | 154 +++++++---------------------------------------
> arch/x86/mm/init_32.c     | 123 ++++++++++++++++++++++++++++++++++++
> arch/x86/mm/mm_internal.h |   7 +++
> drivers/acpi/tables.c     |   4 +-
> include/linux/acpi.h      |   5 +-
> 7 files changed, 172 insertions(+), 140 deletions(-)
>
>-- 
>2.7.4
>
>
>


