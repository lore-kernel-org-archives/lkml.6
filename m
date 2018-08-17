Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4998BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22CC208EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsy3ErxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22CC208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeHQTDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:03:45 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47073 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQTDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:03:45 -0400
Received: by mail-yb0-f194.google.com with SMTP id n10-v6so2098832yba.13;
        Fri, 17 Aug 2018 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4fcruF0wHWAiuq7TBuf0S7S9RugixbQxRSP48LAR0zc=;
        b=Jsy3ErxEW5czngd306aCb2YJmiW2wT36rr2cN+fWybPa7H2AfX1lkF5OvYJ6kkPV8v
         ZNwthLC3UktUqSduS9PFjdfFeY/bqhwcmIPxb4VFZPOEiwNv/OTIqVxONezaDBhDgzIG
         MGb70uQXjMqkOyCuRvVHu6C66Q9fdmB1uxT8uMK9uxAOwDdtkhZ/ZjQiwo5NVVZvwPIh
         XXcfM/l+IpFcxCpDzOLOFYcld6hOIL2wykT07YgEd5a04nmvfpPz6bP6pXcS9gvbb9ul
         Zl1BmPSgsBPWXvUsREaoKwD3XwkRd/Bm0dK+0BNZi04CYdliQImVEr7LbEd7bUykC3OD
         A1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fcruF0wHWAiuq7TBuf0S7S9RugixbQxRSP48LAR0zc=;
        b=P4YMe7I0LgMuPchg1e/EfqXuE2al2wrGwg4+HdNoDt7kqtKDMORnD/RLM7Jx+daVms
         Jzzu91HD1tDlObD7sl3HR35nSl/BgQsL/sb1aq6/Jtc+YxYzjtA6MhSms666pAyDPdp6
         an5H8oCGhpmJEOuUutgF06kKOjHW9KPVIdDKg8GD8BQryS4D2JJo4y0ICUx3kbb12WWv
         +xfMM1NXScaDV1aR0aIp09Q/Tw781iW4XZS8OdrOMKERQ0lSM0x6mvMdHyofRBqFJr7E
         3AWk2V+5fXMtZO0ZpNLCH0jnXYTQcy/aqlhmQ2bXHLgM7nCC+u8UClqiqIO/tD9apxJA
         uCmA==
X-Gm-Message-State: AOUpUlHghhEG62nuNE6QakJKEllfRyLHbYt8x56jABXc+clyia7R5GfA
        jKthbV2irycEaUWQ9nzlKVyKWGW3
X-Google-Smtp-Source: AA+uWPxuBnCTkurGiw4xAlIx74FYSy2kGGhSjzdSlBH3oDOxTs3I+o2/9wrNZTeu+Bawv2FW0f5isQ==
X-Received: by 2002:a25:2042:: with SMTP id g63-v6mr3402955ybg.123.1534521590174;
        Fri, 17 Aug 2018 08:59:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:9b8b])
        by smtp.gmail.com with ESMTPSA id t4-v6sm1071556ywa.51.2018.08.17.08.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 08:59:49 -0700 (PDT)
Date:   Fri, 17 Aug 2018 08:59:46 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180817155946.GJ3978217@devbig004.ftw2.facebook.com>
References: <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
 <20180720114549.GY72677@devbig577.frc2.facebook.com>
 <20180720154454.GR2494@hirez.programming.kicks-ass.net>
 <20180720155613.GB1934745@devbig577.frc2.facebook.com>
 <4857a9db-ebf5-24f8-c42d-d795f5c75854@redhat.com>
 <20180720163712.GU2494@hirez.programming.kicks-ass.net>
 <8c655adc-6d9e-b767-1024-5d6941c995a9@redhat.com>
 <20180720174100.GC1934745@devbig577.frc2.facebook.com>
 <446ab203-85cd-32ff-40a9-0ba22d5a2534@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446ab203-85cd-32ff-40a9-0ba22d5a2534@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

On Mon, Aug 13, 2018 at 01:56:15PM -0400, Waiman Long wrote:
> The following restrictions are still imposed on a partition root wrt
> allowable changes in cpuset.cpus:
> 1) cpuset.cpus cannot be set to "". There must be at least 1 cpu there.
> 2) Adding cpus that are not in parent's cpuset.cpus (as well as
> cpuset.cpus.effective) or that will take all the parent's effective cpus
> away is not allowed.
> 
> So are these limitations acceptable?
> 
> The easiest way to remove those restrictions is to forcefully turn off
> the cpuset.sched.partition flag in the cpuset as well as any
> sub-partitions when the user try to do that. With that change, there
> will be no more new restriction on what you can do on cpuset.cpus.

I think that'd be the right thing to do.  That's what we do with
cpuset.cpus and cpuset.mems too.  If there's nothing available, we
ignore the config and show the settings which are currently in effect.

Thanks.

-- 
tejun
