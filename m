Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D084C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1983208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSV5mbkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1983208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeJBEHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:07:53 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38546 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:07:53 -0400
Received: by mail-wr1-f53.google.com with SMTP id a13-v6so4856214wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=apf9odFJIcquUiyujhj+s1WiX7a9jwhLCZLxde9a3kI=;
        b=MSV5mbkxs1C2ZJt+DdRG/NQiUPKXgySYv6I+tYR7IXxqt/VVTUMFpkwNfuDRu6Xy88
         fzl0iC5RhORFQHnYvHQNMtxwCs+/u6jEk5LR0/kY1K3f6RK0dNvFgI3fKEAj2Uyd4l8n
         R7jLi0zyjK1qguWk4VNo1D2OQj4notr1iOULg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=apf9odFJIcquUiyujhj+s1WiX7a9jwhLCZLxde9a3kI=;
        b=VwxpUpFZHheROStGHwZBGXLrdGK+X1Tg0UF2Z8KUR+3TDkgZmbb2OSnlkaV5qrpyKo
         vXtoQc79z8GNpIYZM1iBS3elgI2jdWCXmfyrxe5aLjTXtjxNIIUVCgQ0oEtZXGTKurg7
         2PQ2o/siwh4VC3Y7qBisBqLqE/Gwc+qEY04Hr3nxw2dWw8WBCXGoXuQghiVFVWXMu/4t
         anVeFxLfRKOqozILjhvJ/0VvdvSgjpw4tMC5WMscSjOs01UHCm3wjwJw6DVhGNWAq1HY
         Nbg50qIpaspT9sAt5HjngSybt0832t1RWsw/+SDZwHIhpvKSZ1OflmWI1gMyKQSIQQ8s
         3elA==
X-Gm-Message-State: ABuFfohnGEACKtNdDoiydPg5RVBh3qlcZXrhVQAhMHe/yGhwyEuBZ/DO
        7Ij/X69E8QhoxF2gmsjhP4m78hyzNEpcP/wq+CRx+Q==
X-Google-Smtp-Source: ACcGV624q0tN/ds5FmxA+extWaTu5LsepcIFu27//q8b12E7L3V9j5aqODhZ6Nra4DdSLW1OWkcJPkpaWWOYauGo174=
X-Received: by 2002:adf:a1dd:: with SMTP id v29-v6mr8129732wrv.50.1538429285244;
 Mon, 01 Oct 2018 14:28:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 14:28:04 -0700 (PDT)
In-Reply-To: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
References: <20181001175845.168430-1-salyzyn@android.com> <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 1 Oct 2018 14:28:04 -0700
Message-ID: <CALAqxLVGx_GhqHZbPoVExOehCD8f5s4LfXZx5DTvSuiErCCa3A@mail.gmail.com>
Subject: Re: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 1:44 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> On 10/01/2018 11:49 AM, John Stultz wrote:
>> It seems the patchset is already somewhat broken up into separate
>> sets, so I might recommend picking just one area and focus on
>> upstreaming that first. Maybe the in-arch cleanups for arm and then
>> arm64 and then maybe do the move to lib?
>
>
> They are in set-order, The first 12 can be taken one at a time to modernize
> arm so that it is up-to-date with the assembler code for arm64. More or less
> the order you just outlined.
>
> TahDah :-)

Sorry, I appreciate the background. I know this has been something
you've been pushing for quite some time, but it also seems to be
somewhat sporadic, and that makes it hard to keep track of the
narrative.

I'm unfortunately not the right person to queue the arm/arm64 changes,
but let me know if I can help with the generic bits.

thanks
-john
