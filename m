Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ACDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876E320870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yG/tb0oP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876E320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeGaDoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:44:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33778 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbeGaDoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:44:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so8241898pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A4zpO1uJGsmRjfWj7Y21yntU4J7DLgF5qpZXNTvfC/Y=;
        b=yG/tb0oPxQmrizJeKnrwTLPsp4yPqMPVOJH/vp5eBSrIQyLf2xxJKezaX070SAA790
         nwNIPxULbQsOlMjBwjGOAb/n64GmxXxTcTI1/WmEa8LEF1cC0DbSPDpIlNHAlhCWHtN+
         XUJx+6HzU8O/nMufbSmqPWq0Go0AGrfeSpH8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A4zpO1uJGsmRjfWj7Y21yntU4J7DLgF5qpZXNTvfC/Y=;
        b=DUO5iLJH6x3jClyTEK3BtMN9DnjTwdoOPi0BCZDrUAnP9yprkqpTe0fGzCVDI0JL5l
         VZ7eICx/ZNQuNitSyjqeJ+/KnIpyUTCO/PbygjxFTScz7h0dcXnHm4N18TnJ16aeVMdt
         Gyvew8tRkZBdOnfz10C1OLegxoHl+Dd/Foxe6PMIJ/ivQlOZacnTx36HNyOplubpVfyI
         wkccwuJ9o5uOsO5ru+/CeFf8oT6NDNCrZC4stk+ejU+TzoChuLm/3xUXxyb3oW6bSyG0
         WCL/IzSfOAhubX3rqt0IPsAAAbG/fVvyWiyFbZa9BOJHF4j9VhxNrNALjUMERFvqG/op
         VLXw==
X-Gm-Message-State: AOUpUlEmfFNhaChfVn3J8+yWblcfoYkYWNMoLF3TQEjfUGJGt0sYsTmf
        xVIfFlOH3DNjMRXcqdCuh1P0Ww==
X-Google-Smtp-Source: AAOMgpd/Bnsm5lyzA32Y5a1MEbNNRjBQYR1EX33Vex9uB8YEElsCk62VSnkvhXAc0mFeoyrnQV94YQ==
X-Received: by 2002:a62:f587:: with SMTP id b7-v6mr20241304pfm.158.1533002790469;
        Mon, 30 Jul 2018 19:06:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id h7-v6sm21839476pfd.155.2018.07.30.19.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 19:06:30 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:06:29 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2] Add BPF_SYNCHRONIZE_MAPS bpf(2) command
Message-ID: <20180731020629.GB22311@joelaf.mtv.corp.google.com>
References: <CAADnVQL4twmGF3d26TgLsQJvnqLnM0F6hqL_42DSs95OuZ1y9A@mail.gmail.com>
 <20180731020122.GA22311@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731020122.GA22311@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 07:01:22PM -0700, Joel Fernandes wrote:
> On Sun, Jul 29, 2018 at 06:51:18PM +0300, Alexei Starovoitov wrote:
> > On Thu, Jul 26, 2018 at 7:51 PM, Daniel Colascione <dancol@google.com> wrote:
> > > BPF_SYNCHRONIZE_MAPS waits for the release of any references to a BPF
> > > map made by a BPF program that is running at the time the
> > > BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command is
> > > to provide a means for userspace to replace a BPF map with another,
> > > newer version, then ensure that no component is still using the "old"
> > > map before manipulating the "old" map in some way.
> > >
> > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > ---
> > >  include/uapi/linux/bpf.h |  9 +++++++++
> > >  kernel/bpf/syscall.c     | 13 +++++++++++++
> > >  2 files changed, 22 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index b7db3261c62d..5b27e9117d3e 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -75,6 +75,14 @@ struct bpf_lpm_trie_key {
> > >         __u8    data[0];        /* Arbitrary size */
> > >  };
> > >
> > > +/* BPF_SYNCHRONIZE_MAPS waits for the release of any references to a
> > > + * BPF map made by a BPF program that is running at the time the
> > > + * BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command
> > 
> > that doesn't sound right to me.
> > such command won't wait for the release of the references.
> > in case of map-in-map the program does not hold
> > the references to inner map (only to outer map).
> 
> I didn't follow this completely.
> 
> The userspace program is using the inner map per your description of the

Sorry just to correct myself, here I meant "The kernel eBPF program is using
the inner map on multiple CPUs" instead of "userspace".

thanks,

- Joel





> algorithm for using map-in-map to solve the race conditions that this patch
> is trying to address:
> 
> If you don't mind, I copy-pasted it below from your netdev post:
> 
> if you use map-in-map you don't need extra boolean map.
> 0. bpf prog can do
>    inner_map = lookup(map_in_map, key=0);
>    lookup(inner_map, your_real_key);
> 1. user space writes into map_in_map[0] <- FD of new map
> 2. some cpus are using old inner map and some a new
> 3. user space does sys_membarrier(CMD_GLOBAL) which will do synchronize_sched()
>    which in CONFIG_PREEMPT_NONE=y servers is the same as synchronize_rcu()
>    which will guarantee that progs finished.
> 4. scan old inner map
> 
> In step 2, as you mentioned there are CPUs using different inner maps. So
> could you clarify how the synchronize_rcu mechanism will even work if you're
> now saying "program does not hold references to the inner maps"? 
> 
> Thanks!
> 
> - Joel
> 
