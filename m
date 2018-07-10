Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C13AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E3D20BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SxBNSk1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E3D20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeGJSdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45221 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388827AbeGJSdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id i26-v6so5239059pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+XTYgetClYOTxjmlc8NSqkgUX/cDrZg2E2hwqW1wuAg=;
        b=SxBNSk1N8qn66837aHPIkw4b1lT68VydQsitQoNMH/+d3A1FgV2+Rjw4Jjhzkz+Rko
         9/INz/pM3SZgJLqKRbnOOltr1X0Cn1KIVChayrajuDB7CjfN4HDvnyomTVo3q/cI7ViY
         cMqIzWLgcLr8SDmurA6QSKMALLnPpCyLDXy3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+XTYgetClYOTxjmlc8NSqkgUX/cDrZg2E2hwqW1wuAg=;
        b=E+fCcmjvAodrHDfGIfg7CgqOFhBy0nv60mMikKE7t6ILhEFhc/eBukf3HPRrvBHUFw
         StHRILY3129i4HF6WvdH45uQ13qsJX+Zeo58OYopdUxjCsEFfdJ/SN88vkX7+4V4dH0+
         fYZOOYoL0Oms9G6qs2Ops8xZXAZBRPxS5OGBDUaVDpEK1U52bN7JWZaRN07a1mjJBTKj
         LWkGTU8g6+9O+XTmiYeH5otJSu2Ih/E5en6ZGpBwTnFxKqOkGoGx2Swts9muZKUSZizA
         yyn4iwWS74dE4efcZv5nFId80l+D8BomZitkW9yG3Xa8byDFZHTl8NRPiZhU7BpNqNu8
         0tzw==
X-Gm-Message-State: APt69E2ii+W0HL2Gq6i3ZG8czfTwyqOjxmDrKrSUaNoxtZOsayMOV7MT
        Ad0OW9ABZHF+4cgWkrbEZLrcNhrVgP4=
X-Google-Smtp-Source: AAOMgpeRJlPiwRHYp8zm+mieKKGRf+3lAJcttkGaMCPbTSUqELKUSX4p//yWrRcEO0/TdXo2oH29og==
X-Received: by 2002:a63:6743:: with SMTP id b64-v6mr16960004pgc.91.1531243798938;
        Tue, 10 Jul 2018 10:29:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id j23-v6sm28328728pfi.137.2018.07.10.10.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:29:58 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:29:57 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, fengc@google.com
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180710172957.GA103636@joelaf.mtv.corp.google.com>
References: <20180707015616.25988-1-dancol@google.com>
 <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com>
 <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180710051347.GA180724@joelaf.mtv.corp.google.com>
 <20180710164212.GY3593@linux.vnet.ibm.com>
 <20180710165744.GA99146@joelaf.mtv.corp.google.com>
 <20180710171229.GZ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710171229.GZ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:12:29AM -0700, Paul E. McKenney wrote:
[..]
> > > > The other question I have is about the whole "nohz-full doesn't work" thing.
> > > > I didn't fully understand why. RCU is already tracking the state of nohz-full
> > > > CPUs because the rcu dynticks code in (kernel/rcu/tree.c) monitors
> > > > transitions to and from usermode even if the timer tick is turned off. So why
> > > > would it not work?
> > > 
> > > In the nohz_full case, there is no need for sys_membarrier()'s call to
> > > synchronize_sched() to interact directly with the nohz_full CPU.  It
> > > can instead look at the target CPU's dyntick-idle state, and that state
> > > would potentially have been set in the dim distant past, thus having
> > > no effect on the target CPU's current execution.
> > 
> > In nohz-idle case though, there's nothing to promote the barrier() to
> > smp_mb() if you were to purely look at the dynticks-idle state on the
> > nohz-full CPU executing in user mode?
> > 
> > So then it makes sense to me now that nohz-full needs something to IPI that
> > CPU inorder to enforce the needed memory barrier and pure synchronize_sched()
> > wouldn't work. So then makes me think the expedited versions of
> > synchronize_sched should be able to do the job but I could off on a different
> > track..
> 
> The problem is that the expedited versions also check the dyntick-idle
> state and don't touch idle (or nohz_full usermode) CPUs.  This is by
> design for the battery-powered embedded use case.  ;-)

Oh ok! ;)

I guess there's also a MEMBARRIER_CMD_GLOBAL_EXPEDITED which seems to IPI
CPUs (I'm guessing regardless of dynticks state) and execute smp_mb within
the IPI so userspace can fallback to using that incase MEMBARRIER_CMD_GLOBAL
returns -EINVAL.

thanks!

-Joel

