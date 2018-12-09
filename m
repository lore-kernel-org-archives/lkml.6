Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6195BC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFCD20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="eJWNYhRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFCD20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeLIV4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:56:47 -0500
Received: from imap.thunk.org ([74.207.234.97]:39476 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbeLIV4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jZLg3biT82SlntlVTN6j4KUpZWNGenpcJI473Dbu0+Y=; b=eJWNYhRSDc8vGaD2iqPZnwFnZi
        wHl0epNZwpO2FWG6/dbUIosFyDL9wBbd+AlsflXFrLRyEIwlccl/TprKXDikPvSSbLACWBpq8s0bL
        co2HqZ8IEhJVr0hxCHaCkbgtgIF8HqnEbqw6sUyJ80393/ZYCikRDPSQ1EtNJDkyNr80=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gW745-0000j1-Hp; Sun, 09 Dec 2018 21:56:41 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7ABE07A442F; Sun,  9 Dec 2018 16:56:40 -0500 (EST)
Date:   Sun, 9 Dec 2018 16:56:40 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>
Subject: Re: [PATCH v4] fscrypt: add Adiantum support
Message-ID: <20181209215640.GC1840@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>
References: <20181126192737.129355-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181126192737.129355-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:27:37AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for the Adiantum encryption mode to fscrypt.  Adiantum is a
> tweakable, length-preserving encryption mode with security provably
> reducible to that of XChaCha12 and AES-256, subject to a security bound.
> It's also a true wide-block mode, unlike XTS.  See the paper
> "Adiantum: length-preserving encryption for entry-level processors"
> (https://eprint.iacr.org/2018/720.pdf) for more details.  Also see
> commit 059c2a4d8e16 ("crypto: adiantum - add Adiantum support").

Thanks, applied.

					- Ted
