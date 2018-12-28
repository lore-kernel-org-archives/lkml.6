Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FECFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A9820874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kylb3E2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbeL1LSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:18:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34674 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeL1LSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:18:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id r62so17156878oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VTJztM92oYt4LsgbQkq0KQlLA+AeO1F45n04gA+OvU=;
        b=kylb3E2pKD6rqT0zKiYLx6gMJUeW5s9gRGalcpejsjuHCVzVTowOyNPjxRVcasb9JW
         RF/opF0MDutr7AoV6vc4DnmUFa7WAz/eFigamtfr8/n7esfVzi2FpL+lrg8mlYvAcI4b
         LxdgMeW3BzrJpUfhEPxsoT/uuZeEdaXEbQ29U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VTJztM92oYt4LsgbQkq0KQlLA+AeO1F45n04gA+OvU=;
        b=Bjogg5zUrvsmdvl34xEEhkvpULWB7lh6ECrXMNdcxqs0+pRJyuOhMJH49CH6N2FBDJ
         R0KByXaFTBWsUZQBH/HT7VNuewuU6+ofb7e+HHV3LEHmJKfr4hKKTFzzBz4TjTpZ90Lt
         nb8HlM2bU1tCIVvoyfv+Oc2gHGxIucaQcjIndK8eldcKi36JFgnh7rHhNsfax7WS10lO
         dr0eoaCZpJ1YyyDMg8OpWxIfPpM18CIevGCFPiAkoEOcRviw6TF3ZNKRUjwl+5BpWCFK
         WjtPqZZakVTwywyLE1t5s9sV0w0Qk8x8zmAyI8cQjk0HlAG46I0Bhi7spL2CfbjojkHC
         AVKg==
X-Gm-Message-State: AA+aEWbalNZInKRXSlWmUgn/n50lpZok37QlQR1MsbNHLnk+nuRn5zHs
        RS3eC7Nh4nkDkoDWkv1E9mxB+FzJFXiIlhvfImj3ChDB
X-Google-Smtp-Source: ALg8bN6z3C23Wquko4hDM6yeOzhbtNrM90xUCzJp3MXkLMDiG/pIWGdJHvb0zyQOo3puj5xllkfkLQz/si1bEbkTx0w=
X-Received: by 2002:aca:1e17:: with SMTP id m23mr17974889oic.332.1545995910314;
 Fri, 28 Dec 2018 03:18:30 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de> <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
 <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
In-Reply-To: <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 28 Dec 2018 11:18:18 +0000
Message-ID: <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lucho@ionkov.net, libc-alpha@sourceware.org,
        Arnd Bergmann <arnd@arndb.de>, ericvh@gmail.com, hpa@zytor.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 00:23, Andreas Dilger <adilger@dilger.ca> wrote:
> On Dec 27, 2018, at 10:41 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> > As you note, this causes breakage for userspace programs which
> > need to implement an API/ABI with 32-bit offset but which only
> > have access to the kernel's 64-bit offset API/ABI.
>
> This is (IMHO) a bit of an oxymoron, isn't it?  Applications using
> the 64-bit API, but storing the value in a 32-bit field?

I didn't say "which choose to store the value in a 32-bit field",
I said "which have to implement an API/ABI which has 32-bit fields".
In QEMU's case, we use the host kernel's ABI, which has 64-bit
offset fields. We implement a syscall ABI for the guest binary
we are running under emulation, which may have 32-bit offset fields
(for instance if we are running a 32-bit Arm binary.) Both of
these ABIs are fixed -- QEMU doesn't have a choice here, it
just has to make the best effort it can with what the host kernel
provides it, to provide the semantics the guest binary needs.
My suggestion in this thread is that the host kernel provides
a wider range of facilities so that QEMU can do the job it's
trying to do.

>  The same
> problem would exist for filesystems with 64-bit inodes or 64-bit
> file offsets trying to store these values in 32-bit variables.
> It might work most of the time, but it can also break randomly.

In general inodes and offsets start from 0 and work up --
so almost all of the time they don't actually overflow.
The problem with ext4 directory hash "offsets" is that they
overflow all the time and immediately, so instead of "works
unless you have a weird edge case" like all the other filesystems,
it's "never works".

> > I think the best fix for this would be for the kernel to either
> > (a) consistently use a 32-bit hash or (b) to provide an API
> > so that userspace can use the FMODE_32BITHASH flag the way
> > that kernel-internal users already can.
>
> It would be relatively straight forward to add a "32bitapi" mount
> option to return a 32-bit directory hash to userspace for operations
> on that mountpoint (ext4 doesn't have 64-bit inode numbers yet).
> However, I can't think of an easy way to do this on a per-process
> basis without just having it call the 32-bit API directly.

The problem is that there is no 32-bit API in some cases
(unless I have misunderstood the kernel code) -- not all
host architectures implement compat syscalls or allow them
to be called from 64-bit processes or implement all the older
syscall variants that had smaller offets. If there was a guaranteed
"this syscall always exists and always gives me 32-bit offsets"
we could use it.

> For ext4 at least, you could just shift the high 32-bit part of
> the 64-bit hash down into a 32-bit value in telldir(), and
> shift it back up when seekdir() is called.

Yes, that has been suggested, but it seemed a bit dubious
to bake in knowledge of ext4's internal implementation details.
Can we rely on this as an ABI promise that will always work
for all versions of all file systems going forwards?

thanks
-- PMM
