Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E462ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5798C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoTwqdmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5798C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeGTMdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:33:44 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36361 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeGTMdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:33:44 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so4509601ybk.3;
        Fri, 20 Jul 2018 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6sEETIyfIWdZRxqCxHBW0J9SmgRvXDxvZJWaFQVYhbs=;
        b=SoTwqdmEbMmonRN971Cup0y96sOq+fVjiBQwt8k5GQW3n/CY3/uphhAc+dbm0ZQHbC
         WRvSknKlP5dMGiyUdna2lEg1NrNp369STOC6hvl0EjNFAdz0UCqezggg524ncXMC4R4o
         O8CHWpfqaQUpje/dSk3IQf7z1vU3XhVwFntucnj5TAPxJItXnBeC63IqvR+fbxqdaeGn
         ZgsLgpFeeWocjSdcNiPbyOJFE8RItgazlBaNJ04oTs8Ffu5BnKndtIjFDhOQsa3Zyb7K
         7zjV6jLgnqoW2itWkpjHi7sDcKn7qIaEnOmBpxCmnf79JoyTNcH1aVQDLhdVT0m1MoWf
         7DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6sEETIyfIWdZRxqCxHBW0J9SmgRvXDxvZJWaFQVYhbs=;
        b=l2CbcaUi92IuR9bzQJofvNw9Xo6rkI2QUJ90EiRROAgHM25WEsVxr0oAtdquVd9sFA
         mEb8pBhziq5zywPcRikYKHwn1XG2lB3xzYnux01Ihsu/FpIJ7KHn00NWGTJdNsSIM9c1
         yx54t5Gbftf0aZwnDuKy6ieiqAo5nJRDpLtqQu05UaPVrS2FsCYiCvPvg9+7KS3SmkCu
         W8Zkw9E2Bgjj9t1pnCdkRf1JYJm3bptY+UEasyAhCDZaRpM+SR/gS0pgiRWCoRa9BVwk
         pLEsjvv7EFsrf7TQEHCPlSj/4h8opJGwojBII2KuH3Fd3oGOxp27B4x+wPDfZSWS0xKT
         eqIA==
X-Gm-Message-State: AOUpUlFloULn3EwClmCVgN81pMODfKcGUYtUqRg0SSnzYhrfnr4JH0+6
        2nOIJrvE+XnyigenncvlIvs=
X-Google-Smtp-Source: AAOMgpev4EXLS5twupEoWktG+YliRX/QAgf52IxrD6AxT2x1DSOZJ83Gr+NRsRmcKDzYtb40euMCGw==
X-Received: by 2002:a25:63d6:: with SMTP id x205-v6mr789287ybb.248.1532087152044;
        Fri, 20 Jul 2018 04:45:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:5c80])
        by smtp.gmail.com with ESMTPSA id 141-v6sm757374ywj.65.2018.07.20.04.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 04:45:51 -0700 (PDT)
Date:   Fri, 20 Jul 2018 04:45:49 -0700
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
Message-ID: <20180720114549.GY72677@devbig577.frc2.facebook.com>
References: <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
 <20180719153045.GT72677@devbig577.frc2.facebook.com>
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
 <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 20, 2018 at 01:31:21PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 19, 2018 at 09:52:01AM -0700, Tejun Heo wrote:
> > On Thu, Jul 19, 2018 at 11:52:46AM -0400, Waiman Long wrote:
> > > BTW, the way the partition is currently implemented right now is that a
> > > child cannot be a partition root unless its parent is a partition root
> > > itself. That is to avoid turning on partition to affect ancestors
> > > further up the hierarchy than just the parent. So in the case of a
> > > container, it cannot allocate sub-partitions underneath it unless it is
> > > a partition itself. Will that solve your concern?
> > 
> > Hmm... so a given ancestor must be able to both
> > 
> > 1. control which cpus are moved into a partition in all of its
> >    subtree.
> 
> By virtue of the partition file being owned by the parent, this is
> already achived, no?

The currently proposed implementation is somewhere in the middle.  It
kinda gets there by restricting a partition to be a child of another
partition, which may be okay but it does make the whole delegation
mechanism less useful.

> > 2. take away any given cpu from ist subtree.
> 
> I really hate this obsession of yours and doubly so for partitions. But
> why would this currently not be allowed?

Well, sorry that you hate it.  It's a fundamental architectural
constraint.  If it can't satisfy that, it should't be in cgroup.

Thanks.

-- 
tejun
