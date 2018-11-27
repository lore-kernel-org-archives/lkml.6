Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB39C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01DE20851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LvTMQPpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01DE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeK1J2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:28:25 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40868 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeK1J2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:28:25 -0500
Received: by mail-yw1-f66.google.com with SMTP id r130so6699240ywg.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WW8bgpKHo05gPWwa1WmZMrRyx4HbC5t6/zYCxOKYWjU=;
        b=LvTMQPpgqsyYyAPPiHLWDGV5RTL4ir5J8VlwkfO1hECOvuW5mvyScnaMm4mFDJaDDs
         L3e1Tpt8KyqIgRwarytY3xoC/y1vq59QeTctm/HCKXAXhYwr0k58eOkDFMRwrmLiMXgh
         ibk92UYu7ntc/w2tsai6Wguvz1l603UZqTJx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WW8bgpKHo05gPWwa1WmZMrRyx4HbC5t6/zYCxOKYWjU=;
        b=Zf8ViZRrbkQL+LJ5Q+7xXUhO8syFeEVurwVmHpnyEzxsTWbzEdIXPuTTv8eKhCRgbZ
         SMnLmpGD65DalQVmayMBmCZGyMuQY6h6TfyKztojmGUWgAAoybIm9/tELv5D722gnFyA
         x4kX2NaOKWmc2mzgmIqkmvX2J5wiXgPVX5wCZjZkICkvz8nyhSwLSfojsRC0MDKQuutv
         vkDvlES9OajIm/gWaQNo7hDmCEH/iMPWCpOCMhb3Zz7pLrSrYZAm3y1xrJy9Ij/tr8in
         7vAyB/DXTdxFKAFNCwf7372T/GlgpYVuO45frDPVITOwXBmKVDpq5EvOTbO4CarzYWup
         FbEA==
X-Gm-Message-State: AGRZ1gLMf8Ao6RBIyF27NDLf6lLqymNS1qNDF3nvOqc0WDCpnPQ3rL/M
        HTYh1gctcyLdTMQv5w4TfPVPDEXFMl4=
X-Google-Smtp-Source: AJdET5eXcICQKI29Is86D3UcHmve3VenNaduxUAQwWly0DEQ4SWbMumdp/lFlC2yFsyfFaqGXd9oLg==
X-Received: by 2002:a81:ad49:: with SMTP id l9mr36205013ywk.260.1543357741839;
        Tue, 27 Nov 2018 14:29:01 -0800 (PST)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id q187sm1562112ywb.40.2018.11.27.14.28.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:29:00 -0800 (PST)
Received: by mail-yw1-f50.google.com with SMTP id h138-v6so8055909ywa.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:28:59 -0800 (PST)
X-Received: by 2002:a81:c446:: with SMTP id s6mr26549072ywj.237.1543357739468;
 Tue, 27 Nov 2018 14:28:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 14:28:58
 -0800 (PST)
In-Reply-To: <20181125041003.GA3258@altlinux.org>
References: <20181121165806.07da7c98@akathisia> <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
 <20181121235634.GA14146@altlinux.org> <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
 <20181122191504.GB27204@altlinux.org> <CALCETrXvXzRzoEqwEY_VZ7Vpt-sLwaF+rZPg+y_eG2xyzubXtw@mail.gmail.com>
 <20181123040139.GB2572@altlinux.org> <20181125041003.GA3258@altlinux.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 14:28:58 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJyMG2r09Hfi9G9159J-s5rne12OAvmRTqMz8AP-qVFfQ@mail.gmail.com>
Message-ID: <CAGXu5jJyMG2r09Hfi9G9159J-s5rne12OAvmRTqMz8AP-qVFfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
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

