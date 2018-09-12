Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDF9C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644B120882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644B120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeILTPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:15:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbeILTPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:15:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71AC4AEF2;
        Wed, 12 Sep 2018 14:10:55 +0000 (UTC)
Date:   Wed, 12 Sep 2018 16:10:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pavel.tatashin@microsoft.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
Message-ID: <20180912141053.GL10951@dhcp22.suse.cz>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234341.4068.26882.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910234341.4068.26882.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-09-18 16:43:41, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> On systems with a large amount of memory it can take a significant amount
> of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> value. I have seen it take over 2 minutes to initialize a system with
> over 12GB of RAM.
> 
> In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
> the boot time returned to something much more reasonable as the
> arch_add_memory call completed in milliseconds versus seconds. However in
> doing that I had to disable all of the other VM debugging on the system.
> 
> In order to work around a kernel that might have CONFIG_DEBUG_VM enabled on
> a system that has a large amount of memory I have added a new kernel
> parameter named "page_init_poison" that can be set to "off" in order to
> disable it.

I am still not convinced that this all is worth the additional code. It
is much better than a new config option for sure. If we really want this
though then I suggest that the parameter handler should note the
disabled state (when CONFIG_DEBUG_VM is on) to the kernel log. I would
also make it explicit who might want to do that in the parameter
description.

> +	page_init_poison=	[KNL] Boot-time parameter changing the
> +			state of poisoning of page structures during early
> +			boot. Used to verify page metadata is not accessed
> +			prior to initialization. Available with
> +			CONFIG_DEBUG_VM=y.
> +			off: turn off poisoning
> +			on: turn on poisoning (default)
> +

what about the following wording or something along those lines

Boot-time parameter to control struct page poisoning which is a
debugging feature to catch unitialized struct page access. This option
is available only for CONFIG_DEBUG_VM=y and it affects boot time
(especially on large systems). If there are no poisoning bugs reported
on the particular system and workload it should be safe to disable it to
speed up the boot time.
-- 
Michal Hocko
SUSE Labs
