Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B43FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4EB20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Sw/cX0zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4EB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeGRSPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:15:22 -0400
Received: from imap.thunk.org ([74.207.234.97]:58130 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731361AbeGRSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=a1M2yLEw+iaksbket0HI5ThJW44kmqwZx8TYaFekuLM=; b=Sw/cX0zshwgfUSM/d7TCF38ljk
        EDLIxivgpSHitFXa2mIrKv0rXqJx1ndd3FvP3BVDygeu/NpP9aQsXiArJ+bVCSn2iSyc3dTM/mg2r
        uWHmSiUWJR1YMPDnWtICHI/tZ71YEt8q7o5u0kQwYQaGrMF/kBeH5Hef/Kfys4tclxuc=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ffqNE-00052x-K6; Wed, 18 Jul 2018 17:36:24 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E0EB77A6403; Wed, 18 Jul 2018 13:36:21 -0400 (EDT)
Date:   Wed, 18 Jul 2018 13:36:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Subject: Re: [PATCH] random: addu a config option to trust the CPU's hwrng
Message-ID: <20180718173621.GC30706@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sandy Harris <sandyinchina@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
References: <20180718014344.1309-1-tytso@mit.edu>
 <20180718015154.GE3489@thunk.org>
 <CACXcFmk7D5t9yg9VxhKZgMvqK-LmFF0d7Dh9A3hsoGTfzzeM8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACXcFmk7D5t9yg9VxhKZgMvqK-LmFF0d7Dh9A3hsoGTfzzeM8A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:14:20AM -0400, Sandy Harris wrote:
> Instead, I had a compile-time option to choose a number 0-32
> for how much entropy to assume a 32-bit value from the HWRNG
> contains. Default was something less than 32. I debated values
> in the 24-30 range, don't recall what I chose & don't think it
> Matters hugely.
> 
> Is that a better approach than the binary choice?

This patch is only affecting the initialization of the CRNG.  It
doesn't do anything about the entropy estimator, so it doesn't change
the behavior of /dev/random, for example.

In practice I doubt most people would be able to deal with a numerical
dial, and I'm trying to ecourage people to use getrandom(2).  I view
/dev/random as a legacy interface, and for most people a CRNG is quite
sufficient.  For those people who are super paranoid and want a "true
random number generator" (and the meaning of that is hazy) because a
CRNG is Not Enough, my recommendation these days is that they get
something like an open hardware RNG solution, such as ChaosKey from
Altus Metrum[1].

[1] https://altusmetrum.org/ChaosKey/

						- Ted
