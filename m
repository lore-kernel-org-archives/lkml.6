Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C05C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax6Mr7Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6588D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeIFUAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:00:01 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:39679 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeIFUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:00:01 -0400
Received: by mail-pg1-f181.google.com with SMTP id i190-v6so5407399pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EZ7qwTQPzySCPhznfiKJQLnEiIYCnZy8+g/df4Qxwl8=;
        b=Ax6Mr7SsCwyS2Y17kG4LLyvBq9OjiqTOwvZK1p43lmkvN+TKi9P4gi1Zubw6YSqAP0
         LbfAvP0Nvb1Z2jFTxwG09zTJA6wUnRZyDP6IvQUAP3ZKDyJX88IrpjvsS/Dltb9jsWRV
         Oo5mCGsGnr17ng3OOQt+uftonqFRweQo7Ng27kO9z4U/WaesE4sRS0zGM5xkKzKu3sWN
         HSi/RgO5pM+YQ2WKzoxoGplRyMrRPLmWxlkWKalDflO1EkdEnk/O8jXkW3Dz2zxn4Ljs
         8obmJWitRew/Z/oA+dmcw4+a3B0JRXlNdw5C/dC61lexufJizZQthsijF1tmZ22Hn3eN
         C43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZ7qwTQPzySCPhznfiKJQLnEiIYCnZy8+g/df4Qxwl8=;
        b=F+ORIuVRcxL87smTeLC0wGQd0a/wDpY38NVyCIAnASXV+a9fbweptshFw9sIVz31sL
         It0mqcQ96SvElteBTHU6Qp3y8W8XXSlUscjwu460b2NZXuKFAQ5YX9xB5FB4IKnknKIA
         K+KXMbB8+HdjebNNIsWssABSCVxzE+aqrCY3Rou3fWXYzybUXCXn3m4/ilS/qx/fYi6A
         s5vhpT0hRAeTtE+3W09LMGbLSSj3BxOT2476vwOWSpHx0hCtmK+24J0klY4ExGeIpSzD
         VvKBdxJnP0kCAX51t2a9jXZaGimRQ0kCGYBJyrOkH4SLi4naeXLg/Q9U31cYGYO4zwiN
         esvA==
X-Gm-Message-State: APzg51C1IZN4fDKekB3lmTffVBH1xPzK319GUU7nx8tmX8fy7RaX065c
        91OLhARMwD+lnvMdNiRVQ1k=
X-Google-Smtp-Source: ANB0VdZbWh66M3VUP3cUscRSk+eTpELa6Sqz4ZGuRrhD5W4JiT4sez2laWJXIIcK7RA4SYadA5Bxxw==
X-Received: by 2002:a62:b604:: with SMTP id j4-v6mr3375801pff.199.1536247440228;
        Thu, 06 Sep 2018 08:24:00 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t21-v6sm9524784pfi.73.2018.09.06.08.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:23:59 -0700 (PDT)
Date:   Thu, 6 Sep 2018 08:23:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matt Hart <matthew.hart@linaro.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Widespread crashes in next-20180906
Message-ID: <20180906152357.GA13389@roeck-us.net>
References: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
 <20180906140413.GA5098@thunk.org>
 <CAH+k93Fgk2yZ3OzBOL2uxSVuOqEJB5wS1Zfny8bDkbuQ3sM6Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+k93Fgk2yZ3OzBOL2uxSVuOqEJB5wS1Zfny8bDkbuQ3sM6Jw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:13:23PM +0100, Matt Hart wrote:
> On 6 September 2018 at 15:04, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > On Thu, Sep 06, 2018 at 06:45:15AM -0700, Guenter Roeck wrote:
> >> Build results:
> >>       total: 134 pass: 133 fail: 1
> 
> Do you build arm64? Because KernelCI is seeing build failures in arm64
> defconfig for next-20180906
> Clearly it's a module build problem for sunxi but I'm not sure who to
> CC about this.
> 
I do, but as part of the boot tests, not as explicit build test,
to save a bit of time. Maybe I should run a build test as well.

> https://kernelci.org/build/next/branch/master/kernel/next-20180906/
> https://storage.kernelci.org/next/master/next-20180906/arm64/defconfig/build.log
> 
> ERROR: "sun8i_tcon_top_de_config"
> [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_set_hdmi_src"
> [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko]
> undefined!

Same error here, in the boot tests. Sorry, there are just too many
failures there, and I didn't go through all the logs.

Do you have bisect results ? Otherwise I can run bisect later today;
that should hopefully identify the culprit.

Thanks,
Guenter
