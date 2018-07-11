Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87217C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C69208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cXzTOnWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C69208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbeGKC7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:59:07 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:42083 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKC7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:59:07 -0400
Received: by mail-io0-f178.google.com with SMTP id r24-v6so22275403ioh.9;
        Tue, 10 Jul 2018 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrE1UY5wsjU4WRweicLv7RKq+TA0HHuaDKoBztqdCD0=;
        b=cXzTOnWe2NizjLCT1aGJG5poEgziINA3sbvnBVzmCyKGyDvC1q7ubA4fooAwY7z+wW
         tcEv8mFBP3Z1bsDaWue34+joA7F+pWJdVMGYe7pFEKvT7uYBhR7xhsEK4jPq/wYVWwzh
         AeiEyOFcRITw7Ro2bEpXfSnjHQb6UfegZhK2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrE1UY5wsjU4WRweicLv7RKq+TA0HHuaDKoBztqdCD0=;
        b=Ubc8QxOJLZMMmM/bzqGFT4Q1tdLd5A/9VXUQiMMXjqdrdEo68d3s8fE3s41GeTkvbD
         6LIug5VXcdARVH13myZ9jErAv+7Woph6gYa36zSY8VhDcoNHAHJNoq1g95Wbva8vQ9ry
         E/jljmulafbrCWukdfdsnbU9uUUEdds9bNNPaf54KSNNS2zQVJeccECkcnYYdPusKjTy
         A8A7ojg4rT+DX4voezoEEe/eKq3ueLIo60mNGiPmHuNG34NkdFjQwuZT7wvTS+x6NAK6
         tXZBZWh7+APHBFB3fB19d+59MYb/SgNEYgaZnMHf4NVZnspnBVsYd+LS2HZLpLKvlNqV
         WZlA==
X-Gm-Message-State: APt69E3AyNSOCDsJ2BLin7rW8xsKFxN1sPBnZxZV79vz7z1WQ9+YpGtS
        yBsOI95flhXvu3cf2WSps/+cskEqylB83bGRR3YjjA==
X-Google-Smtp-Source: AAOMgpfemdPR0N3NQLZKndyOft/IKCM17Ub3d/7zFWwUEozlQwoV7/s2tQP6n9F4XxtbfV9RS+v2ce8kZ2AjnO6+Pj0=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7850242iom.238.1531277822176;
 Tue, 10 Jul 2018 19:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 19:56:51 -0700
Message-ID: <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/42] drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, you didn't seem to have a coverletter email, so I'm just replying
to the first one.

Apart from the couple of totally trivial things I reacted to, this
looks very clean and nice. And now I sat in front of the computer
while reading it, so I could follow along better.

So apart from the small stylistic nits, all Acked-by from me.

                Linus
