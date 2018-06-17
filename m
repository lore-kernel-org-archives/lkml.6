Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27046C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EBB20864
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq5WIhkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EBB20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeFQPJg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 11:09:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44996 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933418AbeFQPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 11:09:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id h12-v6so6958429pfk.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Bn7GJ65B47Eq9coU4GRDAJrg/uIRpbDVpkLr70wEuc=;
        b=kq5WIhkxTmZcsblHUm/8Zam3JNnjFkq4KR8NcZd85XXGN28FKjKIEoxK+J35DqouC9
         Fobdfs1tpqIGlRRGcZ6lxML6Ic3FCDiDoDRM+ia8hiOkYY5n60oPUh/fAqeuu6P/7lg9
         butN3n3H4DcSG7FpnI6hmEBMulK+En+V6bR8ATVOMphIodelmf1E5WLYDaJ13LF7pkEQ
         AMhtBkLeXekORVvWxoshuEcsQ5SWscembrqlOtQFE+iC/SHQrvj0rMy/xEvyvaZTAqBt
         F5inQnhIXOC2I2vUO8MsRLDcwrb9xfZTouTJD4ICqP6xIPvP1drxIduGE4E4qxLfW+TC
         7jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Bn7GJ65B47Eq9coU4GRDAJrg/uIRpbDVpkLr70wEuc=;
        b=XSvhsQPu19FPpqtXzPlkbvg1SVBpT+BTtONgjSsiLl6qkPjVPfTAOgsL6W0y3OBwKj
         F+N38aOicPqKhCN3sTQp/sH7IpUJPdoTG622oHWuMoCyDgQaRTb9P7wYHj/v/bTywznG
         kBWW2dYR8kgb7Uav55LCtg+G61LP4YIpRvPhjFRU7XkCpeVkpH1fYWrTLUiG7fQpmIm/
         Ypce9WhGp0V6170eGVKDaheWLRgm6JgwZ/E2CUQVEoV8C/Su/zyZ0+meN160RZlkOAod
         /JuV7jbMgu3CnX2OfG21641UA/kighgRLGQBFIMNekGlylDLbwsWBa+ODQ28gloOOytf
         /1Jg==
X-Gm-Message-State: APt69E1UOp+SoqyoiJsi8fO68Eda/Y+jcfp7NRpABhlcOOi6AmMA9s3v
        +ITLOX8lunIqlW2Za5c5NzY=
X-Google-Smtp-Source: ADUXVKK6HRqXFLEVgA4STJvah2qgoWD0fBiOgUyfwXxp2/yPmU3vg9qj+dwnFNjsLe7xeybRaUoFaw==
X-Received: by 2002:a65:4348:: with SMTP id k8-v6mr8274586pgq.341.1529248174508;
        Sun, 17 Jun 2018 08:09:34 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id s19-v6sm22830600pfe.97.2018.06.17.08.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 08:09:33 -0700 (PDT)
Date:   Mon, 18 Jun 2018 00:09:31 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] mm: Mark pages in use for page tables
Message-ID: <20180617150931.GB24595@lianli.shorne-pla.net>
References: <20180307134443.32646-1-willy@infradead.org>
 <20180307134443.32646-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307134443.32646-5-willy@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 05:44:43AM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Define a new PageTable bit in the page_type and use it to mark pages in
> use as page tables.  This can be helpful when debugging crashdumps or
> analysing memory fragmentation.  Add a KPF flag to report these pages
> to userspace and update page-types.c to interpret that flag.
> 
> Note that only pages currently accounted as NR_PAGETABLES are tracked
> as PageTable; this does not include pgd/p4d/pud/pmd pages.  Those will
> be the subject of a later patch.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/tile/mm/pgtable.c                 | 3 +++
>  fs/proc/page.c                         | 2 ++
>  include/linux/mm.h                     | 2 ++
>  include/linux/page-flags.h             | 6 ++++++
>  include/uapi/linux/kernel-page-flags.h | 1 +
>  tools/vm/page-types.c                  | 1 +
>  6 files changed, 15 insertions(+)
> 


Helloi Matthew,

I have bisected a regression on OpenRISC in v4.18-rc1 to this commit.  Using
our defconfig after boot I am getting:

    BUG: Bad page state in process hostname  pfn:00b5c
    page:c1ff0b80 count:0 mapcount:-1024 mapping:00000000 index:0x0
    flags: 0x0()
    raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
    page dumped because: nonzero mapcount
    Modules linked in:
    CPU: 1 PID: 38 Comm: hostname Tainted: G    B
    4.17.0-simple-smp-07461-g1d40a5ea01d5-dirty #993
    Call trace:
    [<(ptrval)>] show_stack+0x44/0x54
    [<(ptrval)>] dump_stack+0xb0/0xe8
    [<(ptrval)>] bad_page+0x138/0x174
    [<(ptrval)>] ? ipi_icache_page_inv+0x0/0x24
    [<(ptrval)>] ? cpumask_next+0x24/0x34
    [<(ptrval)>] free_pages_check_bad+0x6c/0xd0
    [<(ptrval)>] free_pcppages_bulk+0x174/0x42c
    [<(ptrval)>] free_unref_page_commit.isra.17+0xb8/0xc8
    [<(ptrval)>] free_unref_page_list+0x10c/0x190
    [<(ptrval)>] ? set_reset_devices+0x0/0x2c
    [<(ptrval)>] release_pages+0x3a0/0x414
    [<(ptrval)>] tlb_flush_mmu_free+0x5c/0x90
    [<(ptrval)>] tlb_flush_mmu+0x90/0xa4
    [<(ptrval)>] arch_tlb_finish_mmu+0x50/0x94
    [<(ptrval)>] tlb_finish_mmu+0x30/0x64
    [<(ptrval)>] exit_mmap+0x110/0x1e0
    [<(ptrval)>] mmput+0x50/0xf0
    [<(ptrval)>] do_exit+0x274/0xa94
    [<(ptrval)>] ? _raw_spin_unlock_irqrestore+0x1c/0x2c
    [<(ptrval)>] ? __up_read+0x70/0x88
    [<(ptrval)>] do_group_exit+0x50/0x110
    [<(ptrval)>] __wake_up_parent+0x0/0x38
    [<(ptrval)>] _syscall_return+0x0/0x4


In this series we are overloading mapcount with page_type, the above is caused
due to this check in mm/page_alloc.c (free_pages_check_bad):

        if (unlikely(atomic_read(&page->_mapcount) != -1))
                bad_reason = "nonzero mapcount";

We can see in the dump above that _mapcount is fffffbff, this corresponds to the
'PG_table' flag.  Which was added here.  But it seems for some case in openrisc
its not getting cleared during page free.

This is as far as I got tracing it.  It might be an issue with OpenRISC, but our
implementation is mostly generic.  I will look into it more in the next few days
but I figured you might be able to spot something more quickly.

-Stafford
