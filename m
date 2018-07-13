Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BF0208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjBIKEc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BF0208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbeGMXme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbeGMXme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:42:34 -0400
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89830208A4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 23:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531524347;
        bh=/f79sG+Td8iAA19gXpz4KoUiWcsDyooJqq/0cfEvezU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=JjBIKEc+15d6H1YJyQg1G+Fp9S4gqGhuFsI593T7rIoN/9vPe58VilmpHNKlJtRo8
         d0oQElIJyzSlsj546y1Rw0Glzq7mcHwhOKtMcSUGyFXod5r6YWyKPAdqZQL7bs5f/R
         9xyGY1yFzfysOlx72ouwcu2TBYWZ0/SBOQTeO9Cs=
Received: by mail-wm0-f43.google.com with SMTP id 69-v6so10669620wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:25:47 -0700 (PDT)
X-Gm-Message-State: AOUpUlGvoNTo6LszBXPUF1js7cOY/Yy7rbqB/lmSrM2R/+JGnImEImMK
        fLTGd522aNzUNrYMrhLEfe6v+lgoCgwdDstlVM7PvA==
X-Google-Smtp-Source: AAOMgpePccwskztB0C3aMfrPxFIjZ3BnNrzLoUwuu3dRQWczW8oyPDMkMVnLPnmNpK44/lCXW51PNg5txZFFOjZUV8o=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr4684469wmd.144.1531524346058;
 Fri, 13 Jul 2018 16:25:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 16:25:25
 -0700 (PDT)
In-Reply-To: <1531308586-29340-29-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-29-git-send-email-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Jul 2018 16:25:25 -0700
X-Gmail-Original-Message-ID: <CALCETrXj7TT5tm8m+9ycuRDDWDiqQy4u5gLLVrz8DhNWWw1fXA@mail.gmail.com>
Message-ID: <CALCETrXj7TT5tm8m+9ycuRDDWDiqQy4u5gLLVrz8DhNWWw1fXA@mail.gmail.com>
Subject: Re: [PATCH 28/39] x86/mm/pti: Keep permissions when cloning kernel
 text in pti_clone_kernel_text()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Mapping the kernel text area to user-space makes only sense
> if it has the same permissions as in the kernel page-table.
> If permissions are different this will cause a TLB reload
> when using the kernel page-table, which is as good as not
> mapping it at all.
>
> On 64-bit kernels this patch makes no difference, as the
> whole range cloned by pti_clone_kernel_text() is mapped RO
> anyway. On 32 bit there are writeable mappings in the range,
> so just keep the permissions as they are.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
