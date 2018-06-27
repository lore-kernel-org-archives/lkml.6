Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FBC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5253D26024
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GnQK6e15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5253D26024
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934800AbeF0P2B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:28:01 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35917 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbeF0P17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:27:59 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so2283290iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1LysgFN8qqPxFj2PLP3wSy2eljCDbnOaFtmEqHP3e0=;
        b=GnQK6e15oFaKehnN5NmDbOu3bBQ9Z8dTtuHFl2iX2QRSSkWs5kVdBsEIb5acwEgiA0
         ELQ9FlDjORUK39t7KbZSCWjL8hS9Lsf5jFSfJ9fmTq92uZAb3iXsNkdpzYZNyDrtq+Fz
         DmB/9TBUlLZNFMcwB6R78AWwNubuF+gB7mn7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1LysgFN8qqPxFj2PLP3wSy2eljCDbnOaFtmEqHP3e0=;
        b=aJK7dv5eN0bdqWlzRyf42qj99yl8WgDryugMJbtS+U6RIKmNSZUkZaeST3gTEI6lcf
         P42asiOuXFcksCX17v395n2B8KBZ0XcMXc+uuY4BTl3u3wAyzfmczWDvEjbksdaLHMm1
         OOkYsWoWGXl9cb9azJUxAofJTLCNM53NP/vhwxpjp3aGeWZebrMPa5FHt1BvO6tBeKNT
         O7rJVwn+C60dbcF6Qlasf1SJCIPfBrNWCteUKZnIGj/jympl4JEMG9uIrugvit0Bf2wj
         RH8sE9puJi2UZ24Ryg3CptXSJ09+HgzPrvBxWDenymwJ9gqEuIkV715t3n7Kiswo6WI6
         MYZw==
X-Gm-Message-State: APt69E1i4CgRDEwi7fLAAXK6Y/0vFWrrG0zRKjEKVhJ8osaAHpEWciSM
        Gc2BcpcErc5qdxXSEDH9ptst2dHyLdLYlmcNAKQ=
X-Google-Smtp-Source: AAOMgpfRV3iRJG9gok6Gz+EkAcqOtsZXgH+qKEsF9VVU606Un96SJBCkjNOxm2S8oJc4Qq81VpgGfrN+83D9TctVZOs=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr5565057ion.259.1530113278410;
 Wed, 27 Jun 2018 08:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net>
 <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com>
 <20180625163147.GA7112@roeck-us.net> <CA+55aFwZ1+HEYjo52OmX-aXEJ5iaGMakhJEZq1uY=CVKGdBSgg@mail.gmail.com>
In-Reply-To: <CA+55aFwZ1+HEYjo52OmX-aXEJ5iaGMakhJEZq1uY=CVKGdBSgg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Jun 2018 08:27:47 -0700
Message-ID: <CA+55aFx=UFQQi3c6MoA1jWaMf+-9vXC4pU56H_9dG3S8tbJdHA@mail.gmail.com>
Subject: Re: Build/qemu test results for v4.18-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mcroce@redhat.com,
        sbrivio@redhat.com, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 8:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The problem on x86-64 cross-building to i386 is that the *compiler* is
> the same, but the flags are not, and the games the Makefile plays
> aren't sufficient. It plays with changing HOSTCC to CC in order to get
> he right target compiler, but since the difference between i386 and
> x86-64 is not the compiler but the "-m64" in the cflags, it doesn't
> actually do what it intended to do.
>
> We'll get it sorted, I think.

So right now the build fix is likely to be this:

    https://patchwork.ozlabs.org/patch/935246/

but note that it's literally just a build fix, and for a i386
cross-compile it embeds the wrong binary so it won't actually run
correctly. For this whole "test the concept" stage that's fine.

                Linus
