Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D312087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QmGB2XeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D312087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJKB7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:59:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16207 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJKB7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:59:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbe46830000>; Wed, 10 Oct 2018 11:35:47 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Oct 2018 11:35:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Oct 2018 11:35:52 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 10 Oct
 2018 18:35:51 +0000
Subject: Re: [PATCH v5 2/3] mm: introduce put_user_page*(), placeholder
 versions
To:     Jan Kara <jack@suse.cz>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
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
References: <20181010041134.14096-1-jhubbard@nvidia.com>
 <20181010041134.14096-3-jhubbard@nvidia.com>
 <20181010080326.GB11507@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <75681b69-2db6-bc46-efe3-48d029c9ec22@nvidia.com>
Date:   Wed, 10 Oct 2018 11:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010080326.GB11507@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539196547; bh=uuzy98t+35kgVpMWWrEVSc1gMK1AzZ+8sAv9hVmUX0I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QmGB2XeWRlkVSRlElXUd/cvbzb7vLR0/0VysUHcUfB3xAEqpqYoiRQVDlC8vPzUfX
         oQ2stQHp3hUqOE/xagd5YCGrYXu8c4b8CT5aSU0A9ESfQYEZIUgb5pjf81XxOhqBSg
         c6LL/AXjY4OOczKPJy2I+D6VOgjRAyndVti7R3kSWIKNyY7bahSckvInqZzHCYAXKl
         zfXyHKwyEVlmiHaopWgI2OPlAdknxwkmHKuzH1rJrW2x3hSZsykfaqiX+GwwfulFZM
         NyCLVGo/d2J3NwmnhQwRC1DGMg7JC7qCEsgaTQb/I6Cy8y6tg+qzv37oWjS1kkwSBa
         EHt0oNWycVlew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 1:03 AM, Jan Kara wrote:
> On Tue 09-10-18 21:11:33, john.hubbard@gmail.com wrote:
>> +/*
>> + * put_user_pages() - for each page in the @pages array, release the page
>> + * using put_user_page().
>> + *
>> + * Please see the put_user_page() documentation for details.
>> + *
>> + * This is just like put_user_pages_dirty(), except that it invokes
>> + * set_page_dirty_lock(), instead of set_page_dirty().
> 
> This paragraph should be deleted. Other than that the patch looks good.
> 

Good catch. Fixed locally, and it will go up with the next spin.

thanks,
-- 
John Hubbard
NVIDIA
