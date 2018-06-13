Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A8322C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8C5208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Wnwmd9cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8C5208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934676AbeFMH3v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:29:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38814 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFMH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:29:50 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so840684pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gJn7vtCuRWcJVvZ8LqF/DdD+ZiVLujvzHzvweu3OB6Y=;
        b=Wnwmd9cvIFpqIrmav885JAMqSX1l9ol59fmU+i1MjPcaQq+ehaJ+vSIcmsnByhJnH3
         LHikcDOMRpdZP+KbGrh5Q38FCU1Ed1sbLulf3RpiauBLEjaOoSPzSHKhduwgAaLp1hyq
         8xryHGDc4ra/SOG3wOZq5B85udOzBXLDRVN9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gJn7vtCuRWcJVvZ8LqF/DdD+ZiVLujvzHzvweu3OB6Y=;
        b=DG/fbRyZN2BaeCxTyi0+Ak16K9WHZCZVD0HgrDDaPJaX1g0K7Qe51Ah0v3oZdAK6B/
         42iXk64mhs4ChwePUJkVjcSTtv8AzmfSD8wJ2W0rciVatJY46FSymr47LIC97kq/az7A
         QQq+Ve95+WFFI+kVE5e9TfeZC4g1KNsOsJlBPWuORqJ7daMiQSOHpvvMCdqB06FyQ4eS
         1tu81PkNWxeyp5sMuvL2etRgx862wWM4VUwtFzuIOJJeMTvg0qWtGw8Obl3pyRMrf6ZN
         9lMwiQtb64bq5GPNhDtAQM8h9lYDtIuSegPgYolQhuMCLljh/6stBkp4fZQUt3KD6e/f
         awQg==
X-Gm-Message-State: APt69E1fMhMVWu2YtDqpxPdmS7D6k6tfsV44xg8j+YoNKvrpr6p1uB6W
        v4AGuwOfOlsVRaUPCBqIFRTlig==
X-Google-Smtp-Source: ADUXVKJdeE5k2zUYB/2NdHKFoOhQTS4kZwYN7smber4eZOmjw/z2egxTleBTkXLLGDXc7RsyidmNww==
X-Received: by 2002:a63:770b:: with SMTP id s11-v6mr3151023pgc.339.1528874989346;
        Wed, 13 Jun 2018 00:29:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id c27-v6sm4464460pfl.63.2018.06.13.00.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 00:29:48 -0700 (PDT)
Date:   Wed, 13 Jun 2018 00:29:48 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     kernel test robot <xiaolong.ye@intel.com>
Cc:     Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        lkp@01.org
Subject: Re: [lkp-robot] [rcutorture]  46e26223e3:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print
Message-ID: <20180613072948.GA142000@joelaf.mtv.corp.google.com>
References: <20180610234544.150933-2-joel@joelfernandes.org>
 <20180613065711.GZ16472@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613065711.GZ16472@yexl-desktop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm actually not working this week, but still thought of replying :))

On Wed, Jun 13, 2018 at 02:57:11PM +0800, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-4.9):
> 
> commit: 46e26223e39c64763e321f229e324be15179c505 ("rcutorture: Make boost test more robust")
> url: https://github.com/0day-ci/linux/commits/Joel-Fernandes/rcutorture-Disable-RT-throttling-for-boost-tests/20180611-074731
> base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/

I'll try to reproduce this, but it could be because after this patch, the
boost test is actually working.

The reason for the rcutorture test failure could be that the default
kthread_prio for the system's RCU threads is set to 1 (unless overridden by
rcutree.kthread_prio) which is also equal to the priority of the rcutorture's
boost threads. Due to this the rcutorture test could starve the RCU threads
as well and defeat the boosting mechanism. I was able to solve a similar
issue by just passing rcutree.kthread_prio of 50 on the kernel command line.

Paul, would it be ok if we changed the default kthread_prio to something > 1
so that rcutorture can test properly without needing to pass any extra
rcutree.* parameters?

so something like this in kernel/rcu/tree.c ?

static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;

thanks!

 - Joel

