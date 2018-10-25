Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF37CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFCE20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPCj1j4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFCE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJZHMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeJZHMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:12:02 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5658B20869
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540507052;
        bh=+0/JlFJDhTwnEtcqlBZIM2OLJUYOvnK4qH9Ig9M1GJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PPCj1j4tse7ZiUONhF33y6zt+3etqgt4saXdIFjtraxHwXubbgBV4lAiEeU9WMSn4
         +Fgsmx+Neq2KLiWPpvW/TdqTXdPAGGA13/znoiU9CQX+GpetoyaiXt0r8WNkHUluNW
         Cbsa5g/W7Jc74iygxww3xmZCI12TDbNuQtKUViCw=
Received: by mail-wm1-f50.google.com with SMTP id w186-v6so2995979wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:37:32 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJ+BSg5vDoSB9nRq2NqOzzfIic4rZ/L6qfaXuawm687z6ax3khE
        2LMtWRZh5pvqIgk3AWhOpG9V9HoxGvx+brcEEobn+w==
X-Google-Smtp-Source: AJdET5dgeahJ34DSaEpvO3CXyIvlVgP+9HR9TiXHbAQKBPHZnjA+pAxlLsw1Z7UksxBnl5hnUOlEeY4b00sL7Ceyx38=
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr3670947wmn.102.1540507050639;
 Thu, 25 Oct 2018 15:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
 <1537312139-5580-3-git-send-email-chang.seok.bae@intel.com> <CALCETrUr3DGwW8y6y_cffEKWO_KQs1J2_UvTBZsbdAzES_f-Ag@mail.gmail.com>
In-Reply-To: <CALCETrUr3DGwW8y6y_cffEKWO_KQs1J2_UvTBZsbdAzES_f-Ag@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Oct 2018 15:37:19 -0700
X-Gmail-Original-Message-ID: <CALCETrUGqfpcu6gf2931f9kfkzirTCojANt3BncTY7h9usQYtA@mail.gmail.com>
Message-ID: <CALCETrUGqfpcu6gf2931f9kfkzirTCojANt3BncTY7h9usQYtA@mail.gmail.com>
Subject: Re: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:01 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Sep 18, 2018 at 4:09 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >
> > With new helpers, FS/GS base access is centralized.
> > Eventually, when FSGSBASE instruction enabled, it will
> > be faster.
>
> Sorry for not catching this during review, but:
>
> > +void x86_fsbase_write_cpu(unsigned long fsbase)
> > +{
> > +       /*
> > +        * Set the selector to 0 as a notion, that the segment base is
> > +        * overwritten, which will be checked for skipping the segment load
> > +        * during context switch.
> > +        */
> > +       loadseg(FS, 0);
>
> ^^^
>
> what?
>
> > +       wrmsrl(MSR_FS_BASE, fsbase);
> > +}
>
> I don't understand what the comment is trying to say, but the sole
> caller so far of this function is x86_gsbase_write_task(), and the
> code looks incorrect.
>
> Ingo, I think we need to address this during this merge window,
> probably by removing the comment and the loadseg() call (and the same
> for gsbase...inactive).  But first, Chang, can you explain what
> exactly your intent is here?

It might not be a problem for the current merge window, since the one
and only caller (I think) that hits this code is okay with it.  But it
might still be nice to have it cleaned up in Linus' tree.
