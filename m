Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C154BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B15420835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZxwYf3wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbfBMC6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:58:24 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17653 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfBMC6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:58:12 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6387c60000>; Tue, 12 Feb 2019 18:58:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2019 18:58:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Feb 2019 18:58:11 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Feb
 2019 02:58:10 +0000
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Christopher Lameter <cl@linux.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
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
 <018c1a05-5fd8-886a-573b-42649949bba8@nvidia.com>
 <01000168e29418ba-81301f56-9370-4555-b70c-3ad51be84543-000000@email.amazonses.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b8794103-5ae1-ff8d-22be-d585d36e6310@nvidia.com>
Date:   Tue, 12 Feb 2019 18:58:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <01000168e29418ba-81301f56-9370-4555-b70c-3ad51be84543-000000@email.amazonses.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550026694; bh=pYuUD8ixt0DUBPAmr4vJCg8DY/4XZggnruE+tkGT2iI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZxwYf3wvJ76h2srywAkRBqh0CcEH377shxMYRyeclrKz53nOM8sGge/1XvuYsP9ar
         TmhlGr4nkQbxlKf+4H6dRCTef9wcC0cdAvx0n9d4KZZ6x0utDA4UkbGE/+pYafrpvv
         7VlWtcpwsZCx/7SNoI5JM5QydMnIWsESr6vNbAQLIrbmrdJhCcsD5Vq+Pi0tnHtoCf
         C8DwXWTDxFBDspe1bsrv4GSrCIGlrtw70AhRbRUx0jlk1wqIDcwavouzCD+43Ded6A
         KE35oMbqiXM0mWUKd1ikOhSMlmUS2v6yk7v1Dw2fBg+r1nI6bk33DSg7f9eGF2bRWn
         bOYN0flqnZMPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 8:39 AM, Christopher Lameter wrote:
> On Mon, 11 Feb 2019, John Hubbard wrote:
> 
>> But anyway, Jan's proposal a bit earlier today [1] is finally sinking into
>> my head--if we actually go that way, and prevent the caller from setting up
>> a problematic gup pin in the first place, then that may make this point sort
>> of moot.
> 
> Ok well can be document how we think it would work somewhere? Long term
> mapping a page cache page could a problem and we need to explain that
> somewhere.
> 

Yes, once the dust settles, I think Documentation/vm/get_user_pages.rst is the
right place. I started to create that file, but someone observed that my initial
content was entirely backward-looking (described the original problem, instead 
of describing how the new system would work). So I'll use this opportunity for 
a do-over. :)

thanks,
-- 
John Hubbard
NVIDIA
