Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1059CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4619C206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2wPt5bU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeLNOeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:34:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36397 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbeLNOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:34:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so4701997oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMgXFm/rRO6gaes71rbchB5oOTyNj1IYboe7Uczq2eU=;
        b=V2wPt5bUwXqnvzs31xGj2MrPI+XxhIUzteHmi6Oqb60Y0tTQY4Cbzxj+KVvzFxkklM
         eNNrxoWQYUYRuJw5i3zPl8KJfiJ1oYW7CFbIEMcdd5n7rQ6odxGaL6eVnULBVaS0hVp1
         wzqwncglY2NjV+LYVflwHi2Fcf7tONEDeNnDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMgXFm/rRO6gaes71rbchB5oOTyNj1IYboe7Uczq2eU=;
        b=JpCzVuOq6ogdZpoinNQmNNv06d1g0L0OTbEDMKKyTL6g/14JT/CQsp/kh7YjN0T62T
         1Tzo1XF0pYuPSMF2jdfOoLRI8j4qZ15ylk9HFi9otn5rRbvstiNMaN6F0FxLLL90CvAB
         78qGEzJMXQf9hEH8JkrF/0ROLoaYD0u6zYS712Lxs4b0fNuhvGj3YWOt96tAiLnCbIvk
         k/b4yRoevNpXYyRE1dsa7uYCxq9vuBOMuY8BBMCKH+jb9rRBU8urPIlBNtbqEKOi2tFf
         CgIOZRXeOjLD5ZmcRaxJIHRkbdabnMzBMu1gbObHOtFtBFvBIur8hV4NLg1DEBAdM6oK
         wppQ==
X-Gm-Message-State: AA+aEWaYI+qr0gvL7XngLgXZ3PiMWCLA1Q2JT0ZxtH0TTEY8aZVRL9Sd
        ndWqKm480sMGpC6OnaQKWreZ3xJTbEXZ07HgzHOPbA==
X-Google-Smtp-Source: AFSGD/VEtBNKjE0LtLP8dvRnqOk+rnG/1YhJtF32Sp5qGNQxxKCTyYCTDd7v15itBfj8DgVQqyyEC9U658f38RS9lxM=
X-Received: by 2002:aca:bcc6:: with SMTP id m189mr1951162oif.337.1544798045123;
 Fri, 14 Dec 2018 06:34:05 -0800 (PST)
MIME-Version: 1.0
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com> <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
In-Reply-To: <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 14 Dec 2018 14:33:53 +0000
Message-ID: <CAFEAcA-ajJ_W0FtC00aEiG=wGgbbU_8OEt+B+B87647gTsSMvQ@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To:     James Morse <james.morse@arm.com>
Cc:     gengdongjiu <gengdongjiu@huawei.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 at 13:56, James Morse <james.morse@arm.com> wrote:
>
> Hi Dongjiu Geng,
>
> On 14/12/2018 10:15, Dongjiu Geng wrote:
> > When user space do memory recovery, it will check whether KVM and
> > guest support the error recovery, only when both of them support,
> > user space will do the error recovery. This patch exports this
> > capability of KVM to user space.
>
> I can understand user-space only wanting to do the work if host and guest
> support the feature. But 'error recovery' isn't a KVM feature, its a Linux
> kernel feature.
>
> KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying to
> map a page at stage2 that the kernel-mm code refuses this because its poisoned.
> (e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)
>
> This is exactly the same as happens to a normal user-space process.
>
> I think you really want to know if the host kernel was built with
> CONFIG_MEMORY_FAILURE.

Does userspace need to care about that? Presumably if the host kernel
wasn't built with that support then it will simply never deliver
any memory failure events to QEMU, which is fine.

The point I was trying to make in the email Dongjiu references
(https://patchwork.codeaurora.org/patch/652261/) is simply that
"QEMU gets memory-failure notifications from the host kernel"
does not imply "the guest is prepared to receive memory
failure notifications", and so the code path which handles
the SIGBUS must do some kind of check for whether the guest
CPU is a type which expects them and that the board code
set up the ACPI tables that it wants to fill in.

thanks
-- PMM
