Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC63C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C29821571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lGD7Gf/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C29821571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeI1DdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:33:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeI1DdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:33:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RL8YHl153409;
        Thu, 27 Sep 2018 21:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hHyLN+DKnaoctaGReregGDcV8BWUQku0PWLZH0L8Nx8=;
 b=lGD7Gf/uOD9G0n6mg3Nd9KzNwcoWe3a9bZZmnuFrkab+9txvCFppBoNMCbXIjK6kziNY
 JwYjd5x+23fHdfS0K7fZ7jSM9lCy+Om7WrZ+T/h/Rnp/cJip8K4EfUjiC60T64bNKLZ2
 IJW9S8yjFckJRwfjayIakXDjWRP6XwTab8QRWSazXsE8TRSBuvKYUOIrc0ZMXHYg/8ZD
 FPVzLRUxd9Eih6VdWIgCao7Lhgh5faWf0pbVFjMWjDj9zHeWRgHGN3w5h1M+3XoxZubh
 ebQtwxRotcbeISscEOoUllBMEp4PPQ4tQQpHcW91ziCbolETVTchBqkRW+KyGhXeuQRV pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mndppvjrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 21:12:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8RLCfKd000449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 21:12:41 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8RLCbuu028511;
        Thu, 27 Sep 2018 21:12:37 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 21:12:36 +0000
Date:   Thu, 27 Sep 2018 14:12:39 -0700
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
Message-ID: <20180927211238.ly3e7cyvfu3rswcv@ca-dmjordan1.us.oracle.com>
References: <20180925071348.31458-1-ying.huang@intel.com>
 <20180925071348.31458-4-ying.huang@intel.com>
 <20180925191953.4ped5ki7u3ymafmd@ca-dmjordan1.us.oracle.com>
 <874lecifj4.fsf@yhuang-dev.intel.com>
 <20180926145145.6xp2kxpngyd54f6i@ca-dmjordan1.us.oracle.com>
 <87r2hfhger.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2hfhger.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:34:36AM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > On Wed, Sep 26, 2018 at 08:55:59PM +0800, Huang, Ying wrote:
> >> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> >> > On Tue, Sep 25, 2018 at 03:13:30PM +0800, Huang Ying wrote:
> >> >>  /*
> >> >>   * Increase reference count of swap entry by 1.
> >> >> - * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
> >> >> - * but could not be atomically allocated.  Returns 0, just as if it succeeded,
> >> >> - * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
> >> >> - * might occur if a page table entry has got corrupted.
> >> >> + *
> >> >> + * Return error code in following case.
> >> >> + * - success -> 0
> >> >> + * - swap_count_continuation is required but could not be atomically allocated.
> >> >> + *   *entry is used to return swap entry to call add_swap_count_continuation().
> >> >> + *								      -> ENOMEM
> >> >> + * - otherwise same as __swap_duplicate()
> >> >>   */
> >> >> -int swap_duplicate(swp_entry_t entry)
> >> >> +int swap_duplicate(swp_entry_t *entry, int entry_size)
> >> >>  {
> >> >>  	int err = 0;
> >> >>  
> >> >> -	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
> >> >> -		err = add_swap_count_continuation(entry, GFP_ATOMIC);
> >> >> +	while (!err &&
> >> >> +	       (err = __swap_duplicate(entry, entry_size, 1)) == -ENOMEM)
> >> >> +		err = add_swap_count_continuation(*entry, GFP_ATOMIC);
> >> >>  	return err;
> >> >
> >> > Now we're returning any error we get from __swap_duplicate, apparently to
> >> > accommodate ENOTDIR later in the series, which is a change from the behavior
> >> > introduced in 570a335b8e22 ("swap_info: swap count continuations").  This might
> >> > belong in a separate patch given its potential for side effects.
> >> 
> >> I have checked all the calls of the function and found there will be no
> >> bad effect.  Do you have any side effect?
> >
> > Before I was just being vaguely concerned about any unintended side effects,
> > but looking again, yes I do.
> >
> > Now when swap_duplicate returns an error in copy_one_pte, copy_one_pte returns
> > a (potentially nonzero) entry.val, which copy_pte_range interprets
> > unconditionally as 'try adding a swap count continuation.'  Not what we want
> > for returns other than -ENOMEM.
> 
> Thanks for pointing this out!  Before the change in the patchset, the
> behavior is,
> 
> Something wrong is detected in swap_duplicate(), but the error is
> ignored.  Then copy_one_pte() will think everything is OK, so that it
> can proceed to call set_pte_at().  The system will be in inconsistent
> state and some data may be polluted!

Yes, the part about page table corruption in the comment above swap_duplicate.

> But this doesn't cause any problem in practical.  Per my understanding,
> because if other part of the kernel works correctly, it's impossible for
> swap_duplicate() return any error except -ENOMEM before the change in
> this patchset.

I agree with that, but it's not what I'm trying to explain.  I didn't go into
enough detail, let me try again.  Hopefully I'm understanding this right.

While running with these patches, say we're at

  copy_pte_range
   copy_one_pte
    swap_duplicate
     __swap_duplicate
      __swap_duplicate_locked
    
And say __swap_duplicate_locked returns an error that isn't -ENOMEM, such as
-EEXIST.  That means __swap_duplicate and swap_duplicate also return -EEXIST.
copy_one_pte returns entry.val, which can be and usually is nonzero, so we
break out of the loop in copy_pte_range and then--erroneously--call
add_swap_count_continuation.

The add_swap_count_continuation call was added in 570a335b8e22 and relies on
the assumption that callers can only get -ENOMEM from swap_duplicate.  This
patch changes that assumption.

Not a big deal: the continuation call just returns early, no harm done, but it
allocs and frees a page needlessly, so we should fix it.  One way is to change
copy_one_pte's return to int so we can just pass the error code back to
copy_pte_range so it knows whether to try adding the continuation.

The other swap_duplicate caller, try_to_unmap_one, seems ok.

> But the error may be possible during development, and it
> may serve as some kind of document too.  So I suggest to add
> 
> VM_BUG_ON(error != -ENOMEM);
> 
> in swap_duplicate().  What do you think about that?

That doesn't seem necessary.

> > So it might make sense to have a separate patch that changes swap_duplicate's
> > return and makes callers handle it.
> 
> Thanks for your help to take a deep look at this.  I want to try to fix
> all potential problems firstly, because the number of the caller is
> quite limited.  Do you agree?

Yes, makes sense to me.

Daniel
