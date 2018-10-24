Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FA9ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F342207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug1qJ8pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F342207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJYDSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeJYDSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:18:42 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C1220834
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540406970;
        bh=hAuW7PyzUjF6oeJUMXoQTxwgkTPb65VriMP9+LVfVaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ug1qJ8pc+pkonafgVMDCmqiXobVkrIbU9ZGJITjgcETjxlFl7KtYqTHJsnSxHb42+
         kAHidGAaca5wrFFFZs4u3XGfd4oEVGxFkTOZ+lKfJkWfwUGC7c4xxBRWMpc/ihsy+o
         MCIAgks3FRuS4fd+WalwMHARjYcGooRao/wC4Hhs=
Received: by mail-wr1-f48.google.com with SMTP id l6-v6so6730145wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:49:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLIeN9ME8+AsLAwTPN9yz9dKPTE48KJ90yBj86flMJ4B2XfoDk7
        Xm5HhPEUuXFzIo7lp1yt38o1kC64n4S0arj84Lhn9w==
X-Google-Smtp-Source: AJdET5eolcOlngciFEFNPXmwM9p6gLPYnWz2/QCY66YBaoXFzHxcjUVxtcnWAMM+IQJF6J/Km4UB4mOH+ffoKYD23oc=
X-Received: by 2002:a5d:4406:: with SMTP id z6-v6mr979744wrq.308.1540406968712;
 Wed, 24 Oct 2018 11:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181023163157.41441-1-kirill.shutemov@linux.intel.com> <20181023163157.41441-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20181023163157.41441-3-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Oct 2018 11:49:17 -0700
X-Gmail-Original-Message-ID: <CALCETrUsqCzU6VO0h4EFpsdXOOn-kJY7ogwKQiQScNY9YJ6hWA@mail.gmail.com>
Message-ID: <CALCETrUsqCzU6VO0h4EFpsdXOOn-kJY7ogwKQiQScNY9YJ6hWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/ldt: Unmap PTEs for the slow before freeing LDT
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 9:32 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> modify_ldt(2) leaves old LDT mapped after we switch over to the new one.
> Memory for the old LDT gets freed and the pages can be re-used.
>
> Leaving the mapping in place can have security implications. The mapping
> is present in userspace copy of page tables and Meltdown-like attack can
> read these freed and possibly reused pages.

Code looks okay.  But:

> -       /*
> -        * Did we already have the top level entry allocated?  We can't
> -        * use pgd_none() for this because it doens't do anything on
> -        * 4-level page table kernels.
> -        */
> -       pgd = pgd_offset(mm, LDT_BASE_ADDR);

This looks like an unrelated cleanup.  Can it be its own patch?
