Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3455C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B43020831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCI3mcv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B43020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405673AbeKWBf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388992AbeKWBf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:35:26 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B7320824
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542898543;
        bh=Mt8CSRGr88p5g1+8PO5LBDynX39LxAaEk0DyOXdk0gk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PCI3mcv7f7+ddzePXUPWGfMPEcNjN7BdLc5B5nKkCs6T0BXL5ztChAE+C718SFUEm
         Ww48tBOHoghqGKjDULyNz5gcu4UxilblZw6g/IbVhPfcCXP+9AOS5LjDZV0Um5wxvf
         Q2egpAWUsEa5Z7S0gMGT1qljcXLVl00eI0Dp6N8Y=
Received: by mail-wr1-f50.google.com with SMTP id j10so9540896wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:55:43 -0800 (PST)
X-Gm-Message-State: AA+aEWYyi1yjmw8eVzm5Hm6x9rJA9uhuOo0eFgL1CZK08ngE6bm6YUB4
        e7H+dow8tEncCVazL/cE40E1iDUsm0HhGN67bbwCww==
X-Google-Smtp-Source: AFSGD/WkgYduilHO5MmZqtORQ+NJZlp+KKXtQg31SFhnuXBYUiYlwtgzARc9sCi9YVRO/v5XGVhWcvTgRdm/7+pvwRY=
X-Received: by 2002:a5d:5541:: with SMTP id g1mr10378526wrw.330.1542898541768;
 Thu, 22 Nov 2018 06:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20181121165806.07da7c98@akathisia> <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
 <20181121235634.GA14146@altlinux.org>
In-Reply-To: <20181121235634.GA14146@altlinux.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 06:55:29 -0800
X-Gmail-Original-Message-ID: <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
Message-ID: <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        strace-devel@lists.strace.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 3:56 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On Wed, Nov 21, 2018 at 02:56:57PM -0800, Andy Lutomirski wrote:
> > Please cc linux-api@vger.kernel.org for future versions.
> >
> > On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova wrote:
> > >
> > > struct ptrace_syscall_info {
> > >         __u8 op; /* 0 for entry, 1 for exit */
> >
> > Can you add proper defines, like:
> >
> > #define PTRACE_SYSCALL_ENTRY 0
> > #define PTRACE_SYSCALL_EXIT 1
> > #define PTRACE_SYSCALL_SECCOMP 2
> >
> > and make seccomp work from the start?  I'd rather we don't merge an
> > implementation that doesn't work for seccomp and then have to rework
> > it later.
>
> What's the difference between PTRACE_EVENT_SECCOMP and syscall-entry-stop
> with regards to PTRACE_GET_SYSCALL_INFO request?  At least they have the
> same entry_info to return.

I'm not sure there's any material difference.

>
> As long as implementation (ab)uses ptrace_message to tell one kind of stop
> from another, it can distinguish syscall-entry-stop and syscall-exit-stop
> from each other and from many other kinds of stops, but it cannot
> distinguish PTRACE_EVENT_SECCOMP from e.g. PTRACE_EVENT_EXIT.

Hmm.  PTRACE_GET_SYSCALL_INFO should fail for PTRACE_EVENT_EXIT, I think.

>
> > >         __u8 __pad0[7];
> > >         union {
> > >                 struct {
> > >                         __s32 nr;
> >
> > __u64 please.  Syscall numbers are, as a practical matter, 64 bits.
> > Admittedly, the actual effects of setting the high bits are unclear,
> > and seccomp has issues with it, but let's not perpetuate the problem.
>
> I agree.  Although the implementation uses syscall_get_nr()
> which returns int, this could potentially be fixed in the future.

Agreed.  Although if we ever start using those high bits, things will
get confusing.

>
> > >                         __u32 arch;
> > >                         __u64 instruction_pointer;
> > >                         __u64 args[6];
> > >                 } entry_info;
> > >                 struct {
> > >                         __s64 rval;
> > >                         __u8 is_error;
> > >                         __u8 __pad1[7];
> > >                 } exit_info;
> > >         };
> > > };
> >
> > Should seccomp events use entry_info or should they just literally
> > supply seccomp_data?
>
> It certainly can use entry_info.
> I'd prefer to avoid using in uapi/linux/ptrace.h those types
> that are defined in uapi/linux/seccomp.h.

Makes sense to me.  Also, it's possible in principle to extend
seccomp_data with other fields that are only generated if they're
read, so passing struct seccomp_data to userspace as a struct may be
the wrong thing to do.
