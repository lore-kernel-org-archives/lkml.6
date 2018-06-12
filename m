Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B5BDCC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B27F2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXwzlphO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B27F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeFLMFK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:05:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49508 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbeFLMFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:05:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CBtZvh072757;
        Tue, 12 Jun 2018 12:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=+lHvNAHTQYdvhsgnNY2ltTLw6t99CbGpdjF1OOzCl5A=;
 b=aXwzlphObPDO62TKfG679UCnJ1kb40l1nLQbpuNLJhyyZYWaSI3xwjQepRZaUWDDZiO0
 p1Yu3u6ePnwkoKlrQB+OFTUyjgi3FJrO1ETH9+oxjIKARtyktB/EG7UtUe0YfqRRIq4U
 pk7Fstc230q/caSov5EQTgMVY2KFT7Y+Dzh9hgeDsgym61pcBye2czkjnxQgdmcXSswG
 aVzDYRL8+Xf5pccHi6+PqIT1XbIlJ5dP2p65rt+f8h7KNbOi731HTKWZaBjW7HX3uhUc
 iAzU6xvX/jyMpKQIZNdOkDU5BXaWuZncO7h7x4WK0URQtdaZab6JMNtPqWzdOLNR36v5 sQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jgecxgwhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:04:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CC4cQu001114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:04:38 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5CC4ZQe001968;
        Tue, 12 Jun 2018 12:04:35 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 05:04:35 -0700
Date:   Tue, 12 Jun 2018 05:04:30 -0700
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
Message-ID: <20180612120430.f4wce5hygca5wlhg@ca-dmjordan1.us.oracle.com>
References: <20180523082625.6897-1-ying.huang@intel.com>
 <20180523082625.6897-4-ying.huang@intel.com>
 <20180611204231.ojhlyrbmda6pouxb@ca-dmjordan1.us.oracle.com>
 <87o9ggpzlk.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9ggpzlk.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 09:23:19AM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > #2:  We've masked off SWAP_HAS_CACHE and COUNT_CONTINUED, and already checked
> > for SWAP_MAP_BAD, so I think condition #2 always fails and can just be removed.
> 
> I think this is used to check some software bug.  For example,
> SWAP_MAP_SHMEM will yield true here.

So it does!  And so __swap_duplicate returns -EINVAL in that case, which
swap_shmem_alloc just ignores.  Confusing, and an explicit check for
SWAP_MAP_SHMEM would be cleaner, but why fix what isn't broken.

> 
> >> +#ifdef CONFIG_THP_SWAP
> >> +static int __swap_duplicate_cluster(swp_entry_t *entry, unsigned char usage)
> > ...
> >> +	} else {
> >> +		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
> >> +retry:
> >> +			err = __swap_duplicate_locked(si, offset + i, 1);
> >
> > I guess usage is assumed to be 1 at this point (__swap_duplicate_locked makes
> > the same assumption).  Maybe make this explicit with
> >
> > 			err = __swap_duplicate_locked(si, offset + i, usage);
> >
> > , use 'usage' in cluster_set_count and __swap_entry_free too, and then
> > earlier have a
> >
> >        VM_BUG_ON(usage != SWAP_HAS_CACHE && usage != 1);
> >
> > ?
> 
> Yes.  I will fix this.  And we can just check it in
> __swap_duplicate_locked() and all these will be covered.

I'll respond to your other mail.

> > Not related to your changes, but while we're here, the comment with
> > SWAP_HAS_CONT in swap_count() could be deleted: I don't think there ever was a
> > SWAP_HAS_CONT.
> 
> Yes.  We should correct this.  Because this should go to a separate patch,
> would you mind to submit a patch to fix it?

Sure, I'll do that.

Daniel
