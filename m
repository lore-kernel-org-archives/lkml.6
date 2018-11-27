Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F0DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27552086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZVasoIJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27552086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeK0VQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:16:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38755 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbeK0VQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:16:43 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so16379747ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1y4X7Opw4iIGOfBvZt8nMyUQSecVlFkwQ050IbABWDo=;
        b=ZVasoIJeccz9WclPeulYvCnThPVSqKZVljsx0I3jl/SecNp2SpoRveK7/pjyr14ZOB
         ggfnKsz+N36Kd7TtAIa6nTjqIjPlVdmlHx/TwpJNOVF2Foe4yElkfIFo+2DsDlmAUARn
         Jv7AtBfeW4+zEk7HHb/48pzaT332p2KdOfN26I8tWyuSRUjGw+90smX6ooLrRk6XCr0M
         BdOjalLYdP+rt+eKIQ/5iSBpoqaGxFRmJsHSXn/s/KMu6LaMLJJBS0QVWX2z7gj4CBpJ
         L/XASvVdaX4AA/pE4bZTwKGqju7hI4ngjPbBqpf5qe9/gtBFlq6fehB/sjf4pekSH9Ay
         AS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1y4X7Opw4iIGOfBvZt8nMyUQSecVlFkwQ050IbABWDo=;
        b=VpFw+w/1B+UWjiC/UKnrtKLtNBoFG/l5CCQw6pGZJDpOhU8+NStrjCR5dQXyXROiyN
         iWSFkAFogYcZoas8Bj/Z2Hlv+RWa7XL4QA2nemGpI6J9wtGiliogKFnA3+C6s5g5lTy7
         PoPOAO42VdDKd4fZ5cTT0Io2bN/m/wz1a/2jhGdC20dxAsX/aUB4nWuG0pQ3v+Qz/vhH
         wEs0wkIrxU6gnqXOoYtlrXL2sAaE8X6Pdryt11ObMfTPJbUE4ItfK6jZkmcWWyxmpzIa
         fhuzEvScZWWITUVTSJNuYn9B5flGxYPCjN2OzaC0Amsh84cbkZI/RyrcdKT2/7YX9aTF
         07fw==
X-Gm-Message-State: AA+aEWZC1KJd3ZL9o8njoj9jZBk95j2vsceiuPD+bIX6OPe5DSAwirzR
        21AyTZr278BwmOv2DROlqF5+BA==
X-Google-Smtp-Source: AFSGD/WsBKgjlj4IRe9X2SCj9bBqh0eo94p79/ag80FhAy/olUXIf+xWlHE07ZkmcShRIaAWjqHwrA==
X-Received: by 2002:a5e:870e:: with SMTP id y14mr24262657ioj.253.1543313958087;
        Tue, 27 Nov 2018 02:19:18 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id m22-v6sm1567169iti.42.2018.11.27.02.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 02:19:17 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:19:08 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        tyhicks@canonical.com, kadlec@blackhole.kfki.hu, fw@strlen.de,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com
Subject: Re: [PATCH net-next 1/2] br_netfilter: add struct netns_brnf
Message-ID: <20181127101906.wzi3sxazxwo5x45h@brauner.io>
References: <20181107134859.19896-1-christian@brauner.io>
 <20181107134859.19896-2-christian@brauner.io>
 <20181127002047.7jzpfy32oupsthtj@salvia>
 <20181127022043.mzpqxlknqxcl6fmg@brauner.io>
 <20181127082349.ummq2perajt6olhh@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181127082349.ummq2perajt6olhh@salvia>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:23:49AM +0100, Pablo Neira Ayuso wrote:
> On Tue, Nov 27, 2018 at 03:20:45AM +0100, Christian Brauner wrote:
> > On Tue, Nov 27, 2018 at 01:20:47AM +0100, Pablo Neira Ayuso wrote:
> > > Hi,
> > > 
> > > On Wed, Nov 07, 2018 at 02:48:58PM +0100, Christian Brauner wrote:
> > > [...]
> > > > diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
> > > > index ca043342c0eb..eedbd1ac940e 100644
> > > > --- a/include/net/netns/netfilter.h
> > > > +++ b/include/net/netns/netfilter.h
> > > > @@ -35,4 +35,20 @@ struct netns_nf {
> > > >  	bool			defrag_ipv6;
> > > >  #endif
> > > >  };
> > > > +
> > > > +struct netns_brnf {
> > > > +#ifdef CONFIG_SYSCTL
> > > > +	struct ctl_table_header *ctl_hdr;
> > > > +#endif
> > > > +
> > > > +	/* default value is 1 */
> > > > +	int call_iptables;
> > > > +	int call_ip6tables;
> > > > +	int call_arptables;
> > > > +
> > > > +	/* default value is 0 */
> > > > +	int filter_vlan_tagged;
> > > > +	int filter_pppoe_tagged;
> > > > +	int pass_vlan_indev;
> > > > +};
> > > 
> > > I have spun on this several times, wondering if there's a way to avoid
> > > scratching these many bytes per netns to expose these sysctl entries
> > > that are plain on/off toggles... You said this:
> > > 
> > > >Currently, the /proc/sys/net/bridge folder is only created in the
> > > >initial network namespace
> > > 
> > > I think we can add one single sysctl to expose these as flags from net
> > > namespaces. Idea is to keep the existing (legacy) sysctl entries for
> > > init_net only, and add a new single new one that exposes these as flags
> > > (should be also available for consistency in init_net I'd suggest).
> > > Flags could be map in this way, eg.
> > > 
> > >         0x1     call_iptables
> > >         0x2     call_ip6tables
> > >         0x4     call_arptables
> > >         0x8     filter_vlan_tagged
> > >         ...
> > > 
> > > Also documentation would be good to have for this.
> > > 
> > > Would this idea fly for you? Thanks.
> > 
> > My suggestion is to keep these files per network namespace but have a
> > single flag argument in struct netns_brnf:
> > +struct netns_brnf {
> > +#ifdef CONFIG_SYSCTL
> > +        struct ctl_table_header *ctl_hdr;
> > +#endif
> > +
> > +       /* default value is 1 */
> > +       unsigned int filter_flags;
> > +};
> > 
> > #define BRNF_CALL_IPTABLES    0x1
> > #define BRNF_CALL_IP6TABLES   0x2
> > #define BRNF_CALL_ARPTABLES   0x4
> > #define BRNF_CALL_VLAN_TAGGED 0x8
> > 
> > a write to the corresponding file would then cause the flag to be set or
> > unset in filter_flags.
> > This way we are a) space-efficient internally not bloating struct net
> > while b) not breaking running tools in non-initial network namespaces
> > that expect the files to be there. b) is really the important bit here. :)
> 
> OK, please, go explore this space-efficient approach. Thanks.

Will do. I'll try to get to it in the next couple of days and send out a
new version. Thanks! 
