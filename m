Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D4EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01A6214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N+9Ixzzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBKVWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:22:14 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8920 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBKVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:22:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61e7620000>; Mon, 11 Feb 2019 13:21:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 13:22:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 13:22:12 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 21:22:12 +0000
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        <lsf-pc@lists.linux-foundation.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
References: <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <fb507b56-7f8f-cf2c-285c-bae3b2d72c4f@nvidia.com>
Date:   Mon, 11 Feb 2019 13:22:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549920098; bh=DjZRhIk6nj+66m80d2y4KoL4uboyuqGSUxmbuZ6C5i8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=N+9IxzziTXqH/Fz777iPdO26xuw8ZbKxPM7kRnNSRVXNsIaFbmKoZMzMEpboec7Re
         ljo6HMwO8Y/66jKpjoOzBjlG+8bJ4sZ1YCHUYdZDEvpQZhKbUIDSUZ42zfweoclQJL
         XbP/TIVO642z/clG3ILn8hZwLlC/hjT/tXOaKiomlGbhpPbci1Mp/68A6pKpTZACeJ
         Tuj94uUpRl3BLr0QmejPoETKhVMg5B/ojN5UwwUvE2jSV2kzMZoraIiPobHIdalr/A
         SiLVhoepPUfMnPcdz/xQhlmXYrTYUVcB8GaSUXUijPb+o2kGWiuiGpFMPs35QJ6OG0
         oazuwFxQPOUMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 10:19 AM, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 11:06:54AM -0700, Jason Gunthorpe wrote:
>> On Mon, Feb 11, 2019 at 09:22:58AM -0800, Dan Williams wrote:
[...]
> John's patches will indicate to the FS that the page is gup pinned.  But they
> will not indicate longterm vs not "shorterm".  A shortterm pin could be handled
> as a "real truncate".  So, are we back to needing a longterm "bit" in struct
> page to indicate a longterm pin and allow the FS to perform this "virtual
> write" after truncate?
> 
> Or is it safe to consider all gup pinned pages this way?
> 
> Ira
> 

I mentioned this in another thread, but I'm not great at email threading. :)
Anyway, it seems better to just drop the entire "longterm" concept from the 
internal APIs, and just deal in "it's either gup-pinned *at the moment*, or 
it's not". And let the filesystem respond appropriately. So for a pinned page 
that hits clear_page_dirty_for_io or whatever else care about pinned pages:

-- fire mmu notifiers, revoke leases, generally do everything as if it were a
long term gup pin

-- if it's long term, then you've taken the right actions.

-- if the pin really is short term, everything works great anyway.


The only way that breaks is if longterm pins imply an irreversible action, such
as blocking and waiting in a way that you can't back out of or get interrupted
out of. And the design doesn't seem to be going in that direction, right?

thanks,
-- 
John Hubbard
NVIDIA
