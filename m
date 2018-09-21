Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8082EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C02221557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eM7GHbLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C02221557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbeIUXgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:36:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390365AbeIUXgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:36:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8LHi2fC085412;
        Fri, 21 Sep 2018 17:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wdArMeQ93xUNUpwyynd+emiktW+QtTMunaFHDD3TuFo=;
 b=eM7GHbLHow37XEpG7JhIq34PvEzqj8GGewBaKArINgNvIuk0qUUm7mdwMBQfc+6VH7zR
 JQ98VO0xpUBZTwox0ujd0N9SgFm4GUiygkF7ZPUEY9cyi4yee/4KAL7LeIietKyK8VXA
 GnicKmUWKkRESJiIaxrsYzUBDokRo5xtBrHTP7UQD20b7DWI5DLUnwNoEQV3c5aqNOTC
 x3Yl1fF3AqgZVuFNOFjEMClaKbI9rB48alUhgFkcItjxeMbke8Xgog6tNX6WPcBidZIF
 m6HAjDpf7zha4FA/YTRkc0+y7pOuIuaPhpdc2R8Loy8CkvxrDTjwhdn9qpIb8zP+9kaW Yw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mmkm24kn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 17:45:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8LHjaoa025400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 17:45:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8LHjZah030487;
        Fri, 21 Sep 2018 17:45:35 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Sep 2018 10:45:35 -0700
Date:   Fri, 21 Sep 2018 10:45:36 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Yosef Lev <levyossi@icloud.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH 0/9] Improve zone lock scalability using Daniel
 Jordan's list work
Message-ID: <20180921174536.7igaoi36rg76auy4@ca-dmjordan1.us.oracle.com>
References: <20180911053616.6894-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911053616.6894-1-aaron.lu@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9023 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:36:07PM +0800, Aaron Lu wrote:
> Daniel Jordan and others proposed an innovative technique to make
> multiple threads concurrently use list_del() at any position of the
> list and list_add() at head position of the list without taking a lock
> in this year's MM summit[0].
> 
> People think this technique may be useful to improve zone lock
> scalability so here is my try.

Nice, this uses the smp_list_* functions well in spite of the limitations you
encountered with them here.

> Performance wise on 56 cores/112 threads Intel Skylake 2 sockets server
> using will-it-scale/page_fault1 process mode(higher is better):
> 
> kernel        performance      zone lock contention
> patch1         9219349         76.99%
> patch7         2461133 -73.3%  54.46%(another 34.66% on smp_list_add())
> patch8        11712766 +27.0%  68.14%
> patch9        11386980 +23.5%  67.18%

Is "zone lock contention" the percentage that readers and writers combined
spent waiting?  I'm curious to see read and write wait time broken out, since
it seems there are writers (very likely on the allocation side) spoiling the
parallelism we get with the read lock.

If the contention is from allocation, I wonder whether it's feasible to make
that path use SMP list functions.  Something like smp_list_cut_position
combined with using page clusters from [*] to cut off a chunk of list.  Many
details to keep in mind there, though, like having to unset PageBuddy in that
list chunk when other tasks can be concurrently merging pages that are part of
it.

Or maybe what's needed is a more scalable data structure than an array of
lists, since contention on the heads seems to be the limiting factor.  A simple
list that keeps the pages in most-recently-used order (except when adding to
the list tail) is good for cache warmth, but I wonder how helpful that is when
all CPUs can allocate from the front.  Having multiple places to put pages of a
given order/mt would ease the contention.

> Though lock contention reduced a lot for patch7, the performance dropped
> considerably due to severe cache bouncing on free list head among
> multiple threads doing page free at the same time, because every page free
> will need to add the page to the free list head.

Could be beneficial to take an MCS-style approach in smp_list_splice/add so
that multiple waiters aren't bouncing the same cacheline around.  This is
something I'm planning to try on lru_lock.

Daniel

[*] https://lkml.kernel.org/r/20180509085450.3524-1-aaron.lu@intel.com
