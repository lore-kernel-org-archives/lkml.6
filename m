Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19962ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C672E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="NEmbyy20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C672E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGRW7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:59:10 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45136 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbeGRW7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:59:09 -0400
Received: by mail-yw0-f193.google.com with SMTP id 139-v6so2328486ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bD9srxegSeR+jqZ/FLmrRSF3IEaczzHH/71bKwF27TQ=;
        b=NEmbyy20pPYu2Zcb3g6ZT+IkUwm2tZSRlFe9MhWjPIxUQwDBw9DOoiC5PuC7lSe0wz
         LB8Wys7zS0ALFQQ3FlIIji0pZzPtNrVG1gua76vnxD1iILIJPsgdWkP2JyWVHmBtBvme
         9H8rz+HWHQ0/BZ5ZvGrShNmGUVG/CARXHxyl0vFzggcl1J5x7TFnb9qhC1EYJz+Ha186
         VSc6pCtU52M2rA4w4tIzrgiTKotAIDL414TlEp5N5/uzVVHftzrOM5TLTNFkMwfdEPsQ
         XmoxYckRerpIfHfMhvQhU7Zt2UijY7wmgPf/3jxXEuZmcjoV5a2X/X28RJvZcOZAOGga
         SLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bD9srxegSeR+jqZ/FLmrRSF3IEaczzHH/71bKwF27TQ=;
        b=GYNHIdsR+YvEfWbew5CRORHX8YPeh5e83e27fxuML3MB4e4GaJc6KTaKaDfNdHcXs3
         yCGDKwZNlNMSQDb3qM0Uikz+xaEJBqBT51RTQhp45/FiwVh8N8Ort5hlD75lrRq4SZzr
         4BEHCe2BrShfANvawECdGvWauFRYkZC3TpkSPgeSHJhhBwx7oj4/MltWNjVyV2ke/8mi
         IbPZERrLUeOK8bjaFBND6EEeREqLCM0I+VD9lijU5Z1HtyqHrY2nePiIOLimQj/0xIA9
         kDYEHaIYFufB4KDX/L+goHoUf/B4s3lld7WnN/NPQAO3DO5us/ETkbc+pwmKYDqIgoPS
         scTg==
X-Gm-Message-State: AOUpUlF5APba08ko2Xgz70SjMHwpbcYExS9D48jkoLk6YvMGwn2lLjcd
        MoHxgz+zDYnDcO3EsnCJqKESdc2FZIM=
X-Google-Smtp-Source: AAOMgpfKiQE5QRChTuYBRYzCM/YvalCo+N5mYc9mBJ01+QO0OPuypV0KMRBA5vMgbDqUE4saYGcB/w==
X-Received: by 2002:a81:7c02:: with SMTP id x2-v6mr4103383ywc.81.1531952351380;
        Wed, 18 Jul 2018 15:19:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id t184-v6sm2002713ywa.74.2018.07.18.15.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:19:10 -0700 (PDT)
Date:   Wed, 18 Jul 2018 18:21:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Drake <drake@endlessm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, linux@endlessm.com,
        linux-block@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180718222157.GG2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180716155745.10368-1-drake@endlessm.com>
 <20180717112515.GE7193@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717112515.GE7193@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:25:15PM +0200, Michal Hocko wrote:
> On Mon 16-07-18 10:57:45, Daniel Drake wrote:
> > Hi Johannes,
> > 
> > Thanks for your work on psi! 
> > 
> > We have also been investigating the "thrashing problem" on our Endless
> > desktop OS. We have seen that systems can easily get into a state where the
> > UI becomes unresponsive to input, and the mouse cursor becomes extremely
> > slow or stuck when the system is running out of memory. We are working with
> > a full GNOME desktop environment on systems with only 2GB RAM, and
> > sometimes no real swap (although zram-swap helps mitigate the problem to
> > some extent).
> > 
> > My analysis so far indicates that when the system is low on memory and hits
> > this condition, the system is spending much of the time under
> > __alloc_pages_direct_reclaim. "perf trace -F" shows many many page faults
> > in executable code while this is going on. I believe the kernel is
> > swapping out executable code in order to satisfy memory allocation
> > requests, but then that swapped-out code is needed a moment later so it
> > gets swapped in again via the page fault handler, and all this activity
> > severely starves the system from being able to respond to user input.
> > 
> > I appreciate the kernel's attempt to keep processes alive, but in the
> > desktop case we see that the system rarely recovers from this situation,
> > so you have to hard shutdown. In this case we view it as desirable that
> > the OOM killer would step in (it is not doing so because direct reclaim
> > is not actually failing).

Yes, we currently use a userspace application that monitors pressure
and OOM kills (there is usually plenty of headroom left for a small
application to run by the time quality of service for most workloads
has already tanked to unacceptable levels). We want to eventually add
this back into the kernel with the appropriate configuration options
(pressure threshold value and sustained duration etc.)

> Yes this is really unfortunate. One thing that could help would be to
> consider a trashing level during the reclaim (get_scan_count) to simply
> forget about LRUs which are constantly refaulting pages back. We already
> have the infrastructure for that. We just need to plumb it in.

This doesn't work without quantifying the actual time you're spending
on thrashing IO. The cutoff for acceptable refaults is very different
between rotating disks, crappy SSDs, and high-end flash.

But in the future we might want the OOM killer to monitor psi memory
levels and dispatch tasks when we sustain X percent for Y seconds.
