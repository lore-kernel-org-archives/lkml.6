Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18996ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FE82146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FE82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeIRTyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:54:22 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39271 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbeIRTyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:54:22 -0400
Received: by mail-qt0-f193.google.com with SMTP id o15-v6so1829874qtk.6;
        Tue, 18 Sep 2018 07:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBezYcy63E4L2TTh0bwZ86gDBJJe5e8Ts5qKs6if3bE=;
        b=uQryEN6NvyTiAE4vKkjSt3eubwqJc2/3uYlHlnqZpaBYfKO4p6gIhF9/C5J9+gGJ4v
         FC5eyLGfTOvOn8y+tlzioYasxkWKuBsTpzWgttOU2ll9XIfcfA0tM3hg3Ol7oy/5qFGQ
         638u5WpE6cD6bRaWPBBhPC8XHKrDP3Wpc7jdU3dP6dg1ljZznaMooRaPgN3PuPvnt8EC
         Vn/I00UF496ZPWdvtVYXITNMA3jNyq89x7ZMGEED0dKexnxpBoNBDOv7gjfaSXGcJBAp
         T4gSAwcunxx03CBr2AaHf/IC34CmV/6b9nv65+TE3UbSR5zDZE6vqvr74zgHHLl57u+J
         Q0Yg==
X-Gm-Message-State: APzg51DkcWuOu97wVpdS5Ylc0i2ltmOHvxYmA1mC/Bz12fmnUxcogrBH
        AK47nzitMTG5DF+pTI2v/6zfhqSLw6M8TQKjo2c=
X-Google-Smtp-Source: ANB0VdZyvFlzTfEgd7b+cDMGEK38T2FC5/Kuzf7ppbv7bEPI/SJfI5pPxnR3p78Y+E5B8yHz8fXAhH39zOJ77k22Bug=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr20692455qvc.180.1537280492911;
 Tue, 18 Sep 2018 07:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180914113929.953895-1-arnd@arndb.de> <alpine.DEB.2.21.1809171204350.13789@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.21.1809171204350.13789@digraph.polyomino.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Sep 2018 07:21:13 -0700
Message-ID: <CAK8P3a3PViCK9RzhwDkXhO_mJvgnfe0=tbFs5X_7JDRQQMujYA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] making uapi/linux/elfcore.h useful again
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 5:05 AM Joseph Myers <joseph@codesourcery.com> wrote:
>
> On Fri, 14 Sep 2018, Arnd Bergmann wrote:
>
> > +typedef unsigned long elf_greg_t;
>
> Does that need to be unsigned long long for x32?  (At least glibc thinks
> so; I've not tested what an x32 core dump actually looks like, but to be
> useful it certainly ought to have 64-bit registers.)

Yes, I think that's right. 'unsigned long' was correct inside of the kernel,
but copying it into a uapi header means we have to use '__kernel_ulong_t'
so it gets interpreted right by x32 user space.

          Arnd
