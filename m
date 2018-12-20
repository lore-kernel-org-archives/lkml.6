Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE23C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D82084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbeLTNaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:30:21 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:18484 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:30:20 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBKDUJPv016989;
        Thu, 20 Dec 2018 22:30:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Thu, 20 Dec 2018 22:30:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBKDU8no016710
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 20 Dec 2018 22:30:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <1545239047.14089.13.camel@synopsys.com>
 <49f9edc9-87ee-1efc-58f8-b0d9a52c8a49@synopsys.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <e2d2c160-0ef6-5504-7824-032a5c70fa7f@I-love.SAKURA.ne.jp>
Date:   Thu, 20 Dec 2018 22:30:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <49f9edc9-87ee-1efc-58f8-b0d9a52c8a49@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/20 10:16, Vineet Gupta wrote:
> On 12/19/18 9:04 AM, Eugeniy Paltsev wrote:
>> As I can see x86 use print_vma_addr() in their show_signal_msg()
>> function which allocate page with __get_free_page(GFP_NOWAIT);
> 
> Indeed with that the __get_free_page() lockdep splat is gone.
> 
> There's a different one now hence my other patch.
> 
> | [ARCLinux]# ./segv-null-ptr
> | potentially unexpected fatal signal 11.
> | BUG: sleeping function called from invalid context at kernel/fork.c:1011
> | in_atomic(): 1, irqs_disabled(): 0, pid: 70, name: segv-null-ptr
> | no locks held by segv-null-ptr/70.
> | CPU: 0 PID: 70 Comm: segv-null-ptr Not tainted 4.18.0+ #69
> |
> | Stack Trace:
> |  arc_unwind_core+0xcc/0x100
> |  ___might_sleep+0x17a/0x190
> |  mmput+0x16/0xb8

Then, does mmput_async() help?

> |  show_regs+0x52/0x310
> |  get_signal+0x5ee/0x610
> |  do_signal+0x2c/0x218
> |  resume_user_mode_begin+0x90/0xd8
