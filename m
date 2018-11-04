Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E36C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1332082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AGmK/EC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1332082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeKDKlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 05:41:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45888 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeKDKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 05:41:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so3728045lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QBk/iytyd3BrdzNGlS4xaETKPEGwFovSqylSEG7G9k=;
        b=AGmK/EC2iKEWMj0ar4266S1QOch1l/xbeqbzLQSfdFoAmNVoEdPIU1DRS30JNJdehV
         DJ1+GWmDFgeb5vMHvEEBWe9nECfAyc7vquLZL7r5zTixoyMM/zDYJrsDMe7kMlQG+QWc
         cHYwqaqvuDGf2OIzIKpAxYaQ0yt7Mt0YHnu54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QBk/iytyd3BrdzNGlS4xaETKPEGwFovSqylSEG7G9k=;
        b=jPZpV2JSidECnfJFBMzTYTOUvRrKS8ql6BxHqb87gT1Xwmx3FX5Zuff8HJ5c97paZE
         I/VFkEJAOMSvYvVLeuYc1cMg2pqZI85SLBrfUb5wPlIl1bCwZl1PqzmNgQ17zmNqhYLD
         4RfbdMGAmlvEjNqNQCsB0P8Ph8HuNQxbuVCJ8NS/gEPt8DLvjjCdT4qXP0E4I6blw3q0
         kHyw/G6MgudmzvoZKBEo0KgjeZx3w4CavrzHxBXazWJqMwopTtWE4YOzkYUz93eF2lYd
         l1NDeSmgNQzNojd+lnjaBqczGmv7pj8Dhqf9e0yID0ceP5nUE6IUOmwiVwJCEpVlAg/J
         OIUA==
X-Gm-Message-State: AGRZ1gL2YOPftpXzkFDO1PUeGXW2KnMRPcRma+RZyb45N34ZSg0UPyMY
        aWF5sXOvOIqZdlT3xZpTVCMYelUWYWo=
X-Google-Smtp-Source: AJdET5fFWZB9nnU3UZ2LkPLH2jAz2qNLmS826vxi88j4Oxq8f/7qfi7z6vQTDZHqGmbPpld4kKNnrg==
X-Received: by 2002:a19:9904:: with SMTP id b4mr9443649lfe.95.1541294875890;
        Sat, 03 Nov 2018 18:27:55 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j13-v6sm5993104ljh.42.2018.11.03.18.27.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 18:27:55 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u18so3728173lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:27:54 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr9175752lfj.16.1541294874361;
 Sat, 03 Nov 2018 18:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181103230947.GA95167@gmail.com>
In-Reply-To: <20181103230947.GA95167@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 18:27:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_U_2pKLTFqit=foRxSTnfpkTggCEaXJX=6gwmAqYivw@mail.gmail.com>
Message-ID: <CAHk-=wg_U_2pKLTFqit=foRxSTnfpkTggCEaXJX=6gwmAqYivw@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tglx@linutronix.de, bp@alien8.de,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 4:09 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> A number of fixes and some late updates:

Pulled,

             Linus
