Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeCBUSl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932720AbeCBUSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:18:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244F921783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELs9TxIkxDsZrZHgWyOqvircS5rcC8f5pJn6ufQrPq+DIrCubqVWpSmRAoj5RQLIanL/sZeniO0YCL56xT/3bmg=
MIME-Version: 1.0
In-Reply-To: <20180302105503.24428-2-vkuznets@redhat.com>
References: <20180302105503.24428-1-vkuznets@redhat.com> <20180302105503.24428-2-vkuznets@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 2 Mar 2018 20:18:18 +0000
X-Gmail-Original-Message-ID: <CALCETrX0CB_+QvDH3B8fYdH+ekRRX-i=jZU7zQ8qYbGzDrM-uQ@mail.gmail.com>
Message-ID: <CALCETrX0CB_+QvDH3B8fYdH+ekRRX-i=jZU7zQ8qYbGzDrM-uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:55 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
> the context is pretty well defined
>

True.

> and MSR_FS_BASE should always be
> equal to current->thread.fsbase.

Not true.  current->thread.fsbase is almost entirely undefined in this
context.  What you *could* do is export save_fsgs() and call it first.
When FSGSBASE support lands (which will happen eventually!), the code
in your patch will be completely wrong.

Admittedly, your patch isn't 100% bogus, but the reason is subtle and
you need lots of comments there *and* in save_fsgs().
