Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE55BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8373320836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8373320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964776AbeFRRow (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:44:52 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19801 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbeFRRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:44:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b27ef980000>; Mon, 18 Jun 2018 10:44:56 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Jun 2018 10:44:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Jun 2018 10:44:54 -0700
Received: from [10.2.175.123] (10.2.175.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 17:44:49 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Christoph Hellwig <hch@infradead.org>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <20180617012510.20139-3-jhubbard@nvidia.com>
 <20180618075650.GA7300@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7295d9c3-ecc3-ae60-1818-72b0565741ff@nvidia.com>
Date:   Mon, 18 Jun 2018 10:44:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618075650.GA7300@infradead.org>
X-Originating-IP: [10.2.175.123]
X-ClientProxiedBy: HQMAIL102.nvidia.com (172.18.146.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks for looking at this...

On 06/18/2018 12:56 AM, Christoph Hellwig wrote:
> On Sat, Jun 16, 2018 at 06:25:10PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> This fixes a few problems that come up when using devices (NICs, GPUs,
>> for example) that want to have direct access to a chunk of system (CPU)
>> memory, so that they can DMA to/from that memory. Problems [1] come up
>> if that memory is backed by persistence storage; for example, an ext4
>> file system. I've been working on several customer bugs that are hitting
>> this, and this patchset fixes those bugs.
> 
> What happens if we do get_user_page from two different threads or even
> processes on the same page?  As far as I can tell from your patch
> the first one finishing the page will clear the bit and then we are
> back to no protection.

The patch does not do that. The flag is only ever cleared when the page is 
freed. That can't happen until each of the two threads above is done and 
calls put_page(). So while there may be other design issues here, the above 
case is not one of them. :)


thanks,
-- 
John Hubbard
NVIDIA
