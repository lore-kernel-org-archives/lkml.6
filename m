Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A76ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC0D20831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uzFLhmSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC0D20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeJYBxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:53:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57600 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYBxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:53:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9OHNdqq186465;
        Wed, 24 Oct 2018 17:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=I1faConqQ+B2rpISxy+U1ZjPJgLuo9VrLWS9bSnFkb8=;
 b=uzFLhmSqavCD3qS+rokXCxrROVmGEK25FYGceBj6l3fkjM1a5DSb+a9YnVM1btLu0qv1
 nM5NJ7rDMGvq1XjAYq7psWMh/G4IAsrW00KyAEargkMKL57eG/C6UYbc8/CxfKx79AGN
 N6N8mbenr46Bj5uMnWKFVIaGs+zozeHIQXC+gbkXQXjN9lZnSNJ5NqG8fSivMoua7VWq
 +CCU4pit5YSroAQl5zzFAUA1w3enNMuhEdlYf/PLMtY3d0BVtKqrmIGDuLTpwMj90vrZ
 fBSnmc/1ctZH0urxF0r6Y4le5agYq+2TaAXFZMAOKDtgZPHth4NVev2IN+jtZOaezBiK Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n7vaq50sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 17:24:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9OHO89a021894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 17:24:08 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9OHO5aV017460;
        Wed, 24 Oct 2018 17:24:05 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 10:24:05 -0700
Date:   Wed, 24 Oct 2018 10:24:10 -0700
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
Subject: Re: [PATCH -V6 00/21] swap: Swapout/swapin THP in one piece
Message-ID: <20181024172410.a3pibijoc2u2awwo@ca-dmjordan1.us.oracle.com>
References: <20181010071924.18767-1-ying.huang@intel.com>
 <20181023122738.a5j2vk554tsx4f6i@ca-dmjordan1.us.oracle.com>
 <87sh0wuijl.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh0wuijl.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:31:42AM +0800, Huang, Ying wrote:
> Hi, Daniel,
> 
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Wed, Oct 10, 2018 at 03:19:03PM +0800, Huang Ying wrote:
> >> And for all, Any comment is welcome!
> >> 
> >> This patchset is based on the 2018-10-3 head of mmotm/master.
> >
> > There seems to be some infrequent memory corruption with THPs that have been
> > swapped out: page contents differ after swapin.
> 
> Thanks a lot for testing this!  I know there were big effort behind this
> and it definitely will improve the quality of the patchset greatly!

You're welcome!  Hopefully I'll have more results and tests to share in the
next two weeks.

> 
> > Reproducer at the bottom.  Part of some tests I'm writing, had to separate it a
> > little hack-ily.  Basically it writes the word offset _at_ each word offset in
> > a memory blob, tries to push it to swap, and verifies the offset is the same
> > after swapin.
> >
> > I ran with THP enabled=always.  THP swapin_enabled could be always or never, it
> > happened with both.  Every time swapping occurred, a single THP-sized chunk in
> > the middle of the blob had different offsets.  Example:
> >
> > ** > word corruption gap
> > ** corruption detected 14929920 bytes in (got 15179776, expected 14929920) **
> > ** corruption detected 14929928 bytes in (got 15179784, expected 14929928) **
> > ** corruption detected 14929936 bytes in (got 15179792, expected 14929936) **
> > ...pattern continues...
> > ** corruption detected 17027048 bytes in (got 15179752, expected 17027048) **
> > ** corruption detected 17027056 bytes in (got 15179760, expected 17027056) **
> > ** corruption detected 17027064 bytes in (got 15179768, expected 17027064) **
> 
> 15179776 < 15179xxx <= 17027064
> 
> 15179776 % 4096 = 0
> 
> And 15179776 = 15179768 + 8
> 
> So I guess we have some alignment bug.  Could you try the patches
> attached?  It deal with some alignment issue.

That fixed it.  And removed three lines of code.  Nice :)
