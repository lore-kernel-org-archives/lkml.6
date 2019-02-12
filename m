Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD71AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2E021B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfBLVHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:07:32 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:33892 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfBLVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:07:32 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1CL7UsS021116;
        Wed, 13 Feb 2019 06:07:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Wed, 13 Feb 2019 06:07:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1CL7OOv021047
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 13 Feb 2019 06:07:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] proc, oom: do not report alien mms when setting
 oom_score_adj
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20190212102129.26288-1-mhocko@kernel.org>
 <20190212125635.27742b5741e92a0d47690c53@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <46b3262e-2a9a-da01-16de-14cd4d7eaa40@i-love.sakura.ne.jp>
Date:   Wed, 13 Feb 2019 06:07:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212125635.27742b5741e92a0d47690c53@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/13 5:56, Andrew Morton wrote:
> On Tue, 12 Feb 2019 11:21:29 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
>> Tetsuo has reported that creating a thousands of processes sharing MM
>> without SIGHAND (aka alien threads) and setting
>> /proc/<pid>/oom_score_adj will swamp the kernel log and takes ages [1]
>> to finish. This is especially worrisome that all that printing is done
>> under RCU lock and this can potentially trigger RCU stall or softlockup
>> detector.
>>
>> The primary reason for the printk was to catch potential users who might
>> depend on the behavior prior to 44a70adec910 ("mm, oom_adj: make sure
>> processes sharing mm have same view of oom_score_adj") but after more
>> than 2 years without a single report I guess it is safe to simply remove
>> the printk altogether.
>>
>> The next step should be moving oom_score_adj over to the mm struct and
>> remove all the tasks crawling as suggested by [2]
>>
>> [1] http://lkml.kernel.org/r/97fce864-6f75-bca5-14bc-12c9f890e740@i-love.sakura.ne.jp
>> [2] http://lkml.kernel.org/r/20190117155159.GA4087@dhcp22.suse.cz
> 
> I think I'll put a cc:stable on this.  Deleting a might-trigger debug
> printk is safe and welcome.
> 

Putting cc:stable is fine. But I doubt the usefulness of this patch.
If nobody really depends on the behavior prior to 44a70adec910,
we should remove the pointless (otherwise racy) iteration itself.
