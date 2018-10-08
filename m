Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54ADC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B6C20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBnFuzYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B6C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJIDMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:12:38 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43164 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIDMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:12:38 -0400
Received: by mail-pf1-f169.google.com with SMTP id p24-v6so8842008pff.10;
        Mon, 08 Oct 2018 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qqQbbsxC/rPrue43FMkautUcO00aAt812pFD1cJ19Ww=;
        b=kBnFuzYpXK1+RJ4mV4pIv7QN92CAX2Dl8834SXM/9FzGHc8nWbS16LJRPegIss/KbL
         yMUsKwC3YdjMP1C4pjgoM7cTg0tGEgIuryaad1f1m2szrZzht2wuySGjQELEszjjSDJd
         a4X6DwD6UZvPHHlt4/m4bFh/euOBmrp5PCERGI6o3hR6fyHWZ5SywzC64vkfw4+4Rt8k
         iBWSZ6eAMSp2uOMBLuh/2jD8xudKUauvpa4s9sbypcA4XgejHe5rj3PIibGjmyisBSsl
         F66+9Sk3Y6mZ2IhHXmjk6+IDHfn9vxARk1z+zTbKGxzkQm9vi3im6UoFkmITROVEdrDH
         Xrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qqQbbsxC/rPrue43FMkautUcO00aAt812pFD1cJ19Ww=;
        b=prepgj8qEQUjwikpICJPjJnBBby/BrKGDog2DYKHR81kFyj6nADWaJ5s+BHVXn6uM/
         ber45v1iGeJ6ij6ZZA6hMV7LI/hV50cILeXVDzAykMTCNXMt/hZqARFSsd0CN+MyXA/Q
         0Y0fKvZShf3k34osbXT22DxdqxWIcBb4RGkevrxvpHJbjMP/FGk1HIU5hdFygNtJZw4I
         NIWRvAGn1l2f7Tv/1G/K5TL9D65a88j94Ek2rqIJBVvFfk2fOOjmB32wmXcbYDF3ZmYI
         llpNQ71XuDegmr+SciZExcCI49XKD7VkOg/cAT6Ys1AUS4Vl/7PbL1PHVL0vII5Kk7Gc
         mN5A==
X-Gm-Message-State: ABuFfohwSV2jxrUlNWBJ6V0gRwPJFceAG2RAPkTON8Dg1m03nYap+ekU
        cer9prr6ioRB7YINRkTIxC4=
X-Google-Smtp-Source: ACcGV60pjbalAWJpWY89aGLGdFJwbOlqE1a9AP0M/oh16PyEcuIEftzUDhYQNGIB6xAd/nfNx1dA5g==
X-Received: by 2002:a62:7a81:: with SMTP id v123-v6mr27190738pfc.240.1539028752141;
        Mon, 08 Oct 2018 12:59:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i76-v6sm26701145pfk.43.2018.10.08.12.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:59:11 -0700 (PDT)
Date:   Mon, 8 Oct 2018 12:59:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/228] 4.18.12-stable review
Message-ID: <20181008195909.GA26056@roeck-us.net>
References: <20181002132459.032960735@linuxfoundation.org>
 <af80bbc1-6753-01d2-1ecb-830720b38f48@roeck-us.net>
 <20181003162539.GA4653@kroah.com>
 <20181003172440.GA7955@roeck-us.net>
 <CAL_Jsq+GBDB21tSDTq7p39SvQEGq1R3ZPeH7Yx+9fHttx3v9Ew@mail.gmail.com>
 <20181003180847.GA15682@roeck-us.net>
 <20181007141808.GA14337@roeck-us.net>
 <CAL_Jsq+0t+x4GSPUW-0Qhcsng1Z+0qn_72XpmX5At00FtT5V4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+0t+x4GSPUW-0Qhcsng1Z+0qn_72XpmX5At00FtT5V4g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 12:48:41PM -0500, Rob Herring wrote:
> On Sun, Oct 7, 2018 at 9:19 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Oct 03, 2018 at 11:08:47AM -0700, Guenter Roeck wrote:
> > > On Wed, Oct 03, 2018 at 12:53:11PM -0500, Rob Herring wrote:
> > > > On Wed, Oct 3, 2018 at 12:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > >
> > > > > On Wed, Oct 03, 2018 at 09:25:39AM -0700, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Oct 03, 2018 at 05:59:09AM -0700, Guenter Roeck wrote:
> > > > > > > On 10/02/2018 06:21 AM, Greg Kroah-Hartman wrote:
> > > > > > > > This is the start of the stable review cycle for the 4.18.12 release.
> > > > > > > > There are 228 patches in this series, all will be posted as a response
> > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > let me know.
> > > > > > > >
> > > > > > > > Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
> > > > > > > > Anything received after that time might be too late.
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Build results:
> > > > > > >     total: 137 pass: 137 fail: 0
> > > > > > > Qemu test results:
> > > > > > >     total: 321 pass: 320 fail: 1
> > > > > > > Failed tests:
> > > > > > >     powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> > > > > >
> > > > > > What is the status of that powerpc failure fix?  What's the odds it can
> > > > > > get into mainline soon?
> > > > > >
> > > > >
> > > > > The fix has been -next for about a week.
> > > > >
> > > > > da08d8cb8cfc of: unittest: Disable interrupt node tests for old world MAC systems
> > > > >
> > > > > You'll have to ask Rob (copied) if he plans to send a pull request before
> > > > > the next commit window opens.
> > > >
> > > > I wasn't planning to as it's just for the unittest and has been that
> > > > way for how long? Why's the unittest enabled for a defconfig anyways?
> > > >
> > >
> > > I enabled it to improve test coverage for stable releases. This is how
> > > I found the problem in the first place. Are you suggesting that I should
> > > not run DT unit tests for stable release candidates ?
> > >
> > I have now disabled CONFIG_OF_UNITTEST in my tests.
> 
> Well no, that wasn't what I was suggesting. I'll send it to Greg this week.
> 
> Are there details on how you run qemu?
> 
Official ? No.

However, everything is published at https://github.com/groeck/linux-build-test/.

Guenter
