Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C30ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686F42087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcB4HrdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686F42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeGMRoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbeGMRoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:44:46 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C6E0214D5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531502952;
        bh=ZszZlBHTPABHo5NkbIkNv+m8IAV9wr+lL8FO08FuVdA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jcB4HrdCDaSyeKhmdBQUqRaqTCCfYSUcM0LVsVAiAZuKXG9YTBfFFmcaWRfLp3znt
         JNSdz1A0SE/KmThtE4DIxCbrAx+uskdBDfRQggYUBpSpojOlMWQ8KYiwJitDXQanq4
         Pa1wGH0nT9T2jCuAXoCL856MgPcmQt1fPdEGxj4w=
Received: by mail-wm0-f51.google.com with SMTP id s14-v6so10142259wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:29:12 -0700 (PDT)
X-Gm-Message-State: AOUpUlGiUNiOZlByoPSiejOvnwZmEIzqWwwIKoAMNFOhFfeHbZKMB21Y
        p1A6Kvo3hsax3W1qjGHuFwiB84ibA8iHLgOBzSlklQ==
X-Google-Smtp-Source: AAOMgpcNvtDdwIlkOibWEkT/DP6ODVVB+Xfo6ZzVXhY+gWkf3z1ifl2AriyRxo9UvyNeDwZeKbyMy/zK7nC2rSwUAFI=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr4230224wmd.144.1531502950776;
 Fri, 13 Jul 2018 10:29:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:28:50
 -0700 (PDT)
In-Reply-To: <1531308586-29340-40-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-40-git-send-email-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Jul 2018 10:28:50 -0700
X-Gmail-Original-Message-ID: <CALCETrUw5DTnPtDK5TUNv4z50rrmcxwPA-KqtBHcWRcazJXy6Q@mail.gmail.com>
Message-ID: <CALCETrUw5DTnPtDK5TUNv4z50rrmcxwPA-KqtBHcWRcazJXy6Q@mail.gmail.com>
Subject: Re: [PATCH 39/39] x86/entry/32: Add debug code to check entry/exit cr3
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
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Add a config option that enabled code to check that we enter
> and leave the kernel with the correct cr3. This is needed
> because we have no NX protection of user-addresses in the
> kernel-cr3 on x86-32 and wouldn't notice that type of bug
> otherwise.
>

I like this, but could you make it just use CONFIG_DEBUG_ENTRY?

--Andy
