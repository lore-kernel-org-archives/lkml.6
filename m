Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C33C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354BC2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354BC2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLCKYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:24:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbeLCKYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:24:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3F4A30832C9;
        Mon,  3 Dec 2018 10:24:06 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39ADE604CC;
        Mon,  3 Dec 2018 10:23:59 +0000 (UTC)
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge or
 THP
To:     Jan Stancek <jstancek@redhat.com>, linux-mm@kvack.org,
        alex.williamson@redhat.com, aarcange@redhat.com,
        rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, mhocko@suse.com
Cc:     linux-kernel@vger.kernel.org
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <35a664c0-6dab-bb32-811e-65250200d195@redhat.com>
Date:   Mon, 3 Dec 2018 11:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 03 Dec 2018 10:24:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 13:06, Jan Stancek wrote:
> LTP proc01 testcase has been observed to rarely trigger crashes
> on arm64:
>     page_mapped+0x78/0xb4
>     stable_page_flags+0x27c/0x338
>     kpageflags_read+0xfc/0x164
>     proc_reg_read+0x7c/0xb8
>     __vfs_read+0x58/0x178
>     vfs_read+0x90/0x14c
>     SyS_read+0x60/0xc0
> 
> Issue is that page_mapped() assumes that if compound page is not
> huge, then it must be THP. But if this is 'normal' compound page
> (COMPOUND_PAGE_DTOR), then following loop can keep running
> (for HPAGE_PMD_NR iterations) until it tries to read from memory
> that isn't mapped and triggers a panic:
>         for (i = 0; i < hpage_nr_pages(page); i++) {
>                 if (atomic_read(&page[i]._mapcount) >= 0)
>                         return true;
> 	}
> 
> I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
> with a custom kernel module [1] which:
> - allocates compound page (PAGEC) of order 1
> - allocates 2 normal pages (COPY), which are initialized to 0xff
>   (to satisfy _mapcount >= 0)
> - 2 PAGEC page structs are copied to address of first COPY page
> - second page of COPY is marked as not present
> - call to page_mapped(COPY) now triggers fault on access to 2nd
>   COPY page at offset 0x30 (_mapcount)
> 
> [1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c
> 
> Fix the loop to iterate for "1 << compound_order" pages.
> 
> Debugged-by: Laszlo Ersek <lersek@redhat.com>
> Suggested-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Changes in v2:
> - change the loop instead so we check also mapcount of subpages
> 
> diff --git a/mm/util.c b/mm/util.c
> index 8bf08b5b5760..5c9c7359ee8a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -478,7 +478,7 @@ bool page_mapped(struct page *page)
>  		return true;
>  	if (PageHuge(page))
>  		return false;
> -	for (i = 0; i < hpage_nr_pages(page); i++) {
> +	for (i = 0; i < (1 << compound_order(page)); i++) {
>  		if (atomic_read(&page[i]._mapcount) >= 0)
>  			return true;
>  	}
> 

Totally uninformed side-question:

how large can the return value of compound_order() be? MAX_ORDER?

Apparently, MAX_ORDER can be defined as CONFIG_FORCE_MAX_ZONEORDER.

"config FORCE_MAX_ZONEORDER" is listed in a number of Kconfig files.
Among those, "arch/mips/Kconfig" permits "ranges" (?) that extend up to
64. Same applies to "arch/powerpc/Kconfig" and "arch/sh/mm/Kconfig".

If we left-shift "1" -- a signed int, which I assume in practice will
always have two's complement representation, 1 sign bit, 31 value bits,
and 0 padding bits --, by 31 or more bit positions, we get undefined
behavior (as part of the left-shift operation).

Is this a practical concern?

Thanks,
Laszlo
