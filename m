Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4420875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB4420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbeGWLt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:49:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387778AbeGWLt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:49:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09380AFED;
        Mon, 23 Jul 2018 10:48:49 +0000 (UTC)
Date:   Mon, 23 Jul 2018 12:48:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v1 1/2] mm: clarify semantics of reserved pages
Message-ID: <20180723104847.GB31229@dhcp22.suse.cz>
References: <20180720123422.10127-1-david@redhat.com>
 <20180720123422.10127-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180720123422.10127-2-david@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-07-18 14:34:21, David Hildenbrand wrote:
> The reserved bit once was used to hinder pages from getting swapped. While
> this still works,

Does it? There is no single PageReserved check in the reclaim path. I
have no idea when we stopped checking but it must be loooong ago.

> the semantics are a little bit stronger nowadays: The
> page should never be touched by anybody in the system except by the owner.
> The original comment already gave a hint about that.
> 
> So especially, these pages should also not be dumped by dumping tools.
> Let's make that more clear by updating the comment.
> 
> This will be useful especially in the future in virtual environments where
> pages marked with the reserved bit might no longer be accessible.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Miles Chen <miles.chen@mediatek.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Petr Tesarik <ptesarik@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

for this change
> ---
>  include/linux/page-flags.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 901943e4754b..ba81e11a868c 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -17,8 +17,8 @@
>  /*
>   * Various page->flags bits:
>   *
> - * PG_reserved is set for special pages, which can never be swapped out. Some
> - * of them might not even exist...
> + * PG_reserved is set for special pages, which should never be touched (read/
> + * write) by anybody except their owner. Some of them might not even exist.
>   *
>   * The PG_private bitflag is set on pagecache pages if they contain filesystem
>   * specific data (which is normally at page->private). It can be used by
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
