Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3770C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DBB2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="oZiceKzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfAXDkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:40:04 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40223 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfAXDkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:40:03 -0500
Received: by mail-pf1-f180.google.com with SMTP id i12so2281135pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 19:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ibxki1XOqyIi8jMBecHLCIGHs42zmj+2ldnhjRgHHqk=;
        b=oZiceKzLtREBJn2dA0/HRfnDmcnm22NUpel6DAFPbs/xffkcIZpmUaN2zvOjJRzy6K
         C8sh2SLqbwkBjldMM56k5zGsEjefnwDWmyhdIWTqnprWuKQ3AUtMfAh6nlC28fmFNXhT
         aN4Y92cVPtWdwBsDAfUog7ZwjryfCnmF6IQiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ibxki1XOqyIi8jMBecHLCIGHs42zmj+2ldnhjRgHHqk=;
        b=AX7jnt/Q1C6yewoWo5FYToYVXQWZ16Hh+KB7dGuKiSaAHoU0mwGYoYMpXygOpnWIag
         4Ki0sfkfTg+crf6Nztp4hL+nFdh+o5ru8X1FdeiJWNbHjaCwa6KNiiX+Ai+1zfXuMQ5e
         xUp4sfvizuvdpg700KFPQhbdZebG9dliJnidoukhHW8YUYSjK1G1b7S638+wiGoh1dBW
         iqOXQY+Q7TOVyxEdcG21Ea9Nedfj1ctCEqwx0HGNJWwkbFSef32RbNom1I1zhfqHffsC
         fLVSosZoubCCW4Rd5RjvYEgSs2zXoBwj1GMvwAgPHWZey57sys1RcVIv0BVYm3yv2tAB
         jOXw==
X-Gm-Message-State: AJcUukd8D8mBfzT5L+dxT+paJ4VJtSAVLsL5uCeSafu0x3WI7kliE4gQ
        QeQByGeCczg0xBXjArSH06Es3C4v6378
X-Google-Smtp-Source: ALg8bN61pn9878UmEtP0Rmlv3l7WcjzEVU+4bgfcgSDh1lvaDJDUKAL2/5pr8wIw7aRNXDXkMchw5g==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr4834393pfm.253.1548301202934;
        Wed, 23 Jan 2019 19:40:02 -0800 (PST)
Received: from [192.168.1.144] (64-46-6-129.dyn.novuscom.net. [64.46.6.129])
        by smtp.gmail.com with ESMTPSA id c7sm28674327pfh.18.2019.01.23.19.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 19:40:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [v2 PATCH] rhashtable: Still do rehash when we get EEXIST
From:   Josh Elsasser <jelsasser@appneta.com>
In-Reply-To: <20190124030841.n4jtsqka5zji3e62@gondor.apana.org.au>
Date:   Wed, 23 Jan 2019 19:40:01 -0800
Cc:     "David S . Miller" <davem@davemloft.net>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D5A6C2E7-2AB1-46D0-8876-2D6AAAA3937F@appneta.com>
References: <20190123211758.104275-1-jelsasser@appneta.com>
 <20190124030841.n4jtsqka5zji3e62@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2019, at 7:08 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Thanks for catching this!
> 
> Although I think we should fix this in a different way.  The problem
> here is that the shrink cannot proceed because there was a previous
> rehash that is still incomplete.  We should wait for its completion
> and then reattempt a shrinnk should it still be necessary.
> 
> So something like this:

SGTM. 

I can't test this right now because our VM server's down after a power
 outage this evening, but I tried a similar patch that swallowed the
 -EEXIST err and even with that oversight the hashtable dodged the
reschedule loop.

- Josh
