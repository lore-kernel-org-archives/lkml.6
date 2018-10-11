Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9737C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE7320835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn9JxS+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE7320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJLEsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeJLEsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:48:02 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCBB82087D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 21:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539292738;
        bh=vzl9VntTyBrDRJTcWY5nq5kb+ei2A16HRd8uPb5bOQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bn9JxS+vH0nHuysVnLTNP1NShosStTIX9WYsU+7aLEKIgGm1imhCHydBYSYc28tof
         5CAUPG4twIaMnB16/K4/4suKhI+pMqe+QRtYFokAwyTfyK6lgak0Ids6sd6WbyClAB
         +GuB6ne6ULtT4OStjN7yr/f5/7S2Mq4Jh3QxP3UA=
Received: by mail-wr1-f49.google.com with SMTP id x12-v6so11201950wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 14:18:57 -0700 (PDT)
X-Gm-Message-State: ABuFfohOg4Sl5UaEGMNmJttqsPWyvYnzvYChoiEh6t7AJEKdcpRLeogx
        qOApDrzPdmN/JbA4vCvMzgdN2JGOlr4vJ/wIlaloqw==
X-Google-Smtp-Source: ACcGV63EyDhz0Dp4qcICazHuUmVJsgqKqDHgMjD/DpxQk1zsxREQvFMPJaH6II1U6I/r7y8jKnMrDot5C7W/oz24zP0=
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr3135084wrb.283.1539292736267;
 Thu, 11 Oct 2018 14:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-9-bigeasy@linutronix.de>
 <m1lg7474ps.fsf@dinechin.org>
In-Reply-To: <m1lg7474ps.fsf@dinechin.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Oct 2018 14:18:44 -0700
X-Gmail-Original-Message-ID: <CALCETrVPOv-7K0ihvSy-5bLJqpxA8D=8wJeZGzrP_=b7aDiAcg@mail.gmail.com>
Message-ID: <CALCETrVPOv-7K0ihvSy-5bLJqpxA8D=8wJeZGzrP_=b7aDiAcg@mail.gmail.com>
Subject: Re: [PATCH 08/11] x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
To:     christophe.de.dinechin@gmail.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:50 AM Christophe de Dinechin
<christophe.de.dinechin@gmail.com> wrote:
>
>
> Sebastian Andrzej Siewior writes:
>
> > From: Rik van Riel <riel@surriel.com>
> >
> > copy_fpstate_to_sigframe() has two callers and both invoke the function only if
> > fpu->initialized is set.
>
> One of the callers is in a different file.
> Not sure if that warrants some kind of check that
> fpu->initialized is set?

I still kind of think that fpu->initialized should be removed entirely
as part of this series.  Keeping unnecessary complication around in
the FPU code increaseds the scope for interesting bugs and makes
understanding the code considerably harder.
