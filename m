Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34712C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89162156E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="HbAeG4FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89162156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeHGWcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:32:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37243 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGWcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:32:42 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so5427733ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vFrIkVSJRWrek9LCE6RVV2ocWVB+kQ17jI5T6SGl1mo=;
        b=HbAeG4FC/4PbyOJk7fpENxYk/SlIh2GKngBma4F3ijzuKcJDYkK0v92Clm+BB9Hu0i
         JM/KQ5n6j+Bgf+SeeiQcDCTTfqLinKoyYK5vu1RmXTHgZH8zZfWrFIaUjLcjYKFUyuId
         coxjMYT1y3M7WwO6RN3DaRvDE74VfpuyiTVYR3XJg+HL7LYt28SfTpanAHqYl0QARgn4
         G985zZ+GvTlRM9XlqJo5fKkphHiQV4jDRAyyyjLpJw5ucjak3NMkpspTxg/2f9nG33g8
         5wLh/LvwSXEY0cmYfkZYUO4vJyPVFV7TIDVMlmJO5RKhGfind4y5hlK0MN6R7KVwI4bh
         JvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vFrIkVSJRWrek9LCE6RVV2ocWVB+kQ17jI5T6SGl1mo=;
        b=kouN6vwDtUHaRA4XGKqycqFUHJv52sEWEw4ghvbougJQ6QtsVqOr/wtg2Cl0RC9NbG
         bgcn0gK0uwX2G6MYyKTwziH5+CrQ8Mx5nyTPwcxw6plWoV03OwPA/zqzn0NwdvSZWRZn
         w2hiZyXIdKNvWu1d6fEzZSTiz61HDfTBpNwBshzgRmsDL703aN/dTTupKeWLuqkVUChj
         BgVg5oIEzKUd6lHeCsPLOgJ/Tecm4ak3e63WoFHr2c8/lQ4FSucZqqsifVandv4S+HDe
         yXb52rci5TNc5KUXkPm+Al+e/t7YvAkzlU7cC2G99n3ZKchNfO57BoeyqFF1LkIKaj6B
         9kbg==
X-Gm-Message-State: AOUpUlH8GXQC+oSaHbclIvF8E6SExCIz3T8307f5PxdOBhd+Fp0nMoat
        punAApf8nuMHKGuAJsRwmkdXEA==
X-Google-Smtp-Source: AAOMgpcbCkft9HM0yvVTRkcrQ1E3IJ5Iy11/anrHgHS1eHHerS5b3z/lpv09lCiERR9O8T2c8uM05g==
X-Received: by 2002:a81:48d4:: with SMTP id v203-v6mr10715407ywa.375.1533672996183;
        Tue, 07 Aug 2018 13:16:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:97c3])
        by smtp.gmail.com with ESMTPSA id m82-v6sm2438583ywm.19.2018.08.07.13.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 13:16:35 -0700 (PDT)
Date:   Tue, 7 Aug 2018 16:19:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        Greg Thelen <gthelen@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] memcg, oom: be careful about races when warning about no
 reclaimable task
Message-ID: <20180807201935.GB4251@cmpxchg.org>
References: <20180807072553.14941-1-mhocko@kernel.org>
 <863d73ce-fae9-c117-e361-12c415c787de@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863d73ce-fae9-c117-e361-12c415c787de@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 07:15:11PM +0900, Tetsuo Handa wrote:
> On 2018/08/07 16:25, Michal Hocko wrote:
> > @@ -1703,7 +1703,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
> >  		return OOM_ASYNC;
> >  	}
> >  
> > -	if (mem_cgroup_out_of_memory(memcg, mask, order))
> > +	if (mem_cgroup_out_of_memory(memcg, mask, order) ||
> > +			tsk_is_oom_victim(current))
> >  		return OOM_SUCCESS;
> >  
> >  	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> > 
> 
> I don't think this patch is appropriate. This patch only avoids hitting WARN(1).
> This patch does not address the root cause:
> 
> The task_will_free_mem(current) test in out_of_memory() is returning false
> because test_bit(MMF_OOM_SKIP, &mm->flags) test in task_will_free_mem() is
> returning false because MMF_OOM_SKIP was already set by the OOM reaper. The OOM
> killer does not need to start selecting next OOM victim until "current thread
> completes __mmput()" or "it fails to complete __mmput() within reasonable
> period".

I don't see why it matters whether the OOM victim exits or not, unless
you count the memory consumed by struct task_struct.

> According to https://syzkaller.appspot.com/text?tag=CrashLog&x=15a1c770400000 ,
> PID=23767 selected PID=23766 as an OOM victim and the OOM reaper set MMF_OOM_SKIP
> before PID=23766 unnecessarily selects PID=23767 as next OOM victim.
> At uptime = 366.550949, out_of_memory() should have returned true without selecting
> next OOM victim because tsk_is_oom_victim(current) == true.

The code works just fine. We have to kill tasks until we a) free
enough memory or b) run out of tasks or c) kill current. When one of
these outcomes is reached, we allow the charge and return.

The only problem here is a warning in the wrong place.
