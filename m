Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4C0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0A620673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wUdxpvnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0A620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbeG0Axm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:53:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46435 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbeG0Axl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:53:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so1470751ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=86dOKH0F5ymPUFqJUh6MLwgojjUqAEOCH69+iwtaQs4=;
        b=wUdxpvnjnuWXPGBjyk8H2ikOdEtpjJhtzHVwG2af50W7mXvtXy+7pb/uVfY3/DiRqJ
         Cuwbi1eSD3FrgZc/iapNzxzbskh+JfYGmLejE5E/3p5b9myrGhySkmqiFD71r+Ca34Nf
         6R4ia5mNbvxvhRq76YFuQ5htn/bwlC9rh1y3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86dOKH0F5ymPUFqJUh6MLwgojjUqAEOCH69+iwtaQs4=;
        b=PfXWA7VG3wrXoiL221e6bdgRj3lhAwhCMdKfGVAxeRvcWti40Petkq+D/esININRj9
         nvc+Kx2J9iox/1ZgzgRZ16iUxY5+UqDHLrvjFDsEdc84EyGYZ2ufk/UNK2uvp5ZioM+o
         yiUQ5pNSbXeuCRx4MAe5U/txtjSpbyAikj98Gk7fHRrsowF71lDSTYSvH9hgsDU09Xog
         LDlVPm0DW0MSFJQEDYcppqlak2xUP+rCH3wrbXJF/ExcZGNNt8g5JaPC710HAolwGZdz
         EbWszFPDmeca0CxBwZY+paTbggGkOh1Inu6dwg3Nsxgd0NznjF5tirVmlr4BF5E0BAIW
         uWPg==
X-Gm-Message-State: AOUpUlHL/P9TDxq2GJvAgOJzP15FiYp+OiNjRh/s0ahH4WYgwU/Tfonb
        ZyLrYcaTsR+cZPXJSpfmbpoCyOF9Z8w=
X-Google-Smtp-Source: AAOMgpeOIrzBWAf1fIAce96yMzjHkWBxxGghlu0diS7jcIOVHKL+9sW6n7MDdTU2lOatKuJu8ElMHg==
X-Received: by 2002:a17:902:760d:: with SMTP id k13-v6mr3715771pll.56.1532648077140;
        Thu, 26 Jul 2018 16:34:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id s73-v6sm4520378pfi.154.2018.07.26.16.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 16:34:36 -0700 (PDT)
Date:   Thu, 26 Jul 2018 16:34:36 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [LKP] [rcutorture]  3b745c8969:
 WARNING:at_mm/slab_common.c:#kmalloc_slab
Message-ID: <20180726233436.GA211260@joelaf.mtv.corp.google.com>
References: <20180726085015.GA29979@shao2-debian>
 <20180726115325.GE24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726115325.GE24813@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:53:25AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 26, 2018 at 04:50:15PM +0800, kernel test robot wrote:
> > 
> > FYI, we noticed the following commit (built with gcc-5):
> > 
> > commit: 3b745c8969c752601cb68c82a06735363563ab42 ("rcutorture: Make boost test more robust")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -smp 2 -m 512M
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> Is this fixed by 4babd855fd61 ("rcutorture: Add support to detect
> if boost kthread prio is too low")?  That could address the
> rcu_torture_stats_print() failures, depending on exactly what they were.
> (Yes, I should have reversed these two commits, but they are in -tip
> now, so that ship has sailed.)
> 
> Joel, any other thoughts?

I ran the next tree myself and was not able to reproduce the issue with the
same configuration. Although I don't have rcupdate.rcu_cpu_stall_timeout=100
passed in like they do (which I can also try if you think its of significance
here).

It seems from their logs that most Locking API self tests are failing. the
Lock API test suite is run before rcutorture where rcutorture hasn't even
started.

Also as per their rcutorture output, it appears the 'rtf' value is also
non-zero (rcu_torture_free test). Which makes sense if the earlier memory
allocation warnings are somehow related.

thanks,

- Joel


