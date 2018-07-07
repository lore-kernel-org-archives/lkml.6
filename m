Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36652C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA47322516
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA47322516
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbeGGGB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:01:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46318 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeGGGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:01:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so5946230wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 23:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zC7V3Sp6DQW9aUfDnOJxaKZIQhOmT3snXeuCyiYxGC8=;
        b=KV2l2cBmnATKwAGLs5OHjzqPye1Smb3aK1j6xLhljWel54exoAa7igtGrPYBGr5JGl
         7yU0wCZwS2ewIFcXe1nXcx+9B+ghkdFaJaC80h8XqHlphm3R6H1kgocFUAFWAOhEK1ZE
         Hwcp8YUtoHr6pahjCrlu6T3NF9EpLf0ufM2SozX1K+td/OsKCIV11KQvY04wZHOEfbuu
         7OzydGtpi/B0EpIqczGyrFPpMkkMZfN4lqQ6q6d6sMxhxB/0XdAd+T7TzBkH5CBofn8h
         DTbWNo+5ROdtG1PniL/dWy37dMnEUUK6bZNS/HZ8TjzBh0aoNJaeNS500DZuoJa6oNP0
         t3YA==
X-Gm-Message-State: APt69E3ZRrSU26ZBsoN7NLSGUxQPUC32R0w0vZPyNSht/MF+LAOVcL6h
        SEl4UnYaIlZ8+6WrCng1QL0=
X-Google-Smtp-Source: AAOMgpcyyWenxq8bmyha9dxmwKnb/Mjv3lcyJ+F4UYhjoduOPX8ZCSFgghMli8v3IxukO39EL/CZfw==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5-v6mr7099666wrt.210.1530943316218;
        Fri, 06 Jul 2018 23:01:56 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 56-v6sm5566876wry.52.2018.07.06.23.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 23:01:55 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 03EB5123C67; Sat,  7 Jul 2018 08:01:53 +0200 (CEST)
Date:   Sat, 7 Jul 2018 08:01:53 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     pasha.tatashin@oracle.com, linux-nvdimm@lists.01.org,
        bhe@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        osalvador@suse.de
Subject: Re: [PATCH v2] mm/sparse.c: fix error path in sparse_add_one_section
Message-ID: <20180707060153.GA13141@techadventures.net>
References: <20180706190658.6873-1-ross.zwisler@linux.intel.com>
 <20180706223358.742-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706223358.742-1-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:33:58PM -0600, Ross Zwisler wrote:
> The following commit in -next:
> 
> commit 054620849110 ("mm/sparse.c: make sparse_init_one_section void and
> remove check")
> 
> changed how the error handling in sparse_add_one_section() works.
> 
> Previously sparse_index_init() could return -EEXIST, and the function would
> continue on happily.  'ret' would get unconditionally overwritten by the
> result from sparse_init_one_section() and the error code after the 'out:'
> label wouldn't be triggered.
> 
> With the above referenced commit, though, an -EEXIST error return from
> sparse_index_init() now takes us through the function and into the error
> case after 'out:'.  This eventually causes a kernel BUG, probably because
> we've just freed a memory section that we successfully set up and marked as
> present:
> 
>   BUG: unable to handle kernel paging request at ffffea0005000080
>   RIP: 0010:memmap_init_zone+0x154/0x1cf
> 
>   Call Trace:
>    move_pfn_range_to_zone+0x168/0x180
>    devm_memremap_pages+0x29b/0x480
>    pmem_attach_disk+0x1ae/0x6c0 [nd_pmem]
>    ? devm_memremap+0x79/0xb0
>    nd_pmem_probe+0x7e/0xa0 [nd_pmem]
>    nvdimm_bus_probe+0x6e/0x160 [libnvdimm]
>    driver_probe_device+0x310/0x480
>    __device_attach_driver+0x86/0x100
>    ? __driver_attach+0x110/0x110
>    bus_for_each_drv+0x6e/0xb0
>    __device_attach+0xe2/0x160
>    device_initial_probe+0x13/0x20
>    bus_probe_device+0xa6/0xc0
>    device_add+0x41b/0x660
>    ? lock_acquire+0xa3/0x210
>    nd_async_device_register+0x12/0x40 [libnvdimm]
>    async_run_entry_fn+0x3e/0x170
>    process_one_work+0x230/0x680
>    worker_thread+0x3f/0x3b0
>    kthread+0x12f/0x150
>    ? process_one_work+0x680/0x680
>    ? kthread_create_worker_on_cpu+0x70/0x70
>    ret_from_fork+0x3a/0x50
> 
> Fix this by clearing 'ret' back to 0 if sparse_index_init() returns
> -EEXIST.  This restores the previous behavior.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>
-- 
Oscar Salvador
SUSE L3
