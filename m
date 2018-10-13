Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDEC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577020693
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qUbC9MYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeJNE6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:58:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8803 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeJNE6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:58:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc2617d0000>; Sat, 13 Oct 2018 14:19:58 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 13 Oct 2018 14:19:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 13 Oct 2018 14:19:58 -0700
Received: from [10.2.167.215] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 13 Oct
 2018 21:19:57 +0000
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
To:     Christoph Hellwig <hch@infradead.org>
CC:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-5-jhubbard@nvidia.com> <20181013035516.GA18822@dastard>
 <7c2e3b54-0b1d-6726-a508-804ef8620cfd@nvidia.com>
 <20181013164740.GA6593@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <005bc69b-ffa8-ccb4-db0b-3f4c52a54745@nvidia.com>
Date:   Sat, 13 Oct 2018 14:19:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181013164740.GA6593@infradead.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539465598; bh=fIOY++3HJ/l6aRCZYvEftRFb/hyqT6DSGFixGDY+my4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qUbC9MYm/ITHZ7pLL3s8WZRNyNBXx0tSN2TDNrPa5vQxshDqxkb4UeckO5v00H7Si
         m9vxl68dSCoraFB8YvVVqb9XLhAfSIhHVQXyu+8H+UYB5Gl27FZhK/kbczrhJGSMqW
         xvl6e0VCtkK/U3UrDiZ7x5WonrsD+BmAjlDgKso16ZDZCVXY8FC7eFRFqBW3pwx0aw
         2ivGlB/skQh86+Z245GJii/Ct8W0t8SYlW/LGlSztdulchdHTCBve2eqy/Ey8Yc3X/
         iCS33FDqS9FzSX7hyHa6tl9D1yXsF6DjlWD04rw9gWsdCAhZOkeRIosqF/jIb/K4Oe
         Db2pnjNcpu11w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/18 9:47 AM, Christoph Hellwig wrote:
> On Sat, Oct 13, 2018 at 12:34:12AM -0700, John Hubbard wrote:
>> In patch 6/6, pin_page_for_dma(), which is called at the end of get_user_pages(),
>> unceremoniously rips the pages out of the LRU, as a prerequisite to using
>> either of the page->dma_pinned_* fields. 
>>
>> The idea is that LRU is not especially useful for this situation anyway,
>> so we'll just make it one or the other: either a page is dma-pinned, and
>> just hanging out doing RDMA most likely (and LRU is less meaningful during that
>> time), or it's possibly on an LRU list.
> 
> Have you done any benchmarking what this does to direct I/O performance,
> especially for small I/O directly to a (fast) block device?

Not yet. I can go do that now. If you have any particular test suites, benchmarks,
or just programs to recommend, please let me know. So far, I see

   tools/testing/selftests/vm/gup_benchmark.c


-- 
thanks,
John Hubbard
NVIDIA
 
