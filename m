Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775BEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BA214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfBDJCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:02:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39755 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:02:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so13464316wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OvHZIVZFg1+RhiDFK9pDWwUAkslSj9haTj/ZsI9PTU8=;
        b=ElCWg0tvcTlqXB+SoEqifz18RpJK1zxaa7la4ruSp5SE3nx2FPfRicWtiT8A3oVZ8I
         ljkB+c2IsjROX3qrWfiAyudXXHHETalmKaNIK7ac03IpG6MDD8+stfHbdUNZqpIqSR88
         p9LQHiW6ute3q6NH0Cgf3Y0OZ2h/KnNw/s3WeN+FS712hhmC1TdlVWB5dGebD1yAiM2F
         fMjnUF1H5PzAVfi7a9BdPQ3vkAnqkT8kbRkIGZIl4t4wJyyaliARzemHh5f8GG4BgpSN
         B7gbzTBOUHiLMZMByklr7eYpLmgNNvMEeBaNI8iHq0cdRqEowvKT1S4g1uyeAYgSe0Hn
         hNsg==
X-Gm-Message-State: AHQUAuYLrLrZD1Wl9HE4bTsrDlxWssY/dLyI6f34fZ07ut9KsH7Q9hZ0
        r5DMj5RE1w5JyI1Ka1NSGJNmNQ==
X-Google-Smtp-Source: AHgI3IYHhf1p6xJ3qSlOU6rBbN5u0FVOpwWBkKn0aDgFBcJ4Nti4tV3xXzFfh6PTG0Rj/2n5q9ya6w==
X-Received: by 2002:adf:ff49:: with SMTP id u9mr7399015wrs.279.1549270935484;
        Mon, 04 Feb 2019 01:02:15 -0800 (PST)
Received: from localhost.localdomain ([151.15.206.34])
        by smtp.gmail.com with ESMTPSA id m4sm6299758wml.2.2019.02.04.01.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 01:02:14 -0800 (PST)
Date:   Mon, 4 Feb 2019 10:02:11 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     longman@redhat.com
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH v6 0/5] sched/deadline: fix cpusets bandwidth accounting
Message-ID: <20190204090211.GA10449@localhost.localdomain>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190118161739.GE50184@devbig004.ftw2.facebook.com>
 <20190118164642.GC26615@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118164642.GC26615@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/19 17:46, Juri Lelli wrote:
> On 18/01/19 08:17, Tejun Heo wrote:
> > On Thu, Jan 17, 2019 at 09:47:34AM +0100, Juri Lelli wrote:
> > > Hi,
> > > 
> > > v6 of a series of patches, originally authored by Mathieu, with the intent
> > > of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
> > > As originally reported by Steve [1], when hotplug and/or (certain)
> > > cpuset reconfiguration operations take place, DEADLINE bandwidth
> > > accounting information is lost since root domains are destroyed and
> > > recreated.
> > > 
> > > Mathieu's approach is based on restoring bandwidth accounting info on
> > > the newly created root domains by iterating through the (DEADLINE) tasks
> > > belonging to the configured cpuset(s).
> > > 
> > > Apart from some minor refactoring needed to rebase the set on top of
> > > Waiman Long's cpuset for cgroup series (now mainline), two changes worth
> > > of notice:
> > 
> > Generally looks good to me but can you please ask Waiman to take a
> > look?
> 
> Argh! I should have cc-ed him in the first instance.
> 
> Thanks for reviewing.
> 
> Waiman, do you see anything wrong with this series? Thanks!
> 
> https://lore.kernel.org/lkml/20190117084739.17078-1-juri.lelli@redhat.com/

Ping?

Thanks,

- Juri
