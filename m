Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D724218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546285880;
	bh=NpKSN3UYCtIFR1ayOSb/VFuDfTDRzzKzhjXr0i/9Icg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mMukqPra18tjrdamG3IiyGSRfa5PLiTJX/HnSc7K9dpA9ubrQlsw+jlJ8M136cuI0
	 Gm7XWW5IxWkBh68NNWmTT+MpJVpd9jb3G4EieZzLxcZ7nbKL1DpjyiMHyjfhPKVI8b
	 pJxbl30vvTkVcMVPd6vrddHbeHTxpkASEx5MTE34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbeLaTvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeLaTvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:51:18 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B70218AD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 19:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546285877;
        bh=NpKSN3UYCtIFR1ayOSb/VFuDfTDRzzKzhjXr0i/9Icg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rMDNfPjyXbvseavzqw2+M+NHgl9KsYRdTuEL7xrZpV1thFeetycmgDV2I74NrWP5q
         UqS3VLwXtda/ibkQ4tLyWs2X1q5C5zP3ojQX0H5vknfnKVhQFsLonn1URL3OGDVO0u
         geJkXqmFmAbMcAHOWxbIRz6H4y+q1QMJtsrNf6IU=
Received: by mail-wm1-f47.google.com with SMTP id t200so12939544wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 11:51:17 -0800 (PST)
X-Gm-Message-State: AJcUukcuX3bIAf4NxRaV5LT+1j/3lxIy7e70ts5tlqhxMSfcroIAoySE
        zSVoy1WudLQXXdXVnx/CFwTesbVsnTuGYv8Q9gBnRg==
X-Google-Smtp-Source: AFSGD/WoIg51LqLPkoTfZr0VvJK8m01eZrKyvTkTZxqxXKgpnQTu6uD/IKngbSGtrOfk3Oq7+cUfT5d2MME7Pvg8R2g=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr30723613wme.108.1546285876094;
 Mon, 31 Dec 2018 11:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20181231072112.21051-1-namit@vmware.com>
In-Reply-To: <20181231072112.21051-1-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 31 Dec 2018 11:51:04 -0800
X-Gmail-Original-Message-ID: <CALCETrW_52zEv1kHa7AdhF4PUGvyX4VyHqig1bFAJM_3VAXn=A@mail.gmail.com>
Message-ID: <CALCETrW_52zEv1kHa7AdhF4PUGvyX4VyHqig1bFAJM_3VAXn=A@mail.gmail.com>
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 11:20 PM Nadav Amit <namit@vmware.com> wrote:
>
> This is a revised version of optpolines (formerly named retpolines) for
> dynamic indirect branch promotion in order to reduce retpoline overheads
> [1].

Some of your changelogs still call them "relpolines".

I have a crazy suggestion: maybe don't give them a cute name at all?
Where it's actually necessary to name them (like in a config option),
use a description like CONFIG_DYNAMIC_DEVIRTUALIZATION or
CONFIG_PATCH_INDIRECT_CALLS or something.

--Andy
