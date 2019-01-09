Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E5BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F735217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="SxX823YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfAIHGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:06:06 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:27703 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfAIHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547017562;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=t2pf9RimKeiqXw2g/il/Z3EG5I75lXeoHOpFlH6p7rE=;
        b=SxX823YCV5mfKFOCO78YrAjT7AjDKhoYe9b4hQwhYgYslyiLC/YMZwCEeqVMSv/WNh
        /StXB2CF+NkAtFYvTi16CmWSS9QmYLAy2gEaKqR7j3xRKHXuK/lkNSz8Vdj1CwF8gcbN
        7lJiIvf27wpUB8Gf2e5KT0rHJ8xSajK/dCmCcTAXEfXqJzjdPvzlv3KGmVUhPx2tEli9
        gFlpWcDXSsWraCDdfLIuG3uUwclgZDxB7v3E5nqnQw8Kx+cA1eU2IpemYR3Mr21W05jZ
        LRaepn6Whu6pqyPIMy8Mevg3dXuYDze0TR6CmImNQCJ/nbkIenszBv9aVtjW9qjwBwMT
        zvwg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaLvSbdkg="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv0975LNxT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 08:05:21 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date:   Wed, 09 Jan 2019 08:05:21 +0100
Message-ID: <1894062.aDvIuj92vB@tauon.chronox.de>
In-Reply-To: <1547017108.2789.24.camel@HansenPartnership.com>
References: <20190103143227.9138-1-jlee@suse.com> <309406107.k3W2fMQUza@tauon.chronox.de> <1547017108.2789.24.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 07:58:28 CET schrieb James Bottomley:

Hi James,

> On Wed, 2019-01-09 at 07:45 +0100, Stephan Mueller wrote:
> > Am Mittwoch, 9. Januar 2019, 01:44:31 CET schrieb James Bottomley:
> > 
> > Hi James,
> > 
> > > Actually, it would be enormously helpful if we could reuse these
> > > pieces for the TPM as well.
> > 
> > Could you please help me understand whether the KDFs in TPM are
> > directly usable as a standalone cipher primitive or does it go
> > together with additional  key generation operations?
> 
> They're used as generators ... which means they deterministically
> produce keys from what the TPM calls seeds so we can get crypto agility
> of TPM 2.0 ... well KDFa does.  KDFe is simply what NIST recommends you
> do when using EC for a shared key agreement ... and really we shouldn't
> be using ECDH in the kernel without it.
> 

Thanks for clarifying. That would mean that indeed we would have hardware-
provided KDF implementations that may be usable with the kernel crypto API.

[...]
> 
> > Would it be appropriate, to implement a type cast to a structure from
> > the u8 pointer?
> > 
> > E.g. for the aforementioned label/context data, we could define
> > something like
> > 
> > struct crypto_kdf_ctr {
> > 
> > 	char *label;
> > 	size_t label_len;
> > 	u8 *contextU;
> > 	size_t contextU_len;
> > 	u8 *contextV;
> > 	size_t contextV_len;
> > 
> > };
> > 
> > And the implementation of the generate function for CTR KDF would
> > 
> > then have a  type cast along the following lines:
> > 	if (slen != sizeof(struct crypto_kdf_ctr))
> > 	
> > 		return -EINVAL;
> > 	
> > 	const struct crypto_kdf_ctr *kdf_ctr_input = (struct
> > 
> > crypto_kdf_ctr *)src;
> > 
> > 
> > For different KDFs, different structs would be needed.
> 
> Actually, we probably just need the input key (or secret material), the
> concatenation and the number of output bits.

Thanks for confirming. Though, when it comes to HKDF (not that I see it being 
needed or required in the kernel), there is a need to split up the src pointer 
since the mentioned input is used in different ways.

In order to try to get the implementation and thus the interface right, I 
would suggest to at least have a consensus on how to handle such situations.

Thus, would the proposal be acceptable for such KDFs that may need to have 
different components communicated as input to the KDF?

Ciao
Stephan


