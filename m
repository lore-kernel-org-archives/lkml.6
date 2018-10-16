Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CABC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D52A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DifW7hw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D52A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeJPNR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:17:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36284 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeJPNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:17:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id l81-v6so10849979pfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 22:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hT/WJu9STplUfy08+85ywKyPPy0EnpKa8gDq1HiCx6c=;
        b=DifW7hw2g2OaNA52UpmUGCGQR7tzH8euxdssKf02hDixqLl7vMpco9tXXXrr9w2l9x
         QyZ3+l0BitrAwEtMcwy2iVq+TEBO2JHkveMzCPCEycv7nDBh71q+p9nL2Mrnx+XVAysG
         hPQQR2mOW1MGgufLyU2Pd1uUseD7Z5htozMUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hT/WJu9STplUfy08+85ywKyPPy0EnpKa8gDq1HiCx6c=;
        b=KgcLCiXpLbe8aKR/n+sf4l1rDzxAWDGu/cTCnYUFobp+EuPmkatVyolj/j0UGNsQo7
         MxdgLJBTFh5JOk0MXtJ/9YgUAWApdxE2hLXvHl9t/DWW23xNDwsMRju57ruGrNtQ2ANa
         kQpkC/mvYutekpexCItEYfkDJSxlcA5zNLZQeNDhaqA9FzlUtNYXLr77v0Tk9RzQZvdE
         AILmDArbiFukITKTtzPcCwtfBdtzBrofqSP/t8V4t6NtyQr2QdDoAz/2M9CW6sX5/SbV
         avuYhEEVzSa4sSC8UnFE3Qfw23b/HtExKux8rDIIg8+HSH/KxVZfQEI0Hmno/uN1SCHX
         8uOQ==
X-Gm-Message-State: ABuFfoje2Ct30dGh79//C5gmhs3Nm5Pz/2nSrcKdl6HWQV3rUGMHUfON
        YAP2g2bfKWIMlx2tTep5JfgcMQ==
X-Google-Smtp-Source: ACcGV622M9IQ8LPV9WJpnQWa+7u0pVVRhTpFEDyTbPuYZksvyfvc7fm2rSA8WWS+7OdhHwdQ83F+pg==
X-Received: by 2002:a62:8f:: with SMTP id 137-v6mr20486712pfa.24.1539667726470;
        Mon, 15 Oct 2018 22:28:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id j3-v6sm11552791pfn.175.2018.10.15.22.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 22:28:45 -0700 (PDT)
Date:   Mon, 15 Oct 2018 22:28:44 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        rostedt@goodmis.org
Subject: Re: [RFC PATCH 12/30] rcu: Prepare rcu_read_[un]lock_bh() for
 handling softirq mask
Message-ID: <20181016052844.GA25151@joelaf.mtv.corp.google.com>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
 <1539213137-13953-13-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539213137-13953-13-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 01:11:59AM +0200, Frederic Weisbecker wrote:
> This pair of function is implemented on top of local_bh_disable() that
> is going to handle a softirq mask in order to apply finegrained vector
> disablement. The lock function is going to return the previous vectors
> enabled mask prior to the last call to local_bh_disable(), following a
> similar model to that of local_irq_save/restore. Subsequent calls to
> local_bh_disable() and friends can then stack up:
> 
> 	bh = local_bh_disable(vec_mask);
> 		bh2 = rcu_read_lock_bh() {
> 			bh2 = local_bh_disable(...)
>             return bh2;
> 		}
> 		...
> 		rcu_read_unlock_bh(bh2) {
> 			local_bh_enable(bh2);
> 		}
> 	local_bh_enable(bh);
> 
> To prepare for that, make rcu_read_lock_bh() able to return a saved vector
> enabled mask and pass it back to rcu_read_unlock_bh(). We'll plug it
> to local_bh_disable() in a subsequent patch.

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  crypto/pcrypt.c                           |  5 ++--
>  drivers/infiniband/ulp/ipoib/ipoib_main.c |  5 ++--
>  drivers/net/hyperv/rndis_filter.c         |  5 ++--
>  drivers/net/macsec.c                      | 12 +++++----
>  drivers/net/vrf.c                         | 19 ++++++++------
>  drivers/vhost/net.c                       |  5 ++--
>  include/linux/rcupdate.h                  |  5 ++--
>  include/net/arp.h                         | 10 ++++---
>  include/net/ip6_fib.h                     |  1 +
>  include/net/ndisc.h                       | 10 ++++---
>  include/net/neighbour.h                   |  1 +
>  kernel/padata.c                           |  5 ++--
>  kernel/rcu/rcuperf.c                      |  2 +-
>  kernel/rcu/rcutorture.c                   |  2 +-
>  net/caif/caif_dev.c                       |  5 ++--
>  net/core/dev.c                            |  7 ++---
>  net/core/neighbour.c                      | 37 +++++++++++++++-----------
>  net/core/pktgen.c                         |  5 ++--
>  net/decnet/dn_route.c                     | 27 +++++++++++--------
>  net/ipv4/fib_semantics.c                  |  5 ++--
>  net/ipv4/ip_output.c                      |  7 ++---
>  net/ipv4/netfilter/ipt_CLUSTERIP.c        |  5 ++--
>  net/ipv6/addrconf.c                       | 21 ++++++++-------
>  net/ipv6/ip6_fib.c                        |  4 +--
>  net/ipv6/ip6_flowlabel.c                  | 43 ++++++++++++++++++-------------
>  net/ipv6/ip6_output.c                     | 12 +++++----
>  net/ipv6/route.c                          | 15 ++++++-----
>  net/ipv6/xfrm6_tunnel.c                   |  5 ++--
>  net/l2tp/l2tp_core.c                      | 33 ++++++++++++++----------
>  net/llc/llc_core.c                        |  5 ++--
>  net/llc/llc_proc.c                        | 13 +++++++---
>  net/llc/llc_sap.c                         |  5 ++--
>  net/netfilter/ipset/ip_set_core.c         | 10 ++++---
>  net/netfilter/ipset/ip_set_hash_gen.h     | 15 ++++++-----
>  net/netfilter/nfnetlink_log.c             | 17 ++++++++----
>  35 files changed, 229 insertions(+), 154 deletions(-)
> 
> diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> index f8ec3d4..490358c 100644
> --- a/crypto/pcrypt.c
> +++ b/crypto/pcrypt.c
> @@ -73,12 +73,13 @@ struct pcrypt_aead_ctx {
>  static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
>  			      struct padata_pcrypt *pcrypt)
>  {
> +	unsigned int bh;
>  	unsigned int cpu_index, cpu, i;
>  	struct pcrypt_cpumask *cpumask;
>  
>  	cpu = *cb_cpu;
>  
> -	rcu_read_lock_bh();
> +	bh = rcu_read_lock_bh();
>  	cpumask = rcu_dereference_bh(pcrypt->cb_cpumask);
>  	if (cpumask_test_cpu(cpu, cpumask->mask))
>  			goto out;
> @@ -95,7 +96,7 @@ static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
>  	*cb_cpu = cpu;
>  
>  out:
> -	rcu_read_unlock_bh();
> +	rcu_read_unlock_bh(bh);
>  	return padata_do_parallel(pcrypt->pinst, padata, cpu);
>  }

This complicates the RCU API for -bh and doesn't look pretty at all. Is there
anything better we can do so we don't have to touch existing readers at all?

Also, I thought softirqs were kind of a thing of the past, and threaded
interrupts are the more preferred interrupt bottom halves these days,
especially for -rt. Maybe that was just wishful thinking on my part :-)

thanks,

 - Joel

