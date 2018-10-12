Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80495C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5186D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5186D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dei.uc.pt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeJLWCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:02:07 -0400
Received: from smtp.dei.uc.pt ([193.137.203.253]:49786 "EHLO smtp.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeJLWCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:02:07 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (user=sneves mech=PLAIN bits=0)
        by smtp.dei.uc.pt (8.15.2/8.15.2) with ESMTPSA id w9CESceM010961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 15:28:43 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.dei.uc.pt w9CESceM010961
Received: by mail-ed1-f54.google.com with SMTP id c26-v6so11679617edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 07:28:43 -0700 (PDT)
X-Gm-Message-State: ABuFfoi92grEMV30vIlI8fj247zUGo1fiKJ3XTWmnwTMOAMnbXfkULg4
        hqW00gHmsAAl/h+eLT6cS0/njvffsDtl37Hphe4=
X-Google-Smtp-Source: ACcGV61Ft496CrOqU3/trjao5DSZ3CzW5Dj9Riis5GJL/BVu704DtgFquO81cRWsO5tvcwVMwTmTmR/A2+bfcA2MX08=
X-Received: by 2002:a50:9583:: with SMTP id w3-v6mr9437897eda.33.1539354517878;
 Fri, 12 Oct 2018 07:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
 <CAEX_ruGcWOYuhF6Gtm0a9kh8JsUvZzRLxzi8Q982iiWA2ioYpg@mail.gmail.com> <CAG48ez0aTJMREb1JL6SaT5rNLs6oUZVevj+BGrUzVEprZNFKOw@mail.gmail.com>
In-Reply-To: <CAG48ez0aTJMREb1JL6SaT5rNLs6oUZVevj+BGrUzVEprZNFKOw@mail.gmail.com>
From:   Samuel Neves <sneves@dei.uc.pt>
Date:   Fri, 12 Oct 2018 15:28:01 +0100
X-Gmail-Original-Message-ID: <CAEX_ruHf5hDTvL+4BNyL8HsTjKKU+fvAB4uKrszVVfpPen25Mw@mail.gmail.com>
Message-ID: <CAEX_ruHf5hDTvL+4BNyL8HsTjKKU+fvAB4uKrszVVfpPen25Mw@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: w9CESceM010961
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
        score=-60.1, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, L_SMTP_AUTH -50.00)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 2:26 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Oct 12, 2018 at 11:41 AM Samuel Neves <sneves@dei.uc.pt> wrote:
> >
> > On Thu, Oct 11, 2018 at 8:25 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > What exactly is this trying to protect against?  And how many cycles
> > > should we expect L1D_FLUSH to take?
> >
> > As far as I could measure, I got 1660 cycles per wrmsr 0x10b, 0x1 on a
> > Skylake chip, and 1220 cycles on a Skylake-SP.
>
> Is that with L1D mostly empty, with L1D mostly full with clean lines,
> or with L1D full of dirty lines that need to be written back?

Mostly empty, as this is flushing repeatedly without bothering to
refill L1d with anything.

On Skylake the (averaged) uops breakdown is something like

port 0: 255
port 1: 143
port 2: 176
port 3: 177
port 4: 524
port 5: 273
port 6: 616
port 7: 182

The number of port 4 dispatches is very close to the number of cache
lines, suggesting one write per line (with respective 176+177+182 port
{2, 3, 7} address generations).

Furthermore, I suspect it also clears L1i cache. For 2^20 wrmsr
executions, we have around 2^20 frontend_retired_l1i_miss events, but
a negligible amount of frontend_retired_l2_miss ones.
