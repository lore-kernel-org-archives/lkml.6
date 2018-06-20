Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF16C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91932083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KGeOjcYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91932083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeFTBQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:16:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42110 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeFTBQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:16:55 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so1979106ioh.9;
        Tue, 19 Jun 2018 18:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCh24YGqEZFUH5ijpA+hFNXtAhVtj28yUMqCGGGKjBQ=;
        b=KGeOjcYG78rI6RfvFd/Rq5sS6p65M1nguqv4bN0Q4Z+b2PyppuMHhJGyVmChlB7Y8l
         sxFMTcDlyOg5mDVtmoMrtrjwl3croJFKuN1Y0oJ6kybl3gnCweh2MlN3CLqYtBcshWH5
         1bfRL2NCAq4WBxZ776HtyfGEw1YPfqlypxi/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCh24YGqEZFUH5ijpA+hFNXtAhVtj28yUMqCGGGKjBQ=;
        b=T8m5v4Ub29OJVujqdN2JMwKmNIdWDqqjhuhB+1+EYAetjw2+GywoiNwX6brhUJdkqr
         +3RWc9HhCHk0YMiF0y4fDFlCgmdFuxwvF/MKAEkLVN+jRDYJNvjjgsdalKYaUhai62bH
         EMDHQ7BEGOVMVjDEQDym2N4rW1Z5/+jIiSoSlHQtX/Nnyi/DLrCFU2rnFstR8oqBE9yC
         59y93hCUAdsHdF2HX/aRJGx6oMXygg1C76BQ4e/c75I1uj5DpX15AfyUkV/p0N9AyzrI
         QAaM2G26TspzpYHISmNbIulmsav4yHep7nmFOPsTpTQS0EP6reTtSnL+3h7R/KTmziXZ
         GF+Q==
X-Gm-Message-State: APt69E0L7G3kY95aG7RaIvA106Z/Nus/9D5K5PwgS3DWMZ6g8TySqRqK
        mR2+Sfhqv9uvmITXtbQQ12v2Jf162/sBiUKO9yE=
X-Google-Smtp-Source: ADUXVKJVDuu9o1PVa/iX/dgBIxEi7fJOh/dBKdpK6/xLelEU8QvgEaeB0Ps4IE3bDxu3R30HDq8Yh2VyGk7gRCKg71s=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr16147732ion.259.1529457414368;
 Tue, 19 Jun 2018 18:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <87muvr58ak.fsf@xmission.com>
In-Reply-To: <87muvr58ak.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 10:16:43 +0900
Message-ID: <CA+55aFxTtemhGJweOKfATojapGzD-riaowDUSh65OA2pCB+w6Q@mail.gmail.com>
Subject: Re: [GIT PULL] userns fixes for 4.17-rc2
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        astrachan@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 8:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I stared at this code for quite a while and I finally concluded that the
> best course forward is to simply things and remove the internal kernel
> mount of proc.  The internal mount of proc is directly responsible for
> this regression and it has been the source of pain over the years.

This is not the kind of patch that I'm willing to take outside the
merge window. This is *way* too subtle, and making sysctl do a
kern_mount()/kern_umount() seems odd.  The pid->count test also looks
potentially racy to me.

And even if we want to do all this, it damn well shouldn't be done in
one commit. The sysctl change could and should be done imdependently,
of the other ones, for example. That "remove kernel mount" commit
simply does too much in one go considering how subtle this is. If
there are problems, I want it to bisect to "oh, sysctl broke", not to
"that thing that removed the kernel mount broke something".

The "it's been broken two years" definitely argues for doing this
slowly and carefully, not this way.

                    Linus
