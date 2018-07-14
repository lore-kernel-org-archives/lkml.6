Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11985ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E1320871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d5XjEOwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E1320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGNSiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:38:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42932 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbeGNSiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:38:09 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so12682585pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oykqtlZCMGWPyVgkXiCzw9woGdxg2lvt4qS2utF0pY0=;
        b=d5XjEOwANug752oc1McBkTAUE4KORseINc5xTCUjHjEcLdjmW9JtffkoAfqi7kfFgR
         APMu6c19J3pDp/AvJX9U6mfQx0Lfvm5RWtl8x/u0T6sTOGs0vpbyEeaQoqBoNPLo8bFC
         T8mZbAAaJSVP2bNTSBmiY+s2CCkj/XlXTS0mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oykqtlZCMGWPyVgkXiCzw9woGdxg2lvt4qS2utF0pY0=;
        b=ZWBUJZG8+bM+mwMRQW2Fe43Dh7+eCjzEPi76LCxnYhpMRKW0n9fk1LCjCL6gCFJfO5
         iJBRqbQUu1CL7E8ncexcsQ2D3IRE3McZkO1sCtzn85ttV7TWuxE7YEbbAi6nvaAKEkae
         TJwpAVJ21IpdfZ9vp85Y1ulWXGVRbRmmrRbCgC6qix34Ddi1+CkwFVTlF9onnM4hbOWL
         /of4Qg1zDcFQkMFiTPBHlXYeHLrtXuxp5IgEjyUF9hKlDo3ckENdj3fis9PC6lNiV6rs
         nrTuHtcr3wdWQhnkfSflVcrczKeat7BnENlSPx+tkcW25mR8f/w32lvcm9eUMB3Qjjzo
         kmNw==
X-Gm-Message-State: AOUpUlE/dkYI82bgNyPX72X2BRBKpcLO5vtVrnznyfgaGfCUsOClwmC7
        JRhYOtmcQYPC1/LBNJhOap1cbA==
X-Google-Smtp-Source: AAOMgpdRi68f7vkDeUJC021eHwuHnV4rtVyZnC9DoJqbvC0PGA+uu1R1hNDJTtWVMothqaQZlcmghw==
X-Received: by 2002:a63:aa44:: with SMTP id x4-v6mr10502470pgo.120.1531592296924;
        Sat, 14 Jul 2018 11:18:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id p26-v6sm50128040pfi.164.2018.07.14.11.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 11:18:16 -0700 (PDT)
Date:   Sat, 14 Jul 2018 11:18:15 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>, dancol@google.com,
        mathieu.desnoyers@efficios.com, Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180714181815.GA199777@joelaf.mtv.corp.google.com>
References: <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com>
 <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuetaKNaJVWcu10ZcsiXiK4X+-2z3eFaz1pF8DSxdQ_mEnQ@mail.gmail.com>
 <20180709223439.uc2a6hyic35inwye@ast-mbp.dhcp.thefacebook.com>
 <CAMOXUJ=QmkjTqbWqPRxb=R7f6EpsHBkDQ4MhrSD=VPiDTj7RiA@mail.gmail.com>
 <20180710235252.mioihpgtu4n3syaq@ast-mbp.dhcp.thefacebook.com>
 <CAKD1Yr07uxpd95oGAE7QxfrS_qWuiLcUmy7nsEsC0CzVhV2-rg@mail.gmail.com>
 <20180711034017.o2ehf27tv5hpl3td@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711034017.o2ehf27tv5hpl3td@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:40:19PM -0700, Alexei Starovoitov wrote:
[..]
> > The kernel program might do:
> > 
> > =====
> > const int current_map_key = 1;
> > void *current_map = bpf_map_lookup_elem(outer_map, &current_map_key);
> > 
> > int stats_key = 42;
> > uint64_t *stats_value = bpf_map_lookup_elem(current_map, &stats_key);
> > __sync_fetch_and_add(&stats_value, 1);
> > =====
> > 
> > If a userspace does:
> > 
> > 1. Write new fd to outer_map[1].
> > 2. Call BPF_SYNC_MAP_ACCESS.
> > 3. Start deleting everything in the old map.
> > 
> > How can we guarantee that the __sync_fetch_and_add will not add to the
> > old map? 
> 
> without any changes to the kernel sys_membarrier will work.
> And that's what folks use already.
> BPF_SYNC_MAP_ACCESS implemented via synchronize_rcu() will work
> as well whether in the current implementation where rcu_lock/unlock
> is done outside of the program and in the future when
> rcu_lock/unlock are called by the program itself.

Cool Alexei and Lorenzo, sounds great to me. Daniel want to send a follow up
patch with BPF_SYNC_MAP_ACCESS changes then?

> > Will the verifier automatically
> > hold the RCU lock for as long as a pointer to an inner map is valid?
> 
> the verifier will guarantee the equivalency of future explicit
> lock/unlock by the program vs current situation of implicit
> lock/unlock by the kernel.
> The verifier will track that bpf_map_lookup_elem() is done
> after rcu_lock and that the value returned by this helper is
> not accessed after rcu_unlock. Baby steps of dataflow analysis.

Nice!

By the way just curious I was briefly going through kernel/bpf/arraymap.c.
How are you protecting against load-store tearing of values of array map
updates/lookups?

For example, if userspace reads an array map at a particular index, while
another CPU is updating it, then userspace can read partial values /
half-updated values right? Since rcu_read_lock is in use, I was hoping to
find something like rcu_assign_pointer there to protect readers against
concurrent updates.  Thanks for any clarification.

Regards,

- Joel

