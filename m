Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D375EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD07218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qtvcv1dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfBKVjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:39:15 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3741 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKVjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:39:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61eb820000>; Mon, 11 Feb 2019 13:39:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 13:39:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 13:39:13 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 21:39:13 +0000
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>, <netdev@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211201643.7599-3-ira.weiny@intel.com> <20190211203916.GA2771@ziepe.ca>
 <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
 <20190211212652.GA7790@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <fc9c880b-24f8-7063-6094-00175bc27f7d@nvidia.com>
Date:   Mon, 11 Feb 2019 13:39:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211212652.GA7790@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549921154; bh=R+UlXOuMWfVxi1VL88CZYA09pYGWsh6bByyqUXE80pw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qtvcv1dQDcYvz4XLbG382DqyBtFs0gGgLPWo8Xn6GcqHHK/Q47qW1gn5PIm2Xqek0
         gsbpKLrTKOVlrsCPC7xQHKj0uU0zX+fN8JCfmpHUZsqa6mspIwjvkroaL2vUqeQThB
         quUlcyu2fED+SuC5Ielkoooxk21AXSf/qrNDpehuUvaP4RIOSyWK0CK5jbn9d/4ZRX
         If5r4u/Fu3FG2rAgipSY8cm5Tm047SxqP/wKz9RzJgyp81HeZJMI+VZtahMpyOU0fk
         Nk7XjF3ubZa+WGlxRmO2x0qbr3vD1iicYykjC7ShI8CoBdzWB4/xHEmZe3hVGYi4re
         CqxTmm2qLEtWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 1:26 PM, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 01:13:56PM -0800, John Hubbard wrote:
>> On 2/11/19 12:39 PM, Jason Gunthorpe wrote:
>>> On Mon, Feb 11, 2019 at 12:16:42PM -0800, ira.weiny@intel.com wrote:
>>>> From: Ira Weiny <ira.weiny@intel.com>
>> [...]
>> It seems to me that the longterm vs. short-term is of questionable value.
> 
> This is exactly why I did not post this before.  I've been waiting our other
> discussions on how GUP pins are going to be handled to play out.  But with the
> netdev thread today[1] it seems like we need to make sure we have a "safe" fast
> variant for a while.  Introducing FOLL_LONGTERM seemed like the cleanest way to
> do that even if we will not need the distinction in the future...  :-(

Yes, I agree. Below...

> [...]
> This is also why I did not change the get_user_pages_longterm because we could
> be ripping this all out by the end of the year...  (I hope. :-)
> 
> So while this does "pollute" the GUP family of calls I'm hoping it is not
> forever.
> 
> Ira
> 
> [1] https://lkml.org/lkml/2019/2/11/1789
> 

Yes, and to be clear, I think your patchset here is fine. It is easy to find
the FOLL_LONGTERM callers if and when we want to change anything. I just think
also it's appopriate to go a bit further, and use FOLL_LONGTERM all by itself.

That's because in either design outcome, it's better that way:

-- If we keep the concept of "I'm a long-term gup call site", then FOLL_LONGTERM
is just right. The gup API already has _fast and non-fast variants, and once
you get past a couple, you end up with a multiplication of names that really
work better as flags. We're there.

-- If we drop the concept, then you've already done part of the work, by removing
the _longterm API variants.



thanks,
-- 
John Hubbard
NVIDIA
