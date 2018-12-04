Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55D7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955702081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPrpv9wF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955702081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLDULU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:11:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDULU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:11:20 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E23AC20851
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543954279;
        bh=TtPfR0QvZaffYPTc84h47nLX5iJvykdqYEEinZcbiNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HPrpv9wFc+7di/F6+r+5VhL34V9boJa0rHBzwEE+/wFkpe3IeOp4Cfa62DBUlnm3e
         o69Tq6AnNhC+MM4tkdvT5xj3qWId7u+fIYyrz54ml49dzoWSnqvDf7vvxugO0ZStXo
         TpStAfOQtIjuMNIkf8cSP2ql5fc8QoBlt2Izkgmw=
Received: by mail-wm1-f49.google.com with SMTP id n190so8501721wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:11:18 -0800 (PST)
X-Gm-Message-State: AA+aEWYi2ADLQ6suCvJN7P1568pOX751+qxA2bIbOf3yTWf6vOqinEXP
        +QPoDyyDi/Yo5F2bqJ9GUK9zQuSkZeudIE+RZehwwQ==
X-Google-Smtp-Source: AFSGD/XqvFjexh8VobjQufCZnvaQyo1ngJ2zltm4soKzt7g9u+V4phsgWgM+Zjb9l3GL6vgMRl+Jxm/R0q2W5Ll07XQ=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr14507433wmc.74.1543954277442;
 Tue, 04 Dec 2018 12:11:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542841400.git.luto@kernel.org> <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
 <20181122084119.GA44720@gmail.com> <20181127153202.GA27075@linux.intel.com>
 <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com>
 <20181204193346.GD17374@linux.intel.com> <CALCETrU1LFNR+m_YmVDmGMMbNyf5A7AFjFsu9JiET0X8YRgeaQ@mail.gmail.com>
 <20181204195239.GE17374@linux.intel.com>
In-Reply-To: <20181204195239.GE17374@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 12:11:05 -0800
X-Gmail-Original-Message-ID: <CALCETrWMuHoEWcyytgy6vEzGGMNj0FU0ZrrX2iyu9bDGSdOwFg@mail.gmail.com>
Message-ID: <CALCETrWMuHoEWcyytgy6vEzGGMNj0FU0ZrrX2iyu9bDGSdOwFg@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 11:52 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Dec 04, 2018 at 11:47:10AM -0800, Andy Lutomirski wrote:
> > On Tue, Dec 4, 2018 at 11:34 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Tue, Dec 04, 2018 at 11:22:25AM -0800, Andy Lutomirski wrote:
> > > > On Tue, Nov 27, 2018 at 7:32 AM Sean Christopherson
> > > > <sean.j.christopherson@intel.com> wrote:
> > > > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > > > index 2ff25ad33233..510e263c256b 100644
> > > > > --- a/arch/x86/mm/fault.c
> > > > > +++ b/arch/x86/mm/fault.c
> > > > > @@ -660,8 +660,10 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
> > > > >         err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> > > > >         err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> > > > >         err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
> > > > > -
> > > > > -       pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> > > > > +       err_str_append(~error_code, err_txt, X86_PF_USER, "[KERNEL]");
> > > > > +       err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
> > > > > +                                                         "[READ]");
> > > > > +       pr_alert("#PF error code: %s\n", err_txt);
> > > > >
> > > >
> > > > Seems generally nice, but I would suggest making the bit-not-set name
> > > > be another parameter to err_str_append().  I'm also slightly uneasy
> > > > about making "KERNEL" look like a bit, but I guess it doesn't bother
> > > > me too much.
> > >
> > > What about "SUPERVISOR" instead of "KERNEL"?  It'd be consistent with
> > > the SDM and hopefully less likely to be misconstrued as something else.
> >
> > Or even just [!USER], perhaps.
>
> I thought about that too, but the pedant in me didn't like the inconsistency
> of doing "READ" instead of "[!WRITE] [!INSTR]", and IMO "READ" is a lot more
> readable (no pun intended).  I also like having completely different text,
> makes it harder to miss a single "!" and go down the wrong path.

Fair enough.  I'm sold.
