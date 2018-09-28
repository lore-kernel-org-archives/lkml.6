Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0955CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBAD2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZGytgrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBAD2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeI1QsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:48:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35521 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbeI1QsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:48:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id v133-v6so4170885pgb.2;
        Fri, 28 Sep 2018 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvc7tOC6Knfednrgqlv5BibEH//tfqrHoyN25vxI7sI=;
        b=nZGytgrKFXcm8xP6XtGqw+h79hKX4hMfNK1RvypplJB22l3EyBhySgubkf8PmI50Br
         t48GDZCvba0KlJtku2N97rqbdNgLJvRJa0HsFqWJanzGzX05+Kg72pGihFJOy9JujwsS
         aQex4hpM9k+hoiICfq/aQ2C1HJijRi+rUg3seU6XQDmdog0IEhA/z/6esUlF36XjUpBV
         gzP3oxI2C7Fha3M9oLWKUJ1uJO47gcqZXZWQa35W5gKK6PE+yWZmWT3UGiviRCncU/qN
         fuuEl7tBlpJPb52cn0G8nvuF+zTafqVgFnoBs8EDQ3sifck6xeKnTl+P+eztAoVxgnIL
         v98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvc7tOC6Knfednrgqlv5BibEH//tfqrHoyN25vxI7sI=;
        b=ZSHc56gRWT1kBr6ROxLotKcOiAR3u0eMXEcjVaBk7rIp+wmpbpC1fLfQ39JWOG5qQa
         sIsqcb0amgxSnikWcisqnfpmN/UOpBMVSTEPvMq7LcnJ//mE2Pof5y8BGHhM40z3wATs
         VWkLuMFko6/dpYLHg2623MbFM/pRS4Wm7dc4/7VSul6D940H9mFupQHXthC3t3BSswLf
         acrl3dOVFOWuZrQO3km+m8BJw/buk+sSHciiJBzDkiJrx4RX4/igJC/ffTjxzpLj69pG
         oDiZzpziR49QD0dhmQ/idGzcJ5hRX2b2oH+UEcyiFAZxTXlypBDexQP8rU5guC8I/dyo
         /p3A==
X-Gm-Message-State: ABuFfoh/gc2m/LNvFU69xVNoqvCzX5/hmUMZb7zezOopAH74OndvFn/J
        pgImA1Kv6YWC279u55XGCj1236EGo6k=
X-Google-Smtp-Source: ACcGV60acAPd7mazysnSWkyk9bPsSw2nzi9RRkY91YucEUK3Z/d54cRjCWmHZYagIZoNTXs1swW9Eg==
X-Received: by 2002:a65:5b07:: with SMTP id y7-v6mr11576218pgq.125.1538130309771;
        Fri, 28 Sep 2018 03:25:09 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:5ff1])
        by smtp.gmail.com with ESMTPSA id 70-v6sm7474830pfz.27.2018.09.28.03.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 03:25:08 -0700 (PDT)
Date:   Fri, 28 Sep 2018 12:25:01 +0200
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Message-ID: <20180928102458.dbia6xnxkijvkld6@ast-mbp.dhcp.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-4-guro@fb.com>
 <20180928084528.i5txkac34pmqvs3p@ast-mbp.dhcp.thefacebook.com>
 <20180928100302.GB9018@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928100302.GB9018@castle.DHCP.thefacebook.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:03:03AM +0100, Roman Gushchin wrote:
> > > +
> > > +	if (unlikely(map_flags & BPF_EXIST))
> > > +		return -EINVAL;
> > 
> > that should have been BPF_NOEXIST ?
> 
> Yeah, or maybe even better s/&/!= ?
> It's probably better to require BPF_EXIST flag to update a cgroup storage?
> Agree? If so, let me fix this for both shared and per-cpu versions in
> a follow-up patch.

I think BPF_ANY is technically valid too.
If we were to require strict BPF_EXIST only, we'd need to fix stable too.
I'm fine with both (BPF_EXIST only and BPF_ANY|BPF_EXIST).
Daniel, what do you think?

