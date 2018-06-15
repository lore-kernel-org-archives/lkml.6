Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECCDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9556208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L97eI7JS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9556208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756569AbeFOS3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:29:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34824 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756451AbeFOS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:29:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id c22-v6so5261692pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Eq68lMQ8lufA0mQIG30fX1x9XjcmruB4BQyQ2MCvZU=;
        b=L97eI7JSMOJefUU8QDlsBWLzeNuScTZZG24B/CdjVYGeJOso35D1u6u6WM1oTsKmxi
         wWKbHsyE+fA4VQUU1X697wipzmw28cK5Zu2kx33MXnEQmKySwMmfQYVLzb2/+PogKapA
         +RrogvpJi2LWRVQS+MkTQ5YotVVNahEEqnCNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Eq68lMQ8lufA0mQIG30fX1x9XjcmruB4BQyQ2MCvZU=;
        b=dspRMFYmFy3j3+cVQrwD+7mN44yJsnvamhHnWbbdXhQzkx061865N8SpMnq6/6oZ1V
         J+Ws3WbAWnbOTl60Q/ZIkQ01ziReJkz+Vk2FhDp/8lj8GK0aiaog9kl3HU1t1J77tPV/
         4mhViYKqAv93tP7HraSzL93IUtJHsu5uVddiUOp8GhP83MFQ33g4aohJGZM20N+tafNO
         5S/3Ja3hgoRekGevIrpfFJ9raYAcLr2tpYLYRxWioEIz+CBe+MCQ59GbSo9PhKth7ORc
         Vs1aHlpe48Bd7UPTFDtiyJH8pSrc7Uo8Y+GqKukODYxBZdo8XA8D+bJffiPfMHVja/C8
         miuQ==
X-Gm-Message-State: APt69E1NujPxOixJG7+6cGPSp/lJSjgxYwkOLnvGXt4NafER70Ab97EU
        xrZgvrFDWfcgqg8fIXwshqwRMQ==
X-Google-Smtp-Source: ADUXVKJ5vSaB7Sh0xCuPC7oEDzBda8p1gOTngqWK1y+ItwLF6k2C7eoqIDxoj2bvKE5JAI5wAWdFxw==
X-Received: by 2002:a62:d2c3:: with SMTP id c186-v6mr3101999pfg.44.1529087387130;
        Fri, 15 Jun 2018 11:29:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l67-v6sm13957935pfj.66.2018.06.15.11.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:29:46 -0700 (PDT)
Date:   Fri, 15 Jun 2018 11:29:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Message-ID: <20180615182945.GN88063@google.com>
References: <20180615174731.47588-1-mka@chromium.org>
 <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
 <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:18:12AM -0700, Joe Perches wrote:
> On Fri, 2018-06-15 at 11:04 -0700, Nick Desaulniers wrote:
> > On Fri, Jun 15, 2018 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > 
> > > update_permission_bitmask() negates u8 bitmask values and assigns them
> > > to variables of type u8. Since the MSB is set in the bitmask values the
> > > compiler expands the negated values to int, which then are assigned to
> > > u8 variables. Cast the negated values back to u8.
> > > 
> > > This fixes several warnings like this when building with clang:
> > > 
> > > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> > >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> > >   -Wconstant-conversion]
> > >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> > >        ~~                               ^~
> > > 
> > > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > > doesn't seem to be universally enabled)
> 
> Perhaps it's better to turn off the warning.
> There are more of these in the kernel too.
> 
> At least:
> drivers/regulator/max8660.c:	u8 mask = (rdev_get_id(rdev) == MAX8660_V3) ? ~1 : ~4;
> drivers/regulator/max8660.c:	u8 mask = (rdev_get_id(rdev) == MAX8660_V6) ? ~2 : ~4;
> fs/ext4/resize.c:	__u16 uninit_mask = (flexbg_size > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;

In my experience neither clang nor gcc should promote these values to
int, since the MSB/sign bit is not set.

In any case I think it it preferable to fix the code over disabling
the warning, unless the warning is bogus or there are just too many
occurrences.
