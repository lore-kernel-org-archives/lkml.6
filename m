Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B45208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mtdtX8LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B45208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeGMUca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:32:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38702 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbeGMUc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:32:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DKE7Ew158754;
        Fri, 13 Jul 2018 20:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yhZvOvaaB28bel4jLMFiokitZyCXiNaU6/k3QWoWtlc=;
 b=mtdtX8LLqjph3lCxSN6Opg+pf6agoQu9jAjNkyHuSOM1s5OKZVJ39SsqcwmVRJpdLp5W
 316iSSOvtimYWJNCUOmw9alo1OHocNaNkOlcDLBCyOIlbfuXrVSyge7Ehj+g+YPDc/Ls
 /7reW/Ozz18aPIX40TJ4KNXH3i5LM9cz+HKLCB6D7qrjgNVcZ958v48HGFye8R1izmHA
 BNQXYyGe7VVFKap5gJaO5x7VxgjtNEYzbhY8HF6QFPJIT4k1VKik444aUuNGbr9dF9vc
 ERVSCZ5tm0C0MPUgI0upiL/4zvS+5SSvKKqzKePevClQKTvwp4pZYf8aBm5E5oel95oa Jw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k2p7vs4ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 20:15:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DKFwPB019423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 20:15:58 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6DKFs40021846;
        Fri, 13 Jul 2018 20:15:54 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 13:15:53 -0700
Date:   Fri, 13 Jul 2018 13:15:57 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/6] swap: Unify normal/huge code path in
 swap_page_trans_huge_swapped()
Message-ID: <20180713201557.bjt4tj26nisgdmmi@ca-dmjordan1.us.oracle.com>
References: <20180712233636.20629-1-ying.huang@intel.com>
 <20180712233636.20629-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712233636.20629-4-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8953 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 07:36:33AM +0800, Huang, Ying wrote:
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 75c84aa763a3..160f78072667 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -270,7 +270,10 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
>  
>  static inline bool cluster_is_huge(struct swap_cluster_info *info)
>  {
> -	return info->flags & CLUSTER_FLAG_HUGE;
> +	if (IS_ENABLED(CONFIG_THP_SWAP))
> +		return info->flags & CLUSTER_FLAG_HUGE;
> +	else
> +		return false;
>  }
>  
>  static inline void cluster_clear_huge(struct swap_cluster_info *info)
> @@ -1489,9 +1492,6 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
>  	int i;
>  	bool ret = false;
>  
> -	if (!IS_ENABLED(CONFIG_THP_SWAP))
> -		return swap_swapcount(si, entry) != 0;

This tests the value returned from swap_count,

> -
>  	ci = lock_cluster_or_swap_info(si, offset);
>  	if (!ci || !cluster_is_huge(ci)) {
>  		if (map[roffset] != SWAP_HAS_CACHE)

and now we're testing

                    map[roffset] != SWAP_HAS_CACHE

instead.  The two seem to mean the same thing here, since the swap slot hasn't
been freed to the global pool and so can't be 0, but it might be better for
consistency and clarity to use swap_count here, and a few lines down too

        for (i = 0; i < SWAPFILE_CLUSTER; i++) {                                     
                if (map[offset + i] != SWAP_HAS_CACHE) {                             

since swap_count seems to be used everywhere else for this.
