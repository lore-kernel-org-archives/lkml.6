Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E571ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268D120850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XdSlctQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268D120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeGPUwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:52:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37480 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:52:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so1069265pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oi43PK/LlOA786hOlFC+fdGLLE5AMxk1PrN/1xxhqjo=;
        b=XdSlctQSAsTO1Kw3q1PF7uvXKjceEkzkyrohixDDWMsZNgqUXsZH9UOgmaEQyr/Khk
         j3RbmYWKlwl0QE4fhfqBfNYZNBetegoUedzJg1Up8jM0Oc78kpTNlPZgclXsriCYeTyv
         qdeIQZqTHabonATD+Mv+mpaZ8HmUVU4Ef1yXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oi43PK/LlOA786hOlFC+fdGLLE5AMxk1PrN/1xxhqjo=;
        b=Jz7pSOQb2j67Woqjbm22qD+cE9D6Cs1a8SmqwH/7LM/Ct5tAB8SpAMeQ6dtzp+Uagg
         h6sYy7HRH2EBkjZgUuy2QB0peyx1O7bjjDdXRnxK91kqVvxga9jUsQHFb/c23Ur+62on
         r9/GhyjHljuCEEqvostp/Y3uEyPGQ5JPw9R/gi8Yp5hnGwW4tCsx2xIxmI6n1NpMRdTf
         dFaQyuaP2LRTUQNwjPRwR1/GjOB0K4m+iZTgare7aGRikbojHBZNQDrO06lLerSzby+r
         miZeu/ciNc0lxTxNprO6FV2+3NIQ5AIj1ndua0Agx1rP2wJePRFsIZo8RECuGaSOvsf8
         cCAg==
X-Gm-Message-State: AOUpUlH6jgRLsVqiHLHBbvKPhe+BTg8kDYiWRfEWdMrEiL/cmtREZjnm
        b/qj2R1TWGQj0M11CpFjS6PbIg==
X-Google-Smtp-Source: AAOMgpcvJyV9JTFuE1/6YYIZMpcc2XqmcEtryOdWpf7hmr2MaHlKrLfuwNNsvmslEvjmnEYTGuIYmQ==
X-Received: by 2002:a63:d613:: with SMTP id q19-v6mr16656966pgg.327.1531772582858;
        Mon, 16 Jul 2018 13:23:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id s27-v6sm41475920pfk.133.2018.07.16.13.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:23:02 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:23:01 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180716202301.GB160902@joelaf.mtv.corp.google.com>
References: <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com>
 <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuetaKNaJVWcu10ZcsiXiK4X+-2z3eFaz1pF8DSxdQ_mEnQ@mail.gmail.com>
 <20180709223439.uc2a6hyic35inwye@ast-mbp.dhcp.thefacebook.com>
 <CAMOXUJ=QmkjTqbWqPRxb=R7f6EpsHBkDQ4MhrSD=VPiDTj7RiA@mail.gmail.com>
 <20180710235252.mioihpgtu4n3syaq@ast-mbp.dhcp.thefacebook.com>
 <CAKD1Yr07uxpd95oGAE7QxfrS_qWuiLcUmy7nsEsC0CzVhV2-rg@mail.gmail.com>
 <20180711034017.o2ehf27tv5hpl3td@ast-mbp.dhcp.thefacebook.com>
 <20180714181815.GA199777@joelaf.mtv.corp.google.com>
 <CAKOZuetwbE2HSa7vfVoVYwSqfz0ZcNWO93Y=pcJ-q4uEWHSuNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuetwbE2HSa7vfVoVYwSqfz0ZcNWO93Y=pcJ-q4uEWHSuNg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 08:29:47AM -0700, Daniel Colascione wrote:
> On Sat, Jul 14, 2018 at 11:18 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Tue, Jul 10, 2018 at 08:40:19PM -0700, Alexei Starovoitov wrote:
> > [..]
> >> > The kernel program might do:
> >> >
> >> > =====
> >> > const int current_map_key = 1;
> >> > void *current_map = bpf_map_lookup_elem(outer_map, &current_map_key);
> >> >
> >> > int stats_key = 42;
> >> > uint64_t *stats_value = bpf_map_lookup_elem(current_map, &stats_key);
> >> > __sync_fetch_and_add(&stats_value, 1);
> >> > =====
> >> >
> >> > If a userspace does:
> >> >
> >> > 1. Write new fd to outer_map[1].
> >> > 2. Call BPF_SYNC_MAP_ACCESS.
> >> > 3. Start deleting everything in the old map.
> >> >
> >> > How can we guarantee that the __sync_fetch_and_add will not add to the
> >> > old map?
> >>
> >> without any changes to the kernel sys_membarrier will work.
> >> And that's what folks use already.
> >> BPF_SYNC_MAP_ACCESS implemented via synchronize_rcu() will work
> >> as well whether in the current implementation where rcu_lock/unlock
> >> is done outside of the program and in the future when
> >> rcu_lock/unlock are called by the program itself.
> >
> > Cool Alexei and Lorenzo, sounds great to me. Daniel want to send a follow up
> > patch with BPF_SYNC_MAP_ACCESS changes then?
> 
> Will do. Mind if I just mine this thread for the doc comment?

Do you mean the changelog? Yes I believe you could use the discussion in this
thread for the rationale as Alexei described.

thanks,

- Joel


