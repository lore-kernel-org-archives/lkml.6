Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938FB206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLrVmaNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938FB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbeKVJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390220AbeKVJdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:33:38 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5D420C01
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542841031;
        bh=rMSKPt/SYVaxJeKa+ZPcsP7P6nUdKAtiiF7JStebEOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wLrVmaNgiMfk1A9utYCp2clvnZmNOAfZzQDl8cqhirefuf+xlIq3gnpSTJ58pONRe
         DYvoDJC3JNWPRHmS4sv8NTMMTFt8N3wJxwVVP/CzLWsupucI7Reghwlkq/q7cAj2co
         emWa6rbYT3AixR7TbXiTvXd8QMd2t8Yz2BpYK1FI=
Received: by mail-wm1-f47.google.com with SMTP id r11-v6so7076297wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:57:11 -0800 (PST)
X-Gm-Message-State: AA+aEWbfnVXCRgeBa2SjGxFTx4FtjITkO9mw2fo4PYpPmNNl8lFqM9i+
        V6eEAQ04EBtnbg5sAhYKKVOfp5U0SYcToqFiEqPh1A==
X-Google-Smtp-Source: AJdET5fHgCvdeJqZn1R/hmpuSFocyxgqzIxbykTGYJ8g0jDg9MyihGJcXhVs6Txa/3viggEX2TtHHypxchtrE0nbQqs=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr7045722wmf.32.1542841029636;
 Wed, 21 Nov 2018 14:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20181121165806.07da7c98@akathisia>
In-Reply-To: <20181121165806.07da7c98@akathisia>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 21 Nov 2018 14:56:57 -0800
X-Gmail-Original-Message-ID: <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
Message-ID: <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
To:     Elvira Khabirova <lineprinter@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        strace-devel@lists.strace.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc linux-api@vger.kernel.org for future versions.

On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova
<lineprinter@altlinux.org> wrote:
>
> struct ptrace_syscall_info {
>         __u8 op; /* 0 for entry, 1 for exit */

Can you add proper defines, like:

#define PTRACE_SYSCALL_ENTRY 0
#define PTRACE_SYSCALL_EXIT 1
#define PTRACE_SYSCALL_SECCOMP 2

and make seccomp work from the start?  I'd rather we don't merge an
implementation that doesn't work for seccomp and then have to rework
it later.

>         __u8 __pad0[7];
>         union {
>                 struct {
>                         __s32 nr;

__u64 please.  Syscall numbers are, as a practical matter, 64 bits.
Admittedly, the actual effects of setting the high bits are unclear,
and seccomp has issues with it, but let's not perpetuate the problem.

>                         __u32 arch;
>                         __u64 instruction_pointer;
>                         __u64 args[6];
>                 } entry_info;
>                 struct {
>                         __s64 rval;
>                         __u8 is_error;
>                         __u8 __pad1[7];
>                 } exit_info;
>         };
> };

Should seccomp events use entry_info or should they just literally
supply seccomp_data?
