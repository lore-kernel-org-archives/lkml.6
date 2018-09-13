Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81737C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171B220861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171B220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeIMQFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:05:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41497 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:05:04 -0400
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so4860501qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 03:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFy5OlA0Qd0z765toTYIzCgYYKZC4H5Ur9JNpVtTt14=;
        b=cXgQ39bpAmf3bPpod2OEG+IPW1zbCOk/HCH5o52SsTyDSZkYbOYF1jQcOI/2a1Hq8k
         ytL7qIUrw3kXVrKbDSvAhLETlieaDUoHj4fDAw4lC7GiwwWvwQLSHa8cPCN9+S6EzVvZ
         /Hvg+joCOpg3SWZ0BnRERxypdAtVmLsDa/1bALGZaLAcSMPorFVZXqUoTPceHlVfPOIl
         E2oopgATHgfOosX+QygCRm4oQBjq8ShS6p9/9M5uvJ9O0lF2TzHZ7Md+f46SsbWA3mpG
         51tq3vj0v/GmDLTxUZRQFFtghO8SlyIbszK3vr3Tdbhh+RRNu5yv8uxNRu41PssIT38C
         Jyqw==
X-Gm-Message-State: APzg51CZcABTJirS30l/9MmsZYfBUcMNF25U/yikqKySoMylAqVP9uZG
        56Hg/3p9xIwVlLexFFUbTYKT0WPxvIyD09bOq+WqXZOl
X-Google-Smtp-Source: ANB0VdZ8qqW3O443852l+i/v6V3xcR/AT6nAqggDLDYMoNYZlRHmKgOMKeVRBegQC+uMurFH7RZ+l3/GLaCdT0JQZGU=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr4684809qtd.132.1536836168224;
 Thu, 13 Sep 2018 03:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-40-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180913024049.24567-40-viro@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Sep 2018 12:55:52 +0200
Message-ID: <CAK8P3a1J=qFKNiyHSB=uhz9i4wc5vU0=Q2smgS9VBaa4jYWsFw@mail.gmail.com>
Subject: Re: [PATCH 40/50] kill the rest of tty COMPAT_IOCTL() entries
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:

> @@ -1113,17 +1111,6 @@ COMPATIBLE_IOCTL(JSIOCGAXES)
>  COMPATIBLE_IOCTL(JSIOCGBUTTONS)
>  COMPATIBLE_IOCTL(JSIOCGNAME(0))
>
> -#ifdef TIOCSTART
> -/*
> - * For these two we have definitions in ioctls.h and/or termios.h on
> - * some architectures but no actual implemention.  Some applications
> - * like bash call them if they are defined in the headers, so we provide
> - * entries here to avoid syslog message spew.
> - */
> -COMPATIBLE_IOCTL(TIOCSTART)
> -COMPATIBLE_IOCTL(TIOCSTOP)
> -#endif
> -

These are also included in my "compat_ioctl: remove IGNORE_IOCTL()"
patch, but it's trivial to rebased one on top of the other of course.

       Arnd
