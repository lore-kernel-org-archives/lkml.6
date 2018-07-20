Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E78ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFDB2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFDB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeGTBM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:12:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:35188 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730213AbeGTBM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:12:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 17:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,376,1526367600"; 
   d="scan'208";a="58287575"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2018 17:26:49 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v3 4/8] swap: Unify normal/huge code path in swap_page_trans_huge_swapped()
References: <20180719084842.11385-1-ying.huang@intel.com>
        <20180719084842.11385-5-ying.huang@intel.com>
        <20180719124013.GB28522@infradead.org>
Date:   Fri, 20 Jul 2018 08:26:48 +0800
In-Reply-To: <20180719124013.GB28522@infradead.org> (Christoph Hellwig's
        message of "Thu, 19 Jul 2018 05:40:13 -0700")
Message-ID: <871sbywy47.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>>  static inline bool cluster_is_huge(struct swap_cluster_info *info)
>>  {
>> -	return info->flags & CLUSTER_FLAG_HUGE;
>> +	if (IS_ENABLED(CONFIG_THP_SWAP))
>> +		return info->flags & CLUSTER_FLAG_HUGE;
>> +	else
>> +		return false;
>
> Nitpick: no need for an else after a return:
>
> 	if (IS_ENABLED(CONFIG_THP_SWAP))
> 		return info->flags & CLUSTER_FLAG_HUGE;
> 	return false;

Sure.  Will change this in next version.

Best Regards,
Huang, Ying
