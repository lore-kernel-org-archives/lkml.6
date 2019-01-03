Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E708C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63E520675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MktrgIXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfACTkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:40:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40527 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfACTkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:40:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so38117196qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 11:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aFI0giJYbhNPFznjR5oQTctli4EP+mqQQk/jyhXI+1I=;
        b=MktrgIXyWDg/eGQT1DInn+Xjxd6FA7VWIGgIy3veEfIq3U5CheVtOiMwBzrHHI9i0p
         AdRtio7DqVYJLe2tOv6CAxUqUyXykmjWc5w8cGe+z/rgTi/3N33tnyMq9DkxHvlID9F1
         dG2LKcMyWMAsi61bmgsZ1tfX01Grq6/RiZwxQVjZqcSzwF4C5h2O70bjdfQNUJUpHcuJ
         iNdOLGhIBv0AGwJMcldsp8VGjPoTIUadCzXvMDGwkQfPsZuNugeT8ZLoITKkE4xZalfG
         vXTYHtpZH3Ku8N8THOQiybDcjzNK8tYrakM/x75E8Nh4ts0H3VezwebuxYlA3b6QWGyd
         T1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aFI0giJYbhNPFznjR5oQTctli4EP+mqQQk/jyhXI+1I=;
        b=ErqdwshXIXCyZ7YCdrvxc+SpnoluCo0cBQKt/FiylPbbTE88ypgwzFfQqr5EJgWsLp
         zBYJ3ZSpsdYBsgUvcAJyvH7F/YQ1LWRGQBg0ZYheP+/h2ml+vBLqDsj+1gO0TdsfGEzd
         ibLaC+32O/R4W3q47xlHlkC61DY0BVe/jyCSDEaDVcL6ZCRjgdJx/nPdB7h/6UioM6ZV
         xEVFITaIQTcoWYhEovIYQWLseiMOVdFia3x2pPT2bK5wU04Zdrr4z3VyzWbjO0oem7Le
         qiE3Xg+gtp+29z/SwCZn0ZtfmdmZ4tU3s3kyqK7Rx+vQeWPWLkP2euCw+TLBRP9fsG3i
         YlIQ==
X-Gm-Message-State: AJcUukc2274grauZKvpVc7AuDxShAI/SHA18LLWFRxrf6ZKYwV+KcvNv
        PXuxr42KvSWNNVrT19eszwU1RQ==
X-Google-Smtp-Source: AFSGD/Up8YpxMeJvDNJQx6kpoWhR9AJFbT7y1rs5YNjd1QvqsyQV+0Vnc2Ttu1WtwVkvic58LyE13g==
X-Received: by 2002:ac8:6151:: with SMTP id d17mr46702472qtm.194.1546544437694;
        Thu, 03 Jan 2019 11:40:37 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n68sm25417957qte.66.2019.01.03.11.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 11:40:37 -0800 (PST)
Subject: Re: possible deadlock in __wake_up_common_lock
To:     Mel Gorman <mgorman@techsingularity.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        xieyisheng1@huawei.com, zhong jiang <zhongjiang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190102180611.GE31517@techsingularity.net>
 <CACT4Y+YMc0hiU-taTmwvm_6u4hAruBWV0qAz_Bp4f2a6JC-UiA@mail.gmail.com>
 <20190103163750.GH31517@techsingularity.net>
From:   Qian Cai <cai@lca.pw>
Message-ID: <c6c65844-604c-91ab-1b55-64a02accad18@lca.pw>
Date:   Thu, 3 Jan 2019 14:40:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103163750.GH31517@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 11:37 AM, Mel Gorman wrote:
> On Wed, Jan 02, 2019 at 07:29:43PM +0100, Dmitry Vyukov wrote:
>>>> This wakeup_kswapd is new due to Mel's 1c30844d2dfe ("mm: reclaim small
>>>> amounts of memory when an external fragmentation event occurs") so CC Mel.
>>>>
>>>
>>> New year new bugs :(
>>
>> Old too :(
>> https://syzkaller.appspot.com/#upstream-open
>>
> 
> Well, that can ruin a day! Lets see can we knock one off the list.
> 
>>> While I recognise there is no test case available, how often does this
>>> trigger in syzbot as it would be nice to have some confirmation any
>>> patch is really fixing the problem.
>>
>> This info is always available over the "dashboard link" in the report:
>> https://syzkaller.appspot.com/bug?extid=93d94a001cfbce9e60e1
>>
> 
> Noted for future reference.
> 
>> In this case it's 1. I don't know why. Lock inversions are easier to
>> trigger in some sense as information accumulates globally. Maybe one
>> of these stacks is hard to trigger, or maybe all these stacks are
>> rarely triggered on one machine. While the info accumulates globally,
>> non of the machines are actually run for any prolonged time: they all
>> crash right away on hundreds of known bugs.
>>
>> So good that Qian can reproduce this.
> 
> I think this might simply be hard to reproduce. I tried for hours on two
> separate machines and failed. Nevertheless this should still fix it and
> hopefully syzbot picks this up automaticlly when cc'd. If I hear
> nothing, I'll send the patch unconditionally (and cc syzbot). Hopefully
> Qian can give it a whirl too.
> 
> Thanks
> 
> --8<--
> mm, page_alloc: Do not wake kswapd with zone lock held
> 
> syzbot reported the following and it was confirmed by Qian Cai that a
> similar bug was visible from a different context.
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.20.0+ #297 Not tainted
> ------------------------------------------------------
> syz-executor0/8529 is trying to acquire lock:
> 000000005e7fb829 (&pgdat->kswapd_wait){....}, at:
> __wake_up_common_lock+0x19e/0x330 kernel/sched/wait.c:120
> 
> but task is already holding lock:
> 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: spin_lock
> include/linux/spinlock.h:329 [inline]
> 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue_bulk
> mm/page_alloc.c:2548 [inline]
> 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: __rmqueue_pcplist
> mm/page_alloc.c:3021 [inline]
> 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue_pcplist
> mm/page_alloc.c:3050 [inline]
> 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue
> mm/page_alloc.c:3072 [inline]
> 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at:
> get_page_from_freelist+0x1bae/0x52a0 mm/page_alloc.c:3491
> 
> It appears to be a false positive in that the only way the lock
> ordering should be inverted is if kswapd is waking itself and the
> wakeup allocates debugging objects which should already be allocated
> if it's kswapd doing the waking. Nevertheless, the possibility exists
> and so it's best to avoid the problem.
> 
> This patch flags a zone as needing a kswapd using the, surprisingly,
> unused zone flag field. The flag is read without the lock held to
> do the wakeup. It's possible that the flag setting context is not
> the same as the flag clearing context or for small races to occur.
> However, each race possibility is harmless and there is no visible
> degredation in fragmentation treatment.
> 
> While zone->flag could have continued to be unused, there is potential
> for moving some existing fields into the flags field instead. Particularly
> read-mostly ones like zone->initialized and zone->contiguous.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Tested-by: Qian Cai <cai@lca.pw>
