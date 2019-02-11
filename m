Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22865205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kXNHhFIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfBKWdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:33:55 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11878 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfBKWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:33:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61f8540000>; Mon, 11 Feb 2019 14:33:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 14:33:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 14:33:54 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 22:33:53 +0000
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        <lsf-pc@lists.linux-foundation.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
References: <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <fb507b56-7f8f-cf2c-285c-bae3b2d72c4f@nvidia.com>
 <20190211221247.GI24692@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <018c1a05-5fd8-886a-573b-42649949bba8@nvidia.com>
Date:   Mon, 11 Feb 2019 14:33:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211221247.GI24692@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549924436; bh=YrcCJUXUeBjmMXB4uAD+t8FoXjzbCfi0g/YDioIq2Sw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kXNHhFIlhXR6pc/L0Z1RTsNAjsVn4a6I560QWLYgQ/t3+67h3c1paRKSx60lQxe0p
         96BPi5SdqVdeSYR/Z1X7YmtQLd9GURSz4xtlAI2vtr5b82Vwtn+p/pkGq8RDPYigHU
         ZuuNEPd5AU2TPsX66w/GQLDFVIcd/DMFAN5TLcnqJeSq81JKez3cfR7HeQNyIGDl2w
         sprTQRrmmTv/AJ9hWUI7vermVLhyEFMgQtS7EjVnt0mN2KXDkHZaw2ZJc6Lb0ut3cG
         Jxc14gDufMUn/mJsi0Gk/AZWTUFARxEQnKlobPAEnQoxMnFHz0ogmBMiEDrKK9NRgS
         R4CnKnY1GNrfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 2:12 PM, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 01:22:11PM -0800, John Hubbard wrote:
> 
>> The only way that breaks is if longterm pins imply an irreversible action, such
>> as blocking and waiting in a way that you can't back out of or get interrupted
>> out of. And the design doesn't seem to be going in that direction, right?
> 
> RDMA, vfio, etc will always have 'long term' pins that are
> irreversible on demand. It is part of the HW capability.
> 

Yes, I get that about the HW. But I didn't quite phrase it accurately. What I
meant was, irreversible from the kernel code's point of view; specifically,
the filesystem while in various writeback paths.

But anyway, Jan's proposal a bit earlier today [1] is finally sinking into
my head--if we actually go that way, and prevent the caller from setting up
a problematic gup pin in the first place, then that may make this point sort
of moot.


> I think the flag is badly named, it is really more of a
> GUP_LOCK_PHYSICAL_ADDRESSES flag.
> 
> ie indicate to the FS that is should not attempt to remap physical
> memory addresses backing this VMA. If the FS can't do that it must
> fail.
> 

Yes. Duration is probably less important than the fact that the page
is specially treated.

[1] https://lore.kernel.org/r/20190211102402.GF19029@quack2.suse.cz
thanks,
-- 
John Hubbard
NVIDIA
