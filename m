Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFD02147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OXAp+2Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfBSVTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:19:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53532 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBSVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:19:34 -0500
Received: by mail-it1-f193.google.com with SMTP id x131so9737874itc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Jptp2DMnM9R9mZf8xSzHhprhLDojJ3jWWa553UuANw4=;
        b=OXAp+2UmKNqR97vYIWT1aCEPHKti+fcrOUK00Ui6v8+eFSX1s1qzPDxnAFHI1lrnMj
         Sx1g2bvnTySRGMBuK2PooXNboRg871Yp4vQS8W0N02PhQjRGyepYM3/gJxQLwPpvvVfE
         H+A0GWzgLUOhoW0224vV4++MP3af2Bwq4MFkwlXw5+Hcy1lG+z5o2nlEQKEgeKPN4Tr7
         DY93Rm13zAxoEBUFoV6LoSq3pC1ouQwLTHutW3Xo8/nxrDqjGUULOu4+6BB8Cm435WGc
         vKfvV2CIapnYQ1TyX9szOt29WAYsrIbF9O+SmgIc72ZFe0CV0gplKfaESlHTxaq3Y0Lq
         7H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Jptp2DMnM9R9mZf8xSzHhprhLDojJ3jWWa553UuANw4=;
        b=O1ZQL/XgBr1W0LGFEfT+OFwCip6FIZiXKoAveZkgDJQMezVB0go/B3Xjgy5c99SAdm
         OZsiNMrMB4KpzTMMzkVQ5junzOI7+LQPItpwFhuRAj1CjMy9TLpcWf6TG9NU58sjlhED
         FIXfSP1xyMNlr5f7Fcf/23pTpuE8Ht2esew908p6PM8mX2M1eAJBluhRSb0EcGwQkYm5
         m0aZ3qx1qGTgaX1YFx9BQbXGF6p8uIuqIsutPVChsdKqBsfnMqfChJAwDX9z02MIZFnj
         IQyht+eoveWLL/nExD5kf80fxn8RDGYGHlDG361xzOgx//y/NwQ+WiJW3VxdRRNmQ3e7
         c5Ug==
X-Gm-Message-State: AHQUAuZ/gRg1MyiIo/vCr5llrNYIRGmkx03SpB1Arp5NpT9EpvOsuyO3
        UjGY9DYNb7u67qLJ7Ukufmhq/w==
X-Google-Smtp-Source: AHgI3IbmtWLZjNTFVPeCzO56nRRg5oFfHnpAhvmJizcNQaYsFsiajy2Y9cyDbyxXpD0JjFEZQvJWWg==
X-Received: by 2002:a24:118e:: with SMTP id 136mr3158334itf.175.1550611173937;
        Tue, 19 Feb 2019 13:19:33 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id x23sm7664181ion.38.2019.02.19.13.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 13:19:33 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Tue, 19 Feb 2019 13:19:32 -0800 (PST)
To:     Andreas Schwab <schwab@suse.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pwsan.com, palmer@sifive.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] arch: riscv: support kernel command line forcing when
 no DTB passed
In-Reply-To: <mvm36p22ksx.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1902191318520.6518@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com> <mvm36p22ksx.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Feb 2019, Andreas Schwab wrote:

> On Dez 17 2018, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 2c290e6aaa6e..e6b962ff39b1 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -171,7 +171,14 @@ asmlinkage void __init setup_vm(void)
> >  
> >  void __init parse_dtb(unsigned int hartid, void *dtb)
> >  {
> > -	early_init_dt_scan(__va(dtb));
> > +	if (!early_init_dt_scan(__va(dtb)))
> > +		return;
> > +
> > +	pr_err("No DTB passed to the kernel\n");
> 
> Isn't that backwards?  early_init_dt_scan returns true if it found a
> DTB.

Yes, it's backwards.  Thanks for the catch.  Looks like I sent an older 
version of the patch. 

- Paul
