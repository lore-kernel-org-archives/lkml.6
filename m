Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929002082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929002082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeLAKC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:02:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42626 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLAKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:02:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so4135296qka.9;
        Fri, 30 Nov 2018 14:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+I9hnVYtCn+LqSI0d56UyMOxSmwEniJFghCNm332zs=;
        b=RBvwPvSNmQ7OybmfUvthSlg9h4+b6aq62IMs8gNYxQdEUJoZ706wrAWNmH1ZnCUzVm
         MXAeo687EwkekcqR9sRYwqc7cVk8ACspimWHDyUHsQTTbW9JLcynLy38bO2YcZfeis0A
         7rUwjrmqwSXsCMwsRmEe8nzOUZV8y+5FxOpCetZKvjYFPa7i0JcroUiF7zhaDgj8AAmB
         6HXoaCU/9JgQhNKrZqxGDTOBVZM8fJKYXg+dU/4Z05Jky4oghB0NnVyvqSk5GdC7k5xk
         /EZtf7w8MSBdtyFtr6y/p+4XUgKA4BsdXKPRstXbf89KOaFWm4VRXku0ywBiMIkkxvzb
         Z0pw==
X-Gm-Message-State: AA+aEWbJPlN69NHRGMZ5YxIoiD+zf3fSM84i2sGp9QDhQfzeqkmKlWB2
        pC+N8gMsqXdjNH+guzE2GjacOugRrxL3cIsizbk=
X-Google-Smtp-Source: AFSGD/VuSbq/xYyqfC+dFIiCQT9ldzxaUnQSmdfl7k54v2B2iqc85InZd6WK8ukjnDP4rH6tfPZX4SUPRBIwuy4nBAU=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr6873182qkf.330.1543618325188;
 Fri, 30 Nov 2018 14:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast>
In-Reply-To: <20181130224736.GA38485@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 23:51:48 +0100
Message-ID: <CAK8P3a0YGyKf_0wg_sNhN2z-zVvv1N1_Yc=+2AL=8FZT+CRLxQ@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
To:     Kees Cook <keescook@chromium.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:48 PM Kees Cook <keescook@chromium.org> wrote:
>
> Instead of running with interrupts disabled, use a semaphore. This should
> make it easier for backends that may need to sleep (e.g. EFI) when
> performing a write:
>
> |BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
> |in_atomic(): 1, irqs_disabled(): 1, pid: 2236, name: sig-xstate-bum
> |Preemption disabled at:
> |[<ffffffff99d60512>] pstore_dump+0x72/0x330
> |CPU: 26 PID: 2236 Comm: sig-xstate-bum Tainted: G      D           4.20.0-rc3 #45
> |Call Trace:
> | dump_stack+0x4f/0x6a
> | ___might_sleep.cold.91+0xd3/0xe4
> | __might_sleep+0x50/0x90
> | wait_for_completion+0x32/0x130
> | virt_efi_query_variable_info+0x14e/0x160
> | efi_query_variable_store+0x51/0x1a0
> | efivar_entry_set_safe+0xa3/0x1b0
> | efi_pstore_write+0x109/0x140
> | pstore_dump+0x11c/0x330
> | kmsg_dump+0xa4/0xd0
> | oops_exit+0x22/0x30
> ...
>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Fixes: 21b3ddd39fee ("efi: Don't use spinlocks for efi vars")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hmm, I've actually been working on a patch set recently to deprecate
all semaphores from the kernel and replace them with something
else as much as possible.

Why can't this be a mutex instead?

      Arnd
