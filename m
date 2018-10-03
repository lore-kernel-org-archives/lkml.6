Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637A7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5D421477
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I3N1Qc2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5D421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJDGOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:14:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6993 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeJDGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:14:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb54f7e0000>; Wed, 03 Oct 2018 16:23:43 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 03 Oct 2018 16:23:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 03 Oct 2018 16:23:45 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 23:23:44 +0000
Subject: Re: [PATCH 2/4] mm: introduce put_user_page(), placeholder version
To:     Jan Kara <jack@suse.cz>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-4-jhubbard@nvidia.com>
 <20181003162237.GH24030@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6178c173-ffbf-700b-f140-e4b184a5767e@nvidia.com>
Date:   Wed, 3 Oct 2018 16:23:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003162237.GH24030@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538609023; bh=n9Wd8nyNZM+WL0w3Pxufod1o3vq8rCYqcun0XhJBM1Q=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I3N1Qc2dWJMQ3noSEH5BTCDakWuBsf+z94QMtmYqR2p9RjNWSv7o9BsDsTdJPodVB
         v13Ul2a3OQNFbCP5L35na90IF6WBKrhw1QBJzk0i6sk37FwWOQO7Wz1RqAqdn3bjcA
         Bu571UlXzH0qtR1/pPYWSg/G503vwJbcWt9e2/APbiC7Ot3r60xoHX3mvKq42PGC76
         iX1qw6YFN/RpH3qvMn3ZE++2+GbSmdltLzhRz+3FCD3MMyPJchQgGGze00+E22V+wC
         4JQYIdZdvfiFCA456y5vsBM7rX38YO2EldOLuUe0gFiQwO67aNenx3cKF98wYiueWA
         OPsPye4Jn8kpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/18 9:22 AM, Jan Kara wrote:
> On Thu 27-09-18 22:39:48, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Introduces put_user_page(), which simply calls put_page().
>> This provides a way to update all get_user_pages*() callers,
>> so that they call put_user_page(), instead of put_page().
>>
>> Also adds release_user_pages(), a drop-in replacement for
>> release_pages(). This is intended to be easily grep-able,
>> for later performance improvements, since release_user_pages
>> is not batched like release_pages() is, and is significantly
>> slower.
> 
> A small nit but can we maybe call this put_user_pages() for symmetry with
> put_user_page()? I don't really care too much but it would look natural to
> me.
> 

Sure. It started out as "make it a drop-in replacement for release_pages()",
but now it's not quite a drop-in replacement anymore. And in any case it's an 
opportunity to make the name more intuitive, so that seems like a good
idea.

If anyone hates put_user_pages() and wants to campaign relentlessly for
release_pages*(), then now is the time! :)


thanks,
-- 
John Hubbard
NVIDIA
