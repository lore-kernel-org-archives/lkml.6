Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0418DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55872086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OsjLF1Yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55872086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeK0NRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:17:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33268 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeK0NRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:17:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so6860932pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=reKKu+1LJapT7orXiWX1wQTtYUJ4rxhr8+nTKxaR6DI=;
        b=OsjLF1YkbeQTPUT9LPSvRrSeMAyROmZbo5SVvLFYcxlmajP2ZNsAR5m5G/HWH5i4Fc
         hPJqhtJSkW7o+qLp2HzQKb3mfLYTdwiw/0fxkgjWtNjmp6tfvS5I3gg5Jt5L+AUBYRP2
         ZpK6WOMrOD/0TlZZwIobdeFY3TBXz3sbgzeQZmQQzOidQHEVFC2VpVperi7t1jYjZT4X
         5kNfB2YlW6Rt5ipccBEjeZ7exMbxEJyxtYpdTRd9saxUojBV4AvEjyzV7SH3j4tvu+gT
         ax4jL5SOlaGoz/qScYtMf09vre7pY8Y9G5b+hnvoAaXvDnrgpFiGtW9KXtVeDUv0TFGy
         UVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=reKKu+1LJapT7orXiWX1wQTtYUJ4rxhr8+nTKxaR6DI=;
        b=EuWK3PxRgxnB3pRUXmfkEVKsfnZuIrH+MtCcK/59K10C4TrUH7WRBoS4DVmM4X9iQg
         eHQQcncNlk/CtuUIqm7e/ATN85IOW5+gRiiFxExt49LkMteqyaoDredG0cJ3e58qRPX5
         y+XO2mEcFJcbpCXphTYkcIh0niImFuTXKeBaLdX+XBv0ozEI8/iEjJTiU6+V8MP/9lDx
         wtgie9RuVET8Lv8hkjvismzFmu0QaSc6isZFuBBSrWd2sxjoWg8XuOsyYBvXUWb7ylIp
         ZqnPceYnov9PlGDS1/Pd4mkSY0Xd/NAy5DZakMIaN5Jirytwjr8TubRu3TDy3YSyf0jW
         JvRA==
X-Gm-Message-State: AA+aEWZDQcg8vJiGSU0UIxr5Pq2BT+KzOweegy4Zcm1QXwNTC5jjXAa3
        P+nTqmiFFhiHQGadu8atHjszrg==
X-Google-Smtp-Source: AFSGD/WIOhzfmRGqZ1NWUNmzMMDnEELMd0Ym+PXYwEy6/YlPEQsS8twymcu0DzGG/Q8uM9hBk8ENWA==
X-Received: by 2002:a63:4745:: with SMTP id w5mr27972460pgk.377.1543285254484;
        Mon, 26 Nov 2018 18:20:54 -0800 (PST)
Received: from brauner.io ([130.195.55.188])
        by smtp.gmail.com with ESMTPSA id u6sm2053610pgr.79.2018.11.26.18.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:20:53 -0800 (PST)
Date:   Tue, 27 Nov 2018 03:20:45 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        tyhicks@canonical.com, kadlec@blackhole.kfki.hu, fw@strlen.de,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com
Subject: Re: [PATCH net-next 1/2] br_netfilter: add struct netns_brnf
Message-ID: <20181127022043.mzpqxlknqxcl6fmg@brauner.io>
References: <20181107134859.19896-1-christian@brauner.io>
 <20181107134859.19896-2-christian@brauner.io>
 <20181127002047.7jzpfy32oupsthtj@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181127002047.7jzpfy32oupsthtj@salvia>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 01:20:47AM +0100, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Wed, Nov 07, 2018 at 02:48:58PM +0100, Christian Brauner wrote:
> [...]
> > diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
> > index ca043342c0eb..eedbd1ac940e 100644
> > --- a/include/net/netns/netfilter.h
> > +++ b/include/net/netns/netfilter.h
> > @@ -35,4 +35,20 @@ struct netns_nf {
> >  	bool			defrag_ipv6;
> >  #endif
> >  };
> > +
> > +struct netns_brnf {
> > +#ifdef CONFIG_SYSCTL
> > +	struct ctl_table_header *ctl_hdr;
> > +#endif
> > +
> > +	/* default value is 1 */
> > +	int call_iptables;
> > +	int call_ip6tables;
> > +	int call_arptables;
> > +
> > +	/* default value is 0 */
> > +	int filter_vlan_tagged;
> > +	int filter_pppoe_tagged;
> > +	int pass_vlan_indev;
> > +};
> 
> I have spun on this several times, wondering if there's a way to avoid
> scratching these many bytes per netns to expose these sysctl entries
> that are plain on/off toggles... You said this:
> 
> >Currently, the /proc/sys/net/bridge folder is only created in the
> >initial network namespace
> 
> I think we can add one single sysctl to expose these as flags from net
> namespaces. Idea is to keep the existing (legacy) sysctl entries for
> init_net only, and add a new single new one that exposes these as flags
> (should be also available for consistency in init_net I'd suggest).
> Flags could be map in this way, eg.
> 
>         0x1     call_iptables
>         0x2     call_ip6tables
>         0x4     call_arptables
>         0x8     filter_vlan_tagged
>         ...
> 
> Also documentation would be good to have for this.
> 
> Would this idea fly for you? Thanks.

My suggestion is to keep these files per network namespace but have a
single flag argument in struct netns_brnf:
+struct netns_brnf {
+#ifdef CONFIG_SYSCTL
+        struct ctl_table_header *ctl_hdr;
+#endif
+
+       /* default value is 1 */
+       unsigned int filter_flags;
+};

#define BRNF_CALL_IPTABLES    0x1
#define BRNF_CALL_IP6TABLES   0x2
#define BRNF_CALL_ARPTABLES   0x4
#define BRNF_CALL_VLAN_TAGGED 0x8

a write to the corresponding file would then cause the flag to be set or
unset in filter_flags.
This way we are a) space-efficient internally not bloating struct net
while b) not breaking running tools in non-initial network namespaces
that expect the files to be there. b) is really the important bit here. :)

Christian
