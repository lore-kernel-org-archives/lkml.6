Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCFBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FA020869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FA020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeH1OW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:22:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:39939 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH1OW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:22:27 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7SAVKgY080349;
        Tue, 28 Aug 2018 19:31:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Tue, 28 Aug 2018 19:31:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7SAVK4Z080343
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 28 Aug 2018 19:31:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] block/loop: Serialize ioctl operations.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <ce5ce21a-5865-36c5-a110-eed11f785ab2@I-love.SAKURA.ne.jp>
 <748bce03-afda-4ed2-13b3-1fcd01d57770@kernel.dk>
 <9a9209af-c841-6034-4b4f-46d93aa0c037@i-love.sakura.ne.jp>
 <92bffcc8-c25d-2297-80b3-24ba99075cd6@i-love.sakura.ne.jp>
Message-ID: <7986e524-1dc8-8d8e-51bc-a5671d7555cc@i-love.sakura.ne.jp>
Date:   Tue, 28 Aug 2018 19:31:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <92bffcc8-c25d-2297-80b3-24ba99075cd6@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, did you come up with a better alternative?
We have another bug which is causing many hung task reports.
I do want to make progress rather than stall for another three month.

On 2018/07/11 23:29, Tetsuo Handa wrote:
> Since syzbot restarted testing linux-next.git , it is a good chance
> to test this patch for unexpected regressions (until you come up with
> a good alternative).
> 
> On 2018/06/26 23:34, Tetsuo Handa wrote:
>> Did you get any idea?
>>
>> On 2018/06/05 3:13, Jens Axboe wrote:
>>> On 6/4/18 5:19 AM, Tetsuo Handa wrote:
>>>> This problem was already ignored for 8 months. Unless we boost priority,
>>>> this problem will be ignored for years. Jens, can we test this patch?
>>>
>>> Sorry, it's just that I _really_ hate this patch. We're making up
>>> a weird locking primitive that tracks the process, with a weird
>>> unlock helper that only unlocks if it's the process that is
>>> holding the mutex.
>>>
>>> I'll try and think about this a bit, it would be nice if we had
>>> a better alternative than the above.
>>>
