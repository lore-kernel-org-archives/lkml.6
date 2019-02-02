Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DDC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA02320844
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549075420;
	bh=2MPJBg6078FAFANXvdH2NiCL4Mjm0Dwd29x027dlhwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FH8ulkBv1G+bgdTOsSdYOusm4YWGRoUqXTF2BQnFSS7N6i8jXD2J2rstSQZvgOAAs
	 xdPKRQ6WjEB+S30WXzEdK2CtkoqyDfBB7FQ9UWfuQo0vlsVuu0L31YzxC+S7tfKTzw
	 TQwCD7i7hPK4q8NPJvvUz1bFNVm6iCcvC6aL8UU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBBCmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfBBCmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:42:43 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F255218FF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Feb 2019 02:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549075362;
        bh=2MPJBg6078FAFANXvdH2NiCL4Mjm0Dwd29x027dlhwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x3T5Y2EgR/S0wCQitPRf7rEunIb+nrOZOglVpSeeyEbG8KU/2/COOJjOLkqfmC8MD
         BliscB8YEzakftwcnFP/riRKaGXGwLsAPYQ4qX/+qQ/QBdz26aft8MlNmjdzuf3rno
         W/98EPcLrc88o7/q/cYFG9TQSYmvchSyBvF8ki0w=
Received: by mail-wm1-f44.google.com with SMTP id n190so7950073wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 18:42:42 -0800 (PST)
X-Gm-Message-State: AHQUAuZd4g4gYo5TeVTSrG8lhdc5QhjHxJTtfDrpH9K0wMUOgxOSEd2j
        +17rWA/w5PhUN0Q31p3n4ycfZMi7H/5TIzi6aPSoyA==
X-Google-Smtp-Source: AHgI3Ib6A6tBLoLt826xhWpCucayZULamEmTWYXgaUTgmhZ2cve3GCCpuFDKM6BbsK+CERQOJk+mYdi2Or5nvYCldFI=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr4528174wmd.83.1549075360924;
 Fri, 01 Feb 2019 18:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <20190201205319.15995-2-chang.seok.bae@intel.com>
In-Reply-To: <20190201205319.15995-2-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Feb 2019 18:42:29 -0800
X-Gmail-Original-Message-ID: <CALCETrXi=PEOXCQYkCO9BLL+oaoJonRohWoxvUqxZdiWURc3=Q@mail.gmail.com>
Message-ID: <CALCETrXi=PEOXCQYkCO9BLL+oaoJonRohWoxvUqxZdiWURc3=Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] taint: Introduce a new taint flag (insecure)
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> For testing (or root-only) purposes, the new flag will serve to tag the
> kernel taint accurately.
>
> When adding a new feature support, patches need to be incrementally
> applied and tested with temporal parameters. Currently, there is no flag
> for this usage.

I think this should be reviewed by someone like akpm.  akpm, for
background, this is part of an x86 patch series.  If only part of the
series is applied, the kernel will be blatantly insecure (but still
functional and useful for testing and bisection), and this taint flag
will be set if this kernel is booted.  With the whole series applied,
there are no users of the taint flag in the kernel.

Do you think this is a good idea?
