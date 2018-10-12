Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6936C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A65214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKjltXNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A65214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJMBlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeJMBlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:41:24 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8951A21524
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539367661;
        bh=ysnpQYt19Hf3LCOzjyVjC+164Rw6ikwLEXO2M9jvuMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dKjltXNKpHZbplBbqbjFp55RMWYGk/UMr2WzGvoIepZDg7idsFpqxBoVGwJHhj0wc
         hgdpSVBlM8xCqpCMplgXAhDyyGGYD8/UelFtnYjJo7iEIu8oILC2CISBJZlvxWkNo+
         +gSxCNf3jgueIiZpOh90/7m2TSHDZOgHLT6c/Jtw=
Received: by mail-wm1-f44.google.com with SMTP id a8-v6so13697292wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:07:41 -0700 (PDT)
X-Gm-Message-State: ABuFfohF6IS3hx7CgIMAUEFon8Wf6ffM0VljQ8O1s6j166mKvBktF9Fq
        LR6m3Oqwcf4mphqVjjuVAx3eJeDD3tcdWLiL+1ymMQ==
X-Google-Smtp-Source: ACcGV60dtb77l29Hda920aLepWNbKHUgs7q2CyCcrC6EdRwpROB6TvSxQI/xIoh3UjUTK/37qVdkJA5eJMOwOoWwPaM=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr5855641wmd.128.1539367659851;
 Fri, 12 Oct 2018 11:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-8-bigeasy@linutronix.de>
 <1351ba57-1e17-1d76-63c2-0eead2cc5f3b@linux.intel.com>
In-Reply-To: <1351ba57-1e17-1d76-63c2-0eead2cc5f3b@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Oct 2018 11:07:28 -0700
X-Gmail-Original-Message-ID: <CALCETrVm1ZygpEz+912BcMgTAPznB24uYsB1yQ_V4YQa2N-DzQ@mail.gmail.com>
Message-ID: <CALCETrVm1ZygpEz+912BcMgTAPznB24uYsB1yQ_V4YQa2N-DzQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] x86/pkeys: Drop the preempt-disable section
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

On Fri, Oct 12, 2018 at 10:58 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> On 10/04/2018 07:05 AM, Sebastian Andrzej Siewior wrote:
> > The fpu->initialized flag should not be changed underneath us. This might be a
> > fallout during the removal of the LazyFPU support. The FPU is marked
> > initialized as soon as the state has been set to an initial value. It does not
> > signal if the CPU's FPU registers are loaded.
>
> If this is true, then the check for fpu->initialized should also go away.
>

All these "if" statements in the FPU code are messy and make
understanding and reviewing this code hard.

Can you prepare a patch for the beginning of your series that removes
fpu->initialized and just ensures that the fpu is always initialized?
This will regress performance, but you should get all that performance
back with TIF_LOAD_FPU.
