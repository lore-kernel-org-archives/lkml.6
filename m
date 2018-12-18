Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33260C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A12218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1lZnf1Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeLRUy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:54:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36330 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:54:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIKrZxj121162;
        Tue, 18 Dec 2018 20:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=EeG9M/VEs0zQwToO9wK+EFya9rJ9H54Jtm3kwSChiI8=;
 b=1lZnf1LpeeOqef9l4AoraPxy02Sgga4HRAdowgkIU+D+s0BCvoqsCPDq5Pyxg+cedw8k
 s5nBsLJMsw+9RHikE4VGnwuh5dPz+Ng2wAd8j+4keeZX6IOYcYzN8vFQWZ1SjKXpEgzN
 +4CDxfg4iyFCZtLo1Mto8+XwvQDGrGUuuGpinXYDzdIU0zR3rlYuxOEpld+TekygOtGE
 fGNVpd2n0ysAg1KtpSQcbMKzreYTI1ba5apwh18gKRFPH67Su0E9vWlJt0AIFSfTgOGt
 ttH3UbUp3xqtOvvGVwitdnTWqSdhVRBe7InRP2CXtY8H3VCIQ5SeyD/zaoWAtw7dXg0y ng== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pct8qwqyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 20:54:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBIKsZxl031900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 20:54:35 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBIKsUVf004826;
        Tue, 18 Dec 2018 20:54:31 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 12:54:30 -0800
Date:   Tue, 18 Dec 2018 12:54:44 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH -V9 07/21] swap: Support PMD swap mapping when splitting
 huge PMD
Message-ID: <20181218205443.shqczdh3era6heaf@ca-dmjordan1.us.oracle.com>
References: <20181214062754.13723-1-ying.huang@intel.com>
 <20181214062754.13723-8-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214062754.13723-8-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Aneesh

On Fri, Dec 14, 2018 at 02:27:40PM +0800, Huang Ying wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bd2543e10938..49df3e7c96c7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c

> +int split_swap_cluster_map(swp_entry_t entry)
        ...
> +	VM_BUG_ON(!IS_ALIGNED(offset, SWAPFILE_CLUSTER));

Hi Ying, I crashed on this in v6 as reported and it still dies on me now.

> @@ -2150,6 +2185,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
        ...
> +	if (IS_ENABLED(CONFIG_THP_SWAP) && is_swap_pmd(old_pmd))
> +		return __split_huge_swap_pmd(vma, haddr, pmd);

Problem is 'pmd' is passed here, which has been pmdp_invalidate()ed under the
assumption that it is not a swap entry.  pmd's pfn bits get inverted for L1TF,
so the swap entry gets corrupted and this BUG is the first place that notices.

I don't see a reason to invalidate so soon, so what about just moving the
invalidation down, past the migration/swap checks?
