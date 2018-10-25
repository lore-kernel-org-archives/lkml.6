Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C56CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1135C20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1135C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJYJYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:24:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:64533 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeJYJYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:24:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 17:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="83934267"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2018 17:54:17 -0700
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
Subject: Re: [PATCH -V6 06/21] swap: Support PMD swap mapping when splitting huge PMD
References: <20181010071924.18767-1-ying.huang@intel.com>
        <20181010071924.18767-7-ying.huang@intel.com>
        <20181024172549.xyevip5kclq2ig33@ca-dmjordan1.us.oracle.com>
Date:   Thu, 25 Oct 2018 08:54:16 +0800
In-Reply-To: <20181024172549.xyevip5kclq2ig33@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Wed, 24 Oct 2018 10:25:49 -0700")
Message-ID: <87bm7ivoav.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, Oct 10, 2018 at 03:19:09PM +0800, Huang Ying wrote:
>> +#ifdef CONFIG_THP_SWAP
>> +/*
>> + * The corresponding page table shouldn't be changed under us, that
>> + * is, the page table lock should be held.
>> + */
>> +int split_swap_cluster_map(swp_entry_t entry)
>> +{
>> +	struct swap_info_struct *si;
>> +	struct swap_cluster_info *ci;
>> +	unsigned long offset = swp_offset(entry);
>> +
>> +	VM_BUG_ON(!IS_ALIGNED(offset, SWAPFILE_CLUSTER));
>> +	si = _swap_info_get(entry);
>> +	if (!si)
>> +		return -EBUSY;
>
> I think this return value doesn't get used anywhere?

Yes.  And the error is only possible if page table is corrupted.  So
maybe add a VM_BUG_ON() in it caller __split_huge_swap_pmd()?

Best Regards,
Huang, Ying
