Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A32D3C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5309620839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N+kj0w33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5309620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934168AbeFKUoG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:44:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42914 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933204AbeFKUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:44:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5BKftBv187122;
        Mon, 11 Jun 2018 20:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=CFXacZ8fOR7yAkurZhYhloa+JNMGX6dExHwDvgWdRVw=;
 b=N+kj0w33LurFUvxtcETUyjWoWn0AOjDHIzW7g0xmV8H74uN4ywI9Allj4Zp1NqwLAVsH
 y8ftF1EHtVrF4UApXVDfMVQ5PbxivtcAyUF4UiuLYC03EL3nSr8IBuHOcN4/qO/AmGU5
 Ech0BbRQ0xeLHHBTov8dMj0GpPzurF1j2+7apyLJW/E7iwd7VKud9DRKnbSaGQVGjFls
 UrRNpVJWHfDnYPR8q9JVLuFLrVONVMTE2tjHOCJChovZaQdF7PS58NLMfCUYAzhBLB/F
 ws6OeKwx2QvF+3WXb5b6XLyKHa1dkUha+cZVBgKcyCHKlyDlvVf2TfVYxPpWUFDOo2ZL /w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jg6b1f5pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jun 2018 20:42:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5BKgXTG006553
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jun 2018 20:42:34 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5BKgVD9006057;
        Mon, 11 Jun 2018 20:42:31 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jun 2018 13:42:31 -0700
Date:   Mon, 11 Jun 2018 13:42:31 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -mm -V3 03/21] mm, THP, swap: Support PMD swap mapping in
 swap_duplicate()
Message-ID: <20180611204231.ojhlyrbmda6pouxb@ca-dmjordan1.us.oracle.com>
References: <20180523082625.6897-1-ying.huang@intel.com>
 <20180523082625.6897-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523082625.6897-4-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806110233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series up to and including this patch doesn't build.  For this patch we
need:

diff --git a/mm/swap_state.c b/mm/swap_state.c
index c6b3eab73fde..2f2d07627113 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -433,7 +433,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
                /*
                 * Swap entry may have been freed since our caller observed it.
                 */
-               err = swapcache_prepare(entry);
+               err = swapcache_prepare(entry, false);
                if (err == -EEXIST) {
                        radix_tree_preload_end();
                        /*


On Wed, May 23, 2018 at 04:26:07PM +0800, Huang, Ying wrote:
> @@ -3516,11 +3512,39 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)

Two comments about this part of __swap_duplicate as long as you're moving it to
another function:

   } else if (count || has_cache) {
   
   	if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)          /* #1   */
   		count += usage;
   	else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)     /* #2   */
   		err = -EINVAL;

#1:  __swap_duplicate_locked might use

    VM_BUG_ON(usage != SWAP_HAS_CACHE && usage != 1);

to document the unstated assumption that usage is 1 (otherwise count could
overflow).

#2:  We've masked off SWAP_HAS_CACHE and COUNT_CONTINUED, and already checked
for SWAP_MAP_BAD, so I think condition #2 always fails and can just be removed.

> +#ifdef CONFIG_THP_SWAP
> +static int __swap_duplicate_cluster(swp_entry_t *entry, unsigned char usage)
...
> +	} else {
> +		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
> +retry:
> +			err = __swap_duplicate_locked(si, offset + i, 1);

I guess usage is assumed to be 1 at this point (__swap_duplicate_locked makes
the same assumption).  Maybe make this explicit with

			err = __swap_duplicate_locked(si, offset + i, usage);

, use 'usage' in cluster_set_count and __swap_entry_free too, and then
earlier have a

       VM_BUG_ON(usage != SWAP_HAS_CACHE && usage != 1);

?

> +#else
> +static inline int __swap_duplicate_cluster(swp_entry_t *entry,

This doesn't need inline.


Not related to your changes, but while we're here, the comment with
SWAP_HAS_CONT in swap_count() could be deleted: I don't think there ever was a
SWAP_HAS_CONT.

The rest looks ok up to this point.
