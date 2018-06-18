Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D7C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E11F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E11F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935814AbeFRSPD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:15:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2587 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935533AbeFRSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:15:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b27f6ac0001>; Mon, 18 Jun 2018 11:15:08 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Jun 2018 11:15:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Jun 2018 11:15:02 -0700
Received: from [10.2.175.123] (10.2.175.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 18:15:01 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca>
 <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
 <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
Date:   Mon, 18 Jun 2018 11:14:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
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

On 06/18/2018 10:56 AM, Dan Williams wrote:
> On Mon, Jun 18, 2018 at 10:50 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>> On 06/18/2018 01:12 AM, Christoph Hellwig wrote:
>>> On Sun, Jun 17, 2018 at 01:28:18PM -0700, John Hubbard wrote:
>>>> Yes. However, my thinking was: get_user_pages() can become a way to indicate that
>>>> these pages are going to be treated specially. In particular, the caller
>>>> does not really want or need to support certain file operations, while the
>>>> page is flagged this way.
>>>>
>>>> If necessary, we could add a new API call.
>>>
>>> That API call is called get_user_pages_longterm.
>>
>> OK...I had the impression that this was just semi-temporary API for dax, but
>> given that it's an exported symbol, I guess it really is here to stay.
> 
> The plan is to go back and provide api changes that bypass
> get_user_page_longterm() for RDMA. However, for VFIO and others, it's
> not clear what we could do. In the VFIO case the guest would need to
> be prepared handle the revocation.
 
OK, let's see if I understand that plan correctly:

1. Change RDMA users (this could be done entirely in the various device drivers'
code, unless I'm overlooking something) to use mmu notifiers, and to do their
DMA to/from non-pinned pages.

2. Return early from get_user_pages_longterm, if the memory is...marked for
RDMA? (How? Same sort of page flag that I'm floating here, or something else?)
That would avoid the problem with pinned pages getting their buffer heads
removed--by disallowing the pinning. Makes sense.

Also, is there anything I can help with here, so that things can happen sooner? 


