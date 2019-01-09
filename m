Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF5C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAZSHEeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfAIPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:47:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42808 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731981AbfAIPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:47:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so3825443pfr.9;
        Wed, 09 Jan 2019 07:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g8I9zZGfxAN8gpks+OLWMo263nsMOAIaotopBzxeY/o=;
        b=SAZSHEeXfrc0Iay8S0+7pnjYYybYBC7/65L0yjg7HyTVDpjUCWKt0aHLYcFfivoloF
         3qk8iQ917ImnLv09dCYC1M6V7184paiaAb2lDiONegMeXFihYGwnmvmdHEzGtalQX3yX
         AvACZ3beUw+KpgXqIrE054sHlIZT+ZLIFjUghKAsqD7z8xVlkVnuvHkZ9mAgbI16yFgY
         sUpTs/eiEPT9Dmj1ZovUlGRAv0EoMFWxEp0S8vzo7lfkHeB4Dt3O6y32juwRxCDFjgTC
         DK2dcTeqk9M6vi/xgwCFJaxwtr/KXnd2THSfc3HIaOYwij6hPEKYq+36QJZB+3tAjy+f
         Dkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=g8I9zZGfxAN8gpks+OLWMo263nsMOAIaotopBzxeY/o=;
        b=hkg+0s5EN4RPu87i+Dk/aEyeiqpr5zeIM4ZTisGwoBYPGwwkzkctrVfTM6GtHs7zoj
         wST/qrVGRcXf2KPye9QeK9MLHHEorW/IxYcUoaHmG680wQrJG1PweeK/mXpEIX5MuJ0v
         W+6sHhtJBxVKZI8VpWoD7vdhceh4ecpaT+U91PoczeE9+ydILnDm053xZPdae0WVxVud
         usnY5RsAoj9BfRvEAjUnmJfKTHiDk3kn1B31CJFlxXcHt9HWX3yf07h+BEYxjTVRXns1
         WIVZCNVT6ds5USPjDZu/W6p5GpbRvxxN2eu1ucTfHGhRpa902MZOTYeo0+3S0zaCD8cz
         /Nzg==
X-Gm-Message-State: AJcUukdAU7Fdo4/BBZ15/JcAA8iJnSBsjBB/HYSnQSz3w9pDJ4dfB6Hi
        1qy1JehLqh7MmNutsjqZ+aA=
X-Google-Smtp-Source: ALg8bN40VeY/vMXJSFM95y75YLPS+Kv7XZWC1+nzj3rEgQhdh2+IWBLenrJ0y4CjIZH8Y/DXLzGB+w==
X-Received: by 2002:a63:2643:: with SMTP id m64mr5727785pgm.35.1547048830220;
        Wed, 09 Jan 2019 07:47:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l70sm81484077pgd.20.2019.01.09.07.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:47:09 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:47:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jinpu Wang <jinpuwang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190109154708.GA997@roeck-us.net>
References: <20190107105330.372621917@linuxfoundation.org>
 <d86ef960-dd47-b282-5432-4ecbdd4e0daf@roeck-us.net>
 <20190108122542.GA4801@kroah.com>
 <CAD9gYJ+P6SFzDVDUMJRESUEYFNC1GhP+C76__rj2w1HzXPEtDw@mail.gmail.com>
 <20190109144658.GF29274@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109144658.GF29274@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:46:58PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 09, 2019 at 12:40:11PM +0100, Jinpu Wang wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> 于2019年1月8日周二 下午1:28写道：
> > >
> > > On Mon, Jan 07, 2019 at 08:59:12PM -0800, Guenter Roeck wrote:
> > >
> > > Should all now be fixed up.
> > >
> > > I hope, this set of releases has been a pain...
> > >
> > > greg k-h
> > 
> > I had build failure below, looks related to 0fe69354b888 ("crypto:
> > testmgr - add AES-CFB tests")
...
> > make[4]: *** [crypto/testmgr.o] Error 1
> > Makefile:1045: recipe for target 'crypto' failed
> > make[3]: *** [crypto] Error 2
> 
> You are right, that totally does not build.  Odd that no one else's
> tests caught this :(
> 
The failure is only seen with CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n,
but CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y by default, meaning it is
explicitly disabled for all test builds. Out of the probably thousands
of default configurations, only two s390 configurations enable those
tests (ie explicitly set CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n).
So that is not at all surprising.

Question should be why the responsible developers pretty much ensured
that this code is never even build tested.

Guenter
