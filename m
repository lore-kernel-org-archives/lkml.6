Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600AFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfARQqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:46:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33782 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfARQqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:46:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so15899823wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JfSB3jgY74fLupio5GOKjqe5iO5FXurX7b72tmW8azQ=;
        b=b8vry3R/BEcLp25SKoOeKRAXlEJl9NTx5k598d8L9lu9+kuQR/SuW5+ORlnIg16y91
         fV+zK+zVWxrTgamsPB7VMZUlHhAZgI7Mzz/3q6TlGvkmBosogkJulWkaIi12vUwfjJB0
         NJhmtJRF7KZOtD1L/q0tQo3cbEMoD8Zvz3LaKISyHTltDNzLaCcVjotFwIb2hjnDo0ZV
         LT/j7hA63RMhum5LDW8b4YYBa6SFAMjfytW+94bL9nsin1oQDuECe5kIBXmBUYrWrXio
         /+2tR4NvcAEiDEtn1hf7xN5/SwZMV368TR6hfV720Bp3j7Kjpz9JlMbKfojXGJyQ9eGg
         UreQ==
X-Gm-Message-State: AJcUukcPawXXb1whOe6Vt/Uw3IIstenDzKyjNNOKWSrClJwiey6e8CQo
        7MYZkIFJyiSavy5a7L75YLF4NQ==
X-Google-Smtp-Source: ALg8bN7UpSL5iIy6quq/WxmvP9enVt9UlDU9fSyOzbwZE1jtCqoOI40Dszy1kZhiKvtJQOjuYRAFEw==
X-Received: by 2002:adf:e891:: with SMTP id d17mr18614310wrm.140.1547830005274;
        Fri, 18 Jan 2019 08:46:45 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id a12sm80040973wrm.45.2019.01.18.08.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 08:46:44 -0800 (PST)
Date:   Fri, 18 Jan 2019 17:46:42 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     longman@redhat.com
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH v6 0/5] sched/deadline: fix cpusets bandwidth accounting
Message-ID: <20190118164642.GC26615@localhost.localdomain>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190118161739.GE50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161739.GE50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/19 08:17, Tejun Heo wrote:
> On Thu, Jan 17, 2019 at 09:47:34AM +0100, Juri Lelli wrote:
> > Hi,
> > 
> > v6 of a series of patches, originally authored by Mathieu, with the intent
> > of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
> > As originally reported by Steve [1], when hotplug and/or (certain)
> > cpuset reconfiguration operations take place, DEADLINE bandwidth
> > accounting information is lost since root domains are destroyed and
> > recreated.
> > 
> > Mathieu's approach is based on restoring bandwidth accounting info on
> > the newly created root domains by iterating through the (DEADLINE) tasks
> > belonging to the configured cpuset(s).
> > 
> > Apart from some minor refactoring needed to rebase the set on top of
> > Waiman Long's cpuset for cgroup series (now mainline), two changes worth
> > of notice:
> 
> Generally looks good to me but can you please ask Waiman to take a
> look?

Argh! I should have cc-ed him in the first instance.

Thanks for reviewing.

Waiman, do you see anything wrong with this series? Thanks!

https://lore.kernel.org/lkml/20190117084739.17078-1-juri.lelli@redhat.com/
