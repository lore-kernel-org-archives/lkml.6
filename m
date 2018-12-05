Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DC720834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LR8LIybN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DC720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeLEBFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:05:38 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19093 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:05:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c07245e0000>; Tue, 04 Dec 2018 17:05:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Dec 2018 17:05:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 17:05:37 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 01:05:37 +0000
Subject: Re: [PATCH 0/2] put_user_page*(): start converting the call sites
To:     David Laight <David.Laight@ACULAB.COM>,
        "'john.hubbard@gmail.com'" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Jan Kara <jack@suse.cz>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <b31c7b3359344e778fc525013eeece64@AcuMS.aculab.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <cfba998a-8217-bf03-f0d0-c95708aea03d@nvidia.com>
Date:   Tue, 4 Dec 2018 17:05:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <b31c7b3359344e778fc525013eeece64@AcuMS.aculab.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543971934; bh=+r+7FKGjKDkL8pa6jmZv04z58r1rXWiJI/ilZa/ZAQ8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LR8LIybNvNdXE4e2Y53L/XPiqTyr+AlckoIhwuxnMbyUk6RmTO2+KZRnWJzqgwmd5
         oV0Qx9kj0b/dqmWVtcNfFfmcFErNXm1KziIgL5FU6kJdvkSSrqn4S5GAII7Pc3dxMC
         ZY7SXjm90wbVQ+TK7YBxLOkimnjFi5vtMgIM2XGo+nZL8ZUbU3CXaOLHygLfUSw4B+
         KlH9jb0pnsdq3gKHkkwEQexmw9ptN5UwPQLdHxI7yd126e9KsBLsETj/48bNOKQfsj
         EVEKeU5P1VThtlETYkWONHlgGTxcxd7hl6257RXrICrkH5H9jK6g06QmKXc9FBcy9Q
         kFKmwMMAK0Qrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 9:10 AM, David Laight wrote:
> From: john.hubbard@gmail.com
>> Sent: 04 December 2018 00:17
>>
>> Summary: I'd like these two patches to go into the next convenient cycle.
>> I *think* that means 4.21.
>>
>> Details
>>
>> At the Linux Plumbers Conference, we talked about this approach [1], and
>> the primary lingering concern was over performance. Tom Talpey helped me
>> through a much more accurate run of the fio performance test, and now
>> it's looking like an under 1% performance cost, to add and remove pages
>> from the LRU (this is only paid when dealing with get_user_pages) [2]. So
>> we should be fine to start converting call sites.
>>
>> This patchset gets the conversion started. Both patches already had a fair
>> amount of review.
> 
> Shouldn't the commit message contain actual details of the change?
> 

Hi David,

This "patch 0000" is not a commit message, as it never shows up in git log.
Each of the follow-up patches does have details about the changes it makes.

But maybe you are really asking for more background information, which I
should have added in this cover letter. Here's a start:

https://lore.kernel.org/r/20181110085041.10071-1-jhubbard@nvidia.com

...and it looks like this small patch series is not going to work out--I'm
going to have to fall back to another RFC spin. So I'll be sure to include 
you and everyone on that. Hope that helps.

thanks,
-- 
John Hubbard
NVIDIA
