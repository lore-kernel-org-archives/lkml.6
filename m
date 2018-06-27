Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD96C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB8E25FF4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLetfx7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB8E25FF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965224AbeF0O5V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:57:21 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:42949 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933868AbeF0O5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:57:17 -0400
Received: by mail-wr0-f180.google.com with SMTP id p1-v6so2367574wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjSGKVeyhyZba1RnBf9K1F+x04QVhlfhDoCYo8gmYTQ=;
        b=QLetfx7jKphnPCcaMovGe8vOt6aJEFbYohmrRJa2u3AK4Uls0ZjMrQrXj5fut2F24G
         PRZxRwSkAfDLiUA5ZeCGKFo/6TwooCGPkE/b8jT73r9DA6RNPmIGqPzBb4e6JbFhlK6U
         eGWYxsgHrdbAyyQxzYEO5OiXe6uQ5dhA+FH20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjSGKVeyhyZba1RnBf9K1F+x04QVhlfhDoCYo8gmYTQ=;
        b=byPDMozoHALQL3xvcnc3YeVjxj0aUo0lgZI/l6LcMOyg3shWBSqVDl1+1E/2Lajz9G
         30gd3DrfFWZVjaURfblOWq069F8Cyffgv27QUUGGaTdZ6D1bOhCvL4j7EC/emMkr1dSH
         8d10z9uZ/W0UFIBc3mQnJb0o8lmcFCsCaTK3U5x0JGgKcd73/zaAhtuFQBoxmnPw2GIA
         6wfPd7KDH7VShOH2ma2p0IPFgdvu9nOxsbw+e+qmdaA+TfRdLSqFJ36l6oiv2BCJs4GY
         TXBrbBdn62cfto+D51695F3Plq5FNVFus+dznN6MNWMmR4mfgo160yBLiM9PS+pbF/Uw
         glug==
X-Gm-Message-State: APt69E3yfSKF0OlQK5MO+deyv3Eupe5dWGvgkLYC6odn2ib4GmaWLLKh
        OWtX+psnqn1PKgikBZOmYmqnPg==
X-Google-Smtp-Source: AAOMgpfDT0xMR9efONspON8s40SN4lhgIGqcLx/1mPfM9kXDXlW9E+q7KhTqbcn/CA4OySjUroCdCQ==
X-Received: by 2002:adf:bbc9:: with SMTP id z9-v6mr5104983wrg.183.1530111436671;
        Wed, 27 Jun 2018 07:57:16 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b198-v6sm3977145wme.11.2018.06.27.07.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 07:57:15 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:57:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        robh+dt@kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
Message-ID: <20180627145713.uao2gr5kknk2cypk@holly.lan>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
 <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
 <20180626164117.GA5241@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626164117.GA5241@Mani-XPS-13-9360>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:11:17PM +0530, Manivannan Sadhasivam wrote:
> > > diff --git a/include/dt-bindings/power/owl-s900-powergate.h b/include/dt-bindings/power/owl-s900-powergate.h
> > > new file mode 100644
> > > index 000000000000..f1aaf761112b
> > > --- /dev/null
> > > +++ b/include/dt-bindings/power/owl-s900-powergate.h
> > > @@ -0,0 +1,23 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > 
> > checkpatch.pl warns about this line due to not using /* ... */ syntax
> > for headers. I could fix that up on my own, but it made me realize that
> > you are licensing this file under GPL-2.0+ only, whereas the .dts[i] is
> > supposed to be dual-licensed.
> > 
> > Can you please give your consent to make this
> > 
> > /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > 
> 
> You can change the license to GPL-2.0+ OR MIT.
> 
> > like my S500 and S700 bindings?
> > 
> > Question: Should it still be GPL-2.0+ or the new GPL-2.0-or-later?
> >
> 
> I think GPL-2.0+ is fine.

So... when I saw this I did wonder why one would knowly choose to use a
deprecated license identifier (https://spdx.org/licenses/ ).

However running `git diff v4.17..v4.18-rc1` through some filters does
indicate that GPL-2.0+ is the more popular choice by 256 to 0! Doesn't
mean you couldn't break the mould though ;-).


Daniel.
