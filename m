Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCDC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E3320660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFMnF9LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfAHS3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:29:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37233 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAHS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:29:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so2095337pgb.4;
        Tue, 08 Jan 2019 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Or1+LsmwXOhdlXOg4PaWBuuDIOICfOPtOzEPnnkQ8is=;
        b=GFMnF9LY1zQeUGJIlkbVTeWNyjfaJM+26mb2nT6iADcJZdUS4cpaeEPFyFgNW6KcSG
         1DjwehAR+fHqHmPj1hWje6rUsZIG/6DZAfqDvgCrAhK0OW29l6iqo5t8fbON6E9vzUja
         96kx/BrHw75LvYAgMbspYSBKn8pw1qYvfCCwNDHwJguPbi2SCEgYDGBxKhtz/dx9tSIU
         Zb8h4NJZduh51KfEzvwetu2CtwVrVFYwqdRIuUS0/UwC9lfruvghMx6Mnoq0ba5t/0cC
         8+xMiiB+sZu3zr0RaOxvZXJXJxNxg157WRBQ72AkEKVm3hUW5Y7frzvuhBIB2GkVdV0J
         Tiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Or1+LsmwXOhdlXOg4PaWBuuDIOICfOPtOzEPnnkQ8is=;
        b=eu4fDyaa7HtYHDAmck+Rhpio9a36vzPwFvZW4zQiSGBhLF2V+0auTMSqM4PJAJYL8y
         vA9ct893GOCk/FrFDDl6VYGA6jdo+eMCRixzpohFQx6Zg2pGISuhj03pHqu+md8f/iT4
         YpXmzBI7Q+ZnbSng1SxuhQNibiMk0N/vuHhOBCnUcL3ZbOd6G4fEvCSQg4+NOw26ngFC
         DORbtqdSsb0C38ErtRMphil6BidtbP9OtAxssE5kmj2w/uNFVJJAip5dTZR6l1XQ2/cN
         gDcd82F25RYclxHYRtWxjbGmfd/1flS9y6mdBK1HjxegLahiEAeUM7jEAA85abiBKLmE
         Eocg==
X-Gm-Message-State: AJcUukf8l61Hm4e/r+yo0jBHxFExEjBfjpqA07WlN5II9ZuQmav1uYZw
        trlErhQl5s67Djqo6E44nn5m6fyN
X-Google-Smtp-Source: ALg8bN5Q/RcCo/hEWQqHd/mBx6XVqTKfvKipNxl9nMqvLNusiVVF5UdkL1fNbfDuFajgGflg0DZuqQ==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr2902253pfa.76.1546972180738;
        Tue, 08 Jan 2019 10:29:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm90371058pfg.39.2019.01.08.10.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:29:39 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:29:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190108182938.GA19265@roeck-us.net>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108172503.GA28031@roeck-us.net>
 <20190108175640.GA2461@kroah.com>
 <20190108180951.GB28031@roeck-us.net>
 <20190108181322.GA4194@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108181322.GA4194@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 07:13:22PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 08, 2019 at 10:09:51AM -0800, Guenter Roeck wrote:
> > On Tue, Jan 08, 2019 at 06:56:40PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 08, 2019 at 09:25:03AM -0800, Guenter Roeck wrote:
> > > > On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.19.14 release.
> > > > > There are 170 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > 
> > > > Still (for v4.19.13-171-gc68ce175c3b8):
> > > > 
> > > > arch/powerpc/kernel/signal_64.c: In function ‘sys_rt_sigreturn’:
> > > > arch/powerpc/kernel/signal_64.c:761:21: error: ‘msr’ undeclared 
> > > > 
> > > > AFAICS commit 5c784c8414fba ("powerpc/tm: Remove msr_tm_active()") is missing.
> > > 
> > > Breno on this thread just said that this patch should not be applied,
> > > and another one will be submitted upstream instead to solve the problem
> > > correctly and then we can backport it.
> > > 
> > > So we can live with this build issue for now.
> > > 
> > 
> > I think you should drop the offending patch in this case. It doesn't make
> > sense to keep it - all it accomplishes is to break various builds. What is
> > the point of doing that ? Is that somehow better than living with the bug
> > it is supposed to fix ?
> 
> That's what the developers involved seem to say.
> 
That will prevent anyone affected from actually using 4.19.14, and earlier
kernels will still have the problem people are now so concerned about.
In other words, this will accomplish exactly nothig except confirm the
notion that stable releases are not well tested. I _really_ don't get
the point, sorry.

Guenter
