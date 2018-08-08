Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82FF2159D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOR4VPr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82FF2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeHHCcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeHHCcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:32:20 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CF721480;
        Wed,  8 Aug 2018 00:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533687326;
        bh=LMKTKeeQ0VevAB1iteLqC3TVJLS7Q2igoTcMxmpURzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOR4VPr/Ir6/WIoLVSeZ/eojii73DbQbYGDhEb0PWdOsVMXTpkadSX8bTYQQu6RvQ
         lFhPZtyxqJ9ZS/p8OZuFjUc12qwXREeaY6JvBOdMhFC8qzlzlkGMaFjmOZxZ7mbw5b
         on3tdgwQff1FhYlCVfXl4NNCtrVH1RJG5IhDGTY0=
Date:   Tue, 7 Aug 2018 17:15:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Samuel Neves <samuel.c.p.neves@gmail.com>
Cc:     Paul Crowley <paulcrowley@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        tomer.ashur@esat.kuleuven.be, Eric Biggers <ebiggers@google.com>,
        "D. J. Bernstein" <djb@cr.yp.to>
Subject: Re: [RFC PATCH 3/9] crypto: chacha20-generic - refactor to allow
 varying number of rounds
Message-ID: <20180808001524.GD25300@gmail.com>
References: <20180806223300.113891-1-ebiggers@kernel.org>
 <20180806223300.113891-4-ebiggers@kernel.org>
 <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com>
 <CA+_SqcD+KpQ_X6iXUCpQh0N6pWzBorstBJDx7eBqcybY4Dvy8Q@mail.gmail.com>
 <CAEX_ruFp0KddnZyetZt997OvRzKDuN7U95MF_N9AgTh+mTcD7Q@mail.gmail.com>
 <20180807215121.GB25300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807215121.GB25300@gmail.com>
User-Agent: Mutt/1.10.1+60 (20b17ca5) (2018-08-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 02:51:21PM -0700, Eric Biggers wrote:
> On Tue, Aug 07, 2018 at 11:21:04AM +0100, Samuel Neves wrote:
> > > The best attack on ChaCha breaks 7 rounds, and that attack requires 2^248 operations.
> > 
> > This number, as far as I can tell, comes from the "New features of
> > Latin dances" paper. There have been some minor improvements in the
> > intervening 10 years, e.g., [1, 2, 3, 4], which pull back the
> > complexity of breaking ChaCha7 down to 2^235. In any case, every
> > attack so far appears to hit a wall at 8 rounds, with 12 rounds---the
> > recommended eSTREAM round number for Salsa20---seeming to offer a
> > reasonable security margin, still somewhat better than that of the
> > AES.
> > 
> > Best regards,
> > Samuel Neves
> > 
> > [1] https://eprint.iacr.org/2015/698
> > [2] https://eprint.iacr.org/2015/217
> > [3] https://eprint.iacr.org/2016/1034
> > [4] https://doi.org/10.1016/j.dam.2017.04.034
> 
> Thanks Samuel, I'll fix that number in the next iteration of the patchset.
> 

Oops, sorry, for some reason I thought you had quoted one of my commit messages,
but it was actually Paul's email.  I did mention in "crypto: chacha - add
XChaCha12 support" that "the best known attack on ChaCha makes it through only 7
rounds", but I didn't specify the complexity.

- Eric
