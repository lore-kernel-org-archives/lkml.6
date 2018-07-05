Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C284924067
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C284924067
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeGEMOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:14:00 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:55892
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753637AbeGEMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:13:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BZAQDJCj5b/7WXqnwNTxwBAQEEAQE?=
 =?us-ascii?q?KAQGEK4Eng3qVAAEBAQEBAQaBCAgilyoqhE0Cgk43FQECAQEBAQEBAoEJhUI?=
 =?us-ascii?q?BAQEBAgEjFUEFCwsOCgICJgICVwYBDAYCAQGDHAGBcgUXp1JughyEW4NugTU?=
 =?us-ascii?q?FgQuIcIEHgTYMglyDGAKEYYJVAodAIQyFIIw/CAGGBokUgUaMFyuHUII6iSu?=
 =?us-ascii?q?BdDMaCCgIgySGAIpkXZEPAQE?=
X-IPAS-Result: =?us-ascii?q?A2BZAQDJCj5b/7WXqnwNTxwBAQEEAQEKAQGEK4Eng3qVA?=
 =?us-ascii?q?AEBAQEBAQaBCAgilyoqhE0Cgk43FQECAQEBAQEBAoEJhUIBAQEBAgEjFUEFC?=
 =?us-ascii?q?wsOCgICJgICVwYBDAYCAQGDHAGBcgUXp1JughyEW4NugTUFgQuIcIEHgTYMg?=
 =?us-ascii?q?lyDGAKEYYJVAodAIQyFIIw/CAGGBokUgUaMFyuHUII6iSuBdDMaCCgIgySGA?=
 =?us-ascii?q?IpkXZEPAQE?=
X-IronPort-AV: E=Sophos;i="5.51,312,1526313600"; 
   d="scan'208";a="94869712"
Received: from 124-170-151-181.dyn.iinet.net.au (HELO [192.168.0.106]) ([124.170.151.181])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 05 Jul 2018 20:13:54 +0800
Subject: Re: [PATCH v2 0/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <4c08ad85-95f8-7001-5429-eaaf36d061de@linux-m68k.org>
Date:   Thu, 5 Jul 2018 22:13:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 04/07/18 16:28, Mike Rapoport wrote:
> These patches switch m68k boot time memory allocators from bootmem to
> memblock + no_bootmem.
> 
> The first two patches update __ffs() and __va() definitions to be inline
> with other arches and asm-generic. This is required to avoid compilation
> warnings in mm/memblock.c and mm/nobootmem.c.
> 
> The third patch performs the actual switch of the boot time mm. Its
> changelog has detailed description of the changes.
> 
> I've tested the !MMU version with qemu-system-m68k -M mcf5208evb
> and the MMU version with q800 using qemu from [1].
> 
> I've also build tested allyesconfig and *_defconfig.
> 
> [1] https://github.com/vivier/qemu-m68k.git
> 
> v2:
> * fix reservation of the kernel text/data/bss for ColdFire MMU

I am happy with all of these, so for me:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> Mike Rapoport (3):
>    m68k/bitops: convert __ffs to match generic declaration
>    m68k/page_no.h: force __va argument to be unsigned long
>    m68k: switch to MEMBLOCK + NO_BOOTMEM
> 
>   arch/m68k/Kconfig               |  3 +++
>   arch/m68k/include/asm/bitops.h  |  8 ++++++--
>   arch/m68k/include/asm/page_no.h |  2 +-
>   arch/m68k/kernel/setup_mm.c     | 14 ++++----------
>   arch/m68k/kernel/setup_no.c     | 20 ++++----------------
>   arch/m68k/mm/init.c             |  1 -
>   arch/m68k/mm/mcfmmu.c           | 13 +++++++------
>   arch/m68k/mm/motorola.c         | 35 +++++++++++------------------------
>   arch/m68k/sun3/config.c         |  4 ----
>   9 files changed, 36 insertions(+), 64 deletions(-)
> 
