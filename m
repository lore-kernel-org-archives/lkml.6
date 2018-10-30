Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49E020823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49E020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJ3Wvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:51:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50162 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeJ3Wvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:51:35 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9UDvk0H058138;
        Tue, 30 Oct 2018 22:57:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 30 Oct 2018 22:57:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9UDvdRP058075
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 30 Oct 2018 22:57:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH v2 3/3] mm, oom: hand over MMF_OOM_SKIP to exit path
 if it is guranteed to finish
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181025082403.3806-4-mhocko@kernel.org>
 <201810300445.w9U4jMhu076672@www262.sakura.ne.jp>
 <20181030063136.GU32673@dhcp22.suse.cz>
 <95cb93ec-2421-3c5d-fd1e-91d9696b0f5a@I-love.SAKURA.ne.jp>
 <20181030113915.GB32673@dhcp22.suse.cz>
 <ca390ac1-2f10-b734-fff7-56767253e8c5@i-love.sakura.ne.jp>
 <20181030121012.GC32673@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0b1a8c3b-8346-ba7d-da7b-3c79354e11d7@i-love.sakura.ne.jp>
Date:   Tue, 30 Oct 2018 22:57:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030121012.GC32673@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 21:10, Michal Hocko wrote:
> I misunderstood your concern. oom_reaper would back off without
> MMF_OOF_SKIP as well. You are right we cannot assume anything about
> close callbacks so MMF_OOM_SKIP has to come before that. I will move it
> behind the pagetable freeing.
> 

And at that point, your patch can at best wait for only __free_pgtables(),
at the cost/risk of complicating exit_mmap() and arch specific code. Also,
you are asking for comments to wrong audiences. It is arch maintainers who
need to precisely understand the OOM behavior / possibility of OOM lockup,
and you must persuade them about restricting/complicating future changes in
their arch code due to your wish to allow handover. Without "up-to-dated
big fat comments to all relevant functions affected by your change" and
"acks from all arch maintainers", I'm sure that people keep making
errors/mistakes/overlooks.

My patch can wait for completion of (not only exit_mmap() but also) __mmput(),
by using simple polling approach. My patch can allow NOMMU kernels to avoid
possibility of OOM lockup by setting MMF_OOM_SKIP at __mmput() (and future
patch will implement timeout based back off for NOMMU kernels), and allows you
to get rid of TIF_MEMDIE (which you recently added to your TODO list) by getting
rid of conditional handling of oom_reserves_allowed() and ALLOC_OOM.

Your "refusing timeout based next OOM victim selection" keeps everyone unable
to safely make forward progress. OOM handling is too much complicated, and
nobody can become free from errors/mistakes/overlooks. Look at the reality!

