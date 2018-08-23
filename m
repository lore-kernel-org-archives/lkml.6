Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45C5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8825C20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXEL41+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8825C20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeHWUwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:52:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45895 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeHWUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:52:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4-v6so2420523pgv.12;
        Thu, 23 Aug 2018 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Exnm/mgyXnvKwa75uKWSNjWjdmGXQ1D0OUs3V9uHhuY=;
        b=XXEL41+EzPPmqXkonPP6r/ZHdrtGm82w+HbOcFO2MEzUqOtiXwjgVRfFkes8CQGUPe
         9xo+hcH22lgSHgA8WiXxAKhWA/Zuq1SH4SNx2k6iVIKl17Cin5X/rTCrQVL4FZ6f33h1
         4dSg7fny7+eb66bZMsBjucNOapfBHMq0SPxqnt7UiarLAmMrjaui5iH1/0G6PbyTZCLd
         WRMPu2cN6pSQ8lOXXisgShASFGVRZwlX7c6J6WTJ3ehEduqrFP5SB5OGM4eQ332CQdkj
         cn7FIilo34F0eFYG9xDpuy2HxGSobYMQQJy6XhD2tHizlSMvN2wE9YidPWXlYuxFkVAQ
         KqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Exnm/mgyXnvKwa75uKWSNjWjdmGXQ1D0OUs3V9uHhuY=;
        b=onUJ+VoLGB5GDz6ouKSLDK3Uaam4+LAfmSbAyqsebq0p/yub8GtgjzNqwQuUuKa5ls
         gv5cyKhr723wcbBMXgu9pDgph7YN+vj4inlXpYFRfp16tfGHr9vSIV/uTsvaYa+u7JW3
         xfOo7onkoVcudA2RYNoAN/glIquOZ4ABhwnuUg93M+6NNya5+FHC6FpU96vTjNKBw5Gq
         OWu1El6FZRiAMfH7ACMQ2fA1BD2boolntlk+OP5+Jz3k3k5cl7fgVvOo+291tU0qnjyQ
         PIa+nk/Q0W+ZWAYnk5sypDuMsS87letzuREajOeYGN+sYifoiI7KIE/wJbV02E5Q668t
         WrCA==
X-Gm-Message-State: AOUpUlHNyr/ABVzw5wbQDNtVOU+uIGFI9LyQ58TbZbQ9VzhrO9B/P+88
        4RhtUJnsLvQ/H3NMwTomlpTbOKhK
X-Google-Smtp-Source: AA+uWPzMP5knqPToJo2+i8aeKMZ2eOw+0+EcpI5ci8MaFvGVHDOHUGFGHOeVNZ9wSaZieCKtVR2+IQ==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2-v6mr22244567pls.251.1535044885802;
        Thu, 23 Aug 2018 10:21:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e131-v6sm6854178pfg.152.2018.08.23.10.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 10:21:25 -0700 (PDT)
Date:   Thu, 23 Aug 2018 10:21:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/79] 4.4.152-stable review
Message-ID: <20180823172124.GB8669@roeck-us.net>
References: <20180823074918.641878835@linuxfoundation.org>
 <20180823163021.GA8669@roeck-us.net>
 <20180823165621.GA24633@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180823165621.GA24633@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 06:56:21PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 23, 2018 at 09:30:21AM -0700, Guenter Roeck wrote:
> > On Thu, Aug 23, 2018 at 09:52:36AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.152 release.
> > > There are 79 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Aug 25 07:48:51 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Early feedback:
> > 
> > Building i386:tools/perf ... failed
> > Building x86_64:tools/perf ... failed
> > --------------
> > Error log:
> >   PERF_VERSION = 4.4.151.g6d0c34
> > tests/parse-events.c: In function ‘test_event’:
> > tests/parse-events.c:1629:3: error: implicit declaration of function ‘parse_events_print_error’
> 
> oops, forgot to drop that broken perf patch from 4.4 as well, now done,
> sorry about that.
> 

NP. Note that 3.18.y still has the cavium build error.

Guenter
