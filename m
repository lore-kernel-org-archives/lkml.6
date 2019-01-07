Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A495C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D685A218A6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="bc0wctjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfAGPxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:53:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:31130 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfAGPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1546876380;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FWgpn4Gs1XQXE55hR7MjDyXAwrGdQnmdLnAxI/A6CE0=;
        b=bc0wctjvLab0SDb+PqUKsj4hZvMURIeTjmR73RuSPaN+9FCRM2WNdiCHC8dXNFslgG
        5IKhSl6yuH+7zLn4GbcVR2KtjwyWO1thtKXpnLC6g+n5z/Z3aNNVtmuc9n6hzdZOz2Oq
        V/yfGJrzhRjpSNi1OMIvL/tceTrdwep/Kf6j9rS2yiOMv7myBRQ6xqaBAFvaqzRb/PCf
        8vgA5m5DnOHA0cpPmoXThMVSOSswbQDs7v8J8LQko2/kAZuYKdik9zwIxaRAl6sSjRym
        zpBg8SFB+dL5SN/ad4l55roIeQXdd+Zqw5aK1pPQKxJY7Jb1VNWmc0zLJ11lhxTgFKH2
        bqTA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJ/SfQIux"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv07Fq1Evw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Jan 2019 16:52:01 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     herbert@gondor.apana.org.au
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
Date:   Mon, 07 Jan 2019 16:52:00 +0100
Message-ID: <4499700.LRS4F2YjjC@tauon.chronox.de>
In-Reply-To: <20190107153327.GB4210@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com> <4539995.kc8yiMsNgQ@tauon.chronox.de> <20190107153327.GB4210@linux-l9pv.suse>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 7. Januar 2019, 16:33:27 CET schrieb joeyli:

Hi Herbert,

> 
> > use an official KDF type like SP800-108 or HKDF?
> > 
> > You find the counter-KDF according to SP800-108 in security/keys/dh.c
> > (search for functions *kdf*).
> > 
> > Or we may start pulling in KDF support into the kernel crypto API via the
> > patches along the line of [1].
> > 
> > [1] http://www.chronox.de/kdf.html
> 
> Thanks for your suggestion. I didn't touch any key derivation standard
> before. I will study it.
> 
> But I still want to use my original function currently. Because the same
> logic is also used in trusted key. I will happy to move to SP800-108 or
> HKDF when it's available in kernel.

Would it make sense to polish these mentioned KDF patches and add them to the 
kernel crypto API? The sprawl of key derivation logic here and there which 
seemingly does not comply to any standard and thus possibly have issues should 
be prevented and cleaned up.

Ciao
Stephan


