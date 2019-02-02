Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B64DC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4687B21872
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfBBAu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:50:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbfBBAuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:50:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D6C4C0495BB;
        Sat,  2 Feb 2019 00:50:25 +0000 (UTC)
Received: from sky.random (ovpn-121-14.rdu2.redhat.com [10.10.121.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0296E608DA;
        Sat,  2 Feb 2019 00:50:23 +0000 (UTC)
Date:   Fri, 1 Feb 2019 19:50:22 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] uprobes: use set_pte_at() not set_pte_at_notify()
Message-ID: <20190202005022.GC12463@redhat.com>
References: <20190131183706.20980-1-jglisse@redhat.com>
 <20190131183706.20980-2-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131183706.20980-2-jglisse@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 02 Feb 2019 00:50:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:37:03PM -0500, Jerome Glisse wrote:
> @@ -207,8 +207,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>  
>  	flush_cache_page(vma, addr, pte_pfn(*pvmw.pte));
>  	ptep_clear_flush_notify(vma, addr, pvmw.pte);
> -	set_pte_at_notify(mm, addr, pvmw.pte,
> -			mk_pte(new_page, vma->vm_page_prot));
> +	set_pte_at(mm, addr, pvmw.pte, mk_pte(new_page, vma->vm_page_prot));
>  
>  	page_remove_rmap(old_page, false);
>  	if (!page_mapped(old_page))

This seems racy by design in the way it copies the page, if the vma
mapping isn't readonly to begin with (in which case it'd be ok to
change the pfn with change_pte too, it'd be a from read-only to
read-only change which is ok).

If the code copies a writable page there's no much issue if coherency
is lost by other means too.

Said that this isn't a worthwhile optimization for uprobes so because
of the lack of explicit read-only enforcement, I agree it's simpler to
skip change_pte above.

It's orthogonal, but in this function the
mmu_notifier_invalidate_range_end(&range); can be optimized to
mmu_notifier_invalidate_range_only_end(&range); otherwise there's no
point to retain the _notify in ptep_clear_flush_notify.
