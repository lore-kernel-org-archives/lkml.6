Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218A324FA9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q0xkBNXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218A324FA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeGBQwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:52:20 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:42180 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbeGBQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:52:19 -0400
Received: by mail-io0-f182.google.com with SMTP id r24-v6so15293351ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4abVzD+IrQ6bzQG7SpM4cwZH0xUAo71e2Y04FeE6Jk=;
        b=Q0xkBNXKXHUregbZiZjHchUYpDCKQahkiTE773H4Hx0cpgk9Of16rI0K/56Ous7cvk
         E/QUhZ+ozlh9t/M1JhiqfbhUlPf15nzxMn+Hg9sVu6Z+ikbc4WW1Rp3Z2RuEQTzri6Tk
         CyaXOQPz6sZbj2dVPhHoIJqDjp6t/Y2Xh4vdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4abVzD+IrQ6bzQG7SpM4cwZH0xUAo71e2Y04FeE6Jk=;
        b=ENBxcJdQZLeOjmgCZNNsXgRkO+UP0ZhAkezglYm7dPd3Tyzs5cYlCAH/yDt91/RQ+w
         MRhLbppkeBGSIXH51Yhw30SVnL4H7bKCK9iawUJSS30TA1H/pJYKQbJwadl/pi7ZyLTn
         oIMqb6yKt21nMGWZbt2YiR7AwI43l2QVbDJxHik2LjHnb4sTK1ZM8U2rXzwaNjJPaq2X
         P69+enZIlPAWLwxEGz+MkAbx8HtstUGtstj/pkDDHzeGlMaxyOwRBJ/6Ijue+QMs/pDs
         aUAQsBJZwee+8LiCuo8iHx6EbYggGsKu1ILWgkgzHWqmhD5p5nt2++C5dW2qAo6dMZIW
         FDqQ==
X-Gm-Message-State: APt69E3DF3ipS3ZSmOoVQouy3BqD9RC2N3fO5oTWRYv4/PavaEsK7uR3
        VhejN7nkncqQeUduwWPCBXo7V76j+0zUDzriVBRFWw==
X-Google-Smtp-Source: AAOMgpfFLScIEHraI6yJrr0oILvkbHGW1HIOkMWHWJWrZ8BHwphrxzk9u1ad+TSz3pQREJ28GqcfQQ9xp2I9vQm3Nmo=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr17368495ioe.238.1530550337464;
 Mon, 02 Jul 2018 09:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180702164605.GF9114@roeck-us.net> <20180702164758.GA9835@roeck-us.net>
In-Reply-To: <20180702164758.GA9835@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 09:52:06 -0700
Message-ID: <CA+55aFw0OU_6NdEZ1wkTg-yB3Lz5f1yDTgmYArw4nwvkNRAbxw@mail.gmail.com>
Subject: Re: v4.18-rc3: Build and qemu test results
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 9:48 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build and qemu test results for v4.18-rc3:
>
> Failed builds:
>         i386:allyesconfig
>         i386:allmodconfig

Thanks for doing these.

And I have a networking pull request in my queue that finally has that
bpfilter i386 build fix in it, so at least these two should be gone
later today.

                Linus
