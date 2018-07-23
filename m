Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2562ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5473920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXIBDj+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5473920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbeGWQc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:32:29 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:39118 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbeGWQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:32:29 -0400
Received: by mail-yw0-f196.google.com with SMTP id r184-v6so365242ywg.6;
        Mon, 23 Jul 2018 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mh9frJ1DhcJBscGy0/M9i9q+7VztO+TSldvjByVKmhA=;
        b=MXIBDj+8Rew8GzSxiq3NniKf2OqlJl/HlzZSeEwmCI6QQFM9yUK/DkUqo6xflaNTjv
         zraHD63FNqf9vZRTUPwVDDwU2JMyZtRbF2h7crFZmjPC1Fy9kwovPJWl5ExNITeAjcE5
         IEeJ4sZ1YQR2/Yi37ThbBOxpqunEPZnV4/DkGjPl9nC5+O9Ka83oiQYqMixQvrC3Rnen
         7yFqdqlh1dsgZwwBFPfLLLV4nWwX8xUDPIxtGxwqOJViv00yKwY7hDbiwUNYjxVLfGhp
         KPLQ++XX/gdBgJWFnbPU7ZwgrMVzpZpT1iTxQuUaV/EL5dTbXaybqzCUHpv6/Pq9xrnG
         R+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mh9frJ1DhcJBscGy0/M9i9q+7VztO+TSldvjByVKmhA=;
        b=P1KFS93XDgX6KfmOsGs6i+P1LmbNdZC7J1JRySHl1dPcJ5p/PSaay9iYHNgjLXXqQc
         Wing85YqH4EF+DoKFm/iN/zE+Mpjaypyh/MrX7QVFrUjO4SZtRZXENBZ/QnOBjBxuw5p
         eKYPVdOICChUg7Psk3T48CIgko/ekKRQHcKLIeCefSf6pT14ZqmNHAgVRIbpyX7GiY75
         JupU+a+Ix0pZ3Yp00IGXp2P4wWUhkaLui8K8EfVEvUKL/rDQzGxyzWHBEhD318t1NsB1
         6diqHlxAx65BVWAchWO/RQ7zSWGsZRkQL6oNCnbmGl6cH0xThlNGfTgjPlChX4Kmx/Ve
         CM3A==
X-Gm-Message-State: AOUpUlFJ44PFKSeaKrLPMsrDBHbf+Xmdfil3bPZ7N8qUiwhi/gjm2gXe
        jv/B8CNFEyiVLFm96wI5Yr4o97m7
X-Google-Smtp-Source: AAOMgpeK2b8MdJ6WBcqZLOiP72JhJPxQ6BJJtvUmYErCX108iDNdJ97R0URgeVDi2sNaPdbX0XBmiw==
X-Received: by 2002:a81:4f44:: with SMTP id d65-v6mr6845386ywb.366.1532359843085;
        Mon, 23 Jul 2018 08:30:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:71d])
        by smtp.gmail.com with ESMTPSA id r196-v6sm8914259ywe.25.2018.07.23.08.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 08:30:42 -0700 (PDT)
Date:   Mon, 23 Jul 2018 08:30:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180723153040.GG1934745@devbig577.frc2.facebook.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716082906.6061-9-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 16, 2018 at 09:29:02AM +0100, Patrick Bellasi wrote:
> The cgroup's CPU controller allows to assign a specified (maximum)
> bandwidth to the tasks of a group. However this bandwidth is defined and
> enforced only on a temporal base, without considering the actual
> frequency a CPU is running on. Thus, the amount of computation completed
> by a task within an allocated bandwidth can be very different depending
> on the actual frequency the CPU is running that task.
> The amount of computation can be affected also by the specific CPU a
> task is running on, especially when running on asymmetric capacity
> systems like Arm's big.LITTLE.

One basic problem I have with this patchset is that what's being
described is way more generic than what actually got implemented.
What's described is computation bandwidth control but what's
implemented is just frequency clamping.  So, there are fundamental
discrepancies between description+interface vs. what it actually does.

I really don't think that's something we can fix up later.

> These attributes:
> 
> a) are available only for non-root nodes, both on default and legacy
>    hierarchies
> b) do not enforce any constraints and/or dependency between the parent
>    and its child nodes, thus relying on the delegation model and
>    permission settings defined by the system management software

cgroup does host attributes which only concern the cgroup itself and
thus don't need any hierarchical behaviors on their own, but what's
being implemented does control resource allocation, and what you're
describing inherently breaks the delegation model.

> c) allow to (eventually) further restrict task-specific clamps defined
>    via sched_setattr(2)

Thanks.

-- 
tejun
