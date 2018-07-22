Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDEC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1092D20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TW5EyYme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1092D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbeGVTnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:43:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38391 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbeGVTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:43:17 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so13808139iog.5;
        Sun, 22 Jul 2018 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zIYqof/wyWEfb8OugjakOp1sks1FLuEozB2G3y4u6E=;
        b=TW5EyYmeT+IL+U+Fn+e+fjq3Rf8PyCuamzLiGyalo0y31ztqzbs3c16ItoHAYDBBi8
         6nu1UG9agzvkmb1z4i2NTiEDf8323284SWqXGbJwx1D5gRX+iCH1z6JIO0I9/FF8qWct
         +Fi73CfeEFUU3domicuO+Ogu6RCm5eO4gQThY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zIYqof/wyWEfb8OugjakOp1sks1FLuEozB2G3y4u6E=;
        b=UcuqcIMAcX8w2FWx8ZUWenAMIHeAcJo+A+nWP3uQyQulLdBTq2y9z99TmnC1wMvx8k
         +t1wSphowjHGEAxOQVvhCQvtinlMvdU5MyWdxVIU6jOByac34RObb9c3JzRcgVQdH2sG
         2Ai2OZ/bu+dKUFOHIQ0mCctOsrD6B5Wk4KgV35GLRXHz6Ex/PnAWa4w29DiypMcezOXh
         RQVIkmEsbDHgubdCZglgpGWB4BjbHSE+0IAWSTlDg8H1vkzs4cBeZLMP084hWeHe7h0R
         dSCnJwBXOZyHuo4+obkMVpocrzKJvYccUqtjp16YkIXs6aoc5SA8lKleo/TdKI5TsStT
         Uk9g==
X-Gm-Message-State: AOUpUlHO7xfVGIZAc2EpBYZ0v6O5ZOL0ObXaTKYTlqRPOc3DeATz3olB
        JwKE0gnbK9I6kdcgYIdKrWLfizv9T7TKATRFDZv+6DD7
X-Google-Smtp-Source: AAOMgpeIYTzokGV6Hh7+vfP28kkur8WHDcwrL1k+xgMzLDGS5MUY+iPqulecQ57oVUb9pDVNwkb2et+fj+gUZEfxJdc=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr8143713iom.238.1532285140185;
 Sun, 22 Jul 2018 11:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180722140711.GF30522@ZenIV.linux.org.uk>
In-Reply-To: <20180722140711.GF30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Jul 2018 11:45:29 -0700
Message-ID: <CA+55aFxyagGA=3XqqVhw8XAKG90Z+EWKYA=DSVkQKzmHsO+6cQ@mail.gmail.com>
Subject: Re: [PATCH] fix osf_wait4() breakage
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

Just a note:

On Sun, Jul 22, 2018 at 7:07 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Fixes: "osf_wait4: switch to kernel_wait4()"

Please put the actual commit ID there too, because that's what people
with automation check.

> Cc: stable@vger.kernel.org # v4.12+

.. and when you do that, you'll see that it wasn't actually in 4.12,
but got merged during the 4.13 merge window:

    $ git name-rev 92ebce5ac55d
    92ebce5ac55d tags/v4.13-rc1~154^2

(unless it was backported, but I don't think it was).

Also, the prototype for kernel_wait4() (in <linux/sched/task.h>) is
wrong, and doesn't have the __user annotation.

                Linus
