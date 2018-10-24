Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75770ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238852082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wNpOPqZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238852082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJYDXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJYDXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:23:21 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EADB2082F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540407248;
        bh=54SvS0WM5XZyZnqsD7ZKspIz03vxdHQfZHGt30OX5iA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wNpOPqZbPWvdiIbrqm7iYtADYnNGtcsHq76D4p1c8TyScNCtpKTEma8jXjDzhh8KD
         sUiExLb0dspK5EbmZnTJfFUb3EmdqCdVxTDm+++udFYvF6oPnEuBy9PVUrT4AySlhU
         HtJebEBUdBqc49ZL7Limm6ZDP5lmwtH9t1DL+YVo=
Received: by mail-wr1-f47.google.com with SMTP id t10-v6so6706000wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:54:08 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIMKvRFhAn07QaI9dI3bjC05/Mh0vLYLK6KY2lE1hsRvGKami1i
        skmXoMnVMshL5tU6WThlNeAnoWMMGPJhRK5JsMDbpw==
X-Google-Smtp-Source: AJdET5ez0LAhvedbqgPNVNGm/jMmUEF5DFTri3dNR0dnLpskhaSXaMBp2mmrg8ktRHd5xSkE4vWEz4vYMmRRF1rpLzg=
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr937631wrc.131.1540407246617;
 Wed, 24 Oct 2018 11:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com> <20181023184234.14025-4-chang.seok.bae@intel.com>
In-Reply-To: <20181023184234.14025-4-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Oct 2018 11:53:54 -0700
X-Gmail-Original-Message-ID: <CALCETrWWBYgaJfPykTpJ9=TsptVL_ieOR3JdYVVW02=O9CM17Q@mail.gmail.com>
Message-ID: <CALCETrWWBYgaJfPykTpJ9=TsptVL_ieOR3JdYVVW02=O9CM17Q@mail.gmail.com>
Subject: Re: [v3 03/12] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
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

On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> From: Andi Kleen <ak@linux.intel.com>
>
> Add C intrinsics and assembler macros for the new FSBASE and GSBASE
> instructions.
>
> Very straight forward. Used in followon patches.
>
> [ luto: Rename the variables from FS and GS to FSBASE and GSBASE and
>   make <asm/fsgsbase.h> safe to include on 32-bit kernels. ]
>
> v2: Use __always_inline
>
> [ chang: Revise the changelog. Place them in <asm/fsgsbase.h>. Replace
>   the macros with GAS-compatible ones. ]
>
> If GCC supports it, we can add -mfsgsbase to CFLAGS and use the builtins
> here for extra performance.

Reviewed-by: Andy Lutomirski <luto@kernel.org> # C parts only

With the caveat that I'm not convinced that the memory clobbers are
needed.  The __force_order trick in special_insns.h would probably be
more appropriate.

I don't feel qualified to review the asm part without some research.
Whereas hpa or Boris could probably review it with their eyes closed.
