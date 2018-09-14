Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D62ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E602083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E602083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIOBLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:11:36 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33991 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeIOBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:11:36 -0400
Received: by mail-qt0-f179.google.com with SMTP id m13-v6so9902774qth.1;
        Fri, 14 Sep 2018 12:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0WywhA7kSE8NX/ktFlVmlZN1u5sjNooLIpcA51U6Hw=;
        b=OdEfUuQD8dfh6Jjt2gBdirTnLMrpZgfUi6BJxiDE4YmgXTLUSVf3AidTcUhxoyHmR9
         lFo5Tg3mlsCPVa67pq8Q3AYLIIfEBennqYfmFOeknRoHRtbEr2EeYz985rNEz+ux0c1G
         9yU6HOLGcLMyEpgmdzV63tFkYRW9QBSjO7foP+YKsXGWJi/baNrguWlWhbBuvzLbDST/
         OhON0b5o2di1uM62GcUeRlB55LwLhpkKa8Fu7poYNQ6expGnpsZ0Fk8MWm93z5a1a2JL
         e85myewmMKVpmeR811Q4z5IYUwLq7ioNiNxUpHAoxu61UWSHerQdjxZ+1cg2u9C9E8BV
         46AA==
X-Gm-Message-State: APzg51De4rS7uuJBECYxgB7w4QWSc/z5CGOgrDXJeS5j32ER+QCcY4qY
        gprlSCCHOK1EBdlqjSdQMssjXKZnzGWrwAJ25rM=
X-Google-Smtp-Source: ANB0Vdb++E3rxZota0NJWV7iw7i4l+qLIg6YUCApi3jgk6iuFC+THMOhcqETUMbGM6pTx7VZpE8wp61xl7n9N/qokOc=
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr9933057qtg.213.1536954938480;
 Fri, 14 Sep 2018 12:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180914113929.953895-1-arnd@arndb.de> <20180914174528.GA35000@gmail.com>
In-Reply-To: <20180914174528.GA35000@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 21:55:21 +0200
Message-ID: <CAK8P3a03qF4+yGBNVLymrSRN7QjDGjnpduoPwnprwv+kfHZ0Cg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] making uapi/linux/elfcore.h useful again
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
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

On Fri, Sep 14, 2018 at 7:45 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
> > - Move required data from the private x86 asm/elf.h file into
> >   a new uapi/asm/elf.h. Some other architectures already do that,
> >   but most of them do not. Before applying the patch, we have
> >   to do this for all architectures
>
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

> I suspect this wants to go through -mm, or do you want to carry it?

-mm is probably best. For now, I just want to see if there are any
concerns about this, and then I'd have to do the full version that
changes all architectures.

     Arnd
