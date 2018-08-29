Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E16C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D8B20897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1EP5x8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D8B20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeH2Hlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeH2Hlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:41:44 -0400
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0516A2089F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535514418;
        bh=hHc/kq44QxqWumH404HZD8UHUt2+AIo9XH5ZU8B74LY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=a1EP5x8Z/FIlVxvBArjqi0TvHdgTbW6crrOAcIgPzUdzj85vYGx2TS3VEcSlBt/rp
         ZPlQ389NVQIcX5oydkFng35YiIBYxuRPu84VmG4OtkgsVlMNx/ujnZXfGBZrJ1pk5d
         Ltb+amTM432ZEbZuRsXGHQQPVDVs/7ixrurotifM=
Received: by mail-wm0-f43.google.com with SMTP id b19-v6so3789052wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 20:46:57 -0700 (PDT)
X-Gm-Message-State: APzg51BTdvjrHGYrjTaNm1jonm7EEBaKL1mbvBhLhT1kZa5upx1sfZVV
        Y6uhStBBrvWkHMkwl/K/Lb8b0X8pTm+YKqWvBuINkg==
X-Google-Smtp-Source: ANB0Vdb+j74Y4jiAcwD58vQUKUN5c69AsSageWEJIckqmKaw3ZMEIO+sSGh7NOgj6nDfB+Uxop4vK2rBmZykGwdVJMA=
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr3109941wma.21.1535514416342;
 Tue, 28 Aug 2018 20:46:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 20:46:35 -0700 (PDT)
In-Reply-To: <20180828135647.6d516048@imladris.surriel.com>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
 <20180828135647.6d516048@imladris.surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Aug 2018 20:46:35 -0700
X-Gmail-Original-Message-ID: <CALCETrX2v_g_+TpX1DEZasHGi=8Y3w3ka=yYEaTxgFDnPy67nw@mail.gmail.com>
Message-ID: <CALCETrX2v_g_+TpX1DEZasHGi=8Y3w3ka=yYEaTxgFDnPy67nw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:56 AM, Rik van Riel <riel@surriel.com> wrote:
> On Mon, 27 Aug 2018 16:04:16 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> The 0day bot is still chewing on this, but I've tested it a bit locally
>> and it seems to do the right thing.
>
> Hi Andy,
>
> the version of the patch below should fix the bug we talked about
> in email yesterday.  It should automatically cover kernel threads
> in lazy TLB mode, because current->mm will be NULL, while the
> cpu_tlbstate.loaded_mm should never be NULL.
>

That's better than mine.  I tweaked it a bit and added some debugging,
and I got this:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=dd956eba16646fd0b15c3c0741269dfd84452dac

I made the loaded_mm handling a little more conservative to make it
more obvious that switch_mm_irqs_off() is safe regardless of exactly
when it gets called relative to switching current.
