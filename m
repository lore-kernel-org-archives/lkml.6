Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FEBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ABF20877
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WQbePgsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75ABF20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbeIRWqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:46:09 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52073 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbeIRWqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:46:08 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 462f4df4;
        Tue, 18 Sep 2018 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=u99upDNkm5pUIEFFaPWNac0dMdA=; b=WQbePgs
        hfFZBLSXyyTViU6CrSAIkglSXZ9x0o9SKQZhCAtTX2672rdM2iR2TgB+RYC/fPjL
        oqIildRW0MpbbW0eejTQGaf96RArhafxBapqHwxXNa1BNLxT3zk0nHrJpM/ro0I/
        fKCGYXhbAOOluGMgkjDfLyi4CQn0PBzYQBJscYD8PKC04cEOW6asikDO8sG+ff/C
        JvcFd4VPJxswejcdytzl0WAWhvjHXZAqyeMopdLcEcO8Vz8vMuCNILeCmGydkS5z
        HA5U0vVbVMhJ8aQKfOIXfvA2Bu4IoIv/kN/zokNtc+mfqJ9+/nQSlkYngWX1ebqz
        qD/Kmsq3ZR7e7yQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 455358d6 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 18 Sep 2018 16:55:00 +0000 (UTC)
Date:   Tue, 18 Sep 2018 19:12:33 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH net-next v5 19/20] security/keys: rewrite big_key crypto
 to use Zinc
Message-ID: <20180918171231.GA22973@zx2c4.com>
References: <20180918161646.19105-20-Jason@zx2c4.com>
 <20180918161646.19105-1-Jason@zx2c4.com>
 <2826.1537290107@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2826.1537290107@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Sep 18, 2018 at 06:01:47PM +0100, David Howells wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > A while back, I noticed that the crypto and crypto API usage in big_keys
> > were entirely broken in multiple ways, so I rewrote it. Now, I'm
> > rewriting it again, but this time using Zinc's ChaCha20Poly1305
> > function.
> 
> warthog>git grep chacha20poly1305_decrypt net-next/master 
> warthog1>
> 
> Where do I find this?
> 
> David

Previously in the patchset:
https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=jd/wireguard
https://lore.kernel.org/lkml/20180918161646.19105-1-Jason@zx2c4.com/

Regards,
Jason
