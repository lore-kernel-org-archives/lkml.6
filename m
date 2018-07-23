Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6729BECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C0920779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acQFN1mE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C0920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbeGWPaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:30:15 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44128 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbeGWPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:30:13 -0400
Received: by mail-qt0-f195.google.com with SMTP id b15-v6so777252qtp.11;
        Mon, 23 Jul 2018 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UNe3nx21mFWEOS2eWlqfnBvaQPHzv3U5Bt15snZh8Ak=;
        b=acQFN1mEe3bc/nZBLmo+IjFCllIMoZK7xrGvI328JQ5EUPO3h8nkQe0XGmLQ8tKXeP
         6yTXP1fGvnTPreDeD9xn9Gzpmlw6cNHNltvh9MOIpqH0/7Sk12AssdYwHcr7x1H+bRXa
         zU51c4iTyexY5QjGLIMTcZbD3HUEqh1bVKhLggPObAJ25iKPyr/KbtCurQ92fTrDAyNe
         dcRj0PMBEa2/Bxd2jmbe6EvMIYeUF5cZ+ygzFsTPHK5GHXxt7vjIv5n66ChqvYP35c9i
         mCjeOg1YyDRXJE6PvqYHYDk1JQJqlfvFMkbJWdnxp0jyvHa8PFFwiN8EJL0NytEyJKK8
         bMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UNe3nx21mFWEOS2eWlqfnBvaQPHzv3U5Bt15snZh8Ak=;
        b=N7NKJgL7QU43XYrKHUel+aSFXXAermNGFx4keBpGL+TeEU27pWzldjtCf3sHyQcCc0
         SpnJprkjSBxCc1BoVWdhqSJU+1KOntn9FoOcCowC4F5Uo/fRqaWLlJxDeGT1vZQ81hcM
         WKo/3s/i2X/JmpQPd9IiDE8dxzJ4p7QYVYheO7V51RW5x/OklFh0DKp5gGsNHm53S0Gw
         Ra/dZIXBln/X/Tl3KEaPKsctBeX/qlbb4+Q7z3l8vOCknBPDE8zYAdTu9mXiPhq2SdDG
         86OAEFoYijEmsfI+zsw0W7Hp+bE6xE9fUmQe7+hy63U4jkRi8DjBW45s6PQfuoOyXfBX
         GiTQ==
X-Gm-Message-State: AOUpUlEyDABvUP+LvqjE+ucb/8MBpgrpCCXFSsswqXbfaWhM8nrpfSGE
        WO6UPtk4Pw3LhtRPozikoD71Q7cXB3UHsxqzjeQ=
X-Google-Smtp-Source: AAOMgpe2BGxWgWPzN+azfW9XnM6+TKW1VGePph6uF4SBgiOeNy3dgL7HWsNFjpscZbiZGlBOX/0dmNqj21fMbQgUBPI=
X-Received: by 2002:aed:3b5d:: with SMTP id q29-v6mr11864087qte.389.1532356121681;
 Mon, 23 Jul 2018 07:28:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 07:28:41
 -0700 (PDT)
In-Reply-To: <20180716122125.175792-1-maco@android.com>
References: <20180716122125.175792-1-maco@android.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Jul 2018 16:28:41 +0200
X-Google-Sender-Auth: 3dNcFMI93dqgcfqklcV2hnl_fZ4
Message-ID: <CAK8P3a1F2j3PL2ng7xw9TbCQqwn_U+1D5ChH+v8qWVrxOfW3xw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Symbol namespaces
To:     Martijn Coenen <maco@android.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Sandeep Patil <sspatil@google.com>, malchev@google.com,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 2:21 PM, Martijn Coenen <maco@android.com> wrote:
> As of Linux 4.17, there are more than 30000 exported symbols
> in the kernel. There seems to be some consensus amongst
> kernel devs that the export surface is too large, and hard
> to reason about.
>
> Generally, these symbols fall in one of these categories:
> 1) Symbols actually meant for drivers
> 2) Symbols that are only exported because functionality is
>    split over multiple modules, yet they really shouldn't
>    be used by modules outside of their own subsystem
> 3) Symbols really only meant for in-tree use
>
> When module developers try to upstream their code, it
> regularly turns out that they are using exported symbols
> that they really shouldn't be using. This problem is even
> bigger for drivers that are currently out-of-tree, which
> may be using many symbols that they shouldn't be using,
> and that break when those symbols are removed or modified.
>
> This patch allows subsystem maintainers to partition their
> exported symbols into separate namespaces, and module
> authors to import such namespaces only when needed.
>
> This allows subsystem maintainers to more easily limit
> availability of these namespaced symbols to other parts of
> the kernel. It can also be used to partition the set of
> exported symbols for documentation purposes; for example,
> a set of symbols that is really only used for debugging
> could be in a "SUBSYSTEM_DEBUG" namespace.

This looks nice. I don't want to overload you with additional
requests, but it might be good to think about how this can
be taken further, if we want to actually convert large
parts of the kernel to it. I have two ideas:

- It would be nice to have a simple mechanism in Kconfig
  to put all symbols in a module into a namespace that is
  derived from KBUILD_MODNAME, to avoid having to
  annotate every symbol separately. This could be similar
  to how we ended up dealing with EXPORT_NO_SYMBOLS
  in the linux-2.4 days, with the goal of eventually having
  a namespace for each symbol. Similarly, we could pass
  a number of default namespaces through the Makefile,
  e.g. if we have a directory that has lots of drivers that all
  import the symbols from a common subsystem module.

- If this is possible to implement, it would be great to have
  a way to limit the globally visible symbols in a module
  to the ones that are explicitly exported  even when a that
  module is built-in rather than loadable. Not sure how this
  is best done though. A couple of things can be done with
  objcopy, or possibly by reintroducing partial linking (which
  was removed not too long ago).

        Arnd
