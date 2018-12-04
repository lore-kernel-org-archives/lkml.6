Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEEBC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AAC20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AAC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLDCap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:30:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:39353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeLDCao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:30:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 18:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,312,1539673200"; 
   d="scan'208";a="106765015"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.130])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2018 18:30:41 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V7 RESEND 08/21] swap: Support to read a huge swap cluster for swapin a THP
References: <20181120085449.5542-1-ying.huang@intel.com>
        <20181120085449.5542-9-ying.huang@intel.com>
        <20181130233201.6yuzbhymtjddvf3u@ca-dmjordan1.us.oracle.com>
        <8736rirsox.fsf@yhuang-dev.intel.com>
        <20181203161538.gxleg2ugdj2woadr@ca-dmjordan1.us.oracle.com>
Date:   Tue, 04 Dec 2018 10:30:41 +0800
In-Reply-To: <20181203161538.gxleg2ugdj2woadr@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Mon, 3 Dec 2018 08:15:38 -0800")
Message-ID: <87bm62aur2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Sat, Dec 01, 2018 at 08:34:06AM +0800, Huang, Ying wrote:
>> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
>> > What do you think?
>> 
>> I think that swapoff() which is the main user of try_to_unuse() isn't a
>> common operation in practical.  So it's not necessary to make it more
>> complex for this.
>
> Ok, probably not worth the surgery on try_to_unuse, even if swapoff can be
> expensive when it does happen.
>
>> In alloc_hugepage_direct_gfpmask(), the only information provided by vma
>> is: vma->flags & VM_HUGEPAGE.  Because we have no vma available, I think
>> it is OK to just assume that the flag is cleared.  That is, rely on
>> system-wide THP settings only.
>> 
>> What do you think about this proposal?
>
> Sounds like a good compromise.
>
> So alloc_hugepage_direct_gfpmask will learn to make 'vma' optional?  Slightly
> concerned that future callers that should be passing vma's might not and open a
> way to ignore vma huge page hints, but probably not a big deal in practice.  

alloc_pages_vma() -> get_vma_policy() -> __get_vma_policy()

has done that already.  So I guess that's not a big issue.  The callers
should be careful.

Best Regards,
Huang, Ying
