Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA028214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Og1y056"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA028214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeIZVFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:05:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53846 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIZVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:05:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8QEmwLs109305;
        Wed, 26 Sep 2018 14:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=gOGZl1NfdFEpUZDUCzxCpe+b9ZWaBE9+BvuiZ8QbOPQ=;
 b=3Og1y056YQ9yR9P0yU5YjU89FE1CopVfxPxUbhF3ZdHn9FkGSd4pTBlr9qnP53DEETjW
 AYief0Et35hfIdddYncG1dSWDzRpZtqTCA3cWCEzT/oHr1sXrOiYpbh+Iww+GxIjQq5v
 vjMct4HeGIfCjmepaaApXRHi4qmofHNeZhU2UCUj0NNX7MjsWJylmOyyaj9usW8n3+Fj
 /Oepas0dQC0VjAq86T54OSta7kJmNZRn4HVNekTS7PTN6e9wbnBsgojpRxMnWQ0fQLPP
 kFcUU6Kh4ShgbhBEQIWvh1rmSNWWsyrRLizji7kYXgiXWiFVMVhmslyEUzEr+q6x6Hwc 4w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mnd5tk19x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 14:51:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8QEplPe018999
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 14:51:48 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8QEphwU001771;
        Wed, 26 Sep 2018 14:51:43 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Sep 2018 14:51:43 +0000
Date:   Wed, 26 Sep 2018 07:51:45 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V5 RESEND 03/21] swap: Support PMD swap mapping in
 swap_duplicate()
Message-ID: <20180926145145.6xp2kxpngyd54f6i@ca-dmjordan1.us.oracle.com>
References: <20180925071348.31458-1-ying.huang@intel.com>
 <20180925071348.31458-4-ying.huang@intel.com>
 <20180925191953.4ped5ki7u3ymafmd@ca-dmjordan1.us.oracle.com>
 <874lecifj4.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lecifj4.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:55:59PM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > On Tue, Sep 25, 2018 at 03:13:30PM +0800, Huang Ying wrote:
> >>  /*
> >>   * Increase reference count of swap entry by 1.
> >> - * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
> >> - * but could not be atomically allocated.  Returns 0, just as if it succeeded,
> >> - * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
> >> - * might occur if a page table entry has got corrupted.
> >> + *
> >> + * Return error code in following case.
> >> + * - success -> 0
> >> + * - swap_count_continuation is required but could not be atomically allocated.
> >> + *   *entry is used to return swap entry to call add_swap_count_continuation().
> >> + *								      -> ENOMEM
> >> + * - otherwise same as __swap_duplicate()
> >>   */
> >> -int swap_duplicate(swp_entry_t entry)
> >> +int swap_duplicate(swp_entry_t *entry, int entry_size)
> >>  {
> >>  	int err = 0;
> >>  
> >> -	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
> >> -		err = add_swap_count_continuation(entry, GFP_ATOMIC);
> >> +	while (!err &&
> >> +	       (err = __swap_duplicate(entry, entry_size, 1)) == -ENOMEM)
> >> +		err = add_swap_count_continuation(*entry, GFP_ATOMIC);
> >>  	return err;
> >
> > Now we're returning any error we get from __swap_duplicate, apparently to
> > accommodate ENOTDIR later in the series, which is a change from the behavior
> > introduced in 570a335b8e22 ("swap_info: swap count continuations").  This might
> > belong in a separate patch given its potential for side effects.
> 
> I have checked all the calls of the function and found there will be no
> bad effect.  Do you have any side effect?

Before I was just being vaguely concerned about any unintended side effects,
but looking again, yes I do.

Now when swap_duplicate returns an error in copy_one_pte, copy_one_pte returns
a (potentially nonzero) entry.val, which copy_pte_range interprets
unconditionally as 'try adding a swap count continuation.'  Not what we want
for returns other than -ENOMEM.

So it might make sense to have a separate patch that changes swap_duplicate's
return and makes callers handle it.
