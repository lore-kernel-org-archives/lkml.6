Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DA98AC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93401208DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93401208DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935762AbeFMVFF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:05:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:19952 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935526AbeFMVFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:05:03 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5DL4DvL009430;
        Thu, 14 Jun 2018 06:04:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Thu, 14 Jun 2018 06:04:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5DL47VD009397
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 14 Jun 2018 06:04:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block <linux-block@vger.kernel.org>
References: <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
 <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
 <CA+55aFx=CwNCg08HUeyYWc-WWuPkQBXVJDvHfrBjraTy-3MRWQ@mail.gmail.com>
 <20180613164509.oeb3fsjylfpfzxuh@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4a70ca66-3352-10aa-d351-e3fa3baebffc@i-love.sakura.ne.jp>
Date:   Thu, 14 Jun 2018 06:04:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613164509.oeb3fsjylfpfzxuh@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/14 1:45, Jan Kara wrote:
> On Wed 13-06-18 09:25:03, Linus Torvalds wrote:
>> On Wed, Jun 13, 2018 at 9:21 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> Since multiple addresses share bit_wait_table[256], isn't it possible that
>>> cgwb_start_shutdown() prematurely returns false due to wake_up_bit() by
>>> hash-conflicting addresses (i.e. not limited to clear_and_wake_up_bit() from
>>> wb_shutdown())? I think that we cannot be sure without confirming that
>>> test_bit(WB_shutting_down, &wb->state) == false after returning from schedule().
>>
>> Right.
>>
>> That's _always_ true, btw. Something else entirely could have woken
>> you up. TASK_UNINTERRUPTIBLE does not mean "nothing else wakes me", it
>> just means "_signals_ don't wake me".
>>
>> So every single sleep always needs to be in a loop. Always.
> 
> Agreed and in my patch it actually is in a loop - the one iterating the
> list of active writeback structures. If we get a false wakeup, we find the
> same structure in the list again and wait again...

Indeed. I overlooked that wb = list_first_entry() will select same wb again
if cgwb_remove_from_bdi_list() is not yet called. Well, we could update
"(in which case we also wait for it to finish)" part or move the body of
cgwb_start_shutdown() to cgwb_bdi_unregister() so that it becomes clear
that false wake-up is not a problem in this case.
