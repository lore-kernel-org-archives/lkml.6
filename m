Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FDFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D2121738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550617685;
	bh=HnR5xQVtBx1xF0ZwtokCVAfpmgoYis4uL2z6+a4uiHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AgZxkql2a/A3/z8Hp2Qct/3iQwB90HstcSN3FLPFEdnfnMHywHon8NEpaCAMi8uSR
	 SsKoQJyIRF094ZT5NC9ExOZtqd7jueaAcoAwL2b/xj0yKnSMof4HqQ9SdgSGLmJT6+
	 Hi35gYPts3AuSgCvJuTtcgjAPVX7g3C8hX91IFhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfBSXIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfBSXID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:08:03 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB42121479;
        Tue, 19 Feb 2019 23:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550617683;
        bh=HnR5xQVtBx1xF0ZwtokCVAfpmgoYis4uL2z6+a4uiHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RH5fyMYH6A/OLCVyeceKHkpqCYPq8zoG7IdnIpVw283g6hiJk2eWapys8+fWK9lQU
         ZCN4ikh8JvcBiWH5piOdFkg964nPKGv6PdZXYhM1LFEuU7J/hvsn3NrhEKdvoVKHCs
         lm/0gCCgn7ZGDXr71YFPs8Sgk+IqSSqCoiJDltw4=
Date:   Tue, 19 Feb 2019 15:08:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: user: Align the payload buffer
Message-ID: <20190219230800.GD12177@gmail.com>
References: <20190115033716.18380-1-ebiggers@kernel.org>
 <20190207233509.GA125156@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207233509.GA125156@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:35:09PM -0800, Eric Biggers wrote:
> On Mon, Jan 14, 2019 at 07:37:16PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Align the payload of "user" and "logon" keys so that users of the
> > keyrings service can access it as a struct that requires more than
> > 2-byte alignment.  fscrypt currently does this which results in the read
> > of fscrypt_key::size being misaligned as it needs 4-byte alignment.
> > 
> > Align to __alignof__(u64) rather than __alignof__(long) since in the
> > future it's conceivable that people would use structs beginning with
> > u64, which on some platforms would require more than 'long' alignment.
> > 
> > Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Fixes: 2aa349f6e37c ("[PATCH] Keys: Export user-defined keyring operations")
> > Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  include/keys/user-type.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> > index e098cbe27db54..12babe9915944 100644
> > --- a/include/keys/user-type.h
> > +++ b/include/keys/user-type.h
> > @@ -31,7 +31,7 @@
> >  struct user_key_payload {
> >  	struct rcu_head	rcu;		/* RCU destructor */
> >  	unsigned short	datalen;	/* length of this data */
> > -	char		data[0];	/* actual data */
> > +	char		data[0] __aligned(__alignof__(u64)); /* actual data */
> >  };
> >  
> >  extern struct key_type key_type_user;
> > -- 
> > 2.20.1
> > 
> 
> Ping.  David, are you planning to apply this?
> 
> - Eric

Ping.
