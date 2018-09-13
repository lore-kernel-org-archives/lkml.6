Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C987C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C03120861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C03120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeIMPTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:19:30 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42518 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:19:30 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so4768857qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 03:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+fHCp3hvza8UyfsBW/q8Koq2CtTzE86vX9MZwpIE7s=;
        b=EivjAm2JBJAcX2m1UZQZMfabOTcnWo1GJyoZ/EO5invGECFrFjOcOWy/9H+OKd7ffM
         0qxJfxrhzmSQYPeV7reecwvjjBMmOWdiHkKtm6hUmOcmPuOTA0QTeJTpE5N0g/4HXVoB
         Gt0JuyX6jhQl3JRZEEL26nCFa8hsvrTX7r+vBfiJW1Wzy6PfaFcJG7+0R36MIuxUsT7q
         b/NNp7RD3K5p6rimiIa6hAxq0GtdsSqPGOuj/2RTTAOlsqnMVyUMPPRHkI3u/isNS9fa
         ag+RcA/Ha6uQ0ARcXgl0nz01q2HXXOeig/f3vNrvigUNzDU9Q4Lj/856jPa64bopU4a6
         0QqQ==
X-Gm-Message-State: APzg51DFgK1ecF4n5h95H8JOgAuBKJJqKlfvZQta+Q69vcXkO+hvrYhs
        NsMWuayfTCyoYiH/Nbscnlk/OkYsd1kJAI/n70K5zaCE
X-Google-Smtp-Source: ANB0VdZ7hCF+zFIj0mb+cpHTQ2Bs8gQnHV8j6CntNAB4eXHJehKTvXJEsB8m+LdVzyyduK3bexS/UsZVFjX5SqNmW2A=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr4726184qtr.9.1536833442778;
 Thu, 13 Sep 2018 03:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-46-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180913024049.24567-46-viro@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Sep 2018 12:10:26 +0200
Message-ID: <CAK8P3a0w-oF6s-LbNeM688iCTM_D94r9k3nkmv-G7ri6htWhmw@mail.gmail.com>
Subject: Re: [PATCH 46/50] vt_compat_ioctl(): clean up, use compat_ptr() properly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> we need it for "convert the structure" cases too
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Nice catch. I introduced the mistake in commit
e92166517e3c ("tty: handle VT specific compat ioctls in vt driver"),
the original code was fine. drivers/s390/char/tty3270.c implements
some of the VT ioctls, but none that are affected by this.

At least the VT code is not usable on s390, so it did not make
a practical difference.

        Arnd
