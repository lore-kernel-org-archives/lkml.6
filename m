Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A38C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CA320869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCdlV4n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CA320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeKSI6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:58:04 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:43816 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKSI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:58:04 -0500
Received: by mail-lf1-f45.google.com with SMTP id u18so19970524lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 14:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtDBSvKsmwZoI9fNBZ6nmjP5zLoW8A9N9LvX0myuboI=;
        b=DCdlV4n/Lg97IQzaUw+jLfv+0TxE34LYEsxkjeYj7Htq7F2uMOQ6cpYRAuC2/LiGsr
         KLocEmZKpEZP1QDzIBV8ApLXOMNdX0RCvKFOAQixQgcKyQQe8A/6x66dAlscG3jIkEJp
         B8lz/Awp8++GRu6d7hv4tyj5dvgtdbhi25dz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtDBSvKsmwZoI9fNBZ6nmjP5zLoW8A9N9LvX0myuboI=;
        b=KCCMrAzV/7cFQ1/jFUyF3oIe3N3/ZfY2QBHYzyFIx51Y5QTqIzTLejZgqPvattmc8w
         gjbOzAstV4wExYzPjJtpIBrdTcm0IEgXEsX5gl6qzyTpYVXefIk+N4qqSvShHIbfAP6z
         NMrQmvvvLlYbEQdpTbHzblqWLYsLR6yK4FvKFvXrKguk1q915bw8FYt8kSvGIbcY/f5Y
         zh3tSIfzzzTg+r8QBKyRxf3kSrTxIOVehjbMjFIA0+5qP4ctPQsqiD+htXLu3J8FIqa8
         dJ1Svw5q6tmLql2HymdJOw5iFtEZ687RcVXpdFsWt9g9xKjhwnJzbvTuXXzlKCs4BooH
         QCWA==
X-Gm-Message-State: AGRZ1gIWOhtB7lR/sZ00hmty5BJ4W3tzMzGbzSgGSaT4mfXCUCTRdxRU
        J/AiBGjrJwC1O4LYY3KRNHDOYUflQzA=
X-Google-Smtp-Source: AJdET5cGS2Busovs0yh/ZtSkMQkLLvogWiE3B8H6rhcdupHLp8F7cf6j/RrRQ5MZyqD0UDSPH6J0aA==
X-Received: by 2002:a19:f89:: with SMTP id 9mr9242603lfp.10.1542580587805;
        Sun, 18 Nov 2018 14:36:27 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q30sm5622660lfi.94.2018.11.18.14.36.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 14:36:26 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id t9-v6so24525108ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 14:36:26 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr11477346ljk.80.1542580585702;
 Sun, 18 Nov 2018 14:36:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
 <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm> <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
 <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Nov 2018 14:36:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjo9==zLdUuZkCgMx1YBUTpZkD3NnLBPDf7Fw388z5Y6g@mail.gmail.com>
Message-ID: <CAHk-=wjo9==zLdUuZkCgMx1YBUTpZkD3NnLBPDf7Fw388z5Y6g@mail.gmail.com>
Subject: Re: STIBP by default.. Revert?
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 2:17 PM Jiri Kosina <jikos@kernel.org> wrote:
> Which gets us back to Tim's fixup patch. Do you still prefer the revert,
> given the existence of that?

I don't think the code needs to be reverted, but the *behavior* of
just unconditionally enabling STIBP needs to be reverted.

Because it was clearly way more expensive than people were told.

                Linus
