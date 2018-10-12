Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC8C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A292D2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8E7Pu2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A292D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJMBgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeJMBgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:36:13 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C832151C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539367352;
        bh=gh/wgzZhCN63Ik/wl41gD6zk514cHTisZSs6EW7mBuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a8E7Pu2CCUQ619qu7hDoHW7d7y6OrLPh5THtwZr1sJgujlE4TS2tyRQKtRBwJUt/A
         JDZ0r0JtrrwMChMGc1umhz0+D3yWjxDtuHU+mziZ92JadEP5xyqoHHyFVkM1uo57H5
         eT7tvOSlXZnsRQCY2SH2x4qKFUdnZ9YRiQrlDM1w=
Received: by mail-wr1-f53.google.com with SMTP id e4-v6so14363600wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:02:31 -0700 (PDT)
X-Gm-Message-State: ABuFfojSQC74fg+u/mXl1n/LXlurj8ArFC/ODdwyNs5ekktVO546AD+C
        /a1oVZrCxoqXkVwi+go78q2gM7RzKN4Pkz9ll2DD/w==
X-Google-Smtp-Source: ACcGV61YlVlbH6s70e6TtkHVH7jo3K5ZxdCSoQQfWuVWc5GTko8YBJ5LTFVyREsMo8QQ1RroycVzfr8yOB2NtxGHzvI=
X-Received: by 2002:adf:e387:: with SMTP id e7-v6mr6223878wrm.94.1539367350260;
 Fri, 12 Oct 2018 11:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-6-bigeasy@linutronix.de>
 <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com>
In-Reply-To: <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Oct 2018 11:02:18 -0700
X-Gmail-Original-Message-ID: <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com>
Message-ID: <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:54 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> On 10/04/2018 07:05 AM, Sebastian Andrzej Siewior wrote:
> > The PKRU value is not set for kernel threads because they do not have
> > the ->initialized value set. As a result the kernel thread has a random
> > PKRU value set which it inherits from the previous task.
> > It has been suggested by Paolo Bonzini to set it for kernel threads, too
> > because it might be a fix.
> > I *think* this is not required because the kernel threads don't copy
> > data to/from userland and don't have access to any userspace mm in
> > general.
> > However there is this use_mm(). If we gain a mm by use_mm() we don't
> > have a matching PKRU value because those are per thread. It has been
> > suggested to use 0 as the PKRU value but this would bypass PKRU.
> >
> > Set the initial (default) PKRU value for kernel threads.
>
> We might want to do this for cleanliness reasons...  Maybe.
>
> But this *should* have no practical effects.  Kernel threads have no
> real 'mm' and no user pages.  They should not have do access to user
> mappings.  Protection keys *only* apply to user mappings.  Thus,
> logically, they should never be affected by PKRU values.
>
> So I'm kinda missing the point of the patch.

use_mm().
