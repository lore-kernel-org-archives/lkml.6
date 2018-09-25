Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280CAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DCE214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SuAgZKhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DCE214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeIZBaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:30:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50646 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeIZBaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:30:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8PJJaw5178949;
        Tue, 25 Sep 2018 19:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UxeIa//Ou3UL5jmr23lEWhIIgb6QhdPU7XLgkk0//F0=;
 b=SuAgZKhyUwbJ/jEXFj97GBvjlCRja/El0+HeD0iPJiaJBzXTUvOIFJhWy6LhSNz4b8AY
 4ksu5SfIfN9tbRwfWe25bRJhyqCs9200kXCtiUJTzOhhFvlrXpuO3NsQeksi3GgSsILM
 NbAGslKHsp/U+iIRp1lPPu7Pli2UamVWqi+xDaQnw/UUIlhDkFL3DEAzbLj+YVZcs/MA
 DJYbzccgpqAUq39CY1zonfisrVNGiHp4biw/6U9xfozpdKCHKR5Z8y+rYzyWWJWCVO/x
 SUKuDo9vCf/irf72y/p0cHEwjnXSsElcQK1Wm9UnW/YTA71meALAO+hFF2Da3xQnTLLz yw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mnd5teaj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 19:19:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8PJJuAc006930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 19:19:57 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8PJJp2h005278;
        Tue, 25 Sep 2018 19:19:51 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 12:19:51 -0700
Date:   Tue, 25 Sep 2018 12:19:53 -0700
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
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -V5 RESEND 03/21] swap: Support PMD swap mapping in
 swap_duplicate()
Message-ID: <20180925191953.4ped5ki7u3ymafmd@ca-dmjordan1.us.oracle.com>
References: <20180925071348.31458-1-ying.huang@intel.com>
 <20180925071348.31458-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925071348.31458-4-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809250190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 03:13:30PM +0800, Huang Ying wrote:
> @@ -3487,35 +3521,66 @@ static int __swap_duplicate_locked(struct swap_info_struct *p,
>  }
>  
>  /*
> - * Verify that a swap entry is valid and increment its swap map count.
> + * Verify that the swap entries from *entry is valid and increment their
> + * PMD/PTE swap mapping count.
>   *
>   * Returns error code in following case.
>   * - success -> 0
>   * - swp_entry is invalid -> EINVAL
> - * - swp_entry is migration entry -> EINVAL

I'm assuming it wasn't possible to hit this error before this patch, and you're
just removing it now since you're in the area?

>   * - swap-cache reference is requested but there is already one. -> EEXIST
>   * - swap-cache reference is requested but the entry is not used. -> ENOENT
>   * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
> + * - the huge swap cluster has been split. -> ENOTDIR

Strangely intuitive choice of error code :)

>  /*
>   * Increase reference count of swap entry by 1.
> - * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
> - * but could not be atomically allocated.  Returns 0, just as if it succeeded,
> - * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
> - * might occur if a page table entry has got corrupted.
> + *
> + * Return error code in following case.
> + * - success -> 0
> + * - swap_count_continuation is required but could not be atomically allocated.
> + *   *entry is used to return swap entry to call add_swap_count_continuation().
> + *								      -> ENOMEM
> + * - otherwise same as __swap_duplicate()
>   */
> -int swap_duplicate(swp_entry_t entry)
> +int swap_duplicate(swp_entry_t *entry, int entry_size)
>  {
>  	int err = 0;
>  
> -	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
> -		err = add_swap_count_continuation(entry, GFP_ATOMIC);
> +	while (!err &&
> +	       (err = __swap_duplicate(entry, entry_size, 1)) == -ENOMEM)
> +		err = add_swap_count_continuation(*entry, GFP_ATOMIC);
>  	return err;

Now we're returning any error we get from __swap_duplicate, apparently to
accommodate ENOTDIR later in the series, which is a change from the behavior
introduced in 570a335b8e22 ("swap_info: swap count continuations").  This might
belong in a separate patch given its potential for side effects.

Although, I don't understand why 570a335b8e22 ignored errors other than -ENOMEM
when both swap_duplicate callers _seem_ from a quick read to be able to respond
gracefully to any error.
