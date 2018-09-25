Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D42921480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D42921480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeIYOVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:21:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42111 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeIYOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:21:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id b11-v6so6095796wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djxjBtF3FCzObcWTV9HQ3t5DQ9/cCwG6riLdpT6mn9o=;
        b=gcoX5y/1G2jcSwzLIpoLxGDAOFvIZrLyyf1kG0apyqXdUAhpXni6EfyeurRy8RwEmx
         4kvw8RT2C0WeIj+SMIaoLQOMZstmlsUWl3vbWNwxZu/aKgaXLUj1SiXGR2URESz/H1my
         TomqQD6tc0T0pz7EhLzTqlXnM85TnSHVDNAXSCu/l/9cgkyUUIxjDZsAgqV+rRTPYrx5
         s81rDsIzU3Iu8audWEh/V0mvKWGwqzc5ZfMubvz/Tlr1gXdRsGpJzeBwoZKVS8TPWlhZ
         y65sPlhmVJNh/b23UxelmzJ3SKMn1Kol5fc4DTg4ysL0YpNw1cxWwp2Bk/o1mxIlDSHN
         aK7g==
X-Gm-Message-State: ABuFfojJeHbCTitJEVaAMru4drgHUe9eCWsX7knOyUrFoEDKz8k0bs+z
        PvOQgozJQogrCwUE3laCVerJ2A==
X-Google-Smtp-Source: ACcGV61+q4fn7xngou/Kq0Bwj79Wijkt0ySSukSdidLUQ7cSJU2I6mNrt9gPLHzfr7cn6t5bfJrvkQ==
X-Received: by 2002:adf:e910:: with SMTP id f16-v6mr1873521wrm.126.1537863293798;
        Tue, 25 Sep 2018 01:14:53 -0700 (PDT)
Received: from localhost.localdomain (p54B1D21E.dip0.t-ipconnect.de. [84.177.210.30])
        by smtp.gmail.com with ESMTPSA id a203-v6sm1536878wmh.31.2018.09.25.01.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:14:52 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:14:48 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 0/5] sched/deadline: fix cpusets bandwidth accounting
Message-ID: <20180925081448.GA4287@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903142801.20046-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/09/18 16:27, Juri Lelli wrote:
> Hi,
> 
> v5 of a series of patches, originally authored by Mathieu, with the intent
> of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
> As originally reported by Steve [1], when hotplug and/or (certain)
> cpuset reconfiguration operations take place, DEADLINE bandwidth
> accounting information is lost since root domains are destroyed and
> recreated.
> 
> Mathieu's approach is based on restoring bandwidth accounting info on
> the newly created root domains by iterating through the (DEADLINE) tasks
> belonging to the configured cpuset(s).
> 
> Main problem of v4 was caused by the trylocking of cpuset_mutex. As
> noticed by Steve [2], if multiple tasks are created at they same time
> only the first gets to grab the mutex, the other get -EBUSY and need to
> retry. Not really nice. So, in v5 I'm proposing to use callback_lock
> instead of cpuset_mutex, which AFAIU should be enough to grant read-only
> safe access to cpusets.
> 
> 01/05 has been dropped because it wasn't really adding much and was
> only causing false positives.
> 
> 05/05 is still too much DEADLINE specific I guess, but let's first agree
> on foundations patches.
> 
> Set also available at
> 
>  https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v5

Gentle ping about this.

Best,

- Juri
