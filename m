Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F4026792
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F4026792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754942AbeFZWyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:54:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:56364 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754826AbeFZWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:54:34 -0400
Received: from [62.203.87.61] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fXwqc-0001Qo-Ji; Wed, 27 Jun 2018 00:54:06 +0200
Subject: set_memory_* (was: Re: BUG: unable to handle kernel paging request in
 bpf_int_jit_compile)
To:     Ingo Molnar <mingo@kernel.org>, David Miller <davem@davemloft.net>
Cc:     tglx@linutronix.de,
        syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com,
        ast@kernel.org, hpa@zytor.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        x86@kernel.org, yoshfuji@linux-ipv6.org, peterz@infradead.org,
        labbott@redhat.com, keescook@chromium.org,
        torvalds@linux-foundation.org, edumazet@google.com
References: <000000000000d48c8e056f5b6c67@google.com>
 <alpine.DEB.2.21.1806240849150.8650@nanos.tec.linutronix.de>
 <20180624.161411.1560796210597132716.davem@davemloft.net>
 <20180624100249.GA9493@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b4841a84-cf65-f3fb-13b3-ea0a15f47bde@iogearbox.net>
Date:   Wed, 27 Jun 2018 00:53:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180624100249.GA9493@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24699/Tue Jun 26 22:40:42 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/2018 12:02 PM, Ingo Molnar wrote:
> * David Miller <davem@davemloft.net> wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Sun, 24 Jun 2018 09:09:09 +0200 (CEST)
>>
>>> I'm really tempted to make the BPF config switch depend on BROKEN. 
>>
>> This really isn't necessary Thomas.
>>
>> Whoever wrote the code didn't understand that set ro can legitimately
>> fail.
> 
> No, that's *NOT* the only thing that happened, according to the Git history.
> 
> The first use of set_memory_ro() in include/linux/filter.h was added by
> this commit almost four years ago:
> 
>   # 2014/09
>   60a3b2253c41 ("net: bpf: make eBPF interpreter images read-only")
> 
> ... and yes, that commit didn't anticipate the (in hindsight) obvious property of 
> a function that changes global kernel mappings that if it is used after bootup 
> without locking it 'may fail'. So that commit slipping through is 'shit happens' 
> and I don't think we ever complained about such things slipping through.

Hmm, back then I adapted the code similar from 314beb9bcabf ("x86: bpf_jit_comp:
secure bpf jit against spraying attacks") for interpreter images as well, and
from grepping through the kernel code none of the callers of set_memory_{ro,rw}()
at that time (& now except bpf) did check for the return code (e.g. module_enable_ro()
and module_disable_ro() as one example which could happen late after bootup has
finished when pulling in modules on the fly).

I did made the mistake in 9facc336876f ("bpf: reject any prog that failed read-only
lock") assuming that after the set_memory_ro() call it would either succeed or
it would not, but not leaving us in a state in the middle. That was silly assumption
and I'll fix this up in bpf, very sorry about that! I've been debugging the syzkaller
BUG at [1] and noticed that even though set_memory_ro() failed with an error, doing
a probe_kernel_write() on it afterwards failed with EFAULT, meaning the module_alloc()
memory was however set to read-only at that point triggering later the BUG when
attempting to change its memory (at least on the virtual mem). From debugging output,
it was a single 4k page and on x86_64 in the __change_page_attr_set_clr() we failed
in the cpa_process_alias() where the syzkaller fault injection happened. So latter
failure from cpa_process_alias() came from call to __change_page_attr_set_clr() with
primary to 0, where it tried to split a large page in __change_page_attr() but failed
in alloc_pages() thus returning the -ENOMEM from there. Testing subsequent undoing
via set_memory_rw() made it writable again, though.

In any case, for pairs like set_memory_ro() + set_memory_rw() that are also used
outside of bpf e.g. STRICT_MODULE_RWX and friends which are mostly default these
days for some archs, is the choice to not check errors from there by design or from
historical context that it originated from 'debugging code' in that sense (DEBUG_RODATA /
DEBUG_SET_MODULE_RONX) earlier? Also if no-one checks for errors (and if that would
infact be the recommendation it is agreed upon) should the API be changed to void,
or generally should actual error checking occur on these + potential rollback; but
then question is what about restoring part from prior set_memory_ro() via set_memory_rw()?
Kees/others, do you happen to have some more context on recommended use around this
by any chance? (Would probably also help if we add some doc around assumptions into
include/linux/set_memory.h for future users.)

Thanks a lot,
Daniel

  [1] https://syzkaller.appspot.com/bug?extid=a4eb8c7766952a1ca872
