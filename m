Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652FEC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5E820881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5E820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeIMLed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:34:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48529 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeIMLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:34:33 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8D6QTqS073383;
        Thu, 13 Sep 2018 15:26:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Thu, 13 Sep 2018 15:26:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8D6QLB8073341
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 13 Sep 2018 15:26:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, peter.enderborg@sony.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>
References: <000000000000038dab0575476b73@google.com>
 <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
Date:   Thu, 13 Sep 2018 15:26:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/13 12:02, Paul Moore wrote:
> On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> syzbot is hitting warning at str_read() [1] because len parameter can
>> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
>> this case.
>>
>> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
>> ---
>>  security/selinux/ss/policydb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>> index e9394e7..f4eadd3 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>>         if ((len == 0) || (len == (u32)-1))
>>                 return -EINVAL;
>>
>> -       str = kmalloc(len + 1, flags);
>> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
>>         if (!str)
>>                 return -ENOMEM;
> 
> Thanks for the patch.
> 
> My eyes are starting to glaze over a bit chasing down all of the
> different kmalloc() code paths trying to ensure that this always does
> the right thing based on size of the allocation and the different slab
> allocators ... are we sure that this will always return NULL when (len
> + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
> configurations?
> 

Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
ZERO_SIZE_PTR) due to (len == (u32)-1) check above.

The only concern would be whether you want allocation failure messages.
I assumed you don't need it because we are returning -ENOMEM to the caller.
