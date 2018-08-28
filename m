Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B841C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03FA20878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03FA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeH1Sw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:52:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47047 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1Sw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:52:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so1673906ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTR3gH8z8SC06c4kMY4Fd2WJpM8bsrnkCJ/+KBawQs4=;
        b=Dzr8fUvpYdpbEGKUTP6eCLE7hXX27l2dCvVPmWdycDvzjg6YswCJEzXaYlw4ynFBM8
         15Z9v3omzdJoE7KtyiAwIia2T0Z2dHpVr89YD8W9VeRgi+tWZKGf5dy0FQO1EEVMp8Xl
         pYQcbilIZy0W+gKPOCgXHpQFfSdUkMCDV4BI1LsL3UWuGJiqgMaJXtdlBiOEOSKIp+Kd
         SUPXDDvS4UZp0OeXq66BC6+4c47DYjbXwUArnO6OJ29cPPeoVoOiUgtSsut64RaasH02
         QjLFmuA9F/Cf3emFnzZZ8FOnRB5B+OWvatT/1SOv/o+mYG005gMZeIxQ7/6ZHuS9tMxB
         wiLA==
X-Gm-Message-State: APzg51DRAWswfR2F8gLsLguOCNewgBn0E6tr5KVKBLYcH/a11FqkALbY
        SlbDmD0ivqi7R9LS3994aRLUjfmrV//TcT71sJgawA==
X-Google-Smtp-Source: ANB0VdY77qKFKCcOhMO01YngtdIs/ggfth9myKBfN0pmiKx17axOoRqZTE3IGGsbcIQisgUO6YlryhElnkjQArPsdbk=
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr1540858lji.78.1535468450561;
 Tue, 28 Aug 2018 08:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
 <20180829003539.668e514c@roar.ozlabs.ibm.com>
In-Reply-To: <20180829003539.668e514c@roar.ozlabs.ibm.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 28 Aug 2018 15:00:14 +0000
Message-ID: <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
Subject: Re: VirtIO console hangs
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Tue, 28 Aug 2018 12:54:08 +0000
> Matteo Croce <mcroce@redhat.com> wrote:
>
> > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > I can always trigger the bug by pasting some characters in the
> > terminal window, the console will stop receiving keypresses, but I can
> > still see output from the console.
> > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> >
> > I did a git bisect and I've found that this is the offending commit,
> > reverting it fixes it.
> >
> > Cheers,
> >
> > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > Author: Nicholas Piggin <npiggin@gmail.com>
> > Date:   Tue May 1 00:55:54 2018 +1000
> >
> >     tty: hvc: hvc_poll() break hv read loop
>
> Thanks for the report. I can't immediately see what the problem
> is. Can you try get a stack trace of where it is stuck?
>

I tried but didn't get one.

> Perhaps try this patch if you have time (it's a bit of a shot
> in the dark).
>

Yes it seems to fix. Thanks!

-- 
Matteo Croce
per aspera ad upstream
