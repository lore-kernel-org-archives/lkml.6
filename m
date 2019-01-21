Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0562C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D70120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfAUUPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:15:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42772 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfAUUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id 68so12949052qke.9;
        Mon, 21 Jan 2019 12:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdM58cS+Jh/ajgnYcA3c/ArJW1pz9CO9jfEh73a8hxw=;
        b=rNLPzErRw8ldaufBA0+JXbUXoVGhbIxirTRa70MoV6+/cSEdyFV+HjgssWIe+e5b4p
         YbtgYgch29R57TpOJnC+hSiSKI3oAGj4TSoLmFeLziZSyJhze0j9J0SIyAvl/ksYy8JA
         D01Gopl9rVnCIIhIS2x2VYUaektw5iDpwZUouHmntcnRzV/PCUiVk1VTweSansPXrKsZ
         xW6hiv6AhMBeBMaSibW0fzGRA9XHO9VpEAr8gmRY7d2bzBG1q5q2WNJ/QQmJoZ1yenSm
         sJrVHylwRRwpMYqZRyhNee+hsdYiv8PWxXCpDGkJoFx5JiVRgVGKhyy7JcNmuzCBhNDm
         0Jng==
X-Gm-Message-State: AJcUuke1sJsKY8aIt4tIChI/Stx5DHYkbkPrz7xdZWI8tHBIyfbEyTQ8
        QbZvgiQz5ZlB2juMLvgTfrA9ozh87DTJDi7mp+vaJg==
X-Google-Smtp-Source: ALg8bN5bXBj/Whs0xIZ5ToVdcS5yJcEvlAAOXkOkn2dghOnGLBe0a7k7Jk0wzPH2YEZcWc3efKXmZkesNGkhMWQa75E=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr25386973qkf.330.1548101744619;
 Mon, 21 Jan 2019 12:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20190121143951.68956db3@canb.auug.org.au> <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
In-Reply-To: <20190121191306.ifga5aw5atu2vvb7@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jan 2019 21:15:27 +0100
Message-ID: <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
To:     Christian Brauner <christian@brauner.io>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I plan on sending the pidfd branch with the new pidfd_send_signal()
> syscall for the 5.1 window. Should we somehow coordinate so that our
> branches don't conflict? Any suggestions?

A conflict can't be avoided, but if you pick system call number 427
for pidfd_send_signal, and Jens picks numbers 424 through 426 for
io_uring on all architectures, we can hopefully avoid the renumbering.
Of course, if one or more of the patch series don't make it in or
see a rework that changes the number of new syscalls, then we may
have to change the numbers after all, but we can always hope ;-)

      Arnd
