Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52EAC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965662086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965662086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKHU6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:58:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53480 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:58:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id f10-v6so870429wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 03:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o/s5vlP8oC1JnGF6nXdcVHl1SLjYzNtLCE0HrwNrM9c=;
        b=BRVZW8rPHdub1+HPpnJVt+14CFFi3T9TAt2Qa5UnxeVSPUfuhicEPd2EZ7xNmEZUqt
         mWu7p4/pRQitFpwc795wreynZNw3FGpfbDQdBZzl0Eh6Jd+IdSZQsStUqHFLoeDqNU5C
         EtsvFe/CAb97kEkupkuUVHPkItWSLwhE6v7ap2Z082tv5vTBbR9yQDM06BTOCQAoQVAN
         pbHW0lCwobdBY6t9R4zjwl2U4kfuylbCJldsLwh53NRVw4D2H3drxwSmIHCpLPUtWgUE
         rmy+/KBKV2C0t2ZU1WvT8u3eXSyd/+w4mQGuGvxj6NR1BQRtp4opK7wCJt96UPN22rIG
         cCcA==
X-Gm-Message-State: AGRZ1gKBhR5mQH+d6Lp0L1jc17bZdkqC7el1LfXqHb57YiKOwlkF52rP
        XP9pPoRmWuMA5dszjQECtIOBvA==
X-Google-Smtp-Source: AJdET5cre10/Jl6cYbQ+zO9K23jOm2UJZFNj7AvK3SnCcEIf8vKRej+QsdZhBudmhNInhejDZy9eZg==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr837973wmd.3.1541676183108;
        Thu, 08 Nov 2018 03:23:03 -0800 (PST)
Received: from localhost.localdomain ([151.15.207.85])
        by smtp.gmail.com with ESMTPSA id k4sm5131207wrx.91.2018.11.08.03.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 03:23:02 -0800 (PST)
Date:   Thu, 8 Nov 2018 12:22:59 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan@huawei.com, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, cgroups@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        longman@redhat.com
Subject: Re: [PATCH v5 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20181108112259.GB18091@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-4-juri.lelli@redhat.com>
 <20180925143416.GD25664@localhost.localdomain>
 <20181107155330.GA2509588@devbig004.ftw2.facebook.com>
 <20181107163841.GA18091@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107163841.GA18091@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/18 17:38, Juri Lelli wrote:
> Hi,
> 
> On 07/11/18 07:53, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Sep 25, 2018 at 04:34:16PM +0200, Juri Lelli wrote:
> > > It would be great if you could please have a look at the proposed change
> > > below (and the rest of the set of course :-).
> > 
> > Yeah, looks good to me.  Please feel free to add
> > 
> >  Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks!
> 
> > > Another bit that I'd be more comfortable after hearing your word on it
> > > is this one (discussed over 5/5):
> > > 
> > > https://lore.kernel.org/lkml/20180925130750.GA25664@localhost.localdomain/
> > 
> > Can you please loop Waiman Long <longman@redhat.com> into discussion?
> > He's working on cgroup2 cpuset support which might collide.
> 
> Sure, I've been originally working on this on top of his series, but
> didn't try with latest version. Hopefully the two series don't generate
> too much collisions. I'll try to find some time soon to check again.

So, conflicts weren't too bad (on top of v14).

I guess I'll wait for Waiman Long's patches to land for rebasing again
and testing.

Best,

- Juri
