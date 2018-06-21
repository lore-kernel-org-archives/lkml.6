Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6217DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0950F20875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdwJiydI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0950F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeFUDDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:03:24 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42866 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbeFUDDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:03:23 -0400
Received: by mail-qk0-f194.google.com with SMTP id j80-v6so988177qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EKj6KidGJxwt66S2J2eaYKGxGLyUo9K3Gy8941FR52c=;
        b=NdwJiydIamllDj/ju0rs0Zm50iTc5Da+LdDxIaULSfH2W0hyaysIVf0ELSk5VzBEHp
         omIHblrVGG1xJSCeN5081I99UmG841HbDdOQ/iUMilvkuJ2wOYg3Tl2T7vRMshjb/V9v
         WRHSFogZF0oyv8P1FmZtJvckOzRPTJLkxTTFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EKj6KidGJxwt66S2J2eaYKGxGLyUo9K3Gy8941FR52c=;
        b=NF+2dAhwrglEKmLw/YJ9sKrS+xFACN8+CuV9NhI4e7COmEwUHnh8dpA+K7gC+GxcAe
         Wd43fWpbFRuf5lRCM2D4yYS6eaEaAcD9d6okjlbw/aRJBtIa8M09eal6fjDucKgUupeM
         R97jI4mfLzgXlv/51b04P73F9aU9uh4WHGw7ocJ8sIm82aa9QOwCyy2oJSEd6r+zpP/z
         ha2xt1VmPinv73oBgpp3pe+pCBtbwCv1Y85+pSdxdGX/zBclSfdVc30mzENebaEgxtZW
         g1TXegCJhBsr86DWwLFcecBJH+pYPRUmSJS3nlmn18iObt9Ffcm33uYFuEBWQ/733Zbu
         3jSw==
X-Gm-Message-State: APt69E1PjXj9DErtV0oM92fBTfu9NfzxArR8rtUZ11Oc+7AKEPtr8XFj
        fk3B79AR9loQLPQ9TaxSpI5ox+SNjIU=
X-Google-Smtp-Source: ADUXVKLbXTBvxNRA2X7XdZoYM+Z09fcETiSKUiLyv89zncAEQQn9BS69/XmIs3tARNK3g0PRXPusqg==
X-Received: by 2002:a37:1f0c:: with SMTP id f12-v6mr19383197qkf.376.1529550202999;
        Wed, 20 Jun 2018 20:03:22 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id m70-v6sm3183025qkl.72.2018.06.20.20.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 20:03:22 -0700 (PDT)
Date:   Wed, 20 Jun 2018 23:03:21 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Dave Mielke <Dave@mielke.cc>
cc:     Adam Borowski <kilobyte@angband.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
In-Reply-To: <20180621022137.GB18453@beta.private.mielke.cc>
Message-ID: <nycvar.YSQ.7.76.1806202301410.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180619130953.bxil552igfkckjmr@angband.pl> <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr> <20180621014317.ebslk3gwvpq3k6sq@angband.pl> <20180621022137.GB18453@beta.private.mielke.cc>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1432461488-1529550202=:16670"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1432461488-1529550202=:16670
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 20 Jun 2018, Dave Mielke wrote:

> [quoted lines by Adam Borowski on 2018/06/21 at 03:43 +0200]
> 
> >It's meant for displaying braille to _sighted_ people.  And in real world,
> >the main [ab]use is a way to show images that won't get corrupted by
> >proportional fonts. :-þ
> 
> It's not abuse at all. I often use U+28xx to show sighted people what the
> braille for something looks like. I often need to do this when, for example, I
> need them to comapre what I'm showing them to what's on an actual braille
> display. U+28xx is the only way for me to do this without a lengthy description
> containing sequences of dot number combinations.
> 
> Also, U+28xx is the only reasonable way to share braille music between people
> who use different languages.
> 
> >The primary users would be:
> >* people who want symbols uncorrupted (especially if their language uses a
> >  non-latin script)
> >* CJK people (as discussed below)
> 
> Again, that's not true. Why aren't braille users included in this list? After
> all, it's we who motivated this enhancement. I guess actual blind people
> mustn't count just because there are relatively fewer of us. :-(

I'd say blind people fall in the "people who want symbols uncorrupted" 
category.


Nicolas
--8323328-1432461488-1529550202=:16670--
