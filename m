Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19CDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFFB20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFFB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dei.uc.pt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJLQxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:53:32 -0400
Received: from smtp.dei.uc.pt ([193.137.203.253]:60426 "EHLO smtp.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeJLQxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:53:32 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (user=sneves mech=PLAIN bits=0)
        by smtp.dei.uc.pt (8.15.2/8.15.2) with ESMTPSA id w9C9L1Et023524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:21:07 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.dei.uc.pt w9C9L1Et023524
Received: by mail-ed1-f53.google.com with SMTP id x31-v6so10846958edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:21:07 -0700 (PDT)
X-Gm-Message-State: ABuFfoh49TJs6Rd56p++gnyZa2vatwaiuRqnO3/L/Sw1IqsfgeJCUwZO
        dCfzBQYu+SAuT58qQSuDBEiC/G3Fiwvwn+6+RpQ=
X-Google-Smtp-Source: ACcGV62HPqByDX0nYOogBLQMoYGOlgjx/h/Gmbl0k+n2Igu+70VQWfyVcnJoQJRb8Rcb4H1o9+Eklc/Fn/QU3C6tnqE=
X-Received: by 2002:a17:906:e1ce:: with SMTP id gp14-v6mr6335446ejb.221.1539336061564;
 Fri, 12 Oct 2018 02:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com> <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
In-Reply-To: <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
From:   Samuel Neves <sneves@dei.uc.pt>
Date:   Fri, 12 Oct 2018 10:20:25 +0100
X-Gmail-Original-Message-ID: <CAEX_ruGcWOYuhF6Gtm0a9kh8JsUvZzRLxzi8Q982iiWA2ioYpg@mail.gmail.com>
Message-ID: <CAEX_ruGcWOYuhF6Gtm0a9kh8JsUvZzRLxzi8Q982iiWA2ioYpg@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Andy Lutomirski <luto@kernel.org>
Cc:     kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: w9C9L1Et023524
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-60.1, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, L_SMTP_AUTH -50.00)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 8:25 PM Andy Lutomirski <luto@kernel.org> wrote:
> What exactly is this trying to protect against?  And how many cycles
> should we expect L1D_FLUSH to take?

As far as I could measure, I got 1660 cycles per wrmsr 0x10b, 0x1 on a
Skylake chip, and 1220 cycles on a Skylake-SP.
