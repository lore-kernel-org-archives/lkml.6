Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C27AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0C220671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D+2CcLbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0C220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeI2D7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:59:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeI2D7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:59:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8SLRCFj145406;
        Fri, 28 Sep 2018 21:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vupmQYaYr9qOT16FHm1qaVkPMFM9P1Or9YaS/RAohfI=;
 b=D+2CcLbWIi5ag3qiwZOQNmLlGI6nPVJfdR0itxVPly0t/X0nsXiiRCEdRQqu8PTP0iKs
 xMAVyolrjgc0Wr+slCTQXYnX3c0BDj0K/17PbTWTz0vOjCSeu39Xu9U7FNgVCpABTdoQ
 EuVXip6a9i7fG0rBsWlMDt91JyzivGIP0B7dViaWiYAiC3JIVpSVxpEfnI7mcWXuueN5
 pyYSecFydHF1QWHNLhhd4D0Wrb52IBgKDV8RxSmdK2HyrNm8dCfL7UXavVKaF50lrClr
 7XvAOos3u0lPlIk+LzzAswLeAuxX6kWrL0Gx28r703jtFtoEHTmF/DJp1TFYwwS4BQeC 9g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mnd5u2rgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 21:32:28 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8SLWQc4024296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 21:32:27 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8SLWMnc017474;
        Fri, 28 Sep 2018 21:32:22 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 14:32:22 -0700
Date:   Fri, 28 Sep 2018 14:32:24 -0700
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
Message-ID: <20180928213224.tjff2rtfmxmnz5nq@ca-dmjordan1.us.oracle.com>
References: <20180925071348.31458-1-ying.huang@intel.com>
 <20180925071348.31458-4-ying.huang@intel.com>
 <20180925191953.4ped5ki7u3ymafmd@ca-dmjordan1.us.oracle.com>
 <874lecifj4.fsf@yhuang-dev.intel.com>
 <20180926145145.6xp2kxpngyd54f6i@ca-dmjordan1.us.oracle.com>
 <87r2hfhger.fsf@yhuang-dev.intel.com>
 <20180927211238.ly3e7cyvfu3rswcv@ca-dmjordan1.us.oracle.com>
 <87lg7mf30o.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg7mf30o.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9030 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:19:03PM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > One way is to change
> > copy_one_pte's return to int so we can just pass the error code back to
> > copy_pte_range so it knows whether to try adding the continuation.
> 
> There may be even more problems.  After add_swap_count_continuation(),
> copy_one_pte() will be retried, and the CPU may hang with dead loop.

That's true, it would do that.

> But before the changes in this patchset, the behavior is,
> __swap_duplicate() return an error that isn't -ENOMEM, such as -EEXIST.
> Then copy_one_pte() would thought the operation has been done
> successfully, and go to call set_pte_at().  This will cause the system
> state become inconsistent, and the system may panic or hang somewhere
> later.
> 
> So per my understanding, if we thought page table corruption isn't a
> real problem (that is, __swap_duplicate() will never return e.g. -EEXIST
> if copied by copy_one_pte() indirectly), both the original and the new
> code should be OK.
> 
> If we thought it is a real problem, we need to fix the original code and
> keep it fixed in the new code.  Do you agree?

Yes, if it was a real problem, which seems less and less the case the more I
stare at this.

> There's several ways to fix the problem.  But the page table shouldn't
> be corrupted in practice, unless there's some programming error.  So I
> suggest to make it as simple as possible via adding,
> 
> VM_BUG_ON(error != -ENOMEM);
> 
> in swap_duplicate().
> 
> Do you agree?

Yes, I'm ok with that, adding in -ENOTDIR along with it.

The error handling in __swap_duplicate (before this series) still leaves
something to be desired IMHO.  Why all the different returns when callers
ignore them or only specifically check for -ENOMEM or -EEXIST?  Could maybe
stand a cleanup, but outside this series.
