Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F556218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfAVJhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:37:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45744 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfAVJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:37:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so26747995qtr.12;
        Tue, 22 Jan 2019 01:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8U+/fBZ5wzWAOh364eTFGh3wVnqJyhyALgzX91AsVv8=;
        b=bS/QxQZbyuhT1KGvH1OilPnxJVTx4K7gLplQQDUav26iCpIc0D6Q/zbFBlYKiTmHSb
         ShFcLLbcFkNlxi7EfZCsydrsICsVRvMP7KDI4IpteUEMYAbcavY+KEl23zNz9gof9nsJ
         0xHSNAHyo5svSCFhozMTm3nbwjLcPV5NEFB9kYEr2acPZyoMNKoLgSwnU+/RZzMZ/oyb
         yzp+rw6xjzuxMwCq7yaB40ZnFOIEliwxvKcnfsgO6MOZfX8PNy/W4uWkHJBYGQ1NLqzi
         T4IJt0MDWO0ejfk9DZbRHUHqEWSCViHN5JEgG6wlVZgl93e9Mt8xDpfZY0ouf0/GyPfc
         DmXQ==
X-Gm-Message-State: AJcUukdjFcr/+hemM3Xmnrs3gLCjm2QHr7hYYW9GSowj70Qw6g/cJQ3j
        w/PFLL9x9dYWkUjkULG3AqCIs0Bm8pYXP4+4qlbs4Q==
X-Google-Smtp-Source: ALg8bN4Eiz68YIpTfB/KIxDrT7SzuZCXQcETcIDs8wBf/8u6Q83QBq8gc2OcR3ZP6XIBWIFsqU3zvxpf9jHhSD/7PAE=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr30137248qte.212.1548149849290;
 Tue, 22 Jan 2019 01:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
In-Reply-To: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Jan 2019 10:37:12 +0100
Message-ID: <CAK8P3a2sMgHWpSV8OAa7LCo6oQiQ4xd5WQHKJ1-tN0TV8uRDHQ@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
To:     Andy Lutomirski <luto@kernel.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I have a patch that I'll send soon to make x32 use its own table.  As
> far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> not special.  But let's please not reuse 512..547 for other purposes
> on x86 variants -- that way lies even more confusion, IMO.

(trimming Cc list, as this is getting a little off-topic most most)

Just so I understand: do you mean duplicating the .tbl file, or just
the resulting table of entry points?

In either way, how will that work with the new io_uring_setup()
system call that will have to use the compat entry point?
Are you planning to use the same syscall number as x86_64
but point it to the compat function, or do we still need a new
syscall number for x32 in the regular range?

       Arnd