On Sat, Nov 24, 2018 at 8:10 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Fri, Nov 23, 2018 at 07:01:39AM +0300, Dmitry V. Levin wrote:
>> On Thu, Nov 22, 2018 at 04:19:10PM -0800, Andy Lutomirski wrote:
>> > On Thu, Nov 22, 2018 at 11:15 AM Dmitry V. Levin wrote:
>> > > On Thu, Nov 22, 2018 at 06:55:29AM -0800, Andy Lutomirski wrote:
>> > > > On Wed, Nov 21, 2018 at 3:56 PM Dmitry V. Levin wrote:
>> > > > > On Wed, Nov 21, 2018 at 02:56:57PM -0800, Andy Lutomirski wrote:
>> > > > > > Please cc linux-api@vger.kernel.org for future versions.
>> > > > > >
>> > > > > > On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova wrote:
>> > > > > > >
>> > > > > > > struct ptrace_syscall_info {
>> > > > > > >         __u8 op; /* 0 for entry, 1 for exit */
>> > > > > >
>> > > > > > Can you add proper defines, like:
>> > > > > >
>> > > > > > #define PTRACE_SYSCALL_ENTRY 0
>> > > > > > #define PTRACE_SYSCALL_EXIT 1
>> > > > > > #define PTRACE_SYSCALL_SECCOMP 2
>> > > > > >
>> > > > > > and make seccomp work from the start?  I'd rather we don't merge an
>> > > > > > implementation that doesn't work for seccomp and then have to rework
>> > > > > > it later.

Yes, please.

>> > > > >
>> > > > > What's the difference between PTRACE_EVENT_SECCOMP and syscall-entry-stop
>> > > > > with regards to PTRACE_GET_SYSCALL_INFO request?  At least they have the
>> > > > > same entry_info to return.
>> > > >
>> > > > I'm not sure there's any material difference.
>> > >
>> > > In that case we don't really need PTRACE_SYSCALL_SECCOMP: op field
>> > > describes the structure inside the union to use, not the ptrace stop.
>> >
>> > Unless we think the structures might diverge in the future.

Yes, I want to make sure we have a way to expand this, especially for
seccomp: we've come close a few times to adding new fields to struct
seccomp_data, for example.

>>
>> If these structures ever diverge, then a seccomp structure will be added
>> to the union, and a portable userspace code will likely look this way:
>>
>> #include <linux/ptrace.h>
>> ...
>> struct ptrace_syscall_info info;
>> long rc = ptrace(PTRACE_GET_SYSCALL_INFO, pid, (void *) sizeof(info), &info);
>> ...
>> switch (info.op) {
>>       case PTRACE_SYSCALL_INFO_ENTRY:
>>               /* handle info.entry */
>>       case PTRACE_SYSCALL_INFO_EXIT:
>>               /* handle info.exit */
>> #ifdef PTRACE_SYSCALL_INFO_SECCOMP
>>       case PTRACE_SYSCALL_INFO_SECCOMP:
>>               /* handle info.seccomp */
>> #endif
>>       default:
>>               /* handle unknown info.op */
>> }
>>
>> In other words, it would be better if PTRACE_SYSCALL_INFO_* selector
>> constants were introduced along with corresponding structures in the
>> union.
>
> However, the approach I suggested doesn't provide forward compatibility:
> if userspace is compiled with kernel headers that don't define
> PTRACE_SYSCALL_INFO_SECCOMP, it will break when the kernel
> starts to use PTRACE_SYSCALL_INFO_SECCOMP instead of
> PTRACE_SYSCALL_INFO_ENTRY for PTRACE_EVENT_SECCOMP support
> in PTRACE_GET_SYSCALL_INFO.
>
> The solution is to introduce PTRACE_SYSCALL_INFO_SECCOMP and struct
> ptrace_syscall_info.seccomp along with PTRACE_EVENT_SECCOMP support
> in PTRACE_GET_SYSCALL_INFO.  The initial revision of the seccomp
> structure could be made the same as the entry structure, or it can
> diverge from the beginning, e.g., by adding ret_data field containing
> SECCOMP_RET_DATA return value stored in ptrace_message, this would save
> ptracers an extra PTRACE_GETEVENTMSG call currently required to obtain it.

Yup, that'd be a nice addition.

-- 
Kees Cook
