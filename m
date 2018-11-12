Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7401C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12FE214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="tbZthC60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12FE214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbeKLNSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:18:02 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:51699 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeKLNSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:18:02 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e8fdf320;
        Mon, 12 Nov 2018 03:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=jOjz5RLvhngllkJAWpmZjSocdwY=; b=tbZthC
        60adBBcwtnyUXI0AuQbwmtWWnTuZwYEnEEDtxGJjnXM4FAa4KRj0Idu0pA5ItcBQ
        fY58Wc2pL61zjexH0NJA9g9MzD4yT4fInuRRK8Fq0oynAGwQab55wj4NHzoJS7w1
        cQozgbjieIC7VOx+Ue9tY7kvN/4aLmsK1uusdFjcHMeY4M4vPiLG0CVM0/kInwBv
        Xh3UPy5+Fz0gIeWjlzH8S+Zvy+n9RQBkBhK7LUw6jS0Rh4QQDkGGhiQjZ3PZamkD
        ISlJpsHJBx/U/OTtzgFs4/PB6Q6b3n/fOnw1a8ZbkWCmG5XgYC1DrAaNbKQs00de
        b5+8xwQaIOls1TOA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e51cc922 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 12 Nov 2018 03:21:46 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id w25so5992947otm.13;
        Sun, 11 Nov 2018 19:26:49 -0800 (PST)
X-Gm-Message-State: AGRZ1gJKBdwMYfj7N22tah6nMQRFsP21Y0KeIXEV26aa0XYw4SStRRIq
        8t0Jfk3oezXTcq7IcUv0V0SizHj5A59UX++cNBM=
X-Google-Smtp-Source: AJdET5enWD2NjndEUDgTWmFmTyAzkLOpXKp0wvfFwn2LODg+0PdmgA1uLr08cNjcg2Gm1Jz69dqHWm2yNZRMgo4Ab7Y=
X-Received: by 2002:a9d:837:: with SMTP id 52mr10397985oty.143.1541993208829;
 Sun, 11 Nov 2018 19:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20181107194858.9380-1-bigeasy@linutronix.de> <CANRm+CzcHMM+YJEuowxK5gP71uMSCL_G0iDdaUV09m28p=ptHQ@mail.gmail.com>
In-Reply-To: <CANRm+CzcHMM+YJEuowxK5gP71uMSCL_G0iDdaUV09m28p=ptHQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 11 Nov 2018 22:26:37 -0500
X-Gmail-Original-Message-ID: <CAHmME9ot0MiNoW2dRbbHyjenmZnhMZ3N96rymcUYPyKkT2uzDg@mail.gmail.com>
Message-ID: <CAHmME9ot0MiNoW2dRbbHyjenmZnhMZ3N96rymcUYPyKkT2uzDg@mail.gmail.com>
Subject: Re: [PATCH v4] x86: load FPU registers on return to userland
To:     kernellwp@gmail.com
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        KVM list <kvm@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:02 PM Wanpeng Li <kernellwp@gmail.com> wrote:
> On Thu, 8 Nov 2018 at 03:55, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > This is a refurbished series originally started by by Rik van Riel. The
> > goal is load the FPU registers on return to userland and not on every
> > context switch. By this optimisation we can:
> > - avoid loading the registers if the task stays in kernel and does
> >   not return to userland
> > - make kernel_fpu_begin() cheaper: it only saves the registers on the
> >   first invocation. The second invocation does not need save them again.
>
> Do you have any performance data?

In WireGuard, the savings in not having to
save/restore/save/restore/save/restore the registers winds up being in
the order of hundreds of megabits.
