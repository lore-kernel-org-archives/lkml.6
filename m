Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C07C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBCF206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+nvT42l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBCF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbeKVJOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:14:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731883AbeKVJOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:14:53 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6012080F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542839910;
        bh=FjgDisKjG7mAlDi+UPT41IiQ3ORfZ1nF9xd1OgApyeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d+nvT42lFjCte8WwxrU+58BbS7Te0OqNzjJCnKibG2Fzm4KnaH+x4BD/wv8BJr/8i
         iLOOt4kd9A4NMyd/4j5HZ0Ut2ZNxS46QouzzS1vOVcp+KvBhMOJ01I5rqwhRHex9Nz
         egYKAMz03suz3tSECHbqHd2+l9Wr3C9difD6WJoA=
Received: by mail-wm1-f41.google.com with SMTP id s11so7325629wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:38:30 -0800 (PST)
X-Gm-Message-State: AA+aEWb/5A+V02q2dSfPQ0KzbkylxREreZ3qLeI2+N3J8fv26xZs9kTy
        JHoagqdL/E3RfDJgdqbXCETC2dKlf1591M/rhcXrow==
X-Google-Smtp-Source: AFSGD/UbSZE4AeMpgUXDNFK4/u8xGkTeed96w11HmNjBycLqkBchKXMzJeZMcVOuySz2DM/BtUOIKDm9LL2NtQovGOM=
X-Received: by 2002:a1c:110b:: with SMTP id 11mr7272563wmr.83.1542839908831;
 Wed, 21 Nov 2018 14:38:28 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <658cdb28-e3e5-c0af-368f-c26daf9986ac@kernel.dk> <9E7DFB44-8A2A-48CF-972E-6CB5122CCA20@amacapital.net>
 <CAHk-=wia47WugL2b02gMx49AfpUmm5jp3tBoUL5dF2YomSGN2A@mail.gmail.com>
In-Reply-To: <CAHk-=wia47WugL2b02gMx49AfpUmm5jp3tBoUL5dF2YomSGN2A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 21 Nov 2018 14:38:17 -0800
X-Gmail-Original-Message-ID: <CALCETrUWbZGg5=r_GeJzfrmZpuC9y3f4jxFoZuOm4aGuHGhDog@mail.gmail.com>
Message-ID: <CALCETrUWbZGg5=r_GeJzfrmZpuC9y3f4jxFoZuOm4aGuHGhDog@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Dave Hansen <dave.hansen@intel.com>,
        pabeni@redhat.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 21, 2018 at 10:26 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > Can we maybe use this as an excuse to ask for some reasonable instructions to access user memory?
>
> I did that long ago. It's why we have CLAC/STAC today. I was told that
> what I actually asked for (get an instruction to access user space - I
> suggested using a segment override prefix) was not viable.
>

Maybe it wasn't viable *then*, but WRUSS really does write to
userspace with user privilege.  Surely the same mechanism with some of
the weirdness removed would do what we want.
