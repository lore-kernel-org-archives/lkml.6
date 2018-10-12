Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A63C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5769F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="uURwChfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5769F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeJLSwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:52:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41330 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJLSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:52:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id l41-v6so13399654qtl.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BYxMt47H/948Euu1M5kqnRDnnmkjCbhsQL8gLlTF8L8=;
        b=uURwChfzF5fAR0pbZYJc0kU3V7wzH65No0rLdNgtQx/4iOu5VEHVMN9p1smPS0PEGV
         dhYN8tAFaCtjLlfA4OXfOK4dWk7/vxp0c9m58g7bOZBj8AqLaJa81QHuTIoxu9aYUpbv
         RSsVcIluG6xzIoaQY5Hgu30Nrnq3ZxAMwVf08IqHxDdTMmQcy654BM8b6nrF043hy1PU
         MIeCqd0vQ0tXFAA8TJo64+pZWmDfovEehf18oWTzXSbSn9YTMRTsCdiJ5Ut08OX+9hJj
         CXZLLg9oYxoQbwGaAkRH07XIzUPMkJtzpxjq1ZYwuhFuiqX3UXVSZAXdqesQKCVLNUjx
         VLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYxMt47H/948Euu1M5kqnRDnnmkjCbhsQL8gLlTF8L8=;
        b=KWKnvvYbjMuXWYpNEeYyzfQeUdNRYGopozz986bgmPxkI3Mup7f0R7tmKGTe44oMdQ
         tuZoM32exj2iI/Lzx1lzxWkeHVU5OwvOdiFhNC+yCR8dgKSx+n88rSeEIkWosGnT27EN
         Ybfibynx72giUFhXtle+8IhLkfPqzH3UvCtHCmJ03atXkBISmbTz55g79uDjn43cQ93T
         5hqP9YO7IA+/VvUpM765RiflT+Y3M1O4YGragtntRwRVpdCw6MPtI2/wojJu/bWroJl9
         w8G8Q+lXeBr+G9rC6BYytFXIOW9pN6dn007JIcVccEFZwRoqNG9EpsCJ5MQ31DgCnX1J
         teuA==
X-Gm-Message-State: ABuFfojl0Cd/X8Z/UltJQEo55fFA4Vy3fHr8tIq5mEu0NTlZwkOo8t/f
        iElM58Qq4UVNObsbu3wGBRWR5Q==
X-Google-Smtp-Source: ACcGV615NNKmUOKmA8HAURXh6uIkjewO6jt3/OwwbTusvOJ1Fl146QVeS/5hUtZd5S+SZNoitnMwXA==
X-Received: by 2002:a0c:e901:: with SMTP id a1mr5445317qvo.37.1539343211360;
        Fri, 12 Oct 2018 04:20:11 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id m71-v6sm366218qke.71.2018.10.12.04.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:20:10 -0700 (PDT)
Date:   Fri, 12 Oct 2018 07:20:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Michal Hocko <mhocko@suse.com>, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, rientjes@google.com,
        yang.s@alibaba-inc.com
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
Message-ID: <20181012112008.GA27955@cmpxchg.org>
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010151135.25766-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:11:35PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> syzbot has noticed that it can trigger RCU stalls from the memcg oom
> path:
> RIP: 0010:dump_stack+0x358/0x3ab lib/dump_stack.c:118
> Code: 74 0c 48 c7 c7 f0 f5 31 89 e8 9f 0e 0e fa 48 83 3d 07 15 7d 01 00 0f
> 84 63 fe ff ff e8 1c 89 c9 f9 48 8b bd 70 ff ff ff 57 9d <0f> 1f 44 00 00
> e8 09 89 c9 f9 48 8b 8d 68 ff ff ff b8 ff ff 37 00
> RSP: 0018:ffff88017d3a5c70 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000040000 RBX: 1ffffffff1263ebe RCX: ffffc90001e5a000
> RDX: 0000000000040000 RSI: ffffffff87b4e0f4 RDI: 0000000000000246
> RBP: ffff88017d3a5d18 R08: ffff8801d7e02480 R09: fffffbfff13da030
> R10: fffffbfff13da030 R11: 0000000000000003 R12: 1ffff1002fa74b96
> R13: 00000000ffffffff R14: 0000000000000200 R15: 0000000000000000
>   dump_header+0x27b/0xf72 mm/oom_kill.c:441
>   out_of_memory.cold.30+0xf/0x184 mm/oom_kill.c:1109
>   mem_cgroup_out_of_memory+0x15e/0x210 mm/memcontrol.c:1386
>   mem_cgroup_oom mm/memcontrol.c:1701 [inline]
>   try_charge+0xb7c/0x1710 mm/memcontrol.c:2260
>   mem_cgroup_try_charge+0x627/0xe20 mm/memcontrol.c:5892
>   mem_cgroup_try_charge_delay+0x1d/0xa0 mm/memcontrol.c:5907
>   shmem_getpage_gfp+0x186b/0x4840 mm/shmem.c:1784
>   shmem_fault+0x25f/0x960 mm/shmem.c:1982
>   __do_fault+0x100/0x6b0 mm/memory.c:2996
>   do_read_fault mm/memory.c:3408 [inline]
>   do_fault mm/memory.c:3531 [inline]
> 
> The primary reason of the stall lies in an expensive printk handling
> of oom report flood because a misconfiguration on the syzbot side
> caused that there is simply no eligible task because they have
> OOM_SCORE_ADJ_MIN set. This generates the oom report for each allocation
> from the memcg context.
> 
> While normal workloads should be much more careful about potential heavy
> memory consumers that are OOM disabled it makes some sense to rate limit
> a potentially expensive oom reports for cases when there is no eligible
> victim found. Do that by moving the rate limit logic inside dump_header.
> We no longer rely on the caller to do that. It was only oom_kill_process
> which has been throttling. Other two call sites simply didn't have to
> care because one just paniced on the OOM when configured that way and
> no eligible task would panic for the global case as well. Memcg changed
> the picture because we do not panic and we might have multiple sources
> of the same event.
> 
> Once we are here, make sure that the reason to trigger the OOM is
> printed without ratelimiting because this is really valuable to
> debug what happened.
> 
> Reported-by: syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com
> Cc: guro@fb.com
> Cc: hannes@cmpxchg.org
> Cc: kirill.shutemov@linux.intel.com
> Cc: linux-kernel@vger.kernel.org
> Cc: penguin-kernel@i-love.sakura.ne.jp
> Cc: rientjes@google.com
> Cc: yang.s@alibaba-inc.com
> Signed-off-by: Michal Hocko <mhocko@suse.com>

So not more than 10 dumps in each 5s interval. That looks reasonable
to me. By the time it starts dropping data you have more than enough
information to go on already.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
