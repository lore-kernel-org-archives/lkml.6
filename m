Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C89DDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CE6208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QkRGqBzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CE6208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934759AbeFLBaG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:30:06 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33075 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933350AbeFLBaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:30:04 -0400
Received: by mail-io0-f193.google.com with SMTP id d185-v6so26193607ioe.0;
        Mon, 11 Jun 2018 18:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SluO0I9LboLAni0Ve/jBpQHgARmV2Y0yfL+OTjvxow=;
        b=QkRGqBzTpXB5MMGRneex2VIuzgFD2GxgBZTTPGivDwYyc0ygj7ZQFSTVJ60q3bc0r1
         UQ1Q7BP+FX1DOYbVI11TOnYtLWNxkpXNtH8wMpvqxEqs5U20Mnn0B9uohLI2c+JzTjao
         6fwL9nms3O0thlS9i2sRII4qJG2L7dg8kOB1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SluO0I9LboLAni0Ve/jBpQHgARmV2Y0yfL+OTjvxow=;
        b=VujW2NnMepOQrStWtfEIN830OJk9GzmEBn2kvYkr5UnosJWJM42CIJtFPeEVmxpqqG
         iMG8yNd0vUAK5jXMSxpwzmK4mKrd2dNTNVU5aruRHccWRpFG4Dk/Y4RlnbuBSrAjsrBs
         tqeDwQfe3aLzkGCFa3a8GXbHfaQSKVmA3x7N2FzAuIse8cQNwpZDZGdOdRU4pe5gM+WM
         fAdbavsqeSzTxF0PkdVojVZTBGwPE2FOkUN7pNmLmwmYcuKWSX+5gjTwB7Dm5uBMO9Pl
         cZssQ7EBsGGhNR2Boxkr0Ls6Shk18AzYQ0td4PyAJhKon/q01PEOqrTvVLHfe1ZZ+CnT
         bB3A==
X-Gm-Message-State: APt69E05Vv3cj0jlkCF32nwAV/bgUZJ6xaTUr5CF0KslauO4t6KW2OD6
        YmLPucNQcxZ79CDH/SaIBYoGyxfeKR3klOZzOGY=
X-Google-Smtp-Source: ADUXVKJYQBeYk7hRUhZjzPscshmHamTaHvlJAcEtwYNiW4iCipq7Bo2abvn9xovi/b7Q5PL/yJNV7Pj51uY7VWUty2c=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr1525242iog.238.1528767003771;
 Mon, 11 Jun 2018 18:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180612003224.3658-1-labbott@redhat.com>
In-Reply-To: <20180612003224.3658-1-labbott@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 18:29:53 -0700
Message-ID: <CA+55aFwG-UwwHHuOWFnC3tphyEcyfx1zQMx8JuxmUGWo4YwD-Q@mail.gmail.com>
Subject: Re: [PATCHv4 0/3] Salted build ids via linker sections
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nickc@redhat.com, Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 5:32 PM Laura Abbott <labbott@redhat.com> wrote:
>
> v4 takes Linus' suggestion of using linker fill to insert the build id.

Heh. I was hoping somebody would come up with a way to avoid my crazy
"put a LONG into an aligned section to cause alignment filling" thing.

Because somebody will ask "what the heck is the meaning of that
LONG(0xffaa5500) thing"?

But since I couldn't come up with anything better myself, I guess I
can't complain.

> This is pretty small but I also know people can be picky so I'm open to opinions or suggestions here.

I'm not sure anybody will care about 32 bytes. Although maybe it could
be made to be just 8 bytes (four bytes to force padding, four bytes of
padding) and put somewhere where you'll have more padding anyway due
to being followed by a PAGE_ALIGNED section or something?

I don't think we care.

Anyway, I'll pull this if somebody sends it to me, it seems to be
fairly minimally invasive and apparently fixes an issue for distros.

                Linus
