Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6921532
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A+5PQQII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA6921532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeJJHvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:51:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18386 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeJJHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:51:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbd48940002>; Tue, 09 Oct 2018 17:32:20 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Oct 2018 17:32:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Oct 2018 17:32:18 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 10 Oct
 2018 00:32:16 +0000
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>
CC:     <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <20181009083025.GE11150@quack2.suse.cz>
 <20181009162012.c662ef0b041993557e150035@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <62492f47-d51f-5c41-628c-ff17de21829e@nvidia.com>
Date:   Tue, 9 Oct 2018 17:32:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009162012.c662ef0b041993557e150035@linux-foundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539131540; bh=GUCg8cPP+mBlc4rVdnuWV5cH6WRG/fccH/MuopV7ZSQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A+5PQQIIqiXtqldyKeS92AVu8RwHk3BMXUFHGkswDPuthFaCkFHjwbuyEQAzknkjF
         bZDRgPNWKjvYPS5M7MrcyLSKisyAl9P0IxzNPZXiEQxQbVxrv4CEHfHwNxPdQrpLzR
         I09voG3prwW+ZT+3H3jT4U09qry6vyD78cyVZaA5EcKTSsuoDUjvlRVNxDT3SDls93
         OQPRljHA9844DcJFbg4R1Zow+OHqCGb00hvgevwZi6LBRmVlS9lmdsPpAIum3vX1aF
         Rm6EvB189/7j2oiiblKVD7MbXsGvrCe05D6vp4n2PbMlNBShxO21Hdrs7zmgzUgl4i
         Hjxn6GzWT1T2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 4:20 PM, Andrew Morton wrote:
> On Tue, 9 Oct 2018 10:30:25 +0200 Jan Kara <jack@suse.cz> wrote:
> 
>>> Also, maintainability.  What happens if someone now uses put_page() by
>>> mistake?  Kernel fails in some mysterious fashion?  How can we prevent
>>> this from occurring as code evolves?  Is there a cheap way of detecting
>>> this bug at runtime?
>>
>> The same will happen as with any other reference counting bug - the special
>> user reference will leak. It will be pretty hard to debug I agree. I was
>> thinking about whether we could provide some type safety against such bugs
>> such as get_user_pages() not returning struct page pointers but rather some
>> other special type but it would result in a big amount of additional churn
>> as we'd have to propagate this different type e.g. through the IO path so
>> that IO completion routines could properly call put_user_pages(). So I'm
>> not sure it's really worth it.
> 
> I'm not really understanding.  Patch 3/3 changes just one infiniband
> driver to use put_user_page().  But the changelogs here imply (to me)
> that every user of get_user_pages() needs to be converted to
> s/put_page/put_user_page/.
> 
> Methinks a bit more explanation is needed in these changelogs?
> 

OK, yes, it does sound like the explanation is falling short. I'll work on something 
clearer. Did the proposed steps in the changelogs, such as:
  
[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

help at all, or is it just too many references, and I should write the words
directly in the changelog?

Anyway, patch 3/3 is a just a working example (which we do want to submit, though), and
many more conversions will follow. But they don't have to be done all upfront--they
can be done in follow up patchsets. 

The put_user_page*() routines are, at this point, not going to significantly change
behavior. 

I'm working on an RFC that will show what the long-term fix to get_user_pages and
put_user_pages will look like. But meanwhile it's good to get started on converting
all of the call sites.

thanks,
-- 
John Hubbard
NVIDIA
