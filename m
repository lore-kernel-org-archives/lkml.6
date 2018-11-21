Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3720C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC90213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XiMhSNO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC90213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeKUMA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:00:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43379 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:00:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so2746182lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmE7ojsVEZaHbdNiiJMiC2FSdJbmDtHI4q6zyQMOEJs=;
        b=XiMhSNO9OoOljcgItuy0BXPKKBKlAPJs7JAiBmXMV8SHBjHy40GLxeaGINFQr33ORa
         KN2yZEfZTgSC3N/JFNzUcwu8sv9jfNo6+g4mbaRsVAM62UtfVOeGE3CL59qil8lJ+aq2
         /bb7ZsdmNmAJaJK0sCLSE/he7ymkNTxYHB/fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmE7ojsVEZaHbdNiiJMiC2FSdJbmDtHI4q6zyQMOEJs=;
        b=hIDe6LtoaeV+dFknLd8/5XuOBnQk1+QcXLAi1w1s0W/Ff/TtjY0IUEN1hd66tCRzU8
         iXX0TDOLuokB7AC6xzIAwIFDjMkgZQv+stSfU3B6sWozUmjGdjiOVIUVZwiwisS9iFZ0
         IxnoLQZPrCnegoFXr541oOjVyrGBUfc5//jKLWvmSenfyoP7TPZbDS9NBINzmuj66SXO
         ukWolS0zf9xs++/T0h+z6igQzejZc+tBYc0gpJk+VEHmEOUTB19Wmr9nCwNAZmyXhZMq
         TW5gbtD6qaK4QpLOGsKxJ45WsOtBLYjYOBDt4NqxSPMo7y/0StkjRU7uc9NL6/atp4i0
         BZqg==
X-Gm-Message-State: AGRZ1gIRTjqJn4fv/8y60QSJGkEfo/8LZZB22lSERQU31iF1UnoSZxOm
        UmtJXykPP+HPnF9VzMrmjdET33PVlio=
X-Google-Smtp-Source: AJdET5eFv423lwr3ZMCAjlYsAHoNQWePMca9qPgNOBWkiRjWF+/TSz1zkYV+Iwty3aDyCZlygD6d1w==
X-Received: by 2002:a19:f510:: with SMTP id j16mr2296223lfb.35.1542763697160;
        Tue, 20 Nov 2018 17:28:17 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id s24sm6074853lfc.30.2018.11.20.17.28.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 17:28:16 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u6-v6so3368581ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:28:16 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr2916986ljk.80.1542763695428;
 Tue, 20 Nov 2018 17:28:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542757030.git.tim.c.chen@linux.intel.com> <6652faa67f8c4e90c737f9fd9c7e0e2d3cd51cca.1542757030.git.tim.c.chen@linux.intel.com>
In-Reply-To: <6652faa67f8c4e90c737f9fd9c7e0e2d3cd51cca.1542757030.git.tim.c.chen@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Nov 2018 17:27:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRh4QVAHV086U02tDCJz9g8MYHegEHbxCZ6-Ap4ow5Lw@mail.gmail.com>
Message-ID: <CAHk-=wiRh4QVAHV086U02tDCJz9g8MYHegEHbxCZ6-Ap4ow5Lw@mail.gmail.com>
Subject: Re: [Patch v6 14/16] x86/speculation: Use STIBP to restrict
 speculation on non-dumpable task
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 4:33 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> Implements arch_update_spec_restriction() for x86.  Use STIBP to
> restrict speculative execution when running a task set to non-dumpable,
> or clear the restriction if the task is set to dumpable.

I don't think this necessarily makes sense.

The new "auto" behavior is that we aim to restrict untrusted code (and
the loader of such code uses prctrl to set that flag), then this whole
"set STIBP for non-dumpable" makes little sense.

A non-dumpable app by definition is *more* trusted, not less trusted.

So this model of "let's disable prediction for system processes" not
only doesn't make sense, but it also unnecessarily penalizes those
potentially very important system processes.

Also, "dumpable" in general is pretty oddly defined to be used for this.

The same (privileged) process can be dumpable or not depending on how
it was started (ie if it was started by a regular user and became
trusted through suid, it's not dumpable, but if it was started from a
root process it remains dumpable.

So I'm just not convinced "dumpability" is meaningful for STIBP.

                  Linus
