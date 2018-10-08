Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F04BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6B62085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dC2c8e8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6B62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJIEMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:12:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7226 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:12:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbbc5130006>; Mon, 08 Oct 2018 13:58:59 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 08 Oct 2018 13:59:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 08 Oct 2018 13:59:04 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 8 Oct
 2018 20:59:03 +0000
Subject: Re: [PATCH v3 3/3] infiniband/mm: convert put_page() to
 put_user_page*()
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
References: <20181006024949.20691-1-jhubbard@nvidia.com>
 <20181006024949.20691-4-jhubbard@nvidia.com>
 <20181008194240.GA27639@ziepe.ca>
 <15d3daac-ba59-b1c9-873d-1876b58bde9d@nvidia.com>
 <20181008205602.GD27639@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b0f469c7-25dd-d86c-315d-149a9a64e231@nvidia.com>
Date:   Mon, 8 Oct 2018 13:59:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008205602.GD27639@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539032340; bh=Wilvtm2hCZhMdh0LRNo/btRTADv63SHeL/fVeDvU0jM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dC2c8e8P4dQmiSXaLb9KantoFES9X7Vr0LJqRJf4eRIzoQL5elAc4gfm6KBcz9npi
         xhhZKWPkss/LNKlhuaq/0f8GOVoLxpiGybG/Try5ETYBfzM4R2XGDNc6vhZE/oGtcj
         nl/bO1Ws213MY1fP8W//rtgVlgPzZf4/aCxWGMMn+OJmT7tcR4jcudRjvLsC2UwiBP
         nJVwTM2D2VoKKC2u15bhTrEJIo3UKyuhsmWtrtNx+5fj03k1HNmSd5owjlJzuJNydx
         uP30+jpyW0bZb45q8McNKO8xdpGdo9Ja6pbeTVBQmS6VlD3G0B58WdENL+0DtNgCcY
         XjH7aPm4nnd5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 1:56 PM, Jason Gunthorpe wrote:
> On Mon, Oct 08, 2018 at 01:37:35PM -0700, John Hubbard wrote:
>> On 10/8/18 12:42 PM, Jason Gunthorpe wrote:
>>> On Fri, Oct 05, 2018 at 07:49:49PM -0700, john.hubbard@gmail.com wrote:
>>>> From: John Hubbard <jhubbard@nvidia.com>
>> [...]
>>>>  drivers/infiniband/core/umem.c              |  7 ++++---
>>>>  drivers/infiniband/core/umem_odp.c          |  2 +-
>>>>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>>>>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>>>>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>>>>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++++----
>>>>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
>>>>  7 files changed, 24 insertions(+), 28 deletions(-)
>>>
>>> I have no issues with this, do you want this series to go through the
>>> rdma tree? Otherwise:
>>>
>>> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
>>>
>>
>> The RDMA tree seems like a good path for this, yes, glad you suggested
>> that.
>>
>> I'll post a v4 with the comment fix and the recent reviewed-by's, which
>> should be ready for that.  It's based on today's linux.git tree at the 
>> moment, but let me know if I should re-apply it to the RDMA tree.
> 
> I'm unclear who needs to ack the MM sections for us to take it to
> RDMA?
> 
> Otherwise it is no problem..
> 

It needs Andrew Morton (+CC) and preferably also Michal Hocko (already on CC).

thanks,
-- 
John Hubbard
NVIDIA
