Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD99C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A626B23ED7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626B23ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeGCMX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:23:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753134AbeGCMX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:23:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE239AD09;
        Tue,  3 Jul 2018 12:23:25 +0000 (UTC)
Date:   Tue, 3 Jul 2018 14:23:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] docs/mm: add description of boot time memory
 management
Message-ID: <20180703122324.GA23824@dhcp22.suse.cz>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530370506-21751-12-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530370506-21751-12-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-06-18 17:55:06, Mike Rapoport wrote:
> Both bootmem and memblock are have pretty good internal documentation
> coverage. With addition of some overview we get a nice description of the
> early memory management.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Yes this looks reasonable. I would just mention the available debugging
options and CONFIG_ARCH_DISCARD_MEMBLOCK.

Other than that looks goot to get a rough idea. Improvements can be done
on top of course.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/core-api/boot-time-mm.rst | 92 +++++++++++++++++++++++++++++++++
>  Documentation/core-api/index.rst        |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/core-api/boot-time-mm.rst
> 
> diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
> new file mode 100644
> index 0000000..03cb164
> --- /dev/null
> +++ b/Documentation/core-api/boot-time-mm.rst
> @@ -0,0 +1,92 @@
> +===========================
> +Boot time memory management
> +===========================
> +
> +Early system initialization cannot use "normal" memory management
> +simply because it is not set up yet. But there is still need to
> +allocate memory for various data structures, for instance for the
> +physical page allocator. To address this, a specialized allocator
> +called the :ref:`Boot Memory Allocator <bootmem>`, or bootmem, was
> +introduced. Several years later PowerPC developers added a "Logical
> +Memory Blocks" allocator, which was later adopted by other
> +architectures and renamed to :ref:`memblock <memblock>`. There is also
> +a compatibility layer called `nobootmem` that translates bootmem
> +allocation interfaces to memblock calls.
> +
> +The selection of the early allocator is done using
> +``CONFIG_NO_BOOTMEM`` and ``CONFIG_HAVE_MEMBLOCK`` kernel
> +configuration options. These options are enabled or disabled
> +statically by the architectures' Kconfig files.
> +
> +* Architectures that rely only on bootmem select
> +  ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=n``.
> +* The users of memblock with the nobootmem compatibility layer set
> +  ``CONFIG_NO_BOOTMEM=y && CONFIG_HAVE_MEMBLOCK=y``.
> +* And for those that use both memblock and bootmem the configuration
> +  includes ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=y``.
> +
> +Whichever allocator is used, it is the responsibility of the
> +architecture specific initialization to set it up in
> +:c:func:`setup_arch` and tear it down in :c:func:`mem_init` functions.
> +
> +Once the early memory management is available it offers a variety of
> +functions and macros for memory allocations. The allocation request
> +may be directed to the first (and probably the only) node or to a
> +particular node in a NUMA system. There are API variants that panic
> +when an allocation fails and those that don't. And more recent and
> +advanced memblock even allows controlling its own behaviour.
> +
> +.. _bootmem:
> +
> +Bootmem
> +=======
> +
> +(mostly stolen from Mel Gorman's "Understanding the Linux Virtual
> +Memory Manager" `book`_)
> +
> +.. _book: https://www.kernel.org/doc/gorman/
> +
> +.. kernel-doc:: mm/bootmem.c
> +   :doc: bootmem overview
> +
> +.. _memblock:
> +
> +Memblock
> +========
> +
> +.. kernel-doc:: mm/memblock.c
> +   :doc: memblock overview
> +
> +
> +Functions and structures
> +========================
> +
> +Common API
> +----------
> +
> +The functions that are described in this section are available
> +regardless of what early memory manager is enabled.
> +
> +.. kernel-doc:: mm/nobootmem.c
> +
> +Bootmem specific API
> +--------------------
> +
> +These interfaces available only with bootmem, i.e when ``CONFIG_NO_BOOTMEM=n``
> +
> +.. kernel-doc:: include/linux/bootmem.h
> +.. kernel-doc:: mm/bootmem.c
> +   :nodocs:
> +
> +Memblock specific API
> +---------------------
> +
> +Here is the description of memblock data structures, functions and
> +macros. Some of them are actually internal, but since they are
> +documented it would be silly to omit them. Besides, reading the
> +descriptions for the internal functions can help to understand what
> +really happens under the hood.
> +
> +.. kernel-doc:: include/linux/memblock.h
> +.. kernel-doc:: mm/memblock.c
> +   :nodocs:
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index f5a66b7..93d5a46 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -28,6 +28,7 @@ Core utilities
>     printk-formats
>     circular-buffers
>     gfp_mask-from-fs-io
> +   boot-time-mm
>  
>  Interfaces for kernel debugging
>  ===============================
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
