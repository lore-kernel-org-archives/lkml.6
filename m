Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0794FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DB920849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="H92LCtHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DB920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeLMLno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:43:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeLMLno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:43:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so1655235wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 03:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qtsedI8FBgcuUwNusiVxliHjJjL3XLLHyByPD/7zUrc=;
        b=H92LCtHDVfokvBSbcJJY2B1OIlxm7N9zPU5K9/FTHFXpzMwI3C36xg6+xoE5jJT3xQ
         0RQBjH76oJNlJ3oHz2NXotDwrFfTFfXlHbcbkO3CnxRU84k4Zf7bjSAN2XNSJ07QDAJY
         myINCwSe15Sx5BCDJfCS2CBc43R3cf1ZKUSTVnokh0q35Qv/eMeg77Dt03ASkq66oafD
         5/sHpOrszaJ6Yb53PZfaPPVXiGSo4+v0WeSZOPAFn698VLF/0EkSWR4L+nNJHTebCBf+
         x2oh23u/kb5lOUkyVHElGFRmMZilXMLxI3638jFMZHviPkqRKzpmt0ruIceJKvzTJ9fC
         2TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qtsedI8FBgcuUwNusiVxliHjJjL3XLLHyByPD/7zUrc=;
        b=CM1N+xs/aVImXnOfQPM+Nyt/npPHqlxO/QfAYPDVXNWtuvA5gJkz6mZZnkMODUhF5B
         JwmVHPdyH44yVKFcBiFizB8OELfiC6oObfQva70l8wG8zWfQQO/QOm/qA6ymyreoZ39U
         7CbwCoYODhicsr/D60TEFd35Vc0yE6V23gZDpRHJuaGj6uWWCmBBBeJehlKfy4fXPlEr
         LYZx8Fg8RGYLAsukaA/r31U1jWduxn+3KaY2ROB2iF7C9Yaukj3plnpdH2prXvcVQOIJ
         7mbHX0LWcvMn6WHQAQDX2oNXp1qJGIbCehFoJWO33nVOvDkUfWCRBe6Pj30+xRoklrVx
         xClQ==
X-Gm-Message-State: AA+aEWYjHfFnU9Fg3L2YPM4YDTveekyC3xwyRJadrsbqQ0UVIZWn32A0
        QLMXJTSys+LMfBUUps4N1RUvug==
X-Google-Smtp-Source: AFSGD/V3jg5E+w4V3rnJ+1OTgyy2qKKdpnYzvklHr0k2lyGQYvHQnIHfh1rL/thmRaIyH6uGjh4I0A==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr21579769wro.78.1544701421623;
        Thu, 13 Dec 2018 03:43:41 -0800 (PST)
Received: from brauner.io ([2a02:8070:88c2:4000:69e7:45c9:1529:166d])
        by smtp.gmail.com with ESMTPSA id g67sm1824976wmd.38.2018.12.13.03.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 03:43:41 -0800 (PST)
Date:   Thu, 13 Dec 2018 12:43:39 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        tyhicks@canonical.com, kadlec@blackhole.kfki.hu, fw@strlen.de,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com
Subject: Re: [PATCH net-next 1/2] br_netfilter: add struct netns_brnf
Message-ID: <20181213114338.j3thzzu7cvrpz72e@brauner.io>
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

Sorry for the wait. Other patches came up. :)
So, I looked into this approach and it is annoying to do:
- the sysctl proc parsing infrastructure is not equipped to deal with
  flags at all and expanding it to it would be a lot of code
- we would need either an atomic type or locking for filter_flags in the
  netns_brnf struct if multiple proc sysctl handlers try to raise or
  lower bits in filter_flags via different files at the same time

So I feel that this is not a feasible solution. We could make netns_brnf
a pointer in struct net and allocate it on new network namespace
creation if we care about space but then we take the performance hit of
k*alloc().
What I stressed before: for userspace it's important that we don't
change the semantics how br netfilter is configured in a non-initial
network namespace to not break existing tools in such environments.

Christian
