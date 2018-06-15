Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ECDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0345F208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ+mp2lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0345F208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756379AbeFOSuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756299AbeFOSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:50:04 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E520A208E1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529088604;
        bh=aKafc1FFuiPvRXbw4WkNPXm736JSnKh+WTqcmV8T2kg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJ+mp2lOPlXC//kiGd94Jdt5H7kbIaM42L9yX0zkxVQetfOu4nYkORtf2yYZ+ANLT
         L1u25atGkFu8qbvHzX2ZuPdpwpv4OOaYBelV5JSnjdgN42uholfekvXdB7kNlTGtf6
         WTfbO+9VIbEhttu0k0+rBr6F/w1mckSybxcZso5c=
Received: by mail-wm0-f49.google.com with SMTP id v16-v6so4973580wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:50:03 -0700 (PDT)
X-Gm-Message-State: APt69E3wMtmDFmJd+wAWgW9BJI22msD4cynRqQN8t/we2nhB6hxSkcmE
        DZB6OXnDwFmijltZdvPMG36PpUUoRFTdX664mOfTHQ==
X-Google-Smtp-Source: ADUXVKKkFiceQA9522I/yuloMSQw2UXD5SfF38Om4At/EID2mDnjVSMRG3o4jBREqtdhE+WSG4jOC0/W0PQvM+m5APo=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr2190945wma.21.1529088602388;
 Fri, 15 Jun 2018 11:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com> <368b8069-0463-6161-d603-10769fd2ec57@linux.intel.com>
In-Reply-To: <368b8069-0463-6161-d603-10769fd2ec57@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 15 Jun 2018 11:49:50 -0700
X-Gmail-Original-Message-ID: <CALCETrXrWR92L+JP1gaotpjkWd2TowjE9OrJTcj254L=wJfxMw@mail.gmail.com>
Message-ID: <CALCETrXrWR92L+JP1gaotpjkWd2TowjE9OrJTcj254L=wJfxMw@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:43 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> On 06/15/2018 11:31 AM, Andy Lutomirski wrote:
> > Using WRPKRU is easy, but,
> > unless we do something very clever, actually finding PKRU in the
> > in-memory fpstate image may be slightly nontrivial.
>
> Why?
>
> It's at a constant offset during any one boot, for sure.  XSAVEC/XSAVES
> can move it around, but only if you change the Requested Feature BitMap
> (RFBM) that we pass to XSAVES or change the control register that
> enables XSAVE states (XCR0).
>
> We don't change XCR0 after boot, and RFBM is hard-coded to -1 as far as
> I remember.

I thought that XSAVES didn't allocate space for parts of the state
that are in the init state. I guess I was wrong :)

So never mind, context switch should just need to WRPKRU the field at
the predetermined offset in fpstate for the new task.  And, if some
appropriate debug option is set, it should warn if TIF_FPU_UNLOADED is
clear for the new task.

I suspect that the whole patch should only be a couple hundred lines
of code.  And I think there are VM workloads where it would be a
*huge* win.

--Andy
