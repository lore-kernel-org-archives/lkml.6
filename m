Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6CC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D9C21476
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D9C21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeIWTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:53:38 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:48074 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbeIWTxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:53:38 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g44rb-0000cl-J3; Sun, 23 Sep 2018 15:55:55 +0200
Date:   Sun, 23 Sep 2018 15:55:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Christian =?iso-8859-15?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org,
        serge@hallyn.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] netfilter: nf_tables: add SECMARK support
Message-ID: <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
References: <20180923091611.19815-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180923091611.19815-1-cgzones@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Göttsche <cgzones@googlemail.com> wrote:
> Add the ability to set the security context of packets within the nf_tables framework.
> Add a nft_object for holding security contexts in the kernel and manipulating packets on the wire.
> 
> Convert the security context strings at rule addition time to security identifiers.
> This is the same behavior like in xt_SECMARK and offers better performance than computing it per packet.
> 
> Set the maximum security context length to 256.

Looks good, one minor suggestion.

> +#ifdef CONFIG_NETWORK_SECMARK
> +
> +struct nft_secmark {
> +	char ctx[NFT_SECMARK_CTX_MAXLEN];
> +	int len;
> +	u32 secid;
> +};

Can you change this to:

struct nft_secmark {
	u32 secid;
	char *ctx;
};

?
We don't need ctx in the packetpath, so better to keep
the struct size small.

> +	nla_strlcpy(priv->ctx, tb[NFTA_SECMARK_CTX], NFT_SECMARK_CTX_MAXLEN);

You can change this to
	priv->ctx = nla_strdup(tb[NFTA_SECMARK_CTX], GFP_KERNEL);
	if (!priv->ctx)
		return -ENOMEM;

> +	err = nft_secmark_secconversion(priv);
> +	if (err) {
		kfree(priv->ctx);

> +static void nft_secmark_obj_destroy(const struct nft_ctx *ctx, struct nft_object *obj)
> +{
	kfree(priv->ctx);

But other than this i think this is ready to be applied,
thanks a lot for making this happen.
