Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C15ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37AE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aLVlaiOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37AE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbeGRAgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:36:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38585 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbeGRAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:36:21 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so1660470itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=e+eckyoPBeejqLfOkZZIpuNCCNHBQgcPPoK0KJbCyes=;
        b=aLVlaiOOJlrsXz9r4tJf/vPtGtl4RMaejWTMogOcMNBp1PDjPFgug9gdqmIR2Ss51+
         U5IZBhPWIC+paYCoMbKZL6XczLt7Z1QmoJKu5scIvjVLEEIeAzcDmPcS0QpdqY38u1TC
         3nq59OchskZQHZ0h7Zj6icp8MILBIFUVVhf0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e+eckyoPBeejqLfOkZZIpuNCCNHBQgcPPoK0KJbCyes=;
        b=t9V014ZgORvh8PApWxofj09BJibIpJtYPHiVLkHUi/lqeSpRpmQi6rIyDcxkBYjiCO
         KqkcXOm869yr4Hbk+Zhf/O+iTxDXHG4v+ZwjvX1/89l8EYSEUYeHd4DIV74wxN84XqwP
         rSNzw3+tAPtd+SglEFRLSua7/m8WS6qaYZ9jT47TDg+V0Gq+RJDQEk4/ghGjpODyn4eA
         BfN1zOIJFp6V3KlFadgir9TRhngS4K/S2u7p6CVcYe8/LKl01BHtnBVL7aKg6GZWOvpO
         QrwnvsIBahDC/cakA81gzkyVoXPgIiV3gDFdjcZO+KpcxYZwXPvzr3vaXjfqIQtslESi
         EViA==
X-Gm-Message-State: AOUpUlH74PdHupX+NJehJMPxshlfs/TY34whZLpoeSUbZZONHGm4jcjm
        /BFGOoJB1c300uUvc44+eyRT/Qm4WlmtAT9V+mo=
X-Google-Smtp-Source: AAOMgpeJ0uNr+IuivTtI4/07tfBxO8TlwH/GAbgLxpwSy9zZVHEgTKvWjO+4d7/9kFQAg70iOdUN+WLY7dW/ZPuumtg=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr229498itb.16.1531872077861;
 Tue, 17 Jul 2018 17:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180717135307.3713325-1-arnd@arndb.de> <CA+55aFxjx+naf3vQ++kqxBNS=dvevPebcKOzA=OYWfMJZ2CrzA@mail.gmail.com>
 <20180717202635.GA3489@thunk.org>
In-Reply-To: <20180717202635.GA3489@thunk.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 17:01:06 -0700
Message-ID: <CA+55aFwzbWgxrwRcErmFfu+9gRcFvujNJM8e5KyDjbEBmYkiBg@mail.gmail.com>
Subject: Re: [PATCH] random: fix rdrand mix-in
To:     "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, tcharding <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 2:12 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> I wasn't sure how quickly the HW entropy would replenish itself; I
> know that on first RDRAND platforms it would effectively never fail
> (as in if six of the eight cores were calling RDRAND in a tight loop
> _maybe_ you could exhaust the HW entropy).

I suspect you can't hit it in practice on Intel systems, but maybe you
can on others. And maybe future other architectures might be different
yet.

But rdrand has the potential of being pretty slow, and it's almost
certainly not worth continuing if it stopped giving us data.

                  Linus
