Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EFE2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="h7Lxm8Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfAHHKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:10:35 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:24729 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfAHHKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1546931430;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=17RF/1aXaPSHHQcSKJwmCEH2ho3xWAcK1nvGUCYgmTs=;
        b=h7Lxm8QhRsE9pwLGZHoWhKOK5kUYf+D2ERHgAmMT3WdKtVDd+LdXnIHz/L2ZlYR6WR
        rAa6iyuueae8B0HYXIpn/7adZtoYLufFnHO/2y9wpPmtkCt9U7WBqPNXeWWs/EXnw+MA
        XDXcE1SV7SyHF0fjdaLgt12RDl4+FinG+rAr6eipwHj/KQBGyMAlOnxFc4cSjCEBLraQ
        qBsWKFmdRf041qgENENfhxoSwKk2qtwEetq9SSJDGnu27D+fXIP6kVz5P/tNszoq0Tph
        BOYm9PsArpmbq9P9Nrni1OsIUApmdLy5/yAgKFMUI0cmVzbmm6Lj82UbKzVfUhCi0Llr
        u85g==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJ/SfQIux"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv0879hHNH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 8 Jan 2019 08:09:43 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
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
Date:   Tue, 08 Jan 2019 08:09:43 +0100
Message-ID: <1565399.7ulKdI1fm5@tauon.chronox.de>
In-Reply-To: <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
References: <20190103143227.9138-1-jlee@suse.com> <4499700.LRS4F2YjjC@tauon.chronox.de> <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 8. Januar 2019, 06:03:58 CET schrieb Herbert Xu:

Hi Herbert,

> Are we going to have multiple implementations for the same KDF?
> If not then the crypto API is not a good fit.  To consolidate
> multiple implementations of the same KDF, simply provide helpers
> for them.

It is unlikely to have multiple implementations of a KDF. However, KDFs relate 
to hashes like block chaining modes to raw block ciphers. Thus a KDF can be 
applied with different hashes.

My idea was to add template support to RNGs (because KDFs are effectively a 
type of RNG since they produce an arbitrary output from a fixed input). The 
KDFs would be a template wrapping hashes. For example, the CTR-KDF from 
SP800-108 could be instantiated like kdf-ctr(sha256).

Ciao
Stephan


