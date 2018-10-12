Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB26BC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9989421480
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THzjVlxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9989421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJMB53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:57:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35826 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeJMB52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:57:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id 14so9250802oth.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGmx3Atq13x4FKEnBH9tw9ftM2J9cIvdsYS+LQlzga4=;
        b=THzjVlxt7VYPTyWSfgF4AI/+/OAft3oylnOWLauK4n5Q64VW0LD2bmNF9gQ5q7df7y
         7hhT1/iU1kKS3Wlxu7v7k72qYjbboH9VKVFw0+a/D5kVMRHKs/2sfmDfPXyPCvv7dcP7
         i86aHz1uqWsDkEM1QKABIAZ296bY3TB94v45jbal6LGQEqp8ElKKty0wEsh+M0+7ZsK8
         fl9UL3NlEaa25ruxqfQnySgiHITaSphufMq/zCMkZdcP4h7JqLYovfeQ2xho5wtB06P0
         ypdZUOuW7RpCod38pq59qS/19YpSIiGH2nzRWgNQAPkrfSOOA1NXVddNISHn3i8J+Gcy
         XNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGmx3Atq13x4FKEnBH9tw9ftM2J9cIvdsYS+LQlzga4=;
        b=qXT1HhCmMacBilPnXeyE6AHBcyQ3DFPc8HKU48/T5mHdXfLeDdoegG8G7MZwlgZBsR
         0L8ghjBoeBlqeDcVD8swISoloh0uYb+9kqtivjPn4A78sU+5Vhw2K82cEF95BKQa/5O8
         7fJsMFlaQsODuKnR2pP26iLmV2F81y/1cwe1wS5fATXC2+u6osuzZzdPJOUdm0tLFYeq
         aorRRZ26VL377jcgL4g6MzVdkT6oIjOTIw0P8G+NTuf1yxXcyKn0U5NVlIBxsFEMj0AZ
         zaARJiX54Atvb5VjboCg4aqa0iwdtK3dCEUHyXcV6AWRAHwsOiGTUFfkdFdCSSKDzkbl
         TL/g==
X-Gm-Message-State: ABuFfojb9UFWN6DfT9Fg4d7rZJxPHrnE8k8lWUPkUpQ6z9TL+BzQ4CtI
        jt1duRAhqHR9l3+HfkN9djvdyD2hRpSASV5yDfg78g==
X-Google-Smtp-Source: ACcGV60N79wPaPgmvCjBXoplMwoh/HYK58FEWb/tt3Uj+enjF3u61fKXTwLtMPvlKoWY2BMIt4rnX99KRcsBMu3ms0Q=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr4676406otf.242.1539368620937;
 Fri, 12 Oct 2018 11:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
In-Reply-To: <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 20:23:15 +0200
Message-ID: <CAG48ez0pPX7XNqSj4dVG1s+PaDBCh4ar5xw1WcY1sLBPV_QAzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
To:     rick.p.edgecombe@intel.com
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, jeyu@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>, kristen@linux.intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        deneen.t.dock@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 2:35 AM Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
> <rick.p.edgecombe@intel.com> wrote:
> > This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> > module space a user can use. The intention is to be able to limit module space
> > allocations that may come from un-privlidged users inserting e/BPF filters.
>
> Note that in some configurations (iirc e.g. the default Ubuntu
> config), normal users can use the subuid mechanism (the /etc/subuid
> config file and the /usr/bin/newuidmap setuid helper) to gain access
> to 65536 UIDs, which means that in such a configuration,
> RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
> applies to RLIMIT_MEMLOCK.)

Actually, I may have misremembered, perhaps it's not installed by
default - I just checked in a Ubuntu VM, and the newuidmap helper from
the uidmap package wasn't installed.
