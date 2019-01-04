Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA57C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3B20665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfADIue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:50:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:60314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfADIud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:50:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34CD2AFD7;
        Fri,  4 Jan 2019 08:50:32 +0000 (UTC)
Subject: Re: KMSAN: uninit-value in mpol_rebind_mm
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        xieyisheng1@huawei.com, zhong jiang <zhongjiang@huawei.com>
References: <000000000000c06550057e4cac7c@google.com>
 <a71997c3-e8ae-a787-d5ce-3db05768b27c@suse.cz>
 <CACT4Y+bRvwxkdnyRosOujpf5-hkBwd2g0knyCQHob7p=0hC=Dw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <52835ef5-6351-3852-d4ba-b6de285f96f5@suse.cz>
Date:   Fri, 4 Jan 2019 09:50:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bRvwxkdnyRosOujpf5-hkBwd2g0knyCQHob7p=0hC=Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 9:42 AM, Dmitry Vyukov wrote:
> On Thu, Jan 3, 2019 at 9:36 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>>
>> On 12/31/18 8:51 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    79fc24ff6184 kmsan: highmem: use kmsan_clear_page() in cop..
>>> git tree:       kmsan
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13c48b67400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=901dd030b2cc57e7
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=b19c2dc2c990ea657a71
>>> compiler:       clang version 8.0.0 (trunk 349734)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com
>>>
>>> ==================================================================
>>> BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:353 [inline]
>>> BUG: KMSAN: uninit-value in mpol_rebind_mm+0x249/0x370 mm/mempolicy.c:384
>>
>> The report doesn't seem to indicate where the uninit value resides in
>> the mempolicy object.
> 
> Yes, it doesn't and it's not trivial to do. The tool reports uses of
> unint _values_. Values don't necessary reside in memory. It can be a
> register, that come from another register that was calculated as a sum
> of two other values, which may come from a function argument, etc.

I see. BTW, the patch I sent will be picked up for testing, or does it
have to be in mmotm/linux-next first?
