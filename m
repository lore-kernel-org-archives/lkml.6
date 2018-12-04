Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E17C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D193B2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zT1jvbyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D193B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLDTrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbeLDTrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:47:25 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3860420850
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543952844;
        bh=W6gez/Hs3OA9TbJaJpi8UNN02LY+OmYwMWwWxmASGbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zT1jvbydiom//0k63c5OfTYefg5ok5pZJ2FGIYkGsA7UitpD2Yz4wyjxrvW3Brzzh
         dni8a0p4l31VNSSTTYAuuiM7ax3dCJu8XWWI/UalGjKmDPmuYra/dLGjzcwi8sm3Hu
         QyuwyCB1QE4cRUG12JtN2FlYOPPETAWLU6AtpJ9g=
Received: by mail-wm1-f45.google.com with SMTP id s14so10916155wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:47:24 -0800 (PST)
X-Gm-Message-State: AA+aEWb5hGglOEsEFwyzQa8J4i+8AdGs89YmWc/szvObrtllbUhf+5WR
        BC/U6Aj+EDnHmi9tcsLTLhcMizgtwZSTD1kxDhuInQ==
X-Google-Smtp-Source: AFSGD/VKkq6RUUXFPrUDzd71Wkb7ilKVyylTXaL7ySsyxLuL/bMPeZzNjn5UdYm2tetrk40mb6uO4PvWnB3/Z9y/vFI=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr14445497wmc.74.1543952842744;
 Tue, 04 Dec 2018 11:47:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542841400.git.luto@kernel.org> <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
 <20181122084119.GA44720@gmail.com> <20181127153202.GA27075@linux.intel.com>
 <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com> <20181204193346.GD17374@linux.intel.com>
In-Reply-To: <20181204193346.GD17374@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 11:47:10 -0800
X-Gmail-Original-Message-ID: <CALCETrU1LFNR+m_YmVDmGMMbNyf5A7AFjFsu9JiET0X8YRgeaQ@mail.gmail.com>
Message-ID: <CALCETrU1LFNR+m_YmVDmGMMbNyf5A7AFjFsu9JiET0X8YRgeaQ@mail.gmail.com>
Subject: Re: [PATCH 6/5] x86/fault: Clean up the page fault oops decoder a bit
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:34 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Dec 04, 2018 at 11:22:25AM -0800, Andy Lutomirski wrote:
> > On Tue, Nov 27, 2018 at 7:32 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > index 2ff25ad33233..510e263c256b 100644
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -660,8 +660,10 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
> > >         err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> > >         err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> > >         err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
> > > -
> > > -       pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> > > +       err_str_append(~error_code, err_txt, X86_PF_USER, "[KERNEL]");
> > > +       err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
> > > +                                                         "[READ]");
> > > +       pr_alert("#PF error code: %s\n", err_txt);
> > >
> >
> > Seems generally nice, but I would suggest making the bit-not-set name
> > be another parameter to err_str_append().  I'm also slightly uneasy
> > about making "KERNEL" look like a bit, but I guess it doesn't bother
> > me too much.
>
> What about "SUPERVISOR" instead of "KERNEL"?  It'd be consistent with
> the SDM and hopefully less likely to be misconstrued as something else.

Or even just [!USER], perhaps.
