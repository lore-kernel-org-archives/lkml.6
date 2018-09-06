Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9667AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA44206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA44206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeIFOfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:35:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60237 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725809AbeIFOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:35:22 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="44559141"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Sep 2018 18:00:37 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 7D3704B6AE18;
        Thu,  6 Sep 2018 18:00:37 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Sep 2018 18:00:45 +0800
Date:   Thu, 6 Sep 2018 18:00:13 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, <x86@kernel.org>
Subject: Re: [PATCH 0/3] x86/boot/KASLR: enhance randomness of kernel load
 addr when using GiB hugepage
Message-ID: <20180906100013.GD8555@localhost.localdomain>
References: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
 <20180906040723.GC8555@localhost.localdomain>
 <CAFgQCTtafOH45aPZeLwi7bWoJTjjKq7dp2_VAF1hHVrwG0qRKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFgQCTtafOH45aPZeLwi7bWoJTjjKq7dp2_VAF1hHVrwG0qRKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 7D3704B6AE18.A8FFD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:58:08PM +0800, Pingfan Liu wrote:
>On Thu, Sep 6, 2018 at 12:07 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>
>> On Thu, Sep 06, 2018 at 10:36:19AM +0800, Pingfan Liu wrote:
>>
>> Hi Pingfan,
>>
>> >commit 747ff6265db4 ("x86/boot/KASLR: Skip specified number of 1GB huge
>> >pages when doing physical randomization (KASLR)") and commit
>> >9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages
>> >handling") prevent the physical load addr of kernel from spoiling a good
>> >candidate of GiB page. But the algorithm deterministicly chooses the most
>> >front GiB page for hugetlb, and sacrifices the randomness, which
>> >is the heart of the KASLR. This patch tries to enlarge the randomness in
>> >the cases where hugepages=X < the num Y of good candidate of GiB
>>
>> Yes, in some situations, if Y > X, the patch would reduce the
>> randomness. And to reserve a fixed 1G for huge page is not perfect
>> enouth.
>> But the the size of slot is so small, the size of memory is so big.
>>
>Yes, but this is the sense of a human,. and normally, we are protected
>against the attack from a program.
>

Well, in my opinion, the problem that Baoquan tried to fix exists
only when Y == X. If Y > X, I think the problem is not a big problem,
even though kernel breaks a good 1G memory for huge page, there are still
enough place left.

>> >page.
>> >To comparison, taking a typical KVM guest for example, the head 3GiB mem
>> >can not be used as GiB hugetlb. Denoting the total mem size as Z(GiB), when
>> >Z=5, then Y=2, assuming X=1, the randomness range before this patch is
>> >4GiB, after this patch is 5GiB, and get a 25% improvement of randomness.
>>
>> Such as your example,
>> in 4G, the probability every slot chosen is about 0.00049
>> in 5G, the probability every slot chosen is about 0.00039
>> Yes, you did improve 25% for randomness. But I wonder if it's worth to
>> improve from 0.00049 to 0.00039.
>>
>This is the case of least improvement.
>
>> If there is something wrong in my understanding, please let me know.
>>
>Yes, you get my idea. There are two factor worth to consider. The 1st
>one is the head 3GiB, if it can be reduce to 1GiB or 2GiB, then the

Yes, as you said, from a human's feeling, I think if there are more
than one thousand slots, the probability is small enough.
In some situations, your patch improve the randomness much. As for whether
it's worth to do, let's see how other people think.

Thanks,
Chao Fan

>randomness will have a great improvement. The 2nd one is the X, which
>also play a important role of the randomness.
>
>Thanks and regards,
>Pingfan
>
>> Thanks,
>> Chao Fan
>>
>> >If Z=6, then Y=3, assuming X=2, the improvement equals: 50%( 6/(6-2) - 1);
>> >assuming X=1, the improvement will be: 20% (6/(6-1) - 1)
>> >
>> >Cc: Thomas Gleixner <tglx@linutronix.de>
>> >Cc: Ingo Molnar <mingo@redhat.com>
>> >Cc: "H. Peter Anvin" <hpa@zytor.com>
>> >Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> >Cc: Baoquan He <bhe@redhat.com>
>> >Cc: Chao Fan <fanc.fnst@cn.fujitsu.com> (authored:1/16=6%)
>> >Cc: x86@kernel.org
>> >
>> >Pingfan Liu (3):
>> >  x86/boot/KASLR: change the prototypes of
>> >    process_efi_entries/process_e820_entries
>> >  x86/boot/KASLR: change the prototype of process_mem_region() to meet
>> >    the align requirement
>> >  x86/boot/KASLR: enhance randomness when using GiB hugepage
>> >
>> > arch/x86/boot/compressed/kaslr.c | 228 ++++++++++++++++++++++++++-------------
>> > 1 file changed, 152 insertions(+), 76 deletions(-)
>> >
>> >--
>> >2.7.4
>> >
>> >
>> >
>>
>>
>
>


