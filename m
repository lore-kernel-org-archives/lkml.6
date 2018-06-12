Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6509EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C94208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SV+GkUPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C94208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeFLMGS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:06:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35066 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932412AbeFLMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:06:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CC5l1R146193;
        Tue, 12 Jun 2018 12:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=6poXulIUtzztQ5grNIfag9zQknDDPzpU3plil3fEJGU=;
 b=SV+GkUPWIJvozZhMIlwOjKY0+EBPbpHtINyfslaD2iJllMrMBtw1kuJab8VGjZKuxAmU
 dtFNSFdkKY/B18rBNlnNAM2ZjIBexJm0pScOzMhz4KFCDMf/RUrEYiOTwBKA1qu0B1R7
 6gND602ZO9gXhhlWhfcOzr6vUUQv1OPOUedjqlakenc03AtEbr+hvDGQZUYBHmJvaAUM
 N3A436yV4gxQDG4yEGZq+VeBcnnC6WSnEcjD1joHVSBCdE5+5tU5oPAIq1wQeUzubjAB
 9KZCbOP+T/ruZFoWyYGBDuOwCxf3Q0J9y2CyLhKR6CnBTFqwcMNO5XxK+O2tDYCsO6Nn 7w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jg4dm1vv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:05:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CC5oH9024345
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:05:50 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CC5n7N004307;
        Tue, 12 Jun 2018 12:05:49 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 05:05:49 -0700
Date:   Tue, 12 Jun 2018 05:05:47 -0700
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
Message-ID: <20180612120547.njpz73dymeru5mzy@ca-dmjordan1.us.oracle.com>
References: <20180523082625.6897-1-ying.huang@intel.com>
 <20180523082625.6897-4-ying.huang@intel.com>
 <20180611204231.ojhlyrbmda6pouxb@ca-dmjordan1.us.oracle.com>
 <87o9ggpzlk.fsf@yhuang-dev.intel.com>
 <87k1r4puen.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1r4puen.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:15:28AM +0800, Huang, Ying wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> >> On Wed, May 23, 2018 at 04:26:07PM +0800, Huang, Ying wrote:
> >>> @@ -3516,11 +3512,39 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> >>
> >> Two comments about this part of __swap_duplicate as long as you're moving it to
> >> another function:
> >>
> >>    } else if (count || has_cache) {
> >>    
> >>    	if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)          /* #1   */
> >>    		count += usage;
> >>    	else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)     /* #2   */
> >>    		err = -EINVAL;
> >>
> >> #1:  __swap_duplicate_locked might use
> >>
> >>     VM_BUG_ON(usage != SWAP_HAS_CACHE && usage != 1);
> >>
> >> to document the unstated assumption that usage is 1 (otherwise count could
> >> overflow).
> >
> > Sounds good.  Will do this.
> 
> Found usage parameter of __swap_duplicate() could be SWAP_MAP_SHMEM too.
> We can improve the parameter checking.  But that appears not belong to
> this series.

Fair enough, I'll see about adding this along with the other patch I'm sending.

Daniel
