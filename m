Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8960C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66597217CC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZrzeDdFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66597217CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeHMUUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:20:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39548 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729346AbeHMUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:20:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 120938EE171;
        Mon, 13 Aug 2018 10:37:12 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A8KoWGR37buj; Mon, 13 Aug 2018 10:37:11 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8457E8EE0ED;
        Mon, 13 Aug 2018 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534181831;
        bh=eI5Uoi9tJvSfyhubBa3yw7z7t845SBHGxs6Ka/iWCTk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZrzeDdFroGGP4DGf8n66aXZAwuGMrLa/ElEPB/VcJWjFWZ609RfaJMkFTXpQ61Kly
         rW7fNhjoMb574PuJo3hf8S3wHWgldS/wbGzF7ld8mJZYU2sveSYxgXDHTCSZXZOauM
         xBfJ55pHUJ30r5yxiDIjsJSJS0uHL/zi9HKvKwbA=
Message-ID: <1534181830.7872.10.camel@HansenPartnership.com>
Subject: Re: [PATCH v1 0/3] WireGuard: Secure Network Tunnel
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Date:   Mon, 13 Aug 2018 10:37:10 -0700
In-Reply-To: <CAHmME9raa81A_hH_Zykp2r8zOk0ySroFEsk+8384vnVOCuSa=g@mail.gmail.com>
References: <20180731191102.2434-1-Jason@zx2c4.com>
         <1534174811.7872.3.camel@HansenPartnership.com>
         <CAHmME9raa81A_hH_Zykp2r8zOk0ySroFEsk+8384vnVOCuSa=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 10:02 -0700, Jason A. Donenfeld wrote:
> > Could we please build planning for this crypto failure day into
> > wireguard now rather than have to do it later?  It doesn't need to
> > be full cipher agility, it just needs to be the ability to handle
> > multiple protocol versions ... two should do it because that gives
> > a template to follow (and test version to try to find bugs in the
> > implementation). It looks like the protocol could simply be updated
> > to put the version into one (or more) of the three reserved bytes
> > in the handshake headers, so perhaps doing this before they get
> > used for something else would be a good first step?
> > 
> > James
> > 
> > 
> 
> Indeed the answer is in fact along the lines of what you've suggested
> in your question: the protocol is very strictly versioned. This means
> that while there intentionally isn't negotiation of ciphers --
> something historically very bug-prone -- there is ample room for
> updating the protocol. This is enabled via 4 aspects of the protocol:
> 
> - An explicit "identifier" string is hashed in as part of the first
> step of cryptographic operations, containing a "v1" as well as the
> protocol designer's email.
> - An explicit "construction" string is hashed in as part of the first
> step of cryptographic operations, containing the Noise handshake
> pattern and a list of the cryptographic primitives used.

Any hash involving other parameters allows you to check for a version
mismatch, but it's very hard for a flow classifier because you have to
do the hash at the point you classify.  If we're running concurrent
versions we need an easy way to separate them.

> - A type field at the beginning of each message. Newer message types
> (corresponding with newer versions) can easily be introduced via this
> field, and they can even coexist with older ones need be.
> - Three unused reserved fields ready to be utilised in the event
> they're needed.

Either of these will work for easy classification.

> In other words, there's ample room for such contingency measures
> within the protocol.

I have a preference for explicit versioning, having dealt with some
protocol issues before.  However, I'm much less concerned with *how*
it's done than that it *be* done in the kernel patch so we can test out
 rolling the version number to change the algorithms in a backward
compatible way, so lets pick one of the above and try it out.

Regards,

James

