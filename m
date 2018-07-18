Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64E6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7097220850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VDiCTZc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7097220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeGRMgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:36:45 -0400
Received: from 8bytes.org ([81.169.241.247]:57470 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbeGRMgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:36:43 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B10ED1CF; Wed, 18 Jul 2018 13:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531915145; bh=BhXgtHAWgNGvieIGowV1lasZA1Ej+YMKVlv5jSG/O28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDiCTZc0KjybrsmpLWYhA3fv67e3pCkKfbS7jftAQ7YVaP4ftuloG3gn/5ycYFxwj
         W4BaW1ri/GeJ+VXNT74djyuiPHcGsRFE9Ret0mOvCeBiqVufT/UbTLnZlPWNKLv3Pw
         Rf+4WMCJlIj8WtjB4LJ2bw6UV3DV2pMyZ17KEEsz/2VTCiL+cNnqxpXA1/43RThNja
         ftuIrY9yojEFxnH0XZoHGPth8NwdkDjvcg+YpNaYsxY4Kuzcx/fTZAyyB2feb656+W
         VnYoT3NVD+o8wEAsczlufpOKMENyyrEuJwmmlS0tGvQ/YnhzSWzY167yJHeG1UU084
         FJ/OMSn/Z5mPw==
Date:   Wed, 18 Jul 2018 13:59:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Subject: Re: [PATCH 10/39] x86/entry/32: Handle Entry from Kernel-Mode on
 Entry-Stack
Message-ID: <20180718115905.GA18541@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-11-git-send-email-joro@8bytes.org>
 <CALCETrUg_4q8a2Tt_Z+GtVuBwj3Ct3=j7M-YhiK06=XjxOG82A@mail.gmail.com>
 <20180714052110.cobtew6rms23ih37@suse.de>
 <7AB4F269-E0E8-4290-A764-69D8605467E8@amacapital.net>
 <20180714080159.hqp36q7fxzb2ktlq@suse.de>
 <75BDF04F-9585-438C-AE04-918FBE00A174@amacapital.net>
 <20180717071545.ojdall7tatbjtfai@suse.de>
 <CALCETrXAF6+mkDL4+uQdHQdJ=G70YVu_k55P_x6Mgi4hXe3oYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXAF6+mkDL4+uQdHQdJ=G70YVu_k55P_x6Mgi4hXe3oYw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:06:11PM -0700, Andy Lutomirski wrote:
> Yes, we obviously need to restore the correct cr3.  But I really don't
> like the code that rewrites the stack frame that we're about to IRET
> to, especially when it doesn't seem to serve a purpose.  I'd much
> rather the code just get its CR3 right and do the IRET and trust that
> the frame it's returning to is still there.

Okay, I'll give it a try and if it works without the copying we can put
that on-top of this patch-set. This also has the benefit that we can
revert it later if it causes problems down the road.


Regards,

	Joerg
