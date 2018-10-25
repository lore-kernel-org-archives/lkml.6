Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B03BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AE32084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN7kCuTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AE32084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJZHvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbeJZHvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:51:15 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8DF220854
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540509399;
        bh=TVueKtyC7ZN2RBF4zdo1HxxlnmdPaZJQlS7zfNc5sYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PN7kCuTrhXQIi8rkFF9uK0dW8JSw2pQkRKAkL5EArUjDdMLWPXx06Xw7GGdpFlxGH
         ggtCpYrMFF/VLrburM31uHcb4hnvmsaQBQJAsCeIE0tX22lm41AFVww7O61dA1EEcF
         If6IEyfDWg9Wr8NETZ263utycVEOFP5vhb3hF/T0=
Received: by mail-wm1-f53.google.com with SMTP id w186-v6so3051591wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:16:38 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJPZQE7spWDN2mGq008km2relKbODKyzxz9VsTtqJgVyTRDT/qm
        GYfQXBR/UTSyO1aF5lnmZF8v0bHecVYCTVzHSiDK7w==
X-Google-Smtp-Source: AJdET5dyTmjDKJAHtT7tqAR3N7o01nvQ0cKPwQRiCS6rMb5uiFpraU+Dz6kCW7IjNf+hh4/PtKBR+CtYzbYJsDLeLIs=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr3548725wmf.19.1540509397463;
 Thu, 25 Oct 2018 16:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-5-chang.seok.bae@intel.com> <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
In-Reply-To: <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Oct 2018 16:16:26 -0700
X-Gmail-Original-Message-ID: <CALCETrW1KJYL6mHGS8__ApTUGg7+o2nx_jCbDe6EzQ7gGurykQ@mail.gmail.com>
Message-ID: <CALCETrW1KJYL6mHGS8__ApTUGg7+o2nx_jCbDe6EzQ7gGurykQ@mail.gmail.com>
Subject: Re: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in the
 helper functions
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
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

On Wed, Oct 24, 2018 at 12:16 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:

> > +/*
> > + * Interrupts are disabled here. Out of line to be protected from kprobes.
> > + */
> > +static noinline __kprobes unsigned long rd_inactive_gsbase(void)
> > +{
> > +       unsigned long gsbase, flags;
> > +
> > +       local_irq_save(flags);
> > +       native_swapgs();
> > +       gsbase = rdgsbase();
> > +       native_swapgs();
> > +       local_irq_restore(flags);
> > +
> > +       return gsbase;
> > +}
>
> Please fold this into its only caller and make *that* noinline.
>

On further reading of the whole series, I retract this particular
comment.  But I do think that __rdgsbase_inactive() would be a better
name.
