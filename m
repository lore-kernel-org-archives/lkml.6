Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F55C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A3A2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=genki.is header.i=@genki.is header.b="q4fgoDz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A3A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeKHG7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:59:00 -0500
Received: from genki.is ([104.200.25.21]:43246 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeKHG7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:59:00 -0500
Received: by genki.is (OpenSMTPD) with ESMTP id f237522d;
        Wed, 7 Nov 2018 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=f18bGRbJc
        6CkaP8Yweuyw9nwDks=; b=q4fgoDz7J9DtWyaSsN3H9CanEgncyUK7PbkkVmvrp
        S9c6d2xItrBRXic5TlJC7ww/p87dBthrEe01lbfwlFKSqF3Lmryq1/pOtFPHk5rI
        hWN0dKOG/5LWRaXvrMGYK7PaPzKjvoTxwU8JMJe1D7XomhcOFWCDzFNR5FHpvj/4
        3lOnZdQhvwm6Es1XA43dZtu19sP0gViVNf6wpjKid3zwsjwzEAuqNyb+NK/sV46F
        PKHNBI8xqHRUI/bNTVlD+cpEaL8aoSvIOY8iLKTH7CFk47ss7hJ3IIm797ljGF9z
        2/ZWLjVs82ChyNWk2JENKUFRPb62dRSxomm1xUVWDaG9w==
Received: by genki.is (OpenSMTPD) with ESMTPSA id e352ddd8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 7 Nov 2018 21:26:46 +0000 (UTC)
Date:   Wed, 07 Nov 2018 13:26:46 -0800
Message-ID: <20181107.212646.134137464@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Doug Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>, lists@nerdbynature.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
        <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
        <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
        <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
        <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
        <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
        <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 13:18:19 -0800, Doug Anderson <dianders@chromium.org> wrote:
> From reading the thread it sounds like Guenter was not even super
> happy with that based on the principal that you wouldn't expect a
> kernel build to be doing write operations in your .git directory even
> if $objtree == $srctree

I see, thanks.

> In theory you could wrap it.  If passing git with
> "--no-optional-locks" doesn't work you could fall back to the old
> code?  That would mean only people with newer git would get your new
> feature and everyone else would stick with the pre-existing behavior.
>
> It does seem like any things like this should be done atop Guenter's
> revert.  AKA: revert first to get things working the way that they
> were and then start talking about how to make it better.

Okay, it's trading one regression for another, but I guess it's clear
that yours is much more painful. Sorry to have held up progress here.
I'll back out of the discussion until this is reverted.
