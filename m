Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8999DC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406422075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406422075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJ2BwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:52:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38172 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeJ2BwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:52:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGoWj-0002N2-Dn; Sun, 28 Oct 2018 17:07:01 +0000
Date:   Sun, 28 Oct 2018 17:07:01 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] compat_ioctl: add generic_compat_ioctl_ptrarg()
Message-ID: <20181028170701.GA8132@ZenIV.linux.org.uk>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180913020757.GP19965@ZenIV.linux.org.uk>
 <CAK8P3a2PTaanqmJycLCJ5QgNFXONb7nVye1=TJST639wDBNpAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2PTaanqmJycLCJ5QgNFXONb7nVye1=TJST639wDBNpAQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:29:02PM +0200, Arnd Bergmann wrote:

> I was hoping that the _ptrarg suffix gives enough warning here,
> but maybe not. I was careful to only use it in cases that I
> checked are safe, either using only pointer arguments, or
> no arguments.
> 
> What we might do for further clarification (besides adding a
> comment next to the declaration), would be to add a
> complementary generic_compat_ioctl_intarg() that skips
> the compat_ptr(). There are only a handful of drivers that
> would use this though.

... and the next Monday zeniv went down until the end of September,
so I'd missed any resends that might've happened in that window.

It's _probably_ too late for this cycle, but let's deal with that
thing properly for the next one.  A couple of comments from rereading
the thread:
	* generic_compat_ioctl_fthagn^H^H^H^H^H^Hptrarg should not
be EXPORT_SYMBOL_GPL().  I'm sorry, but this is beyond ridiculous -
"call native ioctl, with the last argument interpreted as an address
from 32bit process POV and converted to 64bit equivalent" should
not be copyrightable at all, and there's really only one natural
way to express that.  Use EXPORT_SYMBOL().  And I'd consider names
like compat_ptr_ioctl() - easier to type and less opaque...
	* rtc patch makes RTC_IRQP_SET32 et.al. accepted by 64bit
syscall.  Which is a behaviour change that might or might not be
OK, but it needs to be clearly stated.

Could you resend the series, with ACKs attached, etc., either
based on -next (if done now) or on -rc1 (once released)?
