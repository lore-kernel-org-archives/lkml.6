Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4654E20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVOgsdah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4654E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbeGTQpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:45:11 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41280 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbeGTQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:45:11 -0400
Received: by mail-yw0-f195.google.com with SMTP id q129-v6so4510714ywg.8;
        Fri, 20 Jul 2018 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2eMCmaQOK7Kd62z2r1yCYs9jaqhAA7oLspxsoU77Gg=;
        b=ZVOgsdahfHcd3U74MwqjB/eRBcdxTKYmZiH5e23UjiJeMhkDTNUH+O56imkGcg1GIJ
         mi6SOh7LrYKQxMSVCzxogwzvvpmDA/NRtV8JQRMaF8n2bli69zUPPoNBrDWan/dmNsc1
         vipZrh/31yWBvR8n7/hCia5NxbRF2HbIwEVEn9kQ8NSoV3wVExa1602tbLuxc6WtLMrl
         txMk7mOuhk2F+PmD0xAkY1bZc/zZ7KOcG/XOMdeqvYyieMtj2l7KyjcsZV3/9+MN28Xt
         Sk/x0UJcLoLYIcKfUX/Jr4bjY5mL31jj42f6gmwoZC8igZrzv6XrAhthel5BcvoZu+L9
         9NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2eMCmaQOK7Kd62z2r1yCYs9jaqhAA7oLspxsoU77Gg=;
        b=Ipnve2Yb84XeVxDqddM8ZC3yqKZXLELrOTfohrRHPpw6XGlkZkmq4Lf/jHRQhZ7xEn
         5qsXiptz8JY41MSOHeI7kPfZqFdXxz1IwDDxOxNhCOCRJT1vkGGHwmVpJy54SRzqtl7c
         jaD54lGh3ngv8XY4tgnjYARiwU7J9kEIajjDBbq2KG3EBuaoEyDfaqIWlLK8kCEWdxJz
         8txD6PwmwTP4pHMIFJoLxBWR+wFLd0wsxRoGLnhWZoKkiUp/8+3ImAGYhZ7E/mV4iOi2
         kHCIZ6hfUQYFMBF7q3luwC+I/+hKX36g8WVWXPRQEqNla/ep87VEcexTZz6mHtUG1JGs
         yWOA==
X-Gm-Message-State: AOUpUlHsOK/CgQovTeFMA5ArcjhdZ0DPFYWQcyPPP5aqthYqUnNDCVnV
        hqS/eHYGLvHp8MIqB0YVJpg=
X-Google-Smtp-Source: AAOMgpfRtmx0BWSVyqj9VVxqyVsuK3BHSpnupNH+/0sxAdPX8PjE4C/l0vkQSyrZPPiZ/htt9SsA/A==
X-Received: by 2002:a81:82c7:: with SMTP id s190-v6mr1315350ywf.329.1532102176030;
        Fri, 20 Jul 2018 08:56:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:e55b])
        by smtp.gmail.com with ESMTPSA id r3-v6sm2569621ywr.80.2018.07.20.08.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 08:56:14 -0700 (PDT)
Date:   Fri, 20 Jul 2018 08:56:13 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
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
Message-ID: <20180720155613.GB1934745@devbig577.frc2.facebook.com>
References: <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
 <20180719153045.GT72677@devbig577.frc2.facebook.com>
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
 <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
 <20180720114549.GY72677@devbig577.frc2.facebook.com>
 <20180720154454.GR2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720154454.GR2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter.

On Fri, Jul 20, 2018 at 05:44:54PM +0200, Peter Zijlstra wrote:
> > The currently proposed implementation is somewhere in the middle.  It
> > kinda gets there by restricting a partition to be a child of another
> > partition, which may be okay but it does make the whole delegation
> > mechanism less useful.
> 
> So the implementation does not set ownership of the 'partition' file to
> that of the parent directory? Because _that_ is what I understood from
> Waiman (many versions ago). And that _does_ allow delegation to work
> nicely.

So, that part isn't the problem.  The problem is that if we allow
partitioning nested further away from ancestor, the descendant would
be able to take away reources from the removed ancestor.  Waiman
avoids this problem by only allowing partitions to nest but then it's
kinda weird cuz it's just a separate tree.

> > > > 2. take away any given cpu from ist subtree.
> > > 
> > > I really hate this obsession of yours and doubly so for partitions. But
> > > why would this currently not be allowed?
> > 
> > Well, sorry that you hate it.  It's a fundamental architectural
> > constraint.  If it can't satisfy that, it should't be in cgroup.
> 
> So is hierarchical behaviour; but you seem willing to forgo that.

Well, we do have root or first-level only things.  Things just need to
be properly delegatable when they're hierarchical (and things should
be hierarchical only when that actually means something).  While not
desirable, considering the history, accomodating this specific usage
that way seems acceptable to me.

> Still, the question was, how is this (dispicable or not) behaviour not
> allowed by the current implementation?

I'm not quite sure what you're trying to ask.  Can you elaborate?

Thanks.

-- 
tejun
