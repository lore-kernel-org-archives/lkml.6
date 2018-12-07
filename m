Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42797C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CAC20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eOX8XXw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CAC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeLGRxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:53:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37882 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLGRxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:53:02 -0500
Received: from zn.tnic (p200300EC2BCEC900C13752FC2028AE4C.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:c900:c137:52fc:2028:ae4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1041A1EC0BF3;
        Fri,  7 Dec 2018 18:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544205181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NLW1X+hTqbXOzaqWBHYkcCAMQVuNb11Y5blQyXnEBbY=;
        b=eOX8XXw1wJSJ5sVVkMRPWWR7ass5PRPSHvidNz63XPMe6hv19mnwdHVzb7bfXDArv8LEWf
        r3s8X4GCpX6TaspJdDBsp3L320yvVCHIJf3h4JsLJg6CEQCc0C4FgTdhhoxWUOIe7RkSL9
        0WOYl3hiJJVmGdFARf/8sCC/T3glzy4=
Date:   Fri, 7 Dec 2018 18:52:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     luto@kernel.org, Fangrui Song <maskray@google.com>,
        Andi Kleen <ak@linux.intel.com>, andi@firstfloor.org,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, Rui Ueyama <ruiu@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rafael@espindo.la, Stephen Hines <srhines@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/vdso: drop implicit common-page-size linker flag
Message-ID: <20181207175253.GE9385@zn.tnic>
References: <20181206191231.192355-1-ndesaulniers@google.com>
 <20181207101814.GA9385@zn.tnic>
 <CAKwvOd=75MRjaDbEjHRaMTm1MSC1wkLxPKhH_S3KXreP8yU9Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=75MRjaDbEjHRaMTm1MSC1wkLxPKhH_S3KXreP8yU9Uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 09:45:42AM -0800, Nick Desaulniers wrote:
> Google's Native Client, a technology for running native code in a web
> browser.  It's since been superseded by Portable Native Client (pNaCl)
> and to an extent Web Assembly.  It seems that BFD still contains code
> for NaCl.

Yeah, found the wikipedia page. :)

> How does this sound:
> TL;DR
> -z common-page-size's default value is based on the target
> architecture.  arch/x86/entry/vdso/Makefile sets it to the
> architecture default, which is implicit and redundant.  Drop it.

Sure. Although the longer explanation gives more insight into the whole
deal but that's fine too - the longer explanation is on the ML and we
have the Link: tags.

So no need to resend - I'll simply take the three-liner above.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
