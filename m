Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD4EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7ED208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfp0yIJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7ED208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeGMTQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731261AbeGMTQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:16:00 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E6A208E2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531508406;
        bh=wCj4E/GRmkGhDP2XocWWGrkQj7s61gwkL4GRxxfn1Dc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Dfp0yIJaVS+rbrY8+1k/vFGBki5dYddRmoT88nEqSVw6bMmGJAQlxHE7Fg1c+isVA
         YIkDzpfi0hIMSY1k1Dy9kTJuaBWxsgL6BQvgCi2v5ZFJWJawgrR00T0XHCR2iQjTpV
         eeZcKfKl9t5xUylhXpSORdVYAeBpX4WtV6E6wAuE=
Received: by mail-wr1-f44.google.com with SMTP id b15-v6so26105781wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:00:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlG0CI3/O/W/RzD100phIu+r9LrNc4Izpb8KRE6Y5CycpTgBUXd2
        55t7fT/TXnbnKz2j834DJvWocHsC+W8rFyHxYy0bHA==
X-Google-Smtp-Source: AAOMgpfWFqGYZwlC17CfBB5LJncGJiknZtsAT+glCSdzMDUscy2omCNMrp0yLfIVaTDgTx5bo9HLoi3VL1/qRG9rxqE=
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr5628140wri.199.1531508404809;
 Fri, 13 Jul 2018 12:00:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 11:59:44
 -0700 (PDT)
In-Reply-To: <1531308586-29340-39-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-39-git-send-email-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Jul 2018 11:59:44 -0700
X-Gmail-Original-Message-ID: <CALCETrUTMwwKW6b3dubyC62Rk-_BTQN1zjFOYuLvS13EQ80p9A@mail.gmail.com>
Message-ID: <CALCETrUTMwwKW6b3dubyC62Rk-_BTQN1zjFOYuLvS13EQ80p9A@mail.gmail.com>
Subject: Re: [PATCH 38/39] x86/mm/pti: Add Warning when booting on a PCID
 capable CPU
To:     Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>
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
        Jiri Kosina <jkosina@suse.cz>,
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
> Warn the user in case the performance can be significantly
> improved by switching to a 64-bit kernel.

...

> +#ifdef CONFIG_X86_32
> +       if (boot_cpu_has(X86_FEATURE_PCID)) {

I'm a bit confused. Wouldn't the setup_clear_cpu_cap() call in
early_identify_cpu() prevent this from working?

Boris, do we have a straightforward way to ask "does the CPU advertise
this feature in CPUID regardless of whether we have it enabled right
now"?

--Andy
