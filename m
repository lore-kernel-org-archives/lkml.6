Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB365C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649D420659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FyuLoEzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649D420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeJOG0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:26:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeJOG0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:26:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so21765224wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=OXVY8VDlzuLY5zTT33TA0DMM7CQVZCitEhcfluOX4Sw=;
        b=FyuLoEzJa4R7bmv2epUyudKfWb5QB9LgbC2j4h4aHIBISGT0RCsHO0RXfh8/TXEVC5
         rqiibJwszWCEiqdM6hwmIUJaKDzNB0asPvts9MHlq2hKjK+9YORKWyBftwplY1OfRgVu
         doAQdOes4p34uAh8SYyHTlQI3MbxkV14rM073nB+DU5CmnOQM5Fb5NgAFEp0pI7hjf/A
         z7rtHkSAAebXJeDY7igD552t7piRM5P1WIBG+FxZF+j5xm58S4/K7ZqlznoL8VPOdnYU
         xCBqRW9Lk1OBqdn3W3FEu73j5kF8MgH8zR4aMgjeqiLex8WaotIuy3uK2HCHmCly8vn7
         Rblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=OXVY8VDlzuLY5zTT33TA0DMM7CQVZCitEhcfluOX4Sw=;
        b=mIRFOT6bzEvoezLcVt3EBggIxEBTuVQ3cw83BUx0ROX3ikYP0kAGa/ITdErVbrjNNz
         hmq5kR/EdK7UmNspEkVcmCUwSiauSC4EY9nyLEM986tS8mfp2QhflT3BQSGdXPoRRO1Z
         iQ+G5DV3BAWu9fuWmT/LPy0uMmwd1uti7yHmqaMaWGFaZ6uhLRuHRhvy+C8gUzOm4Mhx
         V7iFUtvKVxTmm0LtFcFlbAQ+iKUc8FygeBlonUsxP9ZfD4yBMX1XzQh5P3wiTy1VgRGh
         QcmTYEIaIpA1LvozkZM9h58nBP6u6HY08+FOyW4KeLnzwuQ6pGR4jC0vom/Nkd3pd+9M
         1Bhw==
X-Gm-Message-State: ABuFfogHVIBof/a/ZLr86F+lHY+UswE0gZsWjGTPplzK/5nftIplkrjC
        ENYcYgXIQunNfEIQtM75Ps5kuQ==
X-Google-Smtp-Source: ACcGV63oSJ35nTvl3k/GqkE9IiIQ2/j464/bhQTokl7e/etzXMuQhAch4+WKX726IaZ2iL5LeQRtVg==
X-Received: by 2002:a1c:9b91:: with SMTP id d139-v6mr12019403wme.62.1539557037218;
        Sun, 14 Oct 2018 15:43:57 -0700 (PDT)
Received: from ?IPv6:2a02:8070:8895:9700:1849:de85:c38a:b276? ([2a02:8070:8895:9700:1849:de85:c38a:b276])
        by smtp.gmail.com with ESMTPSA id p9-v6sm5259918wrt.10.2018.10.14.15.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:43:56 -0700 (PDT)
Date:   Mon, 15 Oct 2018 00:43:53 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181014221325.GA26685@avx2>
References: <20181014221325.GA26685@avx2>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] sysctl: add overflow detection to proc_get_long()
To:     Alexey Dobriyan <adobriyan@gmail.com>
CC:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        longman@redhat.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <FCEAD072-023C-4410-B434-2D6D2EE21889@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 15, 2018 12:13:25 AM GMT+02:00, Alexey Dobriyan <adobriyan@gmail=
=2Ecom> wrote:
>> > Yecchh=2E=2E=2E  First of all, the cast back to unsigned long long is
>completely
>> > pointless=2E  What's more,
>>=20
>> Sorry, seriously asking: why?
>
>In C everything is casted to the same type before doing an operation,

Oh, ok that's what we're talking about=2E I=20
thought the whole check is pointless=2E I=20
didn't read careful enough apparently=2E

Tbh, even if the second cast is not=20
necessary it makes implicit behavior
explicit=2E
I've also seen this form more than
the one without the explicit cast=2E
But I won't fight it=2E If other people
prefer it without the second cast; fine=2E

>in this case comparison
>
>> This was meant to handle the case where
>> sizeof(unsigned long long) !=3D sizeof(unsigned long) and I just looked
>at
>> _kstrtoul() which does the same:
>
>Second cast is unnecessary=2E I don't remember why I did 2 casts=2E

