Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC7BC43143
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786DC20837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwbmp179"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786DC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeIAVuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeIAVuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:50:14 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B38220846
        for <linux-kernel@vger.kernel.org>; Sat,  1 Sep 2018 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535823450;
        bh=5379fYm+sbTSYGSMpKbkGcS7eO5TEf4B5fRiOxw/WYs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dwbmp179pz/p5wOu4w02BZnQQRd3mJ0Lroyo0Jt+HbBNsTWFFqhYK6igTmLzBM6Jw
         C2due3pnv9OLGMkH9WopUDeUyTTxDFFCf9RNaAO4rzyuWqfNb2NRAue7+06p1dH32S
         w0SFpEEQ9yFIs+4zjQp/QY5gaX5tHCoeg9YlcKa0=
Received: by mail-wm0-f48.google.com with SMTP id q8-v6so8062952wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 10:37:30 -0700 (PDT)
X-Gm-Message-State: APzg51CPhMFvPqZd2Po/bJU3DtEmzLHY1wXxfo5oZ2egfg12his1gdCn
        wDoboOsSTueLOpTZ3mYITtY2sawHTP4Afmye5x5Vog==
X-Google-Smtp-Source: ANB0VdZcTPpGTzy9NLEnZFFPDQQo6ZNdKbzCvMf47qfayIB0RhHWnJhDU6IzX74isrzhaSw7b4tmCEJ6Fl/FhdUlr+4=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr1112392wmq.36.1535823448627;
 Sat, 01 Sep 2018 10:37:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9045:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 10:37:08 -0700 (PDT)
In-Reply-To: <0a94774a-6b8b-2014-93e6-131af9c319a6@redhat.com>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au>
 <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com> <0a94774a-6b8b-2014-93e6-131af9c319a6@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 1 Sep 2018 10:37:08 -0700
X-Gmail-Original-Message-ID: <CALCETrW-LkeBUJ6zw7a30mCV2T0Pd5mjYMHjLptg1voTq0VUdA@mail.gmail.com>
Message-ID: <CALCETrW-LkeBUJ6zw7a30mCV2T0Pd5mjYMHjLptg1voTq0VUdA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 2:33 AM, Florian Weimer <fweimer@redhat.com> wrote:
> On 09/01/2018 05:39 AM, Andy Lutomirski wrote:
>>
>> Florian, do you think
>> glibc would be willing to add some magic to turn
>> clock_gettime(CLOCK_MONOTONIC, t) into
>> __vdso_clock_gettime_monotonic(t) when CLOCK_MONOTONIC is a constant?
>
>
> What's the goal here?  Turn the indirect call/conditional jump/indirect call
> sequence into a single indirect call, purely for performance reasons?

Almost.  It's to bypass some of the branches in
__vdso_clock_gettime(), which is supposed to be very fast.  AFAIK most
user code that uses clock_gettime() passes a constant for the first
argument, and we can squeeze out some performance by optimizing that
case.  The indirect branches internal to the vDSO are a separate issue
and should be solved separately.

(It's really too bad that x86 doesn't have a 64-bit call instruction.
If it did, then the PLT could get rewritten at dynamic link time to
avoid indirect calls entirely, and presumably glibc could use the same
technique to call into the vDSO without indirect calls.)
