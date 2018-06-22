Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB6EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396E243FF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDXulHkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5396E243FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeFVOvo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933812AbeFVOus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:50:48 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54FA32440A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529679047;
        bh=NT3wZPBKZ91kirKmpMfjlBzD3k73dcr+ipFFlnqM8yY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDXulHkBwKnPJJHaSfIiVjcPpU6iHoiWUWj6FlLz0cCZN7ELkgpp2Jq1LX6UO+N5p
         JCqAlOfHoDrQS1xSOncVt+aGkHgJud5vwiNfqE3SJPhQpfnTvTFlHgrS9f5zZRQqkj
         MEKysvAyn6UicHJlaPEurJungGzCiyvLb3AvZDCg=
Received: by mail-wm0-f48.google.com with SMTP id 69-v6so2933330wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:50:47 -0700 (PDT)
X-Gm-Message-State: APt69E1t8c4IyYDwHVN2KpL4f11AXLCYEhdQ9MWZ7m/Yb7k6lbbBwsOQ
        kTZVG9y3f2e27SFpaF5aqzpjKDRu+SbgehcNKamjOw==
X-Google-Smtp-Source: ADUXVKKs2jL9V0mJA6XtJpNh1taMw0qc+9SOt8X5iTcRnecP24Jse9vpzRojAtw2r/tdd/ROvWsO1Y6tawpXcxbcr90=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr1868057wmh.116.1529679045882;
 Fri, 22 Jun 2018 07:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
 <1529536506-26237-2-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1806221610500.2402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806221610500.2402@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 07:50:34 -0700
X-Gmail-Original-Message-ID: <CALCETrVzLT0AwUFxZGjuREaontqzJe0DEccNFwLTKdLcLxcARA@mail.gmail.com>
Message-ID: <CALCETrVzLT0AwUFxZGjuREaontqzJe0DEccNFwLTKdLcLxcARA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] x86/fsgsbase/64: Introduce FS/GS base helper functions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 7:28 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 20 Jun 2018, Chang S. Bae wrote:
> > +void write_fsbase(unsigned long fsbase)
> > +{
> > +     /* set the selector to 0 to not confuse __switch_to */
>
> 'to not confuse __switch_to' is not that helpful of a comment as it
> requires to stare into __switch_to to figure out what might get confused
> there. Please write it out why this needs to be done in technical terms.
>
> > +     loadseg(FS, 0);
> > +     wrmsrl(MSR_FS_BASE, fsbase);
> > +}
> > +
> > +void write_inactive_gsbase(unsigned long gsbase)
> > +{
> > +     /* set the selector to 0 to not confuse __switch_to */
>
> Ditto
>
> > +     loadseg(GS, 0);
> > +     wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> > +}
> > +
> > +unsigned long read_task_fsbase(struct task_struct *task)
> > +{
> > +     unsigned long fsbase;
> > +
> > +     if (task == current) {
> > +             fsbase = read_fsbase();
> > +     } else {
> > +             /*
> > +              * XXX: This will not behave as expected if called
> > +              * if fsindex != 0. This preserves an existing bug
> > +              * that will be fixed.
>
> I'm late to this party, but let me ask the obvious question:
>
>     Why is the existing bug not fixed as the first patch in the series?

IIRC that was how I did it in the old version of this code.  I think
it did it because it was less messy to fix the bug after cleaning up
the code, but I could be remembering wrong.
