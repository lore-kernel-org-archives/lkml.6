Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817CDECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367582081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2VfHeAqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367582081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeKIECW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeKIECW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:02:22 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F2C2089F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Nov 2018 18:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541701537;
        bh=1btlQgstCpJizvq6kZHc76gmMfvapjxjFfB1YtKv9hc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2VfHeAqf4tFX+DYTLht0rE/yFHZSWTdDscN+eUuluGJQZWsVxLJImPu31/5CDLlJY
         Z5a7BKHEQl2U5UNa153jX14kxXDWNkGTdyhFgIe0dVr6pSKMy+uc/tL8w+6p4CP/qy
         NwBBwunfmBpETFlGkFeC5XcOajMQMEbEMzw4A7tk=
Received: by mail-wr1-f51.google.com with SMTP id k15-v6so19331151wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:25:36 -0800 (PST)
X-Gm-Message-State: AGRZ1gL7TKzZTQu1FBdELQDZ5SQKOGsDha2t0WyAqQkwxFB+nNg//USz
        eMN3ydud9wo1tHgaSbMiNSCjDOU07ejyz4uLaUsPyg==
X-Google-Smtp-Source: AJdET5do1Uf3kJUumJuaQnyEV+8v4EhWSLxxilj2b5xH5OQNhEhauVGSjkMI2hceJ2XuhXXw18Y0214DtJB8UGiScP0=
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr4882257wrc.131.1541701535293;
 Thu, 08 Nov 2018 10:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20181107194858.9380-1-bigeasy@linutronix.de> <20181107194858.9380-23-bigeasy@linutronix.de>
In-Reply-To: <20181107194858.9380-23-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 8 Nov 2018 10:25:24 -0800
X-Gmail-Original-Message-ID: <CALCETrXYTSsxYUmxb6FmvQrSaMPJ77jqgnfzG_7yRGxLUw3_QQ@mail.gmail.com>
Message-ID: <CALCETrXYTSsxYUmxb6FmvQrSaMPJ77jqgnfzG_7yRGxLUw3_QQ@mail.gmail.com>
Subject: Re: [PATCH 22/23] x86/fpu: Don't restore the FPU state directly from
 userland in __fpu__restore_sig()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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

On Wed, Nov 7, 2018 at 11:49 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> __fpu__restore_sig() restores the CPU's FPU state directly from
> userland. If we restore registers on return to userland then we can't
> load them directly from userland because a context switch/BH could
> destroy them.
>
> Restore the FPU registers after they have been copied from userland.
> __fpregs_changes_begin() ensures that they are not modified while beeing
> worked on. TIF_NEED_FPU_LOAD is clreared we want to keep our state, not
> the saved state.

I'm conceptually okay with this change, but what happens if the
registers that are copied into the kernel are garbage?  We used to
fail the restore and presumably kill the task.  What happens now?
