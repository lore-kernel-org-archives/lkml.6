Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9BFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF32084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABF32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeJ2SiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:38:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35446 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2SiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:38:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id a10-v6so8421611qtp.2;
        Mon, 29 Oct 2018 02:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4maYQCKwB0qKq/uAUBuP1ZPhdQOQ9JtKhlto12/5RIs=;
        b=L7wSDAfsVDmnzG/ktefeQX9VCTXmr1zaBOqSi4HdLXF5NQb1r6uk7KVQHyWqTPTpUC
         39+nWwRXt28mIEizxS4jTpjTkHtg4pLahqWA0MX5uQdQqBuy00zswQonBEuwME1bMudo
         tsTmzgPGUO4JyY3rd/2hU4hgUf2urMl0h5Y/mXcYzoaTNKTNARUgTP5tKJQmkm5RFDwt
         TuLs+BoprEgZoyXq1VIr7V2khDwcUdbQvckz9Xs6FZB8/OjchGWqXRS1jn/RsRTpYiBN
         kilQbxAzW9aES9BfDmp+gr7AXL4YKNSrimWOTlD19Vuy9UFPt7VgisUlDZSiIEWE/7To
         AqaQ==
X-Gm-Message-State: AGRZ1gIclOzhG2g+RqxKoceg/cQVanIy2CPtcwvIXqvsjLd+yacUa0Ih
        yA0J1NTx8DLXHcVdaM/CIlpUCpWU4BukIqFW2FBXjQ==
X-Google-Smtp-Source: AJdET5fcCy3FPIGfJWG+VYiKnSrjU5ttRMLlJUqzCv+9brxH3rNLlJ/RVzVDHVli9gF/6UThmvUyw+/vL5nLms72oRc=
X-Received: by 2002:a0c:c68f:: with SMTP id d15-v6mr12028991qvj.40.1540806619810;
 Mon, 29 Oct 2018 02:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180912150142.157913-1-arnd@arndb.de> <20180913020757.GP19965@ZenIV.linux.org.uk>
 <CAK8P3a2PTaanqmJycLCJ5QgNFXONb7nVye1=TJST639wDBNpAQ@mail.gmail.com> <20181028170701.GA8132@ZenIV.linux.org.uk>
In-Reply-To: <20181028170701.GA8132@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 10:50:03 +0100
Message-ID: <CAK8P3a2kmMJ6Ly4ZkkzEeQ_t67Rw63j00QcUPYCMErTU851BHw@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] compat_ioctl: add generic_compat_ioctl_ptrarg()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 6:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Sep 13, 2018 at 12:29:02PM +0200, Arnd Bergmann wrote:
>
> > I was hoping that the _ptrarg suffix gives enough warning here,
> > but maybe not. I was careful to only use it in cases that I
> > checked are safe, either using only pointer arguments, or
> > no arguments.
> >
> > What we might do for further clarification (besides adding a
> > comment next to the declaration), would be to add a
> > complementary generic_compat_ioctl_intarg() that skips
> > the compat_ptr(). There are only a handful of drivers that
> > would use this though.
>
> ... and the next Monday zeniv went down until the end of September,
> so I'd missed any resends that might've happened in that window.
>
> It's _probably_ too late for this cycle, but let's deal with that
> thing properly for the next one.

Right, I don't think we're in a hurry, so I'll rebase my patches
once -rc1 is out and send you the new version.

> A couple of comments from rereading the thread:
>         * generic_compat_ioctl_fthagn^H^H^H^H^H^Hptrarg should not
> be EXPORT_SYMBOL_GPL().  I'm sorry, but this is beyond ridiculous -
> "call native ioctl, with the last argument interpreted as an address
> from 32bit process POV and converted to 64bit equivalent" should
> not be copyrightable at all, and there's really only one natural
> way to express that.  Use EXPORT_SYMBOL().

Sure, I didn't really give this much thought.

> And I'd consider names
> like compat_ptr_ioctl() - easier to type and less opaque...

Good idea.

>         * rtc patch makes RTC_IRQP_SET32 et.al. accepted by 64bit
> syscall.  Which is a behaviour change that might or might not be
> OK, but it needs to be clearly stated.

Yes. I was aware of the change in behavior and have done similar
changes for simplicity on y2038 ioctl patches in the past, but
you are right that this should be mentioned in the changelog.

       Arnd
