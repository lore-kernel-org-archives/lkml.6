Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47968C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0230020864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g7K2M8Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0230020864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933928AbeGIRVJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:21:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46180 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933479AbeGIRVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:21:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69HJIF2075517;
        Mon, 9 Jul 2018 17:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cdz6Fc8Y45/mytGQB11dZk7enR4eI9uNICfJV2mGcO0=;
 b=g7K2M8LdvUDHEilqS7tQEr5X1lzLKiBsVyusqjOfxcrTyMbiN4d3MBlPubg7i8XDNwq6
 ggQqhnIC1UcdRfHyyPb5Nlyl8EMe64YQQuAC8QLxUP7AHwEq1pOEwDFHYg2YxDRw8aWB
 VLJixt6OhCKQTdGxbOvo7E12/lIFJHAO5yH+S/d7/lqpp4s+ZvevBk/IGVC1PqdcYsNg
 GzPnsPc+jd2NMHRett9WVoE4PWMhYHBtyHtpuBrDg6zru7Inh+eTXGGa2KaxnfuZG+he
 fzdyx8o4m7aXMP441Ji4YvCSNrQp4R5RFFvA0YR2uadwhHbar8IAwsy8Zkv1aLIWJ8QF pA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k2p75n6nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 17:20:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69HKb8p019800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 17:20:37 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69HKZqe014970;
        Mon, 9 Jul 2018 17:20:35 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 10:20:35 -0700
Date:   Mon, 9 Jul 2018 10:20:37 -0700
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
Subject: Re: [PATCH -mm -v4 14/21] mm, cgroup, THP, swap: Support to move
 swap account for PMD swap mapping
Message-ID: <20180709172037.254zyuadep2hj5po@ca-dmjordan1.us.oracle.com>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180622035151.6676-15-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622035151.6676-15-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8948 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:51:44AM +0800, Huang, Ying wrote:
> Because there is no way to prevent a huge swap cluster from being
> split except when it has SWAP_HAS_CACHE flag set.

What about making get_mctgt_type_thp take the cluster lock?  That function
would be the first lock_cluster user outside of swapfile.c, but it would
serialize with split_swap_cluster.

> It is possible for
> the huge swap cluster to be split and the charge for the swap slots
> inside to be changed, after we check the PMD swap mapping and the huge
> swap cluster before we commit the charge moving.  But the race window
> is so small, that we will just ignore the race.

Moving the charges is a slow path, so can't we just be correct here and not
leak?
