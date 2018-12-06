Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BE3C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C159208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544120789;
	bh=jRgs+WLT/TjJU4ZD1y6nKQZC21gJ5g2MkNwkxPOn/Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UEEyFTzl/jnnEUAkqiRqZ8UqB+6jNgsfGk2xs5qRaUQ5LP518WTu9pjpMw6Jrv/HN
	 N+DSFY3IX+FGwdk8TU7n+xQTIPx9UO8hNlBvSw2gIvwWU+6pUOqIUhT47tpckaXmSe
	 G/lp0ooffQFX9RqD1OM0hhZWS3N4550O8CXr4jV8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C159208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLFS02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFS02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:26:28 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8327C20892;
        Thu,  6 Dec 2018 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544120787;
        bh=jRgs+WLT/TjJU4ZD1y6nKQZC21gJ5g2MkNwkxPOn/Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkXyWrmW+aD+3Pkg02iUbn4zFDTIt0+zf9iPSNZfYmnDHkXNflPz0I7F+mFUu7yfm
         S4V7vpNPQtyZcoXOBb7doK6Oc9BQ/VMhQnQAWDzaMpHy8KaTPITSzDfXpJsSHFHWPO
         9fL9HgaMGa6efL8FoU7LQKqx2vnbuVmpXSaBT7YY=
Date:   Thu, 6 Dec 2018 10:26:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, dhowells@redhat.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] KEYS: fix parsing invalid pkey info string
Message-ID: <20181206182625.GA90507@gmail.com>
References: <000000000000c220960579c4936d@google.com>
 <20181103173035.23974-1-ebiggers@kernel.org>
 <20181128232019.GC131170@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128232019.GC131170@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:20:20PM -0800, Eric Biggers wrote:
> On Sat, Nov 03, 2018 at 10:30:35AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > We need to check the return value of match_token() for Opt_err (-1)
> > before doing anything with it.
> > 
> > Reported-by: syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com
> > Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  security/keys/keyctl_pkey.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> > index 783978842f13a..987fac8051d70 100644
> > --- a/security/keys/keyctl_pkey.c
> > +++ b/security/keys/keyctl_pkey.c
> > @@ -50,6 +50,8 @@ static int keyctl_pkey_params_parse(struct kernel_pkey_params *params)
> >  		if (*p == '\0' || *p == ' ' || *p == '\t')
> >  			continue;
> >  		token = match_token(p, param_keys, args);
> > +		if (token == Opt_err)
> > +			return -EINVAL;
> >  		if (__test_and_set_bit(token, &token_mask))
> >  			return -EINVAL;
> >  		q = args[0].from;
> > -- 
> > 2.19.1
> 
> Ping.  David, are you planning to apply this?
> 
> - Eric
> 

Ping.
