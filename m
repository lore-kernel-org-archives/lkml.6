Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0657C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CE72084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B6mdTEc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfALUqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 15:46:24 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1062 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfALUqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 15:46:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3a520f0000>; Sat, 12 Jan 2019 12:46:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 12 Jan 2019 12:46:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 12 Jan 2019 12:46:21 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Jan
 2019 20:46:20 +0000
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Jan
 2019 20:46:21 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        "Dave Chinner" <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "John Hubbard" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20190103015533.GA15619@redhat.com>
 <20190103092654.GA31370@quack2.suse.cz> <20190103144405.GC3395@redhat.com>
 <a79b259b-3982-b271-025a-0656f70506f4@nvidia.com>
 <20190111165141.GB3190@redhat.com>
 <1b37061c-5598-1b02-2983-80003f1c71f2@nvidia.com>
 <20190112020228.GA5059@redhat.com>
 <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
 <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190112032533.GD5059@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9c80b708-35fa-3264-f114-b4d568939437@nvidia.com>
Date:   Sat, 12 Jan 2019 12:46:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190112032533.GD5059@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL102.nvidia.com (172.18.146.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547325967; bh=S5Ve03vaCXwHxIylHrHXTXq61SQp1ualr/VOmbbPK4M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=B6mdTEc8J4L+vxmPnvh2LMfZg62OITAz3mtChLxLDlNlNg/ULoNQEQKSGyJogwPYI
         atHUfrgDu36CWs02kKFr3ogRiYUm5g5XM82JRt+BS9LVW27aCh0Bz5QrzmkJAUukTM
         Nk9zhsXdbcZcNII2w1Oq24yK5PXnph07smMyZ/Ifvf2w0VoRJJs+8YWBHZ9n1IH1RU
         iYeY+U0lhdSbBXXUUIkuyrjrwdS7+YAstGQflcQgTqtapsQuAWE0cAUgLjVD8ZXKfZ
         X38BO8N+KDa0aQvHwFPHmYH+boWy5Ea1lFXjPritx/gmXyZ/uB4ooMnkTzXn60iRhM
         4/yj0MtS91d7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 7:25 PM, Jerome Glisse wrote:
[...]
>>>> Why is it that page lock cannot be used for gup fast, btw?
>>>
>>> Well it can not happen within the preempt disable section. But after
>>> as a post pass before GUP_fast return and after reenabling preempt then
>>> it is fine like it would be for regular GUP. But locking page for GUP
>>> is also likely to slow down some workload (with direct-IO).
>>>
>>
>> Right, and so to crux of the matter: taking an uncontended page lock involves
>> pretty much the same set of operations that your approach does. (If gup ends up
>> contended with the page lock for other reasons than these paths, that seems
>> surprising.) I'd expect very similar performance.
>>
>> But the page lock approach leads to really dramatically simpler code (and code
>> reviews, let's not forget). Any objection to my going that direction, and keeping
>> this idea as a Plan B? I think the next step will be, once again, to gather some
>> performance metrics, so maybe that will help us decide.
> 
> They are already work load that suffer from the page lock so adding more
> code that need it will only worsen those situations. I guess i will do a
> patchset with my solution as it is definitly lighter weight that having to
> take the page lock.
> 

Hi Jerome,

I expect that you're right, and in any case, having you code up the new 
synchronization parts is probably a smart idea--you understand it best. To avoid
duplicating work, may I propose these steps:

1. I'll post a new RFC, using your mapcount idea, but with a minor variation: 
using the page lock to synchronize gup() and page_mkclean(). 

   a) I'll also include a github path that has enough gup callsite conversions
   done, to allow performance testing. 

   b) And also, you and others have provided a lot of information that I want to
   turn into nice neat comments and documentation.

2. Then your proposed synchronization system would only need to replace probably
one or two of the patches, instead of duplicating the whole patchset. I dread
having two large, overlapping patchsets competing, and hope we can avoid that mess.

3. We can run performance tests on both approaches, hopefully finding some test
cases that will highlight whether page lock is a noticeable problem here.

Or, the other thing that could happen is someone will jump in here and NAK anything
involving the page lock, based on long experience, and we'll just go straight to
your scheme anyway.  I'm sorta expecting that any minute now. :)

thanks,
-- 
John Hubbard
NVIDIA
