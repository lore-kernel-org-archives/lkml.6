Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A28C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DB52173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fOY3mgUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfAJIhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:37:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41610 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAJIha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:37:30 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so8274599ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ch50uua6GkQS394O37KZhAfy6Wm7YWq2aCfYFwnxrJE=;
        b=fOY3mgUJL4GhtMMpDCcZazUfXxFg9nPcOrllgCJNrWHYFnfKWWb3BcpF+ui2UOE0mr
         cH2m7mtEymFDa4zf+ud9n4BTDQkz43EiLVu8uNJSk+ssYDNAMl4ZmtWzKVusulgvCwyf
         YOKIIeLkQWcPYPJmDw/v/PdOZeHANEJbmNqVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ch50uua6GkQS394O37KZhAfy6Wm7YWq2aCfYFwnxrJE=;
        b=qlMBLpwRpP9ZuSvhahUyA3chV0iMBmoR8U+1FyzF0+CvGeAj8DeKUS9UdQTPU2NfeY
         JDVC3OJlwErYur2Hycb8S2IiSDbRr1BHFLyd8O8KCtoBA9bNq3F0qKzRewontKDxSao7
         lZ63dIidKye5vCNdqSzIissnou9eZRr/k9Jri0IlvBMRlNYKLbrWR4gVKpLY9BhX53+2
         RZQocLWcyHm94gdw53XozMJngkJ/O6MjFClaM0PpzBlu9cPlH9oGUcz/emizxdtGqCsy
         ywVYXR5y0YRU+/LCJ5nk0bXR82sGgpLxpwq5NDEY0qVpIizDzyLVYDigj1YJyrT+BU6t
         jWhA==
X-Gm-Message-State: AJcUukcgt6Hbd31wkhGCp7O/sxG5Qy8J4ftfYoxY4TF/FCShNSPghMvv
        pUnQce4FeXAH3N4BjcSwp3n831f2ikh+aJRRDNsvXfs1
X-Google-Smtp-Source: ALg8bN5di1VgwbrljY+d/h8I0ga51Or+2Gb8dKeb0vPgQ/rLKf1eO1SoNhNpdMEMI267DoMNcJtLZkO8Zx1SXM36JMw=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr5788938ioh.294.1547109449757;
 Thu, 10 Jan 2019 00:37:29 -0800 (PST)
MIME-Version: 1.0
References: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
 <b0ff11bd-49ea-6073-3c06-80a57275936a@virtuozzo.com>
In-Reply-To: <b0ff11bd-49ea-6073-3c06-80a57275936a@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Jan 2019 09:37:18 +0100
Message-ID: <CAJfpegsnbKNOUj1JwE-cN1ejOi9Ad+T0bcKOHsyPj5u7EDWv+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] fuse: Interrupt-related optimizations and improvements
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 2:25 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> ping
>
> On 08.11.2018 12:05, Kirill Tkhai wrote:
> > v2: Changes in [1-2,5] patches. The biggest change is in [5],
> >     where repeater FR_INTERRUPTED assignment is removed.
> >
> > This patchset consists of several parts. Patches [1-2] optimize
> > likely case of request_end(), and make this function to take
> > fiq->waitq.lock only, when it is really needed. This improves
> > performance of this function completes.
> >
> > Patch 3 makes request_end() to call wake_up() only for not
> > background requests (background requests never wait answer),
> > and this optimizes this function a bit more
> >
> > Patches [4-5] makes code to check userspace requests correct
> > interrupt id to requeue (whether we've sent this interrupt).

Pushed to fuse.git#for-next.

Thanks,
Miklos
