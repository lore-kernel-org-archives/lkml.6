Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE9C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BAA2148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549075970;
	bh=kIGqXvcpyLnfAD3MHpZJsKj71GoTka2Lw9lznxRezNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=caJ/uiSS+PXHrwyqoQhAgSPELmppUqn/KW+Y84pHUDvPaWKb/883dHVbS8K7xTOQQ
	 1EcyDJ965L6syCI/j2bdKpHn2kYE2YURZoR8tI4DK9OJE15zH7UK6DkVs06jcAAXWq
	 skYaNRTg10jl8kiZWaSKBAs3Lv/MfQ9Cbbgj40Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBBCwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfBBCws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:52:48 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4021218FF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Feb 2019 02:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549075968;
        bh=kIGqXvcpyLnfAD3MHpZJsKj71GoTka2Lw9lznxRezNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zuCZY4m4IyGnYksmS2iYk/Rlw61CbnTHHWXzuwpKAcnAiFrPnLAyWGSeX/2vCVtI5
         L0vVk8AYYqx7AnkHkD/ppeOybItm0b92GSAyGdf46v9RQLJbEW1ulY0krmrxh/uIXJ
         1BsMvDypJW8Eh1b00fKbfp8SR3+jKTbGAIQnd9Yc=
Received: by mail-wr1-f54.google.com with SMTP id p4so9052666wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 18:52:47 -0800 (PST)
X-Gm-Message-State: AJcUukfJhAB7OMigCDvbcVd34IyaOu0l8jA9Q5Y5Smyat7jm5xxVE/3q
        5IJhlTove3pcrUMWnpEMxtrLMxglNWcJRNct2tK/OA==
X-Google-Smtp-Source: ALg8bN41oNfvNsqMUUOE687jCWUyFIF4TzsmU1j9P5CfVvmsUOMljfrsYFC+TPO/PG5kjjoEss2Ktp0vxhQNRX2kw3s=
X-Received: by 2002:adf:8323:: with SMTP id 32mr39541754wrd.176.1549075966133;
 Fri, 01 Feb 2019 18:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <20190201205319.15995-5-chang.seok.bae@intel.com>
In-Reply-To: <20190201205319.15995-5-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Feb 2019 18:52:35 -0800
X-Gmail-Original-Message-ID: <CALCETrV9s9+jWgvcbEMkThW9iCcjeTpWu1f67d+TJLp2gV7N_w@mail.gmail.com>
Message-ID: <CALCETrV9s9+jWgvcbEMkThW9iCcjeTpWu1f67d+TJLp2gV7N_w@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
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
> here for extra performance

Does it really get better performance?  If so, let's do it.  If not,
let's remove the comment.  And, whatever you do, please put this above
the [luto] and [chang] parts.
.
>
> [ chang: Use FSGSBASE instructions directly. Removed GAS-compatible
>   macros as the minimum required binutils (v2.21) supports the FSGSBASE
>   instructions. ]

Can you stick the "v2" revision notes below the --- or even just
remove them?  It makes the changelog a lot harder to review and it's
not really useful in the git tree.
