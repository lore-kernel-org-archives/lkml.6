Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39391C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC59220879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC59220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeI2OzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:55:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36470 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeI2OzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:55:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so386281wrw.3;
        Sat, 29 Sep 2018 01:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zRNAhGfRB/2xQjeoBHl7S4YByoOC1qQzhykWEfmOfI=;
        b=QDKWCH18TuBGiowJcBAukegYVaOtpqXSOWIOXN3gEGmec8aWzOhh0eEgsyLT57pxra
         JuC+J7AxHXw9c/OjvZwwVAQGQbQM2AVgwoO2xio2XXpTlppFYblj6AOLplvQ62zbjmZi
         CkbWCUMcM+dNneoL6hhjPkwsAgjhKl2qRc/oMtGUufryeI5XuTpKr3c/HiX4akkzTqnM
         qNru11PjWUsPhotRD5IJMkjCHp0srkJn899qpKe/PZMNuycNdwj/Ci6MhsWNOvkzTLfO
         jwlHB7lfV3b5IFmFOAEuhDin2Y2KCjv78MwcOAlU3uJK0AfAp77jsxkuJt4QCVoGkJc8
         GKiw==
X-Gm-Message-State: ABuFfojYoO6hLEsprOpyad4mOKduXD4LVLb6B6NXoJv66TPKF6f5E3RW
        lODl2jP/E+7ZsuqAwA3Wc0I=
X-Google-Smtp-Source: ACcGV62qglRRpqNCfZZJ/vgd6OaGATEcP5BexhzHyEtc+X+5ouzYgyLe3XXh3B2O0I5O+jO36NgTTg==
X-Received: by 2002:adf:b643:: with SMTP id i3-v6mr1454867wre.14.1538209658454;
        Sat, 29 Sep 2018 01:27:38 -0700 (PDT)
Received: from ryzen ([2a02:2f01:530d:1e00:fdec:1efd:a09c:509a])
        by smtp.gmail.com with ESMTPSA id v106-v6sm11309671wrc.85.2018.09.29.01.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 01:27:37 -0700 (PDT)
Date:   Sat, 29 Sep 2018 11:27:29 +0300
From:   Abel Vesa <abelvesa@linux.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
Message-ID: <20180929082729.GA22116@ryzen>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-5-Jason@zx2c4.com>
 <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
 <CAHmME9rc5zgN4HhBy0_oq+EbEXdS8nePzA7qW39nocx_y4ay1Q@mail.gmail.com>
 <20180929075601.GA11115@zn.tnic>
 <CAKv+Gu_jawg7R1n0qz75=H16J+WNx4aRhEsAt2WMNUkPAhD2og@mail.gmail.com>
 <20180929081118.GB11115@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929081118.GB11115@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-29 10:11:18, Borislav Petkov wrote:
> On Sat, Sep 29, 2018 at 10:00:29AM +0200, Ard Biesheuvel wrote:
> > Note that this is the author of the *patch* not necessarily the author
> > of the code.
> > 
> > Anyone is free to submit patches adding code authored by others as
> > long as the author has made it available under a suitable license, and
> > this is actually the whole point of the S-o-B: you are stating to the
> > next guy that the code included in your patch was made available to
> > you under a compatible license.
> 
> ... and the actual author could be named with Originally-by or
> Co-Developed-by:, and even in free text in the commit message.

Or you could just put the original author as the first S-o-b and then
another (second) S-o-b line where you put yourself as a submitter.

AFAIK, that's how people usually do it.

> 
> But the correct SOB chain denoting who handled the patch on its way up,
> is important.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
