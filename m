Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD87C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C6F2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C6F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJHVIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:08:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36463 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:08:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so20957438wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 06:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pyG2nYglB1R6f1kCXFes4f1lgq7wvtusAVuOwgShGjk=;
        b=n/GQnny+j4rMUmlSP4mXGy1VugOfrn7Mn8d3m0KTxdD7+YE0+IU0dG+CQQXA9fe+lT
         raut9FvvxDQSyrBC4wM5/wT1hRVLVi+PrQ5FqFbYJ/sMbUaaoJk8dF+xEZMk1lQ4GVaf
         wXFqz5ZBooDTRqni6Q6KX4a/uLCWCrGQXMAcZnM1gKC5vsF5BbBC7MYJtt3D3j9lrW3F
         9gIeFDF9nXYwRB6NHUTfQ62K1mz7bf5ddgYBbheAbCZwDRj29nZWbMr9maeyA/VZaekb
         01Fv/4fZJBvh+keUydNzwOCGa3dq/MjNyQ2VnyrvqJjXvz4e/3eMZbfLubOq1izV6YUk
         T6Hw==
X-Gm-Message-State: ABuFfohDjMim2jzsPyFsCy84zCRsvr74hCbOz3gBRPTkkxAJRorl8MnZ
        +KGjIfXbQ4jyrnrndBOxMEE=
X-Google-Smtp-Source: ACcGV60kgeEa4kL2CzCkljYp1hTwjdFQRVzksOF0MgdCWxArROgLRBBEHrq9NAldJcRe4MERYaQIBg==
X-Received: by 2002:adf:a781:: with SMTP id j1-v6mr13998501wrc.277.1539006990944;
        Mon, 08 Oct 2018 06:56:30 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j6-v6sm11294802wru.20.2018.10.08.06.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 06:56:30 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 6EBD1124BAA; Mon,  8 Oct 2018 15:56:29 +0200 (CEST)
Date:   Mon, 8 Oct 2018 15:56:29 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com
Subject: Re: [RFC PATCH v3 0/5] Do not touch pages/zones during hot-remove
 path
Message-ID: <20181008135629.GA10959@techadventures.net>
References: <20181002150029.23461-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002150029.23461-1-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 05:00:24PM +0200, Oscar Salvador wrote:
> Oscar Salvador (5):
>   mm/memory_hotplug: Add nid parameter to arch_remove_memory
>   mm/memory_hotplug: Create add/del_device_memory functions
>   mm/memory_hotplug: Check for IORESOURCE_SYSRAM in
>     release_mem_region_adjustable
>   mm/memory_hotplug: Move zone/pages handling to offline stage
>   mm/memory-hotplug: Rework unregister_mem_sect_under_nodes
> 
>  arch/ia64/mm/init.c            |   6 +-
>  arch/powerpc/mm/mem.c          |  13 +---
>  arch/s390/mm/init.c            |   2 +-
>  arch/sh/mm/init.c              |   6 +-
>  arch/x86/mm/init_32.c          |   6 +-
>  arch/x86/mm/init_64.c          |  10 +--
>  drivers/base/memory.c          |   9 ++-
>  drivers/base/node.c            |  38 ++--------
>  include/linux/memory.h         |   2 +-
>  include/linux/memory_hotplug.h |  17 +++--
>  include/linux/node.h           |   7 +-
>  kernel/memremap.c              |  50 +++++---------
>  kernel/resource.c              |  15 ++++
>  mm/memory_hotplug.c            | 153 ++++++++++++++++++++++++++---------------
>  mm/sparse.c                    |   4 +-
>  15 files changed, 169 insertions(+), 169 deletions(-)
> 
> -- 
> 2.13.6

If there are no further comments, I will send this as a patchset without RFC
later this week.
Since [1] already landed in mmotm, I will pull out the dependency for [2], and
change both devm/HMM code.

[1] https://patchwork.kernel.org/cover/10617699/
[2] https://patchwork.kernel.org/cover/10613425/

Thanks
-- 
Oscar Salvador
SUSE L3
