Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A022084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/6iOhxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A022084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeKCGQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeKCGQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:16:41 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08552084C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Nov 2018 21:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541192879;
        bh=+wOV1KkeljuLGMGdMCb3XGbSUucl4LiPMxH42kqbpyM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K/6iOhxjBmn4n9t0JqDpk9AGxeP4Fi0YXDkBAN03SscIu//AN0Yf+GPrigsa1NUPB
         /Upa/vcyDkj2g6g35YH6oQrko3cR7cv+tzSm6N8W+ikNvXaP7Rpal+Ai1CrgEaPTQX
         fDPGNKEmfeTPV4HDk+zlv9Z2OqxhhRyy6Be+/cM0=
Received: by mail-wm1-f41.google.com with SMTP id f1-v6so1995703wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:07:58 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKAGIyjNbffxeN7H82OGH9Tta9t1pXrKgnorkDtI8xdNlA7N2TI
        pGnb7jFv8bdkNC6yny29xIwdpC/s1+QOyCFOti6yVA==
X-Google-Smtp-Source: AJdET5cQurQzY1QBVVs7rzgTZQB/YkKbX8w9O+FpC+6C9GztMTCWrOAZ5V4C5hU6b9j2vQWMtLXn8VhhK0PjjtzrLcM=
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr177768wmn.102.1541192877352;
 Fri, 02 Nov 2018 14:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181026122856.66224-1-kirill.shutemov@linux.intel.com> <20181026122856.66224-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20181026122856.66224-2-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 2 Nov 2018 14:07:44 -0700
X-Gmail-Original-Message-ID: <CALCETrXMA=4694sstXYWK1rSiHBAFbN=kPpB5PcG2uBpyxoF3g@mail.gmail.com>
Message-ID: <CALCETrXMA=4694sstXYWK1rSiHBAFbN=kPpB5PcG2uBpyxoF3g@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 5:29 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On 5-level paging LDT remap area is placed in the middle of
> KASLR randomization region and it can overlap with direct mapping,
> vmalloc or vmap area.
>
> Let's move LDT just before direct mapping which makes it safe for KASLR.
> This also allows us to unify layout between 4- and 5-level paging.
>
> We don't touch 4 pgd slot gap just before the direct mapping reserved
> for a hypervisor, but move direct mapping by one slot instead.
>
> The LDT mapping is per-mm, so we cannot move it into P4D page table next
> to CPU_ENTRY_AREA without complicating PGD table allocation for 5-level
> paging.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

(assuming it passes tests with 4-level and 5-level.  my test setup is
current busted, and i'm bisecting it.)
