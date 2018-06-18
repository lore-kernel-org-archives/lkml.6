Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F042075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="U73+mnKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F042075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936834AbeFRW0v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:26:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37535 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935073AbeFRW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:26:49 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so9798194plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0danN2t2LPgGNtwAAXcYA9rnhNdrC1SUwccN4Ac+NA=;
        b=U73+mnKct/nuMQicRU9vruA/M21Nw3aYxj+3TYrW6F22S3H5hy+5g1KDziamfkdl0J
         GQ/9JwLqtwcIQQma3e41JxpouaVkvcJI2OIBfkFlW0CLKPUpXORjwQ/H/M7xNui3iVGh
         TOeu3XFnmyR10bG4joGiq0hpUK4RT0P9gjNxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0danN2t2LPgGNtwAAXcYA9rnhNdrC1SUwccN4Ac+NA=;
        b=HYuYutA7UjcMkyhJ4mS/9yzaJWEMve36vXqJk1ihJ5J6Tbm7mGGlctuN08GEX+NctL
         ymWVFAV/BgCsoPRsOEwdlcm3sGstAQvdBjk2edKZzQmRharNhWl2B+hsQ3RudVcQRTnG
         0imVeDcQ8wpAUAGwGOvau0U02XVYtGi5hp3K13C2FZXeAjdAovzrtsjLTVI/JhgJyaZ2
         +dmOpQivxaJEJpA2Qwr1u1ZPJ/T+TCf/6BtsM8Yc8H8BTkenyp8FGqcS/im9BJTtUyzG
         2RW6ZnaYcW5/YE0upwY/s0Ka0Wa/aa02h7LZ0psMb+3U1YiHVJSZvW59i4ZoW7BI0PQu
         jNVw==
X-Gm-Message-State: APt69E0Co72RN7ojYQ7vYO070o9msLMlSLLnpFk/rq/mpww77wgNBdo6
        EyEKF4uosEHMDa2ZfXT/Egr67w==
X-Google-Smtp-Source: ADUXVKKAeLHEDnseId1aeyRIH8lQs4lu8sEr6OVxENohgm4Mb4V/K2bdlDyHcOq2BebO4w9G8vuh3A==
X-Received: by 2002:a17:902:778e:: with SMTP id o14-v6mr15832880pll.214.1529360809090;
        Mon, 18 Jun 2018 15:26:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id s19-v6sm29163583pfe.97.2018.06.18.15.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 15:26:48 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:26:47 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, lkp@01.org
Subject: Re: [lkp-robot] [rcutorture]  46e26223e3:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print
Message-ID: <20180618222647.GA156172@joelaf.mtv.corp.google.com>
References: <20180610234544.150933-2-joel@joelfernandes.org>
 <20180613065711.GZ16472@yexl-desktop>
 <20180613072948.GA142000@joelaf.mtv.corp.google.com>
 <20180618165646.GA3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618165646.GA3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 09:56:46AM -0700, Paul E. McKenney wrote:
> > The reason for the rcutorture test failure could be that the default
> > kthread_prio for the system's RCU threads is set to 1 (unless overridden by
> > rcutree.kthread_prio) which is also equal to the priority of the rcutorture's
> > boost threads. Due to this the rcutorture test could starve the RCU threads
> > as well and defeat the boosting mechanism. I was able to solve a similar
> > issue by just passing rcutree.kthread_prio of 50 on the kernel command line.
> > 
> > Paul, would it be ok if we changed the default kthread_prio to something > 1
> > so that rcutorture can test properly without needing to pass any extra
> > rcutree.* parameters?
> > 
> > so something like this in kernel/rcu/tree.c ?
> > 
> > static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;
> 
> Would it be possible to also condition this on rcutorture being built
> in?  Or are they doing modprobes for rcutorture?

They seem to be doing built-in rcutorture tests. But I believe the same
problem would occur even if you used modules? I believe the fact that
rcutorture is a module or built-in wouldn't matter to the underlying issue
which is the RCU subsystems's threads are at too low of a priority
(rcutree.kthread_prio = 1).

If you agree with changing the default priority, I have included a patch
below for rcu/dev.

thanks,

 - Joel

---8<-----------------------

From b0f4111ef1abd1c481c269fadb3535c83ab43c93 Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Mon, 18 Jun 2018 15:13:10 -0700
Subject: [PATCH] rcu: Change default RCU kthread priority to 2

The current RT priority of 1 for RCU kthreads makes rcutorture's boost test
fail on systems where rcutree.kthread_prio isn't passed.

The rcutorture boost kthreads have the same priority as well (RT priority of
1). Due to this, the rcutorture kthreads starve the RCU subsystem's kthreads
and causes rcutorture failures. This patch changes the priority of the RCU
subsystem's threads to a default RT priority of 2 so that rcutorture's
threads get preempted by them. Verified that the boost tests will pass with
this change.

Reported-by: Xiaolong Ye (via lkp-robot) <xiaolong.ye@intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index deb2508be923..920c39e3f871 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -171,7 +171,7 @@ static void rcu_report_exp_rdp(struct rcu_state *rsp,
 static void sync_sched_exp_online_cleanup(int cpu);
 
 /* rcuc/rcub kthread realtime priority */
-static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
+static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;
 module_param(kthread_prio, int, 0644);
 
 /* Delay in jiffies for grace-period initialization delays, debug only. */
-- 
2.18.0.rc1.244.gcf134e6275-goog

