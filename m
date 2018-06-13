Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E3952C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1B1208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1B1208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935610AbeFMNVD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:21:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63817 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935375AbeFMNVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:21:02 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5DDKpQa065055;
        Wed, 13 Jun 2018 22:20:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 13 Jun 2018 22:20:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5DDKkL4064988
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 13 Jun 2018 22:20:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [rfc patch] mm, oom: fix unnecessary killing of additional
 processes
To:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com>
 <20180525072636.GE11881@dhcp22.suse.cz>
 <alpine.DEB.2.21.1805251227380.158701@chino.kir.corp.google.com>
 <20180528081345.GD1517@dhcp22.suse.cz>
 <alpine.DEB.2.21.1805301357100.150424@chino.kir.corp.google.com>
 <20180531063212.GF15278@dhcp22.suse.cz>
 <alpine.DEB.2.21.1805311400260.74563@chino.kir.corp.google.com>
 <20180601074642.GW15278@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806042100200.71129@chino.kir.corp.google.com>
 <20180605085707.GV19202@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <56138495-fd91-62f8-464a-db9960bfeb28@i-love.sakura.ne.jp>
Date:   Wed, 13 Jun 2018 22:20:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605085707.GV19202@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/05 17:57, Michal Hocko wrote:
>> For this reason, we see testing harnesses often oom killed immediately 
>> after running a unittest that stresses reclaim or compaction by inducing a 
>> system-wide oom condition.  The harness spawns the unittest which spawns 
>> an antagonist memory hog that is intended to be oom killed.  When memory 
>> is mlocked or there are a large number of threads faulting memory for the 
>> antagonist, the unittest and the harness itself get oom killed because the 
>> oom reaper sets MMF_OOM_SKIP; this ends up happening a lot on powerpc.  
>> The memory hog has mm->mmap_sem readers queued ahead of a writer that is 
>> doing mmap() so the oom reaper can't grab the sem quickly enough.
> 
> How come the writer doesn't back off. mmap paths should be taking an
> exclusive mmap sem in killable sleep so it should back off. Or is the
> holder of the lock deep inside mmap path doing something else and not
> backing out with the exclusive lock held?
> 
 
Here is an example where the writer doesn't back off.

  http://lkml.kernel.org/r/20180607150546.1c7db21f70221008e14b8bb8@linux-foundation.org

down_write_killable(&mm->mmap_sem) is nothing but increasing the possibility of
successfully back off. There is no guarantee that the owner of that exclusive
mmap sem will not be blocked by other unkillable waits.
