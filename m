Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88EFECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C8F21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C8F21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeITPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:12:56 -0400
Received: from mail.us.es ([193.147.175.20]:41782 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbeITPM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:12:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 720F52519BC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:30:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4BF45DA912
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:30:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2A45CDA915; Thu, 20 Sep 2018 11:30:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E1A93DA8F0;
        Thu, 20 Sep 2018 11:30:18 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 20 Sep 2018 11:30:18 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9A1124265A31;
        Thu, 20 Sep 2018 11:30:18 +0200 (CEST)
Date:   Thu, 20 Sep 2018 11:30:18 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        kadlec@blackhole.kfki.hu, davem@davemloft.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        jmorris@namei.org, serge@hallyn.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
Message-ID: <20180920093018.qliwjvkeqjrouvsw@salvia>
References: <20180919231402.4482-1-cgzones@googlemail.com>
 <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
 <20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:50:48AM +0200, Florian Westphal wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 9/19/2018 4:14 PM, Christian Göttsche wrote:
> > > Add the ability to set the security context of packets within the nf_tables framework.
> > > Add a nft_object for holding security contexts in the kernel and manipulating packets on the wire.
> > > The contexts are kept as strings and are evaluated to security identifiers at runtime (packet arrival),
> > > so that the nft_objects do not need to be refreshed after security changes.
> > > The maximum security context length is set to 256.
> > >
> > > Based on v4.18.6
> > >
> > > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > 
> > I've only had a cursory look at your patch, but how is it
> > different from what's in xt_SECMARK.c ?
> 
> this change is supposed to make secmark labeling accessible from
> nftables.
> 
> The advantage is that its now possible to use
> maps to assign secmarks from a single rule instead of using
> several rules:
> 
> nft add rule meta secmark set tcp dport map { 22 : tag-ssh, 80 :
> 	tag-http }
> 
> and so on.
> 
> > > +	for (i = 0; i < ARRAY_SIZE(nft_basic_objects); i++) {
> > > +		err = nft_register_obj(nft_basic_objects[i]);
> > > +		if (err)
> > > +			goto err;
> > > +	}
> > >  
> > > -	for (i = 0; i < ARRAY_SIZE(nft_basic_types); i++) {
> > > -		err = nft_register_expr(nft_basic_types[i]);
> > > +	for (j = 0; j < ARRAY_SIZE(nft_basic_types); j++) {
> > > +		err = nft_register_expr(nft_basic_types[j]);
> > >  		if (err)
> > >  			goto err;
> > >  	}
> > > @@ -248,8 +260,12 @@ int __init nf_tables_core_module_init(void)
> > >  	return 0;
> > >  
> > >  err:
> > > +	while (j-- > 0)
> > > +		nft_unregister_expr(nft_basic_types[j]);
> > > +
> > >  	while (i-- > 0)
> > > -		nft_unregister_expr(nft_basic_types[i]);
> > > +		nft_unregister_obj(nft_basic_objects[i]);
> > > +
> > >  	return err;
> 
> Do I read this right in that this is a error unroll bug fix?
> If so, could you please submit this as indepentent patch?
> 
> Fixes should go into nf.git whereas feature goes to nf-next.git.

nft_register_expr() never actually fails, so probably we can just turn
this into void.

@Christian: Please make sure you rebase your secmark patch on top of
nf-next.git.
