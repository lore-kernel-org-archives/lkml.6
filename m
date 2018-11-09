Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C691AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F1120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V3xJjk+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F1120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeKJIOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:14:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33625 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeKJIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:14:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so2928680ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAu/qG3Rm4avcQq7MEHa/IP3OR71kYSg98mMEZUx5bE=;
        b=V3xJjk+uD/aXTqC4Sbmhsl4RJLnAvBNBIaOjKCdDZCv+awHrknRGUo/IzcOKnjBUbm
         KeBGMe5zW4K0TMeIMW1q17dM2IEwwKXgAWYKogQDVmrCSX4kqttNWXzDspEgYmgBsLzs
         dKnTTHUdrNVMPeXZ89QUGzyld99nTLR+j/jO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAu/qG3Rm4avcQq7MEHa/IP3OR71kYSg98mMEZUx5bE=;
        b=GKqW7dZlkzhyk2C7kbSlj+dpsrcZ0EmzzScsEvF0tTe7NwnrZgfVzuSp+MzjT0+9XK
         9O9I47CN5T/k3eSDc9MgUreMB+4l17bYHFs54UTxW7JOvItYwdYLhRr/aPTYUxOfG4EA
         Oc35AGkJBGQvn+FNYvHpI7eSDfKwP0ERKrm7UWnrZPypvEYETENcyi7WrMB8dXGISR01
         /cC8X78LzVESisaXQlrMN8nlnRRG3tLMiYfhPYhlFAGpLwJmb2B1pOeX2mMdXsKLzx00
         rmALEQB/U0v0yIRVzfEtWP0QsNoUStCm7SAwE2iAvh9wUc/p6Z0HF19SuW31OBmxO7AR
         bhbw==
X-Gm-Message-State: AGRZ1gI17ZffUp4gC5dTG48lazOqj6AlfiC72sXg9PN1hxDA6HfIGYxC
        25sb8KbOPHXheGKQLmRb71IHfdrlJBA=
X-Google-Smtp-Source: AJdET5cS7yKaq5AmaP0GavhqRsVTTnv+DfrebmirLU29ViTKDeixUwj0wV4rMKr7o0ZqEciIgSkd7Q==
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr7213261ljl.3.1541802696842;
        Fri, 09 Nov 2018 14:31:36 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a18-v6sm1559394ljk.86.2018.11.09.14.31.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:31:36 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id p86so2451084lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:31:35 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr5741618lff.16.1541802695342;
 Fri, 09 Nov 2018 14:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20181109164755.13100-1-idryomov@gmail.com>
In-Reply-To: <20181109164755.13100-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Nov 2018 16:31:18 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjSArODWM+seBzUGRFgtfMWjorFsna_Ftb8XYW55fab0Q@mail.gmail.com>
Message-ID: <CAHk-=wjSArODWM+seBzUGRFgtfMWjorFsna_Ftb8XYW55fab0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for 4.20-rc2
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 10:48 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Two CephFS fixes (copy_file_range and quota) and a small feature bit
> cleanup.

.. I'm doing a few final manual "pulled" ack emails just to let people
know that I'll be stopping them, because Konstantin's pr-tracker-bot
automation should now be in place if the message is cc'd to lkml.

NOTE! It's currently only lkml, afaik, so other people who don't cc
lkml for their pulls won't get the automation, but I also won't be
looking at "which lists were cc'd", so I won't be doing the manual
ones.

And if you want to use lkml but don't want to see the automated "it
has been merged" emails, there's opt-out too. I know some people hate
getting automated emails.

             Linus
