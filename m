Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED033C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD4020C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD4020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeIMSIr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:08:47 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:9182 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbeIMSEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:34 -0400
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     Michal Hocko <mhocko@kernel.org>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>, <selinux@tycho.nsa.gov>,
        <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>,
        Eric Paris <eparis@parisplace.org>,
        <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        <syzkaller-bugs@googlegroups.com>, linux-mm <linux-mm@kvack.org>
References: <000000000000038dab0575476b73@google.com>
 <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
 <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
 <9d685700-bc5c-9c2f-7795-56f488d2ea38@sony.com>
 <20180913111135.GA21006@dhcp22.suse.cz>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <ec6547f4-6240-d901-b2d2-b5103a10493f@sony.com>
Date:   Thu, 13 Sep 2018 14:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913111135.GA21006@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 01:11 PM, Michal Hocko wrote:
> On Thu 13-09-18 09:12:04, peter enderborg wrote:
>> On 09/13/2018 08:26 AM, Tetsuo Handa wrote:
>>> On 2018/09/13 12:02, Paul Moore wrote:
>>>> On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
>>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>> syzbot is hitting warning at str_read() [1] because len parameter can
>>>>> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
>>>>> this case.
>>>>>
>>>>> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
>>>>>
>>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>>> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
>>>>> ---
>>>>>  security/selinux/ss/policydb.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>>>>> index e9394e7..f4eadd3 100644
>>>>> --- a/security/selinux/ss/policydb.c
>>>>> +++ b/security/selinux/ss/policydb.c
>>>>> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>>>>>         if ((len == 0) || (len == (u32)-1))
>>>>>                 return -EINVAL;
>>>>>
>>>>> -       str = kmalloc(len + 1, flags);
>>>>> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
>>>>>         if (!str)
>>>>>                 return -ENOMEM;
>>>> Thanks for the patch.
>>>>
>>>> My eyes are starting to glaze over a bit chasing down all of the
>>>> different kmalloc() code paths trying to ensure that this always does
>>>> the right thing based on size of the allocation and the different slab
>>>> allocators ... are we sure that this will always return NULL when (len
>>>> + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
>>>> configurations?
>>>>
>>> Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
>>> ZERO_SIZE_PTR) due to (len == (u32)-1) check above.
>>>
>>> The only concern would be whether you want allocation failure messages.
>>> I assumed you don't need it because we are returning -ENOMEM to the caller.
>>>
>> Would it not be better with
>>
>>     char *str;
>>
>>     if ((len == 0) || (len == (u32)-1) || (len >= KMALLOC_MAX_SIZE))
>>         return -EINVAL;
>>
>>     str = kmalloc(len + 1, flags);
>>     if (!str)
>>         return -ENOMEM;
> I strongly suspect that you want kvmalloc rather than kmalloc here. The
> larger the request the more likely is the allocation to fail.
>
> I am not familiar with the code but I assume this is a root only
> interface so we don't have to worry about nasty users scenario.
>
I don't think we get any big data there at all. Usually less than 32 bytes. However this data can be in fast path so a vmalloc is not an option.

And some of the calls are GFP_ATOMC.



