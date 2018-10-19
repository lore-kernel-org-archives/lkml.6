Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C0DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8956821476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0CwEw6or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8956821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJTDLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeJTDLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:11:35 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE682086E;
        Fri, 19 Oct 2018 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539975853;
        bh=DRxt030BYY7roAM2LtYdIUMtLdF6LdUESo5myW3RK40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0CwEw6orflA0D8y/icKKigxh/hxGfDjcs4JVupopiN9TctHLmshCaf9U88VYV/pcl
         bRH5jqgXknnDqzOHWRy+tltMx8UOgkaDETAIxkvbA+jdWkPVrTCNwEwK+Etjkaxhg2
         1wX4FpHHbGaFDL8yKG7y1TYk61Iz4rZ+WmxJpjAo=
Date:   Fri, 19 Oct 2018 12:04:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
Message-ID: <20181019190411.GB246441@gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Oct 19, 2018 at 05:58:35PM +0200, Jason A. Donenfeld wrote:
> Hello Eric,
> 
> > As before, some of these patches conflict with the new "Zinc" crypto
> > library.  But I don't know when Zinc will be merged, so for now I've
> > continued to base this patchset on the current 'cryptodev'.
> 
> I'd appreciate it if you waited to merge this until you can rebase it
> on top of Zinc. In fact, if you already want to build it on top of
> Zinc, I'm happy to work with you on that in a shared repo or similar.
> We can also hash out the details of that in person in Vancouver in a
> few weeks. I think pushing this in before will create undesirable
> churn for both of us.
> 

I won't be at Plumbers, sorry!  For if/when it's needed, I'll start a version of
this based on Zinc.  The basic requirements are that we need (1) xchacha12 and
xchacha20 available as 'skciphers' in the crypto API, and (2) the poly1305_core
functions (see patch 08/12).  In principle, these can be implemented in Zinc.
The Adiantum template and all the NHPoly1305 stuff will be the same either way.
(Unless you'll want one or both of those moved to Zinc too.  To be honest, even
after your explanations I still don't have a clear idea of what is supposed to
go in Zinc and what isn't...)

However, for now I'm hesitant to completely abandon the current approach and bet
the farm on Zinc.  Zinc has a large scope and various controversies that haven't
yet been fully resolved to everyone's satisfaction, including unclear licenses
on some of the essential assembly files.  It's not appropriate to grind kernel
crypto development to grind a halt while everyone waits for Zinc.

So if Zinc is ready, then it makes sense for it to go first;
otherwise, it doesn't.  It's not yet clear which is the case.

Thanks,

- Eric
