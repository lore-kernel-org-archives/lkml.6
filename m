Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82916ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3256820850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v3s23Plf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3256820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbeGTR41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731939AbeGTR41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:56:27 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5241E20858
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532106436;
        bh=+pX2XRouS9SwWpu4ilvc/t4Fjx4URm7cKVPnPh2z8/8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=v3s23Plf8n3vgWfginoABK+/I3Yrtf1sFncDddl+rpMVgiS9oNRKYoBfSjhj5exje
         wP+nau5Dqjffi530+TxgOrEQP5kL2t5b6V/+2gj6hicy9Msosx4GDrlMAtPCKw3pgg
         5dn7IyvNxxoMIdXbBtZ66MoEIkLJAVYR99B5Auf4=
Received: by mail-wr1-f44.google.com with SMTP id a3-v6so11957451wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:07:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlGG4/2IO+KJWs4BDaQ2nx6zlvQMpMcdDXa6yx+f3xsn68+LXUQj
        y8+RHcNOfiGpCdV2RIQKCAZF4eGv5A07Y3GjXwbHAQ==
X-Google-Smtp-Source: AAOMgpfu3Rr5xqpXhloknaXApkZII0SwQYeBOsEoqwadHqsdA7s6DnJz7jwBnfuwAZoy/gvvY+yJt4c/W/xtUtUwSYM=
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr1984651wrs.171.1532106434752;
 Fri, 20 Jul 2018 10:07:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 10:06:54
 -0700 (PDT)
In-Reply-To: <1532103744-31902-2-git-send-email-joro@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org> <1532103744-31902-2-git-send-email-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Jul 2018 10:06:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
Message-ID: <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in all page-tables
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 20, 2018, at 6:22 AM, Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The ring-buffer is accessed in the NMI handler, so we better
> avoid faulting on it. Sync the vmalloc range with all
> page-tables in system to make sure everyone has it mapped.
>
> This fixes a WARN_ON_ONCE() that can be triggered with PTI
> enabled on x86-32:
>
>    WARNING: CPU: 4 PID: 0 at arch/x86/mm/fault.c:320 vmalloc_fault+0x220/0x230
>
> This triggers because with PTI enabled on an PAE kernel the
> PMDs are no longer shared between the page-tables, so the
> vmalloc changes do not propagate automatically.

It seems like it would be much more robust to fix the vmalloc_fault()
code instead.
